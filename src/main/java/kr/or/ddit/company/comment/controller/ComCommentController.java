package kr.or.ddit.company.comment.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.comment.service.IComCommentService;
import kr.or.ddit.company.comment.vo.ComCommentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/company")
@PreAuthorize("hasRole('ROLE_COMPANY')")
public class ComCommentController {

	@Inject
	private IComCommentService commentService;
	
	@ResponseBody
	@PostMapping("/getcomment.do")
	public ResponseEntity<List<ComCommentVO>> commentMain(@RequestBody ComCommentVO commentVO) {
		log.info("!!!"+commentVO.getCmntyNo());
		List<ComCommentVO> commentList = commentService.comcommentMain(commentVO.getCmntyNo());
		
		log.info("댓글 :::" + commentList);
		
		return new ResponseEntity<List<ComCommentVO>>(commentList, HttpStatus.OK);
	}
	
	@PostMapping("/commentInsert/{type}")
	@ResponseBody
	public ResponseEntity<String> commentInsert(@RequestBody ComCommentVO commentVO){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		String userId = employeeVO.getEmpId();
		commentVO.setEmpId(userId);
		commentService.comcommentInsert(commentVO);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PostMapping("/getreply.do")
	@ResponseBody
	public ResponseEntity<List<ComCommentVO>> commentReply(@RequestBody ComCommentVO commentVO){
		List<ComCommentVO> replyList = commentService.comcommentReply(commentVO.getCommentNo());
		
		log.info("대댓글:::" + replyList);
		 
		return new ResponseEntity<List<ComCommentVO>>(replyList, HttpStatus.OK);
	}
	
	@PostMapping("/replyInsert/{type}")
	@ResponseBody
	public ResponseEntity<String> replyInsert(@RequestBody ComCommentVO commentVO){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		String userId = employeeVO.getEmpId();
		commentVO.setEmpId(userId);
		commentService.comreplyInsert(commentVO);
		
		log.info("replyInsert ::: " + commentVO);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	
}

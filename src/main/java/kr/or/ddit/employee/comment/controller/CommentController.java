package kr.or.ddit.employee.comment.controller;

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

import kr.or.ddit.comm.alarm.mapper.IAlarmMapper;
import kr.or.ddit.comm.alarm.service.IAlarmService;
import kr.or.ddit.comm.alarm.vo.AlarmVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.employee.comment.service.ICommentService;
import kr.or.ddit.employee.comment.vo.CommentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/employee")
@PreAuthorize("hasRole('ROLE_EMPLOYEE')")
public class CommentController {

	@Inject
	private ICommentService commentService;
	
	@ResponseBody
	@PostMapping("/getcomment.do")
	public ResponseEntity<List<CommentVO>> commentMain(@RequestBody CommentVO commentVO,  AlarmVO alarmVO) {
		log.info("!!!"+commentVO.getCmntyNo());
		List<CommentVO> commentList = commentService.commentMain(commentVO.getCmntyNo());
		
		log.info("댓글 :::" + commentList);
		
		return new ResponseEntity<List<CommentVO>>(commentList, HttpStatus.OK);
	}
	
	@PostMapping("/commentInsert/{type}")
	@ResponseBody
	public ResponseEntity<String> commentInsert(@RequestBody CommentVO commentVO){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		String userId = employeeVO.getEmpId();
		commentVO.setEmpId(userId);
		commentService.commentInsert(commentVO);
		log.info("commentVO ::: " + commentVO);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	@PostMapping("/getreply.do")
	@ResponseBody
	public ResponseEntity<List<CommentVO>> commentReply(@RequestBody CommentVO commentVO){
		List<CommentVO> replyList = commentService.commentReply(commentVO.getCommentNo());
		
		log.info("대댓글:::" + replyList);
		 
		return new ResponseEntity<List<CommentVO>>(replyList, HttpStatus.OK);
	}
	
	@PostMapping("/replyInsert/{type}")
	@ResponseBody
	public ResponseEntity<String> replyInsert(@RequestBody CommentVO commentVO){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		String userId = employeeVO.getEmpId();
		commentVO.setEmpId(userId);
		commentService.replyInsert(commentVO);
		
		log.info("replyInsert ::: " + commentVO);
		
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	
}

package kr.or.ddit.company.jobgrade.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.company.jobgrade.service.impl.IJobgradeService;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/information")
@PreAuthorize("hasAnyRole('ROLE_COMPANY')")
public class JobgradeController {

	@Inject
	private IJobgradeService jbgdService;
	
	@GetMapping("/alljbgd.do")
	public String allJbgd(Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = user.getMember();
		
		
		List<JobGradeVO> jbgdList = jbgdService.selectJbgd(userVO.getCoCd());
		model.addAttribute("userVO", userVO);
		model.addAttribute("jbgdList", jbgdList);
		
		
		return "company/jobgrade/jobgradeForm";
	}
	
	@PostMapping("/deletejbgd.do")
	public String deleteJbgd(JobGradeVO jobGradeVO, Model model) {
		ServiceResult result = jbgdService.deleteJbgd(jobGradeVO);
	    if (result.equals(ServiceResult.OK)) {
	        log.info("jobGradeVO 수정 끝났을 때 : " + jobGradeVO);
	    } else {
	    }
		
		
		return "redirect:/information/alljbgd.do";
	}
	
	@ResponseBody
	@GetMapping("/getjbgdvo.do")
	public ResponseEntity<JobGradeVO> getJbgdDetails(@RequestParam("cd") String jbgdCd) {
	    JobGradeVO jbgdVO = jbgdService.getJbgdVO(jbgdCd); // 해당 ID로 직급 정보를 조회
	    log.info("jbgdVO값" + jbgdVO);
	    return ResponseEntity.ok(jbgdVO);
	}
	
	@ResponseBody
	@PostMapping("/jbgdmodify.do")
	public ResponseEntity<Map<String, Object>> jbgdModify(HttpServletRequest req, JobGradeVO jobGradeVO) throws Exception {
	    Map<String, Object> response = new HashMap<>();
	    
	    log.info("jobGradeVO 수정 들어왔을 때 : " + jobGradeVO);
	    
	    ServiceResult result = jbgdService.jbgdModify(req, jobGradeVO);
	    if (result.equals(ServiceResult.OK)) {
	        response.put("status", "success");
	        response.put("message", "수정이 완료되었습니다!");
	        log.info("jobGradeVO 수정 끝났을 때 : " + jobGradeVO);
	    } else {
	        response.put("status", "error");
	        response.put("message", "수정에 실패하였습니다!");
	    }
	    return ResponseEntity.ok(response);
	}
	
	@ResponseBody
	@PostMapping("/jbgdinsert.do")
	public ResponseEntity<Map<String, Object>> jbgdInsert(HttpServletRequest req, JobGradeVO jobGradeVO) throws Exception {
		Map<String, Object> response = new HashMap<>();
		
		log.info("employeeVO 등록들어왔을 때 : " + jobGradeVO);
		
		ServiceResult result = jbgdService.jbgdInsert(req, jobGradeVO);
		if (result.equals(ServiceResult.OK)) {
			response.put("status", "success");
			response.put("message", "등록이 완료되었습니다!");
			log.info("jobGradeVO 수정 끝났을 때 : " + jobGradeVO);
		} else {
			response.put("status", "error");
			response.put("message", "등록에 실패하였습니다!");
		}
		return ResponseEntity.ok(response);
	}

	
	
	
	
}

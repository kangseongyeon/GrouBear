package kr.or.ddit.comm.findempinfo.controller;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.email.service.EmailService;
import kr.or.ddit.comm.findempinfo.service.IFindEmpInfoService;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FindEmpIdContoller {
	
	@Autowired
    private EmailService emailService;

	
	@Inject
	private IFindEmpInfoService findempinfoservice;
	
	@GetMapping("/findId.do")
	public String findIdForm() {
		return "common/findEmpInfo/findEmpId";
	}
	
	@ResponseBody
	@PostMapping("/findId.do")
	public ResponseEntity<String> findId(@RequestBody EmployeeVO empVO){
		String findId = findempinfoservice.findId(empVO);
		if (findId == null || findId == "") {
			return new ResponseEntity<String>("failed",HttpStatus.BAD_REQUEST);
		}else {
			boolean result = emailService.sendMailFindId(findId, empVO.getEmpEmlAddr());
		        
	        if(result) {
	        	return new ResponseEntity<String>("success",HttpStatus.OK);
	        } else {
	        	return new ResponseEntity<String>("mailerror",HttpStatus.BAD_REQUEST);
	        }
			
			
		}
		
	}
}

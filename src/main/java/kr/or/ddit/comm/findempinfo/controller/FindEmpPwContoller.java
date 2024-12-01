package kr.or.ddit.comm.findempinfo.controller;

import java.util.Map;
import java.util.Random;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.email.service.EmailService;
import kr.or.ddit.comm.findempinfo.service.IFindEmpInfoService;
import kr.or.ddit.comm.findempinfo.vo.MailAuthVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;


@Controller
public class FindEmpPwContoller {
	
	@Autowired
    private EmailService emailService;
	
	@Inject
	private IFindEmpInfoService findempinfoservice;
	
	@Inject
	private PasswordEncoder pe;
	
	@GetMapping("/findPw.do")
	public String findPwForm() {
		return "common/findEmpInfo/findEmpPw";
	}
	
	@ResponseBody
	@PostMapping("/sendAuthNum.do")
	public ResponseEntity<String> sendAuthNum(@RequestBody EmployeeVO empVO){
		
		String findemail = findempinfoservice.findemail(empVO);
		
		if (findemail.equals(empVO.getEmpEmlAddr())) {
			Random random = new Random();
			int authNum = random.nextInt(999999);
			
			MailAuthVO mailAuthVO = new MailAuthVO();
			
			mailAuthVO.setEmpId(empVO.getEmpId());
			mailAuthVO.setAuthNum(authNum);
			
			int delAuthNum = findempinfoservice.delAuthNum(mailAuthVO);
			int insertNum = findempinfoservice.insertAuthNum(mailAuthVO);
			
			if(insertNum == 1) {
				boolean result = emailService.sendAuthNumMail(authNum, findemail);
				
		        if(result) {
		        	return new ResponseEntity<String>("success",HttpStatus.OK);
		        } else {
		        	return new ResponseEntity<String>("mailerror",HttpStatus.BAD_REQUEST);
		        }
	        } else {
	        	return new ResponseEntity<String>("mailerror",HttpStatus.BAD_REQUEST);
	        }
		}
		return new ResponseEntity<String>("failed",HttpStatus.BAD_REQUEST);
	}
	
	@ResponseBody
	@PostMapping("/chkAuthNum.do")
	public ResponseEntity<String> chkAuthNum(@RequestBody MailAuthVO mailAuthVO){
		int getAuthNum = findempinfoservice.getAuthNum(mailAuthVO);
		if (getAuthNum==mailAuthVO.getAuthNum()) {
			int delAuthNum = findempinfoservice.delAuthNum(mailAuthVO);
			if (delAuthNum != 1) {
				return new ResponseEntity<String>("error",HttpStatus.BAD_REQUEST);
			}
			return new ResponseEntity<String>("success",HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("different",HttpStatus.BAD_REQUEST);
		}
	}
	
	@ResponseBody
	@PostMapping("/changePw.do")
	public ResponseEntity<String> changePw(@RequestBody EmployeeVO empVO){
		
		empVO.setEmpPw(pe.encode(empVO.getEmpPw()));
		
		int result = findempinfoservice.changePw(empVO);
	
		if (result == 1) {
			return new ResponseEntity<String>("success",HttpStatus.OK);
		}
		return new ResponseEntity<String>("error",HttpStatus.BAD_REQUEST);
	}
	
	

}

package kr.or.ddit.comm.login.controller;
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

import kr.or.ddit.comm.login.service.ILoginService;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
	
	@Inject
	private ILoginService loginService;

	@Autowired
    PasswordEncoder passwordEncoder;
	
	@GetMapping("/login.do")
	public String login() {
		return "common/login/login";
	}
	
	@ResponseBody
	@PostMapping("/idchk")
	public ResponseEntity<String> loginChk(@RequestBody EmployeeVO empVO ) {
		
		EmployeeVO resultEmp = loginService.idchk(empVO);
		boolean chkpw = passwordEncoder.matches(empVO.getEmpPw(),resultEmp.getEmpPw());
		if(chkpw) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("error", HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/signup.do")
	public String signUpForm() {
		return "common/login/signupForm";
	}
	
	@ResponseBody
	@PostMapping("/brnochk")
	public ResponseEntity<String> brNoChk(@RequestBody CompanyVO comVO ) {
		log.info("brnochk test");
		int brnoChk = loginService.brNoChk(comVO);
		if(brnoChk == 0) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("error", HttpStatus.BAD_REQUEST);
		}
	}
	
	@ResponseBody
	@PostMapping("/signupidchk")
	public ResponseEntity<String> signupIdChk(@RequestBody EmployeeVO empVO ) {
		log.info("brnochk test");
		EmployeeVO resultEmployeeVO = loginService.idchk(empVO);
		if(resultEmployeeVO == null) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("error", HttpStatus.BAD_REQUEST);
		}
	} 
	
	
}

package kr.or.ddit.comm.security.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.net.openssl.ciphers.Authentication;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommonController {
	
	private static final Logger log = LoggerFactory.getLogger(CommonController.class);
	
	@GetMapping("/accessError")
	public void accessDenied(HttpServletResponse response, Authentication auth, Model model) throws IOException, ServletException {
		log.info("# access denied...!");
		log.info("auth : " +  auth);
		model.addAttribute("msg","Access Denied");
		response.sendRedirect("/login.do");
		
	}
}

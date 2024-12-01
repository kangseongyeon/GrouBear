package kr.or.ddit.comm.security.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import kr.or.ddit.groubear.log.service.ILogService;



public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	private static final Logger log = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	
	////////////
	@Inject
	private ILogService loginService;
	/////////////
	
	Map<String, String> param = new HashMap<String, String>();
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.info("CustomLoginSuccessHandler:onAuthenticationSuccess() 실행!");
		
		User user = (User)authentication.getPrincipal();
		log.info("username : " + user.getUsername() );	// 인증된 회원 정보의 아이디
		log.info("password : " + user.getPassword() );	// 인증된 회원 정보의 비밀번호
		
		
		
		// 인증 시 발생하는 에러 정보들을 session에 저장되어 있는데 해당 에러들을 지운다. (Optional)
		clearAuthenticationAttribute(request);
		
		// 타겟 정보가 존재한다면 타겟으로 이동하고
		// 타겟 정보가 존재하지 않을때에는 '/'로 이동
		// 타겟이 없을 떄 : 보호할 자원으로의 요청을 하지 않았을 때, 즉 단순히 로그인 페이지에서 접속 정보 입력 후 로그인 요청했을때
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String auth = user.getAuthorities().toString();
		log.info("auth : " + auth);	// 인증된 회원 정보의 권한
		String targetUrl ="/";
		if (auth.equals("[ROLE_COMPANY]")) {
			targetUrl = "/company/main.do";
		}else if (auth.equals("[ROLE_GROUBEAR]")) {
			targetUrl = "/groubear/main.do";
		}else if (auth.equals("[ROLE_EMPLOYEE]")) {
			targetUrl = "/employee/main.do";
		}
		if (savedRequest != null) {
			targetUrl = savedRequest.getRedirectUrl();// 보호할 자원으로 이동할 티겟 정보
		}
		log.info("targetURL : " +targetUrl );
				
//////////////////////////////////////////////////////	
		
		
//		String ip = request.getHeader("X-Forwarded-For");
////		logVO.setLogIp(request.getRemoteAddr());
//		ip = request.getRemoteAddr();
//		if (ip == null || ip.length() == 0) {
//            ip = request.getHeader("Proxy-Client-IP");
//        }
//		log.info("ip : " + ip);
		
		
		
		String ip = request.getHeader("X-Forwarded-For");

		 if (ip == null) {
		        ip = request.getHeader("Proxy-Client-IP");
		        log.info("Proxy-Client-IP : " + ip);
		    }
		    if (ip == null) {
		        ip = request.getHeader("WL-Proxy-Client-IP");
		        log.info("WL-Proxy-Client-IP : " + ip);
		    }
		    if (ip == null) {
		        ip = request.getHeader("HTTP_CLIENT_IP");
		        log.info("HTTP_CLIENT_IP : " + ip);
		    }
		    if (ip == null) {
		        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		        log.info("HTTP_X_FORWARDED_FOR : " + ip);
		    }
		    if (ip == null) {
		        ip = request.getRemoteAddr();
		        log.info("getRemoteAddr : "+ip);
		    }
		log.info("ip : " + ip);
			
		loginService.loginInsert(request);
		
		
//////////////////////////////////////////////////////		
		
		HttpSession session = request.getSession();
		session.setAttribute("startWork", "N");
		
		response.sendRedirect(targetUrl);
	}
	
	private void clearAuthenticationAttribute(HttpServletRequest request) {
		// session 정보가 존재 한다면 현재 session을 반환하고 존재하지 않은면 null을 반환합니다.
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}

		// SPRING_SECURITY_LAST_EXCEPTION 값
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);

		
	}
	

}

package kr.or.ddit.employee.messenger.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.employee.messenger.service.IMessengerService;
import kr.or.ddit.employee.messenger.vo.MessengerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/employee")
@PreAuthorize("hasRole('ROLE_EMPLOYEE')")
public class MessengerController {
	
	@Inject
	private IMessengerService msgService;
	
	@GetMapping("/messenger.do")
	public String MessengerMain(MessengerVO messengerVO, Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		List<MessengerVO> msgList = msgService.MessengerMain(employeeVO);
		model.addAttribute("msgList", msgList);
		return "employee/messenger/main";
	}

}

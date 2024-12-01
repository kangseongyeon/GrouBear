package kr.or.ddit.employee.mail.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_EMPLOYEE')")
@RequestMapping("/employee")
public class EmpMailController {
	
	@Inject
	private ITIlesService tilesService;
	
	@GetMapping("/mailList.do")
	public String mailList (
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model,
			HttpServletRequest request) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);

		
		return "employee/mail/mailList";
	}
	
	@GetMapping("/mailForm.do")
	public String mailList (Model model, HttpServletRequest request) {
		
		return "employee/mail/mailForm";
	}
	
	@GetMapping("/mailDetail.do")
	public String mailDetail (Model model, HttpServletRequest request) {
		
		return "employee/mail/mailDetail";
	}
}

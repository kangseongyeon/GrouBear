package kr.or.ddit.company.calendar.controller;

import java.text.SimpleDateFormat;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.comm.calendar.service.ICalendarService;
import kr.or.ddit.comm.elapr.service.IMyElaprService;
import kr.or.ddit.comm.project.service.IProjectService;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_COMPANY')")
@RequestMapping("/company")
public class ComCalendarController {

	@Inject
	private ICalendarService calendarService;

	@Inject
	private ITIlesService tilesService;

	@Inject
	private IProjectService projectService;
	
	@Inject
	private IMyElaprService myElaprService;
	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
	
	/**
	 * 캘린더 메인 홈 
	 * @param model
	 * @return
	 */
	@GetMapping("/calendar.do")
	public String comCalendarHome(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		return "company/calendar/calendarHome";
	}
	

}

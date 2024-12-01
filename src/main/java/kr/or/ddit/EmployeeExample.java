package kr.or.ddit;

import java.util.Locale;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/employee")
@PreAuthorize("hasRole('ROLE_EMPLOYEE')")
public class EmployeeExample {
	
	@Inject
	private ITIlesService tilesService;
	
	@GetMapping("/empexample")
	public String home(Locale locale, Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		return "employee/home";
	}
	
}

package kr.or.ddit;

import java.util.Locale;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/company")
@PreAuthorize("hasRole('ROLE_COMPANY')")
public class CompanyExample {

	@Inject
	private ITIlesService tilesService;
	
	@GetMapping("/comexample")
	public String home(Locale locale, Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		return "company/home";
	}
	
}

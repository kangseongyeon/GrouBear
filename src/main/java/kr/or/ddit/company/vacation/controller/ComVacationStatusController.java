package kr.or.ddit.company.vacation.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.vacation.service.IComVacationStatusSerivce;
import kr.or.ddit.company.vacation.vo.VacationStatusVO;

@Controller
@RequestMapping("/company")
@PreAuthorize("hasAnyRole('ROLE_COMPANY')")
public class ComVacationStatusController {

	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IComVacationStatusSerivce vcsttsService;
	
	
	@GetMapping("/vacation/status.do")
	public String vacationStatus(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model
			) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		
		PaginationInfoVO<VacationStatusVO> pagingVO = new PaginationInfoVO<VacationStatusVO>(10,5);
		pagingVO.setCoCd(empVO.getCoCd());
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage); 
		
		int totalRecord = vcsttsService.getPagingVctSttsCount(pagingVO);
		
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<VacationStatusVO> vctSttsList = vcsttsService.getPagingVctSttsList(pagingVO);
		
		pagingVO.setDataList(vctSttsList);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("workMenu", "show");	
		model.addAttribute("vacationStatus", "active");
		return "company/vacation/comVacationStatus";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}


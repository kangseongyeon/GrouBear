package kr.or.ddit.employee.vacation.controller;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import kr.or.ddit.company.vacation.vo.VacationCreateVO;
import kr.or.ddit.employee.vacation.service.IEmpVacationService;
import kr.or.ddit.employee.vacation.vo.VacationApplyVO;
import kr.or.ddit.employee.vacation.vo.VacationCreateDetailVO;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/employee")
@PreAuthorize("hasRole('ROLE_EMPLOYEE')")
public class EmpVacationHistoryController {
	
	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IEmpVacationService vacationService; 
	
	@GetMapping("/vacation/history.do")
	public String vacationManagement(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage, Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
		
		
		// 리스트 페이징 처리하기
		PaginationInfoVO<VacationCreateDetailVO> pagingVO = new PaginationInfoVO<VacationCreateDetailVO>(10,5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		// startRow, endRow, startpage, endPage를 결정한다.
		pagingVO.setCurrentPage(currentPage); 
		
		// 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
		int totalRecord = vacationService.getvctcrtDetailListCount(pagingVO);
		
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord); 
		
		// 총 게시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의 리스트 데이터를 가져온다.
		List<VacationCreateDetailVO> List = vacationService.getvctcrtDetailList(pagingVO);
		pagingVO.setDataList(List);		
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("pagingVO",pagingVO);
		// 사이드바 메뉴 아코디언 고정하기	
		model.addAttribute("workMenu", "show");	
		model.addAttribute("vacationHistory", "active");
		return "employee/vacation/empVacationCreateHistory";
	}
	
}

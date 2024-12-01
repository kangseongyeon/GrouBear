package kr.or.ddit.employee.facilities.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.websocket.server.PathParam;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.facilities.service.IFacilititesService;
import kr.or.ddit.company.facilities.vo.EquipmentVO;
import kr.or.ddit.company.facilities.vo.FacilityCategoryVO;
import kr.or.ddit.company.facilities.vo.FacilityVO;
import kr.or.ddit.employee.facilities.vo.FacilityReservationDetailVO;
import kr.or.ddit.employee.vacation.vo.VacationCreateDetailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/employee")
@PreAuthorize("hasRole('ROLE_EMPLOYEE')")
public class empFacilitiesReserveStatusController {
	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IFacilititesService fcltService;
	
	@GetMapping("/facilities/reserve/status.do")
	public String facilitiesStatus(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage, Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		List<FacilityReservationDetailVO> List = fcltService.getMyFcltrsvtList(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		model.addAttribute("List",List);
		model.addAttribute("facilitesMenu", "show");
		model.addAttribute("facilitesReserveStatus", "active");
		
		return "employee/facilities/empFacilitesReservceStatus";
	}
	
}

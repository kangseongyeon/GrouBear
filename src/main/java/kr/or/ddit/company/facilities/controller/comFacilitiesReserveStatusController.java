package kr.or.ddit.company.facilities.controller;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

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

import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.facilities.service.IFacilititesService;
import kr.or.ddit.company.facilities.vo.FacilityCategoryVO;
import kr.or.ddit.company.facilities.vo.FacilityVO;
import kr.or.ddit.employee.facilities.vo.FacilityReservationDetailVO;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
@RequestMapping("/company")
@PreAuthorize("hasRole('ROLE_COMPANY')")
public class comFacilitiesReserveStatusController {

	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IFacilititesService fcltService;
	
	@GetMapping("facilities/reserve/status.do")
	public String facilitiesReservceStatus(Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		// 카테고리 가져오기
		List<FacilityCategoryVO> fcltCtgrList = fcltService.getfcltCtgrList(empVO);
		
		List<FacilityReservationDetailVO> fcltreserveList = fcltService.getFcltrsvtList(empVO);
		
		log.info("fcltreserveList :::" + fcltreserveList); 
		
		model.addAttribute("fcltCtgrList",fcltCtgrList);
		model.addAttribute("fcltreserveList",fcltreserveList);
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		model.addAttribute("facilitesMenu", "show");
		model.addAttribute("facilitesReserveStatus", "active");
		return "company/facilities/comFacilitesReservceStatus";
	}
	
	@PostMapping("facilities/reserve/searchfclt.do")
	public ResponseEntity<List<FacilityVO>> searchfclt(@RequestBody FacilityCategoryVO fcltCtgrVO){
		
		//시설 검색
		List<FacilityVO> fcltList = fcltService.getFcltList(fcltCtgrVO);
		if (fcltList == null) {
			return new ResponseEntity<List<FacilityVO>>(fcltList, HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<List<FacilityVO>>(fcltList, HttpStatus.OK);
	}
	
	@PostMapping("facilities/reserve/searchfcltreserve.do")
	public ResponseEntity<List<FacilityReservationDetailVO>> searchfcltreserve(@RequestBody FacilityReservationDetailVO fcltreserveVO){
		
		//시설 검색
		List<FacilityReservationDetailVO> fcltreserveList = fcltService.getFcltReserveList(fcltreserveVO);
		if (fcltreserveList == null) {
			return new ResponseEntity<List<FacilityReservationDetailVO>>(fcltreserveList, HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<List<FacilityReservationDetailVO>>(fcltreserveList, HttpStatus.OK);
	}
	
	
}

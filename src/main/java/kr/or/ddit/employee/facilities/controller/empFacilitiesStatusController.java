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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.facilities.service.IFacilititesService;
import kr.or.ddit.company.facilities.vo.EquipmentVO;
import kr.or.ddit.company.facilities.vo.FacilityCategoryVO;
import kr.or.ddit.company.facilities.vo.FacilityVO;
import kr.or.ddit.employee.facilities.vo.FacilityReservationDetailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/employee")
@PreAuthorize("hasRole('ROLE_EMPLOYEE')")
public class empFacilitiesStatusController {
	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IFacilititesService fcltService;
	
	@GetMapping("/facilities/status.do")
	public String facilitiesStatus( Locale locale, Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		//시설 카테고리 가져오기
		List<FacilityCategoryVO> fcltCtgrList = fcltService.getfcltCtgrList(empVO);
		
		model.addAttribute("fcltCtgrList", fcltCtgrList);
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		model.addAttribute("facilitesMenu", "show");	
		model.addAttribute("facilitesStatus", "active");
		return "employee/facilities/empFacilitesStatus";
	}
	
	@ResponseBody
	@PostMapping("/facilties/getfcltList.do")
	public ResponseEntity<FacilityCategoryVO> getFcltList(@RequestBody FacilityCategoryVO fcltctgrVO){
		fcltctgrVO = fcltService.getfcltCtgrInfo(fcltctgrVO);
		List<FacilityVO> fcltList = fcltService.getFcltList(fcltctgrVO);
		fcltctgrVO.setFcltList(fcltList);
		 
		if(fcltctgrVO == null) {
			return new ResponseEntity<FacilityCategoryVO>(fcltctgrVO, HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<FacilityCategoryVO>(fcltctgrVO, HttpStatus.OK);
	}
	
	@GetMapping("/facilities/detail.do")
	public String fcltDetail(@PathParam(value = "fcltCd") String fcltCd, Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		log.info("fcltCd" + fcltCd);
		
		//시설 정보
		FacilityVO fcltVO = new FacilityVO();
		fcltVO.setFcltCd(fcltCd);
		fcltVO = fcltService.getFcltInfo(fcltVO);
		
		//시설 이미지 정보
		List<AtchFileDetailVO> imgList = fcltService.getFcltImg(fcltVO);
		
		
		//카테고리 정보
		FacilityCategoryVO fcltCtgrVO = new FacilityCategoryVO();
		fcltCtgrVO.setFcltCtgrCd(fcltVO.getFcltCtgrCd());
		fcltCtgrVO = fcltService.getfcltCtgrInfo(fcltCtgrVO);
		
		//비품 정보
		List<EquipmentVO> eqList = fcltService.getEqList(fcltVO);
		
		
		//예약 정보
		//오늘 예약 정보 가져오고 input-date에 오늘 날짜 입력 및 예약 현황에 맞게 예약 시간 버튼 활성화
		//오늘 날짜 정보
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String sdfNow = sdf.format(now);
		
		//오늘 날짜 정보로 예약 정보 검색
		List<FacilityReservationDetailVO> frdList = fcltService.getFRDList(sdfNow);
		
		//예약 가능 시간 생성
		int StartTm = Integer.parseInt(fcltVO.getFcltStartTm().replaceAll(":",""));
		int EndTm = Integer.parseInt(fcltVO.getFcltEndTm().replaceAll(":",""));
		List<Integer> rsvTm = new ArrayList<Integer>();
		
		for (int i = StartTm; i < EndTm; i+=100) {
			rsvTm.add(i);
		}
		
		//이미 예약된 시간 삭제
		for (FacilityReservationDetailVO Tm : frdList) {
			int rsvtBgntTM = Integer.parseInt(Tm.getRsvtBgngTm().replaceAll(":",""));
			rsvTm.remove(Integer.valueOf(rsvtBgntTM));
		}
		
		// 예약 가능 리스트 생성
		List<String> rsvList = new ArrayList<String>();
		for (Integer Tm : rsvTm) {
			String str = Tm.toString();
			str = str.substring(0, str.length() - 2);
			rsvList.add(str+":00");
		}
		
		
		
		log.info("fcltVO"+fcltVO);
		log.info("fcltVO"+fcltCtgrVO);
		log.info("empVO"+empVO);
		log.info("eqList"+eqList);
		log.info("imgList"+imgList);
		log.info("frdList"+frdList);
		log.info("rsvList" + rsvList);
		
		model.addAttribute("rsvList",rsvList);
		model.addAttribute("sdfNow",sdfNow);
		model.addAttribute("empVO",empVO);
		model.addAttribute("fcltVO",fcltVO);
		model.addAttribute("fcltCtgrVO",fcltCtgrVO);
		model.addAttribute("eqList",eqList);
		model.addAttribute("imgList",imgList);
		return "employee/facilities/empFacilitesDetail";
	}
	
	@ResponseBody
	@PostMapping("/facilties/rsvTm.do")
	public ResponseEntity<List<String>> rsvTm(@RequestBody FacilityReservationDetailVO rsvdVO){
		// 검색 시간 다음 예약 정보 가져오기
		log.info(rsvdVO.getRsvtBgngTm());
		if(rsvdVO.getRsvtBgngTm().length() == 4) {
			rsvdVO.setRsvtBgngTm("0"+rsvdVO.getRsvtBgngTm());
		}
		FacilityReservationDetailVO frsvdVO = fcltService.getNextfrsvd(rsvdVO);
		List<String> availableList = new ArrayList<String>();
		int startTm = 0;
		int endTm = 0;
		if (frsvdVO == null) {
			//시설 정보 가져오기
			FacilityReservationDetailVO frsvdVO2 = new FacilityReservationDetailVO();
			FacilityVO fcltVO = new FacilityVO();
			fcltVO.setFcltCd(rsvdVO.getFcltCd());
			fcltVO = fcltService.getFcltInfo(fcltVO);
			frsvdVO2.setRsvtEndTm(fcltVO.getFcltEndTm());
			startTm = Integer.parseInt(rsvdVO.getRsvtBgngTm().substring(0, rsvdVO.getRsvtBgngTm().length() - 3));
			endTm = Integer.parseInt(frsvdVO2.getRsvtEndTm().substring(0, frsvdVO2.getRsvtEndTm().length() - 3));
		}else {
			
			startTm = Integer.parseInt(rsvdVO.getRsvtBgngTm().substring(0, rsvdVO.getRsvtBgngTm().length() - 3));
			endTm = Integer.parseInt(frsvdVO.getRsvtBgngTm().substring(0, frsvdVO.getRsvtBgngTm().length() - 3));
			
		}
		
		
		for (int i = startTm+1; i <= endTm; i++) {
			availableList.add(i+":00");
		}
		return new ResponseEntity<List<String>>(availableList,HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping("/facilties/available.do")
	public ResponseEntity<String> rsvavailable(@RequestBody FacilityReservationDetailVO rsvdVO){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		log.info(rsvdVO+"");
		rsvdVO.setMemId(empVO.getEmpId());
		int result = fcltService.rsvAvailable(rsvdVO);
		if(result == 1) {
			return new ResponseEntity<String>("success",HttpStatus.OK);
		}
		return new ResponseEntity<String>("error",HttpStatus.BAD_REQUEST);
	}
	
	
}

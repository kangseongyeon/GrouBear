package kr.or.ddit.employee.vehicleReservation.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.company.vehicleManagement.vo.VHCLRSVTVO;
import kr.or.ddit.company.vehicleManagement.vo.VHCLVO;
import kr.or.ddit.employee.vehicleReservation.service.IVehicleService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/empvehicle")
@PreAuthorize("hasAnyRole('ROLE_EMPLOYEE')")
public class EmpVehicleReservation {

	@Resource(name = "localPath")
	private String localPath;

	@Inject
	private IVehicleService vehicleService;

	/**
	 * 기능 : 차량 목록, 예약 폼, 모달을 통해 차량 등록 가능 메뉴명 : 기업관리자 / 차량 관리 사원 / 차량 예약
	 * 
	 * @return
	 */
	@GetMapping("/vehicledashboard.do")
	public String empVehicleDashBoard(Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = user.getMember();

		List<VHCLRSVTVO> vhclRsvtList = vehicleService.selectRSVTHistory(userVO.getCoCd());
		List<VHCLVO> vhclList = vehicleService.selectVhclList(userVO.getCoCd());

		model.addAttribute("vhclRsvtList", vhclRsvtList);
		model.addAttribute("vhclList", vhclList);
		model.addAttribute("userVO", userVO);

		return "employee/vehicleForm/vehicleDashBoard";
	}
	
	@ResponseBody
	@PostMapping("/rsvtmodify.do")
	public ResponseEntity<Map<String, Object>> rsvtModify(HttpServletRequest req, VHCLRSVTVO vhclrsvtVO) throws Exception {
	    Map<String, Object> response = new HashMap<>();
	    
	    log.info("vhclrsvtVO 수정 들어왔을 때 : " + vhclrsvtVO);
	    
	    ServiceResult result = vehicleService.rsvtModify(req, vhclrsvtVO);
	    if (result.equals(ServiceResult.OK)) {
	        response.put("status", "success");
	        response.put("message", "수정이 완료되었습니다!");
	        log.info("vhclrsvtVO 수정 끝났을 때 : " + vhclrsvtVO);
	    } else {
	        response.put("status", "error");
	        response.put("message", "수정에 실패하였습니다!");
	    }
	    return ResponseEntity.ok(response);
	}
	
	
	
	@ResponseBody
	@GetMapping("/vehicleList.do")
	public List<Map<String, Object>> vehicleRSTVList(Model model){
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = user.getMember();
		log.info("캘린더 진입");
		List<VHCLRSVTVO> vhclRsvtList = vehicleService.selectAllRSVTHistory(userVO.getCoCd());
		List<Map<String, Object>> events = new ArrayList<Map<String,Object>>();
		
		log.info("캘린더 진입 후 예약 리스트 : " + vhclRsvtList);
		
		for (VHCLRSVTVO vhclRstv : vhclRsvtList) {
			Map<String, Object> event = new HashedMap<String, Object>();
	        event.put("id", vhclRstv.getRsvtCd() + vhclRstv.getEmpNm());
	        event.put("title", vhclRstv.getVhclNo());
	        event.put("description", vhclRstv.getRntlRsn());
	        event.put("location", vhclRstv.getVhclBtdst());
	        event.put("start", vhclRstv.getVhclRntlDt());
	        event.put("end", vhclRstv.getVhclRtnDt());
	        
	        events.add(event);
		}
		log.info("이벤트 맵 설정 후 : " + events);
		return events;
	}
	
	
	@ResponseBody
	@GetMapping("/getrsvtvo.do")
	public ResponseEntity<VHCLRSVTVO> getRsvtVO(@RequestParam("rsvtCd") String rsvtCd) {
	    VHCLRSVTVO vhclRsvtVO = vehicleService.getRsvtVO(rsvtCd); // 해당 ID로 직급 정보를 조회
	    log.info("vhclRsvtVO값" + vhclRsvtVO);
	    return ResponseEntity.ok(vhclRsvtVO);
	}
	

	@ResponseBody
	@PostMapping("/findvhclvo.do")
	public VHCLVO findVhclVO(@RequestBody VHCLVO vhclVO) {
		String vhclNo = vhclVO.getVhclNo();
		log.info("vhclNo값 : " + vhclNo);
		VHCLVO newVhclVO = vehicleService.findVhclVO(vhclNo);
		log.info("newVhclVO : " + newVhclVO);
		return newVhclVO;
	}

	@PostMapping("/delrsvt.do")
	public String delRSVT(HttpServletRequest req, RedirectAttributes ra, VHCLRSVTVO vhclRsvtVO) {
		String goPage = "";
		
		ServiceResult result = vehicleService.rsvtDelete(vhclRsvtVO);
			if (result.equals(ServiceResult.OK)) {
				goPage = "redirect:/empvehicle/reservationhistory.do";
			} else {
				goPage = "redirect:/empvehicle/reservationhistory.do";
			}
		return goPage;
	}
	

	/**
	 * 기능 : 차량 예약현황 페이지 메뉴명 : 기업관리자 , 사원 / 차량 예약 내역
	 * 
	 * @return
	 */
	@GetMapping("/reservationhistory.do")
	public String reservationHistory(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, @RequestParam(required = false) String searchOrder,
			Model model, HttpServletRequest request) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = user.getMember();
		log.info("userVO.getCoCd() : " + userVO.getCoCd());
		
		if (searchOrder == "" || searchOrder == null) {
			searchOrder = null;
		}
		
		PaginationInfoVO<VHCLRSVTVO> pagingVO = new PaginationInfoVO<VHCLRSVTVO>(10, 5);
		pagingVO.setEmpId(userVO.getEmpId());
		
		if (StringUtils.isNotBlank(searchWord) || StringUtils.isNotBlank(searchOrder)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchOrder(searchOrder);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchOrder", searchOrder);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = vehicleService.selectMyRSVTPage(pagingVO);

		pagingVO.setTotalRecord(totalRecord);

		List<VHCLRSVTVO> dataList = vehicleService.selectMyRSVTPaging(pagingVO);

		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);
		
		List<VHCLRSVTVO> vhclMyRsvtList = vehicleService.selectMyRSVTHistory(userVO.getEmpId());
		model.addAttribute("vhclMyRsvtList", vhclMyRsvtList);
		return "employee/vehicleForm/reservationHistory";
	}

	

	@PostMapping("/vehiclereservationinsert.do")
	public String vehicleReservationInsert(HttpServletRequest req, RedirectAttributes ra,
			@ModelAttribute VHCLRSVTVO vhclrsvtVO, Model model) throws Exception {
		String goPage = "";

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = user.getMember();

		log.info("신청자 : " + userVO.getEmpId());
		vhclrsvtVO.setEmpId(userVO.getEmpId());

		if (userVO != null) {
			ServiceResult result = vehicleService.insertReservation(req, vhclrsvtVO);
			if (result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("message", "예약 완료!");
				goPage = "redirect:/empvehicle/vehicledashboard.do";
			} else {
				model.addAttribute("empvehicle", "서버에러, 다시 시도해주세요!");
				goPage = "redirect:/empvehicle/vehicledashboard.do";
			}
		}
		return goPage;
	}

}

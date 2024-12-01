package kr.or.ddit.employee.calendar.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.calendar.service.ICalendarService;
import kr.or.ddit.comm.calendar.vo.CalendarVO;
import kr.or.ddit.comm.elapr.service.IMyElaprService;
import kr.or.ddit.comm.elapr.vo.ElaprVO;
import kr.or.ddit.comm.project.service.IProjectService;
import kr.or.ddit.comm.project.vo.ProjectVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import kr.or.ddit.company.vehicleManagement.vo.VHCLRSVTVO;
import kr.or.ddit.employee.vehicleReservation.service.IVehicleService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_EMPLOYEE')")
@RequestMapping("/employee")
public class EmpCalendarController {
	
	@Inject
	private ICalendarService calendarService;

	@Inject
	private ITIlesService tilesService;

	@Inject
	private IProjectService projectService;
	
	@Inject
	private IMyElaprService myElaprService;

	@Inject
	private IVehicleService vehicleService;
	
	/**
	 * 캘린더 메인 홈 
	 * @param model
	 * @return
	 */
	@GetMapping("/calendar.do")
	public String empCalendarHome(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		return "employee/calendar/calendarHome";
	}
	

	/**
	 * 캘린더 일정 리스트
	 * @return
	 */
	@ResponseBody
	@GetMapping("/calendarList.do")
	public List<Map<String, Object>> calendarList(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		TeamVO teamVO = tilesService.getTeam(empVO);
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);

		List<Map<String, Object>> events = new ArrayList<Map<String,Object>>();
		
		// 캘린더 일정 출력
	    List<CalendarVO> calendarList = calendarService.calendarList(empVO.getEmpId());
	    
	    for (CalendarVO calendar : calendarList) {
	    	Map<String, Object> event = new HashMap<String, Object>();
	    	event.put("id", calendar.getCalendarNo());
	    	event.put("title", calendar.getCalendarNm());
	    	event.put("description", calendar.getCalendarCn());
	    	event.put("location", calendar.getCalendarDaddr());
	    	event.put("start", calendar.getCalendarDt() + "T" + (calendar.getCalendarStartTime() != null ? calendar.getCalendarStartTime() : "00:00"));
	    	event.put("end", calendar.getCalendarEndDt() + "T" + (calendar.getCalendarEndTime() != null ? calendar.getCalendarEndTime() : "23:59"));
	    	event.put("allDay", "Y".equals(calendar.getCalendarAlldayYn()));
	    	event.put("classNames", Arrays.asList("calendar-event"));
	    	events.add(event);
	    }

	    // 프로젝트 일정 출력
	    List<ProjectVO> proCardList = projectService.selectProCardList(empVO.getEmpId());

	    for (ProjectVO project : proCardList) {
	        Map<String, Object> projectEvent = new HashMap<String, Object>();
	        projectEvent.put("id", project.getProNo());
	        projectEvent.put("title", project.getProNm());
	        projectEvent.put("description", project.getProCn());
	        projectEvent.put("start", project.getProStartDt());
	        projectEvent.put("end", project.getProEndDt());
	        projectEvent.put("allDay", true);
	        projectEvent.put("classNames", Arrays.asList("project-event"));
	        events.add(projectEvent);
	    } 
	    
	    // 전자결재 일정 출력
	    List<ElaprVO> dataList = myElaprService.selectAllCalList(empVO.getEmpId());
	    
	    for (ElaprVO elapr : dataList) {
	    	Map<String, Object> elaprEvent = new HashMap<String, Object>();
	    	elaprEvent.put("id", elapr.getElaprNo());
	    	elaprEvent.put("title", elapr.getElaprNm());
	    	elaprEvent.put("start", elapr.getElaprBgngDt());
	    	elaprEvent.put("end", elapr.getElaprEndDt());
	    	elaprEvent.put("allDay", true);
	    	elaprEvent.put("classNames", Arrays.asList("elapr-event"));
	    	events.add(elaprEvent);
	    }
	    
	    // 차량 예약 일정 출력
	    List<VHCLRSVTVO> vhclRsvtList = vehicleService.selectMyRSVTHistory(empVO.getEmpId());
	    for (VHCLRSVTVO vhclRstv : vhclRsvtList) {
			Map<String, Object> vhclEvent = new HashedMap<String, Object>();
	        vhclEvent.put("id", vhclRstv.getRsvtCd() + vhclRstv.getEmpNm());
	        vhclEvent.put("title", vhclRstv.getVhclNo());
	        vhclEvent.put("description", vhclRstv.getRntlRsn());
	        vhclEvent.put("location", vhclRstv.getVhclBtdst());
	        vhclEvent.put("start", vhclRstv.getVhclRntlDt());
	        vhclEvent.put("end", vhclRstv.getVhclRtnDt());
	        vhclEvent.put("classNames", Arrays.asList("vhcl-event"));
	        
	        events.add(vhclEvent);
		}
	    
	    
	    return events;
	}
	
	/**
	 * 캘린더 일정 추가 폼
	 * @param model
	 * @return
	 */
	@GetMapping("/calForm.do")
	public String calForm(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		return "employee/calendar/calendarHome";
	}
	
	
	/**
	 * 캘린더 일정 추가
	 * @param req
	 * @param ra
	 * @param calendarVO
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping("/calInsert.do")
	public String calInsert(
			HttpServletRequest req, 
			@RequestBody CalendarVO calendarVO, Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		TeamVO teamVO = tilesService.getTeam(empVO);
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		String goPage = "";
		

		Map<String, String> errors = new HashMap<String, String>();
		if (StringUtils.isBlank(calendarVO.getCalendarNm())) {
			errors.put("calendarNm", "제목을 입력해주세요");
		}
		
		if (!errors.isEmpty()) {
			return "employee/calendar/calendarHome";
		} else {
			
			if(empVO != null) {
				calendarVO.setEmpId(empVO.getEmpId());
				ServiceResult result = calendarService.calendarInsert(req, calendarVO);
				if (result.equals(ServiceResult.OK)) {
					return "OK";
				} else {
					return "FAIL";
				}
			} else {
				goPage = "redirect:/login.do";
			}
		}
		log.info("calendarVO: ", calendarVO);

		return goPage;
	}
	
	/*
	 * 프젝트 일정 수정 폼
	 * @param calendarNo
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping("/calendarUpdate.do")
	public CalendarVO calendarUpdate(@RequestParam int calendarNo) {
		return calendarService.selectCalendar(calendarNo);
	}
	/**
	 * 프로젝트 일정 수정
	 * @param ra
	 * @param req
	 * @param calendarVO
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping("/calendarUpdate.do")
	public String calendarUpdate(
			@RequestBody CalendarVO calendarVO, HttpServletRequest req, Model model) {
		ServiceResult result = calendarService.calendarUpdate(req, calendarVO);
		if (result.equals(ServiceResult.OK)) {
			return "OK";
		} else {
			return "FAIL";
		}
	}
	
	
	/**
	 * 캘린더 일정 삭제
	 * @param ra
	 * @param req
	 * @param calendarNo
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping("/calendarDelete.do")
	public String projectDelete(
			int calendarNo, HttpServletRequest req, Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		ServiceResult result = calendarService.calendarDelete(req, calendarNo);
		if (result.equals(ServiceResult.OK)) {
			return "OK";
		} else {
			return "FAIL";
		}
		
	}

	/**
	 * 일정 드래그 시 날짜 업데이트
	 * @param updateEvent
	 * @param ra
	 * @return
	 */
	@ResponseBody
	@PostMapping("/updateCalendarDate.do")
	public String updateCalendarDate(@RequestBody CalendarVO updateEvent) {
		ServiceResult result = calendarService.updateCalendarDate(updateEvent);
		if (result.equals(ServiceResult.OK)) {
			return "OK";
		} else {
			return "FAIL";
		}
	}
	

}

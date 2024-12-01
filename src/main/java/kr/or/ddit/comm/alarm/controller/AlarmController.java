package kr.or.ddit.comm.alarm.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.alarm.service.IAlarmService;
import kr.or.ddit.comm.alarm.vo.AlarmVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import kr.or.ddit.employee.workStatus.service.IEmpWorkStatusService;
import kr.or.ddit.employee.workStatus.vo.EmpWorkStatusVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AlarmController {

	@Inject
	private IEmpWorkStatusService workStatusService;

	@Inject
	private ITIlesService tilesService;

	@Inject
	private IAlarmService alarmService;
	
	
	@ResponseBody
	@GetMapping("/alarmToast")
	public List<AlarmVO> alarmToast() {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		AlarmVO alarmVO = new AlarmVO(); // 아무것도 없는 빈 걸 만들음!
		alarmVO.setAlarmTarget(employeeVO.getEmpId());
		
		List<AlarmVO> alarmList = alarmService.selectList(alarmVO);
		log.info("alarmList ::: " + alarmList);
		return alarmList;
	}

	@ResponseBody
	@GetMapping("/alarmList")
	public List<AlarmVO> alarmList() {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		AlarmVO alarmVO = new AlarmVO(); // 아무것도 없는 빈 걸 만들음!
		alarmVO.setAlarmTarget(employeeVO.getEmpId());

		List<AlarmVO> alarmList = alarmService.selectList(alarmVO);
		log.info("alarmList ::: " + alarmList);
		return alarmList;
	}

	@ResponseBody
	@GetMapping("/alarmCnt")
	public int alarmCnt() {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		log.debug("다빈 체킁 {}", user);

		EmployeeVO employeeVO = user.getMember();
		String empId = employeeVO.getEmpId();

		AlarmVO alarmVO = new AlarmVO(); // 아무것도 없는 빈 걸 만들음!
		alarmVO.setAlarmTarget(user.getUsername());

		List<AlarmVO> alarmList = alarmService.selectList(alarmVO);
		log.info("alarmList ::: " + alarmList);
		return alarmList.size();
	}

	@PostMapping("/insertAlarm")
	@ResponseBody
	public ResponseEntity<String> insertAlarm(@RequestBody AlarmVO alarmVO) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		String empId = employeeVO.getEmpId();

		String type = alarmVO.getAlarmCategory();

		if (type.equals("community")) {
			alarmVO.setAlarmCn(empId + "님이 회원님의 게시물에 " + alarmVO.getAlarmCn() + " 댓글을 작성하였습니다.");
		} else if (type.equals("cmntyRe")) {
			alarmVO.setAlarmCn(empId + "님이 회원님의 댓글에 " + alarmVO.getAlarmCn() + " 대댓글을 작성하였습니다.");
		} else if (type.equals("info")) {
			empId = alarmVO.getAlarmTarget();
			log.info("empId : " + empId);
			alarmVO.setAlarmCn(empId + "님의 인사정보가 수정되었습니다!");
		} else if (type.equals("calender")) {
//			empId = alarmVO.getAlarmTarget();
//			log.info("empId : " + empId);
			alarmVO.setAlarmCn(empId + "님이 일정을 등록하였습니다.");
		}
		alarmService.insertAlarm(alarmVO);
		log.info("alarmVO :::" + alarmVO);

		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}

	@PostMapping("/alarmRemove")
	@ResponseBody
	public ResponseEntity<String> alarmRemove(@RequestBody AlarmVO alarmVO) {
		alarmService.alarmRemove(alarmVO.getAlarmNo());
		return new ResponseEntity<String>("SUCCESS : ", HttpStatus.OK);
	}
	
	@PostMapping("/alarmRead")
	@ResponseBody
	public ResponseEntity<String> alarmRead(@RequestBody AlarmVO alarmVO) {
		alarmService.alarmRead(alarmVO.getAlarmNo()); 
		return new ResponseEntity<String>("SUCCESS : ", HttpStatus.OK);
	}

	// employee
	@GetMapping("/employee/allAlarm.do")
	public String empAllAlarm(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model, HttpServletRequest request) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(employeeVO);
		
		model.addAttribute("companyVO",companyVO);
		
		DepartmentVO epmtVO = tilesService.getEpmt(employeeVO);
		
		TeamVO teamVO = tilesService.getTeam(employeeVO);
		
		EmpWorkStatusVO EmpWorkStatusVO = workStatusService.getTodayWorkStatus(employeeVO);
		
		// 페이징 처리
		PaginationInfoVO<AlarmVO> pagingVO = new PaginationInfoVO<AlarmVO>(10, 5);
		pagingVO.setCoCd(employeeVO.getCoCd());
		pagingVO.setAlarmTarget(employeeVO.getEmpId());
		
		// 검색 기능
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = alarmService.countList(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<AlarmVO> dataList = alarmService.alarmList(pagingVO);
		pagingVO.setDataList(dataList);
		log.info("data:::" + dataList);
		
		model.addAttribute("employeeVO", employeeVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("EmpWorkStatusVO", EmpWorkStatusVO);
		model.addAttribute("dataList", dataList);
		model.addAttribute("pagingVO", pagingVO);
		return "employee/alarm/allAlarm";
	}
	
	// company
	@GetMapping("/company/allAlarm.do")
	public String comAllAlarm(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model, HttpServletRequest request) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(employeeVO);
		
		model.addAttribute("companyVO",companyVO);
		
		DepartmentVO epmtVO = tilesService.getEpmt(employeeVO);
		
		TeamVO teamVO = tilesService.getTeam(employeeVO);
		
		EmpWorkStatusVO EmpWorkStatusVO = workStatusService.getTodayWorkStatus(employeeVO);
		
		// 페이징 처리
		PaginationInfoVO<AlarmVO> pagingVO = new PaginationInfoVO<AlarmVO>(10, 5);
		pagingVO.setCoCd(employeeVO.getCoCd());
		pagingVO.setAlarmTarget(employeeVO.getEmpId());
		
		// 검색 기능
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = alarmService.countList(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<AlarmVO> dataList = alarmService.alarmList(pagingVO);
		pagingVO.setDataList(dataList);
		log.info("data:::" + dataList);
		
		model.addAttribute("employeeVO", employeeVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("EmpWorkStatusVO", EmpWorkStatusVO);
		model.addAttribute("dataList", dataList);
		model.addAttribute("pagingVO", pagingVO);
		return "company/alarm/allAlarm";
	}
	
	// groubear
	@GetMapping("/groubear/allAlarm.do")
	public String grouAllAlarm(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model, HttpServletRequest request) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		// 페이징 처리
		PaginationInfoVO<AlarmVO> pagingVO = new PaginationInfoVO<AlarmVO>(10, 5);
//		pagingVO.setCoCd(employeeVO.getCoCd());
		pagingVO.setAlarmTarget(employeeVO.getEmpId());
		
		// 검색 기능
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = alarmService.countList(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<AlarmVO> dataList = alarmService.alarmList(pagingVO);
		pagingVO.setDataList(dataList);
		log.info("data:::" + dataList);
		
		model.addAttribute("employeeVO", employeeVO);
		model.addAttribute("dataList", dataList);
		model.addAttribute("pagingVO", pagingVO);
		return "groubear/alarm/allAlarm";
	}

}

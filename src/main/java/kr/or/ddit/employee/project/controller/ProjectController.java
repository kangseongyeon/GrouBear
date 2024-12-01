package kr.or.ddit.employee.project.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.comm.alarm.service.IAlarmService;
import kr.or.ddit.comm.alarm.vo.AlarmVO;
import kr.or.ddit.comm.cmnty.vo.CmntyVO;
import kr.or.ddit.comm.empallinfo.service.IEmpAllInfoService;
import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.project.service.IProjectService;
import kr.or.ddit.comm.project.service.IProjectTaskService;
import kr.or.ddit.comm.project.vo.ProjectParticipantVO;
import kr.or.ddit.comm.project.vo.ProjectTaskVO;
import kr.or.ddit.comm.project.vo.ProjectVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.service.IInformationService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/employee")
@PreAuthorize("hasAnyRole('ROLE_EMPLOYEE')")
public class ProjectController {

	@Inject
	private IEmpAllInfoService empAllInfoService;
	
	@Inject
	private IProjectService projectService;
	
	@Inject
	private IProjectTaskService projectTaskService;
	
	@Inject
	private ITIlesService tilesService;


	@Inject
	private IInformationService infoService;
	

	@Inject
	private IAlarmService alarmService;
	
	/**
	 * 프로젝트 메인 홈
	 * @param model
	 * @return
	 */
	@GetMapping("/project.do")
	public String project(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		String empId = empVO.getEmpId();
		
		// 프로젝트 진행 / 완료 상태 변경
		projectService.updateProjectStts();
		
		// 프로젝트 메인 홈 카드 리스트
		List<ProjectVO> proCardList = projectService.selectProCardList(empId);
		
		for (ProjectVO project : proCardList) {
//			projectService.updateProjectStts(project.getProNo());
			
			if (project.getParticipantEmpNames() != null) {
				String[] name = project.getParticipantEmpNames().split(", ");
				project.setParticipantEmpNamesList(Arrays.asList(name));
			}
			if (project.getParticipantImgFileUrls() != null) {
				String[] imgFileUrl = project.getParticipantImgFileUrls().split(", ");
				project.setParticipantImgFileUrlsList(Arrays.asList(imgFileUrl));
			}
		}
		
		model.addAttribute("proCardList", proCardList);
		
		return "employee/project/projectMain";
	}
	
	/**
	 *  프로젝트 추가폼
	 * @param model
	 * @return
	 */
	@GetMapping("/projectForm.do")
	public String projectForm(Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
		CompanyVO companyVO = tilesService.getCompany(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		

		List<EmployeeVO> empAllList = infoService.orgEmpList(empVO);
		List<DepartmentVO> deptTeamList = infoService.selectDeptTeamList(empVO);
		List<JobGradeVO> jbgdList = infoService.selectJBGDList(empVO);
		List<TeamVO> teamList = infoService.selectTeamListByDept(empVO);
		
		model.addAttribute("companyVO", companyVO);
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("empAllList", empAllList);
		model.addAttribute("deptTeamList", deptTeamList);
		model.addAttribute("jbgdList", jbgdList);
		model.addAttribute("teamList", teamList);
		
		// 발표 - 하드코딩
		ProjectVO projectVO = new ProjectVO();
		projectVO.setProNm("채팅 및 고객 지원 시스템 개선 프로젝트");
		projectVO.setProCn("고객이 실시간으로 상담을 받을 수 있도록 채팅 및 고객 지원 시스템을 개선하는 프로젝트");
		projectVO.setProStartDt("2024-11-18T13:00");
		projectVO.setProEndDt("2024-11-24T15:00");
		
		model.addAttribute("projectVO", projectVO);

		log.info("companyVO : " + companyVO.getCeoId());
		
		return "employee/project/projectForm";
	}
	
	/**
	 *  프로젝트 추가
	 * @param req
	 * @param ra
	 * @param projectVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/projectInsert.do")
	public String projectForm(
			HttpServletRequest req, RedirectAttributes ra,
			ProjectVO projectVO, Model model) throws Exception {
		

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		String goPage = "";

		Map<String, String> errors = new HashMap<String, String>();
		if (StringUtils.isBlank(projectVO.getProNm())) {
			errors.put("proNm", "제목을 입력해주세요");
		}
		if (StringUtils.isBlank(projectVO.getProCn())) {
			errors.put("proCn", "내용을 입력해주세요");
		}
		if (StringUtils.isBlank(projectVO.getProStartDt())) {
			errors.put("proStartDt", "시작일을 입력해주세요");
		}
		if (StringUtils.isBlank(projectVO.getProEndDt())) {
			errors.put("proEndDt", "마감일을 입력해주세요");
		}
		
		if (errors.size() > 0) {
			model.addAttribute("errors", errors);
			model.addAttribute("projectVO", projectVO);
			return "employee/project/projectForm";
		} else {
			
			if(empVO != null) {
				projectVO.setEmpId(empVO.getEmpId());
				
				List<ProjectParticipantVO> participantList = projectVO.getParticipantList();
				
				ServiceResult result = projectService.insertProForm(req, projectVO);
				if (result.equals(ServiceResult.OK)) {
					ra.addFlashAttribute("message", "프로젝트 등록 완료!");
					goPage = "redirect:/employee/canbanList.do?proNo=" + projectVO.getProNo();
					
					// 실시간 알림
					if (participantList != null && !participantList.isEmpty()) {
						for (ProjectParticipantVO participant : participantList) {
							
							EmployeeVO param = new EmployeeVO();
							param.setEmpId(projectVO.getEmpId());
							EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(param);
							
							AlarmVO alarmVO = new AlarmVO();
							alarmVO.setAlarmCategory("project");
							alarmVO.setAlarmTarget(participant.getEmpId());
							alarmVO.setAlarmCn(participant.getEmpNm() + "님 새로운 프로젝트에 참여자로 지정되셨습니다.");
							
							if (employeeAllVO.getAuthrityNm().equals("ROLE_COMPANY")) {
								alarmVO.setAlarmUrl("/company/canbanList.do?proNo=" + projectVO.getProNo());
							} else if (employeeAllVO.getAuthrityNm().equals("ROLE_EMPLOYEE")) {
								alarmVO.setAlarmUrl("/employee/canbanList.do?proNo=" + projectVO.getProNo());
							}
							
							alarmService.insertAlarm(alarmVO);
						}
					}
				} else {
					model.addAttribute("message", "서버에러, 다시 시도해주세요!");
					goPage = "employee/projectForm.do";
				}
			} else {
				ra.addFlashAttribute("message", "로그인 후 사용 가능합니다.");
				goPage = "redirect:/login.do";
			}
		}
		return goPage;
	}
	
	/**
	 *  프로젝트 수정폼
	 * @param proNo
	 * @param model
	 * @return
	 */
	@GetMapping("/projectUpdate.do")
	public String projectUpdateForm(int proNo, Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		ProjectVO projectVO = projectService.selectProject(proNo);
		model.addAttribute("projectVO", projectVO);
		
		// 참여자 리스트 출력
		List<EmployeeVO> participantList = projectService.getParticipantList(proNo);
		model.addAttribute("participantList", participantList);
		
		model.addAttribute("status", "u");
		return "employee/project/projectForm";
	}
	
	/**
	 *  프로젝트 수정
	 * @param ra
	 * @param req
	 * @param projectVO
	 * @param model
	 * @return
	 */
	@PostMapping("/projectUpdate.do")
	public String projectUpdate(
			RedirectAttributes ra, HttpServletRequest req,
			ProjectVO projectVO, Model model) {
		

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		String goPage = "";
		ServiceResult result = projectService.updateProject(req, projectVO);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "수정이 완료되었습니다.");
			goPage = "redirect:/employee/canbanList.do?proNo=" + projectVO.getProNo();
		} else {
			model.addAttribute("message", "수정에 실패했습니다.");
			model.addAttribute("projectVO", projectVO);
			model.addAttribute("status", "u");
			goPage = "employee/project/projectForm";
		}
		return goPage;
	}
	
	/**
	 *  프로젝트 삭제
	 * @param ra
	 * @param req
	 * @param proNo
	 * @param model
	 * @return
	 */
	@PostMapping("/projectDelete.do")
	public String projectDelete(
			RedirectAttributes ra, HttpServletRequest req,
			int proNo, Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		String goPage = "";
		ServiceResult result = projectService.deleteProject(req, proNo);
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "삭제가 완료되었습니다.");
			goPage = "redirect:/employee/project.do";
		} else {
			ra.addFlashAttribute("message", "서버에러, 다시 시도해주세요");
			goPage = "redirect:/employee/canbanList.do?proNo="+proNo;
		}
		return goPage;
	}
	

	/**
	 *  칸반보드 리스트
	 * @param proNo
	 * @param model
	 * @return
	 */
	@GetMapping("/canbanList.do")
	public String canbanList(@RequestParam(value = "proNo") int proNo, Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		ProjectVO projectVO = projectService.selectCanbanList(proNo);
		
		if (projectVO.getParticipantEmpNames() != null) {
			String[] name = projectVO.getParticipantEmpNames().split(", ");
			projectVO.setParticipantEmpNamesList(Arrays.asList(name));
		}
		if (projectVO.getParticipantImgFileUrls() != null) {
			String[] imgFileUrl = projectVO.getParticipantImgFileUrls().split(", ");
			projectVO.setParticipantImgFileUrlsList(Arrays.asList(imgFileUrl));
		}
		
		model.addAttribute("projectVO", projectVO);
		
		// 칸반 메인 리스트
		List<ProjectParticipantVO> proTaskList = projectTaskService.selectProTaskList(proNo);
		model.addAttribute("proTaskList", proTaskList);
		
		return "employee/project/projectCanban";
	}
	
	/**
	 *  일감 추가폼
	 * @param proNo
	 * @param model
	 * @return
	 */
	@GetMapping("/canbanForm.do")
	public String canbanForm(int proNo, Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		TeamVO teamVO = tilesService.getTeam(empVO);
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("proNo", proNo);
		
		// 날짜 유효성 검사
		ProjectVO projectVO = projectService.getProjectByNo(proNo);
		if (projectVO != null) {
			model.addAttribute("proStartDt", projectVO.getProStartDt());
			model.addAttribute("proEndDt", projectVO.getProEndDt());
		}
		
		ProjectTaskVO projectTaskVO = new ProjectTaskVO();
		
		// 발표용 하드코딩
		projectTaskVO.setProTaskNm("보안/인증 필터링");
		projectTaskVO.setProTaskCn("AOP를 이용해 애플리케이션의 메소드 실행 시간을 모니터링");
		projectTaskVO.setProTaskStartDt("2024-11-18T15:00");
		projectTaskVO.setProTaskEndDt("2024-11-20T18:00");
		
		
		
		model.addAttribute("projectVO", projectVO);
		model.addAttribute("projectTaskVO", projectTaskVO);
		
		
		return "employee/project/proTaskForm";
	}
	
	/**
	 *  일감 추가
	 * @param req
	 * @param ra
	 * @param projectVO
	 * @param projectTaskVO
	 * @param model
	 * @return
	 */
	@PostMapping("/canbanInsert.do")
	public String canbanInsert(
			HttpServletRequest req, RedirectAttributes ra,
			ProjectVO projectVO, ProjectTaskVO projectTaskVO, Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		projectTaskVO.setEmpId(empVO.getEmpId());
		
		
		String goPage = "";
		Map<String, String> errors = new HashMap<String, String>();
		
		if (StringUtils.isBlank(projectTaskVO.getProTaskNm())) {
			errors.put("proTaskNm", "제목을 입력해주세요");
		}
		if (StringUtils.isBlank(projectTaskVO.getProTaskCn())) {
			errors.put("proTaskCn", "내용을 입력해주세요");
		}
		if (StringUtils.isBlank(projectTaskVO.getProTaskStartDt())) {
			errors.put("proTaskStartDt", "시작일을 입력해주세요");
		}
		if (StringUtils.isBlank(projectTaskVO.getProTaskEndDt())) {
			errors.put("proTaskEndDt", "마감일을 입력해주세요");
		}
		
		if (errors.size() > 0) {
			model.addAttribute("errors", errors);
			model.addAttribute("projectVO", projectVO);
			model.addAttribute("projectTaskVO", projectTaskVO);
			goPage = "employee/project/proTasktForm";
		} else {
			if (empVO != null) {
				projectTaskVO.setEmpId(projectTaskVO.getEmpId());
				ServiceResult result = projectTaskService.insertProTask(req, projectTaskVO);
				if (result.equals(ServiceResult.OK)) {
					ra.addAttribute("proNo", projectVO.getProNo());
					ra.addFlashAttribute("projectTaskVO", projectTaskVO);
					ra.addFlashAttribute("message", "일감이 등록 완료됐습니다.");
					
					// 실시간 알림
					List<EmployeeVO> taskParticipants = projectService.getParticipantList(projectVO.getProNo());
					if (taskParticipants != null && !taskParticipants.isEmpty()) {
					    for (EmployeeVO participant : taskParticipants) {
					    	
							EmployeeVO param = new EmployeeVO();
							param.setEmpId(participant.getEmpId());
							EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(param);
							
							AlarmVO alarmVO = new AlarmVO();
							alarmVO.setAlarmCategory("project");
							alarmVO.setAlarmTarget(participant.getEmpId());
						    alarmVO.setAlarmCn(participant.getEmpNm() + "님 일감이 추가 되었습니다.");
							
							if (employeeAllVO.getAuthrityNm().equals("ROLE_COMPANY")) {
								alarmVO.setAlarmUrl("/company/canbanList.do?proNo=" + projectVO.getProNo());
							} else if (employeeAllVO.getAuthrityNm().equals("ROLE_EMPLOYEE")) {
								alarmVO.setAlarmUrl("/employee/canbanList.do?proNo=" + projectVO.getProNo());
							}
							alarmService.insertAlarm(alarmVO);
						}
					}
					
					EmployeeAllVO creator = empAllInfoService.selectEmpImpl(empVO);
					AlarmVO creatorAlarm = new AlarmVO();
					creatorAlarm.setAlarmCategory("project");
					creatorAlarm.setAlarmTarget(creator.getEmpId());
					creatorAlarm.setAlarmCn(creator.getEmpNm() + "님 일감이 추가 되었습니다.");
					creatorAlarm.setAlarmUrl("/employee/canbanList.do?proNo=" + projectVO.getProNo());
					alarmService.insertAlarm(creatorAlarm);
					
					goPage = "redirect:/employee/canbanList.do";
				} else {
					model.addAttribute("message", "서버에러, 다시 시도해주세요!");
					goPage = "employee/proTaskForm.do";
				}
			} else {
				ra.addFlashAttribute("message", "로그인 후 사용 가능합니다.");
				goPage = "redirect:/login.do";
			}
		}
		return goPage;
	}

	/**
	 *  일감 수정폼
	 * @param proTaskNo
	 * @param model
	 * @return
	 */
	@GetMapping("/canbanUpdate.do")
	public String canbanUpdateForm(int proTaskNo, Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		ProjectTaskVO projectTaskVO = projectTaskService.selectProTask(proTaskNo);
		model.addAttribute("projectTaskVO", projectTaskVO);
		model.addAttribute("status", "u");
		
		return "employee/project/proTaskForm";
	}

	/**
	 *  일감 수정
	 * @param ra
	 * @param req
	 * @param projectTaskVO
	 * @param model
	 * @return
	 */
	@PostMapping("/canbanUpdate.do")
	public String canbanUpdate(
			RedirectAttributes ra, HttpServletRequest req, 
			ProjectTaskVO projectTaskVO, Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
	    String goPage = "";
	    ServiceResult result = projectTaskService.updateProTask(req, projectTaskVO);

	    if(result.equals(ServiceResult.OK)) {
	        ra.addFlashAttribute("message", "수정이 완료되었습니다.");
	        int proNo = projectTaskService.selectProNoByTaskNo(projectTaskVO.getProTaskNo());
	        goPage = "redirect:/employee/canbanList.do?proNo=" + proNo;
	    } else {
	        model.addAttribute("message", "수정에 실패했습니다.");
	        model.addAttribute("projectTaskVO", projectTaskVO);
	        model.addAttribute("status", "u");
	        goPage = "employee/project/proTaskForm";
	    }
	    return goPage;
	}

	
	/**
	 *  일감 삭제
	 * @param ra
	 * @param req
	 * @param proTaskNo
	 * @param model
	 * @return
	 */
	@PostMapping("/canbanDelete.do")
	public String canbanDelete(
			RedirectAttributes ra, HttpServletRequest req,
			int proTaskNo, Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		String goPage = "";
		int proNo = 0;
		ServiceResult result = projectTaskService.deleteProTask(req, proTaskNo);
		
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "삭제가 완료되었습니다.");
			
			proNo = projectTaskService.selectProNoByTaskNo(proTaskNo);
			goPage = "redirect:/employee/canbanList.do?proNo="+proNo;
		} else {
			ra.addFlashAttribute("message", "서버에러, 다시 시도해주세요");
			proNo = projectTaskService.selectProNoByTaskNo(proTaskNo);
			goPage = "redirect:/employee/canbanList.do?proNo="+proNo;
		}
		return goPage;
	}

	
	/**
	 *  일감 상태코드 변경
	 * @param ptVO
	 * @param model
	 * @return
	 */
	@PostMapping("/updateTaskStatus.do")
	public ResponseEntity<String> updateTaskStatus(
			@RequestBody ProjectTaskVO ptVO, Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		int cnt = projectTaskService.updateProTaskStts(ptVO);
		return ResponseEntity.ok("상태가 업데이트 되었습니다.");
	}
		
	/**
	 *  간트차트
	 * @param proNo
	 * @param model
	 * @return
	 */
	@GetMapping("/ganttList.do")
	public String projectDetail(int proNo, Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		ProjectVO projectVO = projectService.selectCanbanList(proNo);
		model.addAttribute("projectVO", projectVO);
		
	    List<ProjectTaskVO> ganttList = projectTaskService.selectGanttList(proNo);
	    for (ProjectTaskVO projectTask : ganttList) {
//			projectService.updateProjectStts(project.getProNo());
			
			if (projectTask.getParticipantEmpNames() != null) {
				String[] name = projectTask.getParticipantEmpNames().split(", ");
				projectTask.setParticipantEmpNamesList(Arrays.asList(name));
			}
			if (projectTask.getParticipantImgFileUrls() != null) {
				String[] imgFileUrl = projectTask.getParticipantImgFileUrls().split(", ");
				projectTask.setParticipantImgFileUrlsList(Arrays.asList(imgFileUrl));
			}
		}
	    model.addAttribute("ganttList", ganttList);
	    return "employee/project/projectGantt";
	}
}

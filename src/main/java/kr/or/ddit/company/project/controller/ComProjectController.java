package kr.or.ddit.company.project.controller;

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
@RequestMapping("/company")
@PreAuthorize("hasAnyRole('ROLE_COMPANY')")
public class ComProjectController {
	
	@Inject
	private IProjectService projectService;
	
	@Inject
	private IProjectTaskService projectTaskService;
	
	@Inject
	private ITIlesService tilesService;

	@Inject
	private IInformationService infoService;
	
	/**
	 * 프로젝트 메인 홈
	 * @param model
	 * @return
	 */
	@GetMapping("/project.do")
	public String project(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		String empId = empVO.getEmpId();
		String coCd = empVO.getCoCd();
		
		// 프로젝트 메인 홈 카드 리스트
		List<ProjectVO> proCardList = projectService.selectComProCardList(coCd);
		
		for (ProjectVO project : proCardList) {
	//					projectService.updateProjectStts(project.getProNo());
			
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
		
		return "company/project/projectMain";
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		

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

		
		return "company/project/projectForm";
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
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
			return "company/project/projectForm";
		} else {
			
			if(empVO != null) {
				projectVO.setEmpId(empVO.getEmpId());
				ServiceResult result = projectService.insertProForm(req, projectVO);
				if (result.equals(ServiceResult.OK)) {
					ra.addFlashAttribute("message", "프로젝트 등록 완료!");
					goPage = "redirect:/company/canbanList.do?proNo=" + projectVO.getProNo();
				} else {
					model.addAttribute("message", "서버에러, 다시 시도해주세요!");
					goPage = "company/projectForm.do";
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		ProjectVO projectVO = projectService.selectProject(proNo);
		model.addAttribute("projectVO", projectVO);
		
		List<EmployeeVO> participantList = projectService.getParticipantList(proNo);
		model.addAttribute("participantList", participantList);
		
		model.addAttribute("status", "u");
		return "company/project/projectForm";
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		String goPage = "";
		ServiceResult result = projectService.updateProject(req, projectVO);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "수정이 완료되었습니다.");
			goPage = "redirect:/company/canbanList.do?proNo=" + projectVO.getProNo();
		} else {
			model.addAttribute("message", "수정에 실패했습니다.");
			model.addAttribute("projectVO", projectVO);
			model.addAttribute("status", "u");
			goPage = "company/project/projectForm";
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		String goPage = "";
		ServiceResult result = projectService.deleteProject(req, proNo);
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "삭제가 완료되었습니다.");
			goPage = "redirect:/company/project.do";
		} else {
			ra.addFlashAttribute("message", "서버에러, 다시 시도해주세요");
			goPage = "redirect:/company/canbanList.do?proNo="+proNo;
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
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
		
		return "company/project/projectCanban";
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		ProjectVO projectVO = projectService.getProjectByNo(proNo);
		if (projectVO != null) {
			model.addAttribute("proStartDt", projectVO.getProStartDt());
			model.addAttribute("proEndDt", projectVO.getProEndDt());
		}
		
		model.addAttribute("proNo", proNo);
		ProjectTaskVO projectTaskVO = new ProjectTaskVO();
		model.addAttribute("projectTaskVO", projectTaskVO);
		return "company/project/proTaskForm";
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
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
			goPage = "company/project/proTasktForm";
		} else {
			if (empVO != null) {
				projectTaskVO.setEmpId(projectTaskVO.getEmpId());
				ServiceResult result = projectTaskService.insertProTask(req, projectTaskVO);
				if (result.equals(ServiceResult.OK)) {
					ra.addAttribute("proNo", projectVO.getProNo());
					ra.addFlashAttribute("projectTaskVO", projectTaskVO);
					ra.addFlashAttribute("message", "일감이 등록 완료됐습니다.");
					goPage = "redirect:/company/canbanList.do";
				} else {
					model.addAttribute("message", "서버에러, 다시 시도해주세요!");
					goPage = "company/proTaskForm.do";
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
				
		ProjectTaskVO projectTaskVO = projectTaskService.selectProTask(proTaskNo);
		model.addAttribute("projectTaskVO", projectTaskVO);
		model.addAttribute("status", "u");
		
		return "company/project/proTaskForm";
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
	    String goPage = "";
	    ServiceResult result = projectTaskService.updateProTask(req, projectTaskVO);

	    if(result.equals(ServiceResult.OK)) {
	        ra.addFlashAttribute("message", "수정이 완료되었습니다.");
	        int proNo = projectTaskService.selectProNoByTaskNo(projectTaskVO.getProTaskNo());
	        goPage = "redirect:/company/canbanList.do?proNo=" + proNo;
	    } else {
	        model.addAttribute("message", "수정에 실패했습니다.");
	        model.addAttribute("projectTaskVO", projectTaskVO);
	        model.addAttribute("status", "u");
	        goPage = "company/project/proTaskForm";
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		String goPage = "";
		int proNo = 0;
		ServiceResult result = projectTaskService.deleteProTask(req, proTaskNo);
		
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "삭제가 완료되었습니다.");
			
			proNo = projectTaskService.selectProNoByTaskNo(proTaskNo);
			goPage = "redirect:/company/canbanList.do?proNo="+proNo;
		} else {
			ra.addFlashAttribute("message", "서버에러, 다시 시도해주세요");
			proNo = projectTaskService.selectProNoByTaskNo(proTaskNo);
			goPage = "redirect:/company/canbanList.do?proNo="+proNo;
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
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
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		ProjectVO projectVO = projectService.selectCanbanList(proNo);
		model.addAttribute("projectVO", projectVO);
		
	    List<ProjectTaskVO> ganttList = projectTaskService.selectGanttList(proNo);
	    model.addAttribute("ganttList", ganttList);
	    return "company/project/projectGantt";
	}
}

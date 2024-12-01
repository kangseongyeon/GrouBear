package kr.or.ddit.comm.tiles.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.comm.elapr.service.IMyElaprService;
import kr.or.ddit.comm.elapr.vo.ElaprVO;
import kr.or.ddit.comm.project.service.IProjectService;
import kr.or.ddit.comm.project.vo.ProjectVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.community.service.IComCommunityService;
import kr.or.ddit.company.community.vo.ComCommunityVO;
import kr.or.ddit.company.personnelInformation.service.IInformationService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import kr.or.ddit.company.provedoc.service.IComProvedocService;
import kr.or.ddit.company.provedoc.vo.ComProvedocVO;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/company")
@PreAuthorize("hasRole('ROLE_COMPANY')")
public class CompanyMainController {

	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IInformationService infoService;

	@Inject
	private IProjectService projectService;
	
	@Inject
	private IMyElaprService myElaprService;
	
	@Inject
	private IComProvedocService provedocService;
	
	@Inject
	private IComCommunityService comCmntyService;
	
	@GetMapping("/main.do")
	public String home(Locale locale, Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		List<EmployeeVO> empAllList = infoService.comAllEmpList(empVO);
		List<DepartmentVO> deptList = infoService.selectDeptList(empVO);
		List<JobGradeVO> jbgdList = infoService.selectJBGDList(empVO);
		List<TeamVO> teamList = infoService.selectTeamList(empVO);
		model.addAttribute("empAllList", empAllList);
		model.addAttribute("deptList", deptList);
		model.addAttribute("jbgdList", jbgdList);
		model.addAttribute("teamList", teamList); 
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		
		String empId = empVO.getEmpId();
		String coCd = empVO.getCoCd();
		// 프로젝트 리스트 출력
		List<ProjectVO> proCardList = projectService.selectComProCardList(coCd);
		for (ProjectVO project : proCardList) {
			
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
		
		/**
		 * 전자결재
		 */
		// 전자결재 긴급 문서 리스트 출력
		List<ElaprVO> emrgList = myElaprService.selectEmrgHomeList(empId);
		model.addAttribute("emrgList", emrgList);
		
		// 전자결재 전체 문서 리스트 출력
		List<ElaprVO> allList = myElaprService.selectAllHomeList(empId);
		model.addAttribute("allList", allList);
		
		// 전자결재 참조 문서 리스트 출력
		List<ElaprVO> rerncList = myElaprService.selectRerncHomeList(empId);
		model.addAttribute("rerncList", rerncList);
		
		// 전자결재 열람 문서 리스트 출력
		List<ElaprVO> prslList = myElaprService.selectPrslHomeList(empId);
		model.addAttribute("prslList", prslList);
		
		
		// 현재 전체 증명서와 미발급 증명서 수 카운트하기
		ComProvedocVO provedocCount = provedocService.provedocComCount(empVO.getCoCd());
		model.addAttribute("provedocCount", provedocCount);
		
		

		List<ComCommunityVO> comCmntyList = comCmntyService.communityCompany(empVO);
		model.addAttribute("comCmntyList", comCmntyList);
		
		
		
		return "company/mainPage/home";
	}
	
}

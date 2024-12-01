package kr.or.ddit.company.work.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.websocket.server.PathParam;

import org.apache.commons.lang3.StringUtils;
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

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.service.IInformationService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import kr.or.ddit.company.work.service.IComWorkService;
import kr.or.ddit.company.work.vo.workStatusVO;
import kr.or.ddit.company.workform.service.IComWorkManagementService;
import kr.or.ddit.employee.workStatus.vo.EmpWorkStatusVO;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
@RequestMapping("/company")
@PreAuthorize("hasRole('ROLE_COMPANY')")
public class ComWorkController {

	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IComWorkService workService;
	@Inject
	private IComWorkManagementService workmanagementSerivce;
	@Inject
	private IInformationService infoService;
	
	@GetMapping("/workstatus.do")
	public String departmentWork(Model model){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		model.addAttribute("workMenu", "show");	
		model.addAttribute("workStatus", "active");
		return "company/workmanagement/comWorkStatus";
	}
	
	@PostMapping("/getWorkStatus.do")
	public ResponseEntity<List<EmpWorkStatusVO>> getworkstatus(@RequestBody EmpWorkStatusVO ewsVO)throws Exception{
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		log.info("date :::" + ewsVO);
		
		ewsVO.setCoCd(employeeVO.getCoCd());
		
		List<EmpWorkStatusVO> ewsList = workService.getEwsList(ewsVO);
	
		
		return new ResponseEntity<List<EmpWorkStatusVO>>(ewsList,HttpStatus.OK);
	}
	
	

}

































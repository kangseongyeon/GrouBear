package kr.or.ddit.employee.vacation.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.mvel2.ast.ReturnNode;
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

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.service.IInformationService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import kr.or.ddit.employee.vacation.service.IEmpVacationService;
import kr.or.ddit.employee.vacation.vo.VacationApplyApprovalVO;
import kr.or.ddit.employee.vacation.vo.VacationApplyVO;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
@RequestMapping("/employee")
@PreAuthorize("hasRole('ROLE_EMPLOYEE')")
public class EmpVacationApplicationController {
	
	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IEmpVacationService vacationService; 
	
	@Inject
	private IInformationService infoService;
	
	@GetMapping("/vacation/applicationhistory.do")
	public String vacationManagement(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		CompanyVO companyVO = tilesService.getCompany(empVO);
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		TeamVO teamVO = tilesService.getTeam(empVO);
		
		// 리스트 페이징 처리하기
		PaginationInfoVO<VacationApplyVO> pagingVO = new PaginationInfoVO<VacationApplyVO>(10,5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		// startRow, endRow, startpage, endPage를 결정한다.
		pagingVO.setCurrentPage(currentPage); 
		
		// 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
		int totalRecord = vacationService.getvctAppDetailListCount(pagingVO);
		
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord); 
		
		// 총 게시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의 리스트 데이터를 가져온다.
		List<VacationApplyVO> List = vacationService.getAppDetail(pagingVO);
		pagingVO.setDataList(List);		
		
		
		List<EmployeeVO> empAllList = infoService.comAllEmpList(empVO);
		List<DepartmentVO> deptTeamList = infoService.selectDeptTeamList(empVO);
		List<JobGradeVO> jbgdList = infoService.selectJBGDList(empVO);
		List<TeamVO> teamList = infoService.selectTeamListByDept(empVO);
		model.addAttribute("companyVO", companyVO);
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("empAllList", empAllList);
		model.addAttribute("deptTeamList", deptTeamList);
		model.addAttribute("jbgdList", jbgdList);
		model.addAttribute("teamList", teamList);

		
		model.addAttribute("workMenu", "show");	
		model.addAttribute("vacationApplication", "active");
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("pagingVO",pagingVO);
		
		return "employee/vacation/empVacationApplicationHistory";
	}
	
	@ResponseBody
	@PostMapping("/vacation/getVctCnt.do")
	public ResponseEntity<String> getVctCnt(){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		int result = vacationService.getVctCnt(empVO.getEmpId());
		int result2 = vacationService.getVctApplyCnt(empVO.getEmpId());
			
		
		int sum = 0;
		if (result == 0 && result2 == 0) {
			return new ResponseEntity<String>(sum+"", HttpStatus.OK);
		}
		if(result == 0) {
			sum = result2 + 0;
			return new ResponseEntity<String>(sum+"", HttpStatus.OK);
		}
		if (result2 == 0) {
			sum = result + 0;
			return new ResponseEntity<String>(sum+"", HttpStatus.OK);
		}
		
		sum = result - result2;
		return new ResponseEntity<String>(sum+"", HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping("/vacation/vctapplication.do")
	public ResponseEntity<String> vctApplication(@RequestBody Map<String, String> vctAppVal){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		String vaSeq = vacationService.getVaSeq();
		
		// 휴가 신청 테이블 입력
		VacationApplyVO vaVO = new VacationApplyVO();
		vaVO.setVctAplyCd(vaSeq);
		vaVO.setEmpId(empVO.getEmpId());
		vaVO.setVctRsn(vctAppVal.get("vct_rsn"));
		vaVO.setVctBgngDt(vctAppVal.get("start_dt")); 
		vaVO.setVctEndDt(vctAppVal.get("end_dt"));
		vaVO.setVctUseDayCnt(vctAppVal.get("use_cnt"));
		vaVO.setVctRegUser(empVO.getEmpId());
		
		int vaResult = vacationService.insertVacationApply(vaVO);
		if(vaResult == 1) {
			// 휴가 신청 결재 테이블 입력
			VacationApplyApprovalVO vaaVO = new VacationApplyApprovalVO();
			String sprList = vctAppVal.get("aprList");
			sprList = sprList.substring(0, sprList.length() - 1);
			String[] appList = sprList.split(",");
			int vaaResult = 0;
			for (int i = 0; i < appList.length; i++) {
				vaaVO.setVctAplyCd(vaSeq);
				vaaVO.setVctAplyAprId(appList[i]);
				vaaVO.setVctAplyAprSeq(i+1);
				vaaResult = vacationService.insertVacationApplyApproval(vaaVO);
			}
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		
		return new ResponseEntity<String>("error", HttpStatus.BAD_REQUEST);
	}
	
	@GetMapping("/vacation/approval.do")
	public String approval(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		CompanyVO companyVO = tilesService.getCompany(empVO);
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		TeamVO teamVO = tilesService.getTeam(empVO);
		
		// 리스트 페이징 처리하기
		PaginationInfoVO<VacationApplyVO> pagingVO = new PaginationInfoVO<VacationApplyVO>(10,5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		// startRow, endRow, startpage, endPage를 결정한다.
		pagingVO.setCurrentPage(currentPage); 
		
		// 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
		int totalRecord = vacationService.getvctAppAprListCount(pagingVO);
		
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord); 
		
		// 총 게시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의 리스트 데이터를 가져온다.
		List<VacationApplyVO> List = vacationService.getAppAprList(pagingVO);
		pagingVO.setDataList(List);		
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("pagingVO",pagingVO);
		
		model.addAttribute("workMenu", "show");	
		model.addAttribute("vacationApproval", "active");
		
		return "employee/vacation/empVacationApproval";
	}
	
	
	@ResponseBody
	@PostMapping("/vacation/approvalInfo.do")
	public ResponseEntity<VacationApplyVO> approvalInfo(@RequestBody VacationApplyVO getvaVO){
		
		VacationApplyVO vaVO = vacationService.getApprovalInfo(getvaVO.getVctAplyCd());
		if (vaVO == null) {
			return new ResponseEntity<VacationApplyVO>(vaVO,HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<VacationApplyVO>(vaVO,HttpStatus.OK);
				
	}
	
	@ResponseBody
	@PostMapping("/vacataion/aplyapr.do")
	public ResponseEntity<String> aplyapr(@RequestBody VacationApplyApprovalVO getVaaVO){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		getVaaVO.setVctAplyAprId(empVO.getEmpId());
		int result = vacationService.aplyapr(getVaaVO);
		if(result == 1) {
			return new ResponseEntity<String>("success",HttpStatus.OK);
		}
		return new ResponseEntity<String>("error",HttpStatus.BAD_REQUEST);
	}
	
	@ResponseBody
	@PostMapping("/vacation/getRsn.do")
	public ResponseEntity<String> getRsn(@RequestBody VacationApplyApprovalVO vaaVO){
		String aprRsn = vacationService.getRsn(vaaVO.getVctAplyCd());
		
		return new ResponseEntity<String>(aprRsn,HttpStatus.OK);
	}
}

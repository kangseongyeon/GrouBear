package kr.or.ddit.company.workform.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.service.IInformationService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.workform.service.IComWorkManagementService;
import kr.or.ddit.company.workform.vo.CompanyWorkFormVO;
import kr.or.ddit.company.workform.vo.WorkFormVO;
import kr.or.ddit.employee.workStatus.service.IEmpWorkStatusService;
import kr.or.ddit.employee.workStatus.vo.EmpWorkStatusVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_COMPANY')")
@RequestMapping("/company")
public class ComWorkManagementController {
	
	@Inject
	private IComWorkManagementService workmanagementSerivce;
	
	@Inject
	private IInformationService infomationService;
	
	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IEmpWorkStatusService  workStatusService;
	
	
	@GetMapping("/worksetting.do")
	public String workSetting(Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		WorkFormVO wfVO = workmanagementSerivce.getBaseWorkForm(empVO);
		List<DepartmentVO> deptList = infomationService.selectDeptList(empVO);
		List<CompanyWorkFormVO> wfList = workmanagementSerivce.getWorkFormList(empVO);
		for (CompanyWorkFormVO cwfVO : wfList) {
			String week = "";
			if(cwfVO.getWorkFormSunYn().equals("CHECKED")) {
				week += "일,";
			}
			if(cwfVO.getWorkFormMonYn().equals("CHECKED")) {
				week += "월,";
			}
			if(cwfVO.getWorkFormTueYn().equals("CHECKED")) {
				week += "화,";
			}
			if(cwfVO.getWorkFormWebYn().equals("CHECKED")) {
				week += "수,";
			}
			if(cwfVO.getWorkFormThuYn().equals("CHECKED")) {
				week += "목,";
			}
			if(cwfVO.getWorkFormFriYn().equals("CHECKED")) {
				week += "금,";
			}
			if(cwfVO.getWorkFormSatYn().equals("CHECKED")) {
				week += "토,";
			}
			week = week.substring(0, week.length()-1);
			cwfVO.setWorkFormWeek(week);
		}		
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		model.addAttribute("wfVO",wfVO);
		model.addAttribute("deptList",deptList);
		model.addAttribute("wfList",wfList);
		model.addAttribute("workMenu", "show");	
		model.addAttribute("workSetting", "active");
		return "company/workmanagement/comWorkSetting";
		
	}
	
	
	
	@ResponseBody
	@PostMapping("/getdeptsetting.do")
	public ResponseEntity<WorkFormVO> getDeptSetting(@RequestBody String deptCd){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		WorkFormVO getwfVO = workmanagementSerivce.getDeptWorkForm(deptCd);
		return new ResponseEntity<WorkFormVO>(getwfVO, HttpStatus.OK);	
	}
	
	@ResponseBody
	@PostMapping("/getbasesetting.do")
	public ResponseEntity<WorkFormVO> getBaseSetting(){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		WorkFormVO getwfVO = workmanagementSerivce.getBaseWorkForm(employeeVO);
		
		return new ResponseEntity<WorkFormVO>(getwfVO, HttpStatus.OK);	
	}
	
	
	@ResponseBody
	@PostMapping("/worksettingdept.do")
	public ResponseEntity<String> settingDept(@RequestBody Map<String, String> basicVal){		log.info("=======settingbasic.do=======");
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		WorkFormVO wfVO = new WorkFormVO();
		String gtwkTm = (String)basicVal.get("gtwk_tm_val");
		String lvrmTm = (String)basicVal.get("lvrm_tm_val");
		String breakStart = (String)basicVal.get("break_start_val");
		String breakEnd = (String)basicVal.get("break_end_val");
		wfVO.setDepartmentCd(basicVal.get("deptSelect"));
		wfVO.setCoCd(employeeVO.getCoCd());
		wfVO.setWorkFormGtwkTm(gtwkTm);
		wfVO.setWorkFormLvrmTm(lvrmTm);
		wfVO.setWorkFormBreakBgngTm(breakStart);
		wfVO.setWorkFormBreakEndTm(breakEnd);
		wfVO.setWorkFormSunYn(basicVal.get("sun"));
		wfVO.setWorkFormMonYn(basicVal.get("mon"));
		wfVO.setWorkFormTueYn(basicVal.get("tue"));
		wfVO.setWorkFormWebYn(basicVal.get("web"));
		wfVO.setWorkFormThuYn(basicVal.get("thu"));
		wfVO.setWorkFormFriYn(basicVal.get("fri"));
		wfVO.setWorkFormSatYn(basicVal.get("sat"));
		
		WorkFormVO getwfVO = workmanagementSerivce.getDeptWorkForm(wfVO.getDepartmentCd());
		if (getwfVO != null) {
			int udtResult = workmanagementSerivce.udtDeptWorkForm(wfVO);
			if(udtResult == 1) {
				return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}else {
				return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
			}
		}else {
			int insertResult = workmanagementSerivce.insertDeptWorkForm(wfVO);
			
			if (insertResult == 1) {
				return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);	
			}else {
				return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
			}
		}
	}
	
	
	
	@ResponseBody
	@PostMapping("/worksettingbasic.do")
	public ResponseEntity<String> settingBasic(@RequestBody Map<String, String> basicVal){		log.info("=======settingbasic.do=======");
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		

		WorkFormVO wfVO = new WorkFormVO();
		String gtwkTm = (String)basicVal.get("gtwk_tm_val");
		String lvrmTm = (String)basicVal.get("lvrm_tm_val");
		String breakStart = (String)basicVal.get("break_start_val");
		String breakEnd = (String)basicVal.get("break_end_val");
		wfVO.setCoCd(employeeVO.getCoCd());
		wfVO.setWorkFormGtwkTm(gtwkTm);
		wfVO.setWorkFormLvrmTm(lvrmTm);
		wfVO.setWorkFormBreakBgngTm(breakStart);
		wfVO.setWorkFormBreakEndTm(breakEnd);
		wfVO.setWorkFormSunYn(basicVal.get("sun"));
		wfVO.setWorkFormMonYn(basicVal.get("mon"));
		wfVO.setWorkFormTueYn(basicVal.get("tue"));
		wfVO.setWorkFormWebYn(basicVal.get("web"));
		wfVO.setWorkFormThuYn(basicVal.get("thu"));
		wfVO.setWorkFormFriYn(basicVal.get("fri"));
		wfVO.setWorkFormSatYn(basicVal.get("sat"));
		
		
		WorkFormVO getwfVO = workmanagementSerivce.getBaseWorkForm(employeeVO);
		if (getwfVO != null) {
			
			int udtResult = workmanagementSerivce.udtBaseWorkForm(wfVO);
			
			if (udtResult == 1) {
				return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}else {
				return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);	
			}
		}else {
			int insertResult = workmanagementSerivce.insertBaseWorkForm(wfVO);
			
			if (insertResult == 1) {
				return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);	
			}else {
				return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
			}
		}
	}
	
	
	@GetMapping("/todayworkstatus.do")
	public String todayWorkStatus(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(name="searchDate", required = false, defaultValue = "") String searchDate,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model,
			HttpServletRequest request
			){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		if(searchDate.equals("")) {
			Date today = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy년 MM월 dd일"); 
			searchDate = formatter.format(today);
		}
		
		PaginationInfoVO<EmpWorkStatusVO> pagingVO = new PaginationInfoVO<EmpWorkStatusVO>(10,5);
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setCoCd(employeeVO.getCoCd());
		pagingVO.setDate(searchDate);
		
		int totalRecord = workmanagementSerivce.getTodayWorkStatustCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord); 
		pagingVO.setCoCd(employeeVO.getCoCd());
		List<EmpWorkStatusVO> todayWSList = workmanagementSerivce.getTodayWorkStatus(pagingVO);
		pagingVO.setDataList(todayWSList);
		
		
		
		 
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("formatedNow",searchDate);
		model.addAttribute("workMenu", "show");	
		model.addAttribute("todayWorkStatus", "active");
		return "company/workmanagement/comTodayWorkStatus";
	}
	
	@ResponseBody
	@PostMapping("/getEmpTodayWorkStts.do")
	public ResponseEntity<EmpWorkStatusVO>getEmpTodayWorkStts (@RequestBody String empId){
		EmpWorkStatusVO empwsttsVO = workmanagementSerivce.getEmpTodayWorkStts(empId);
		if (empwsttsVO != null) {
			return new ResponseEntity<EmpWorkStatusVO>(empwsttsVO,HttpStatus.OK);
		}
		return new ResponseEntity<EmpWorkStatusVO>(empwsttsVO,HttpStatus.BAD_REQUEST);
	}
	
	
	@ResponseBody
	@PostMapping("/updateEmpTodayWorkStts.do")
	public ResponseEntity<String>updateEmpTodayWorkStts (@RequestBody EmpWorkStatusVO empWorkSttsVO){
		int startMin = 0;		
		
		if(!empWorkSttsVO.getWorkBgngTm().isEmpty()) {
			int bgngTm = Integer.parseInt(empWorkSttsVO.getWorkBgngTm());
			

			if((int)(Math.log10(bgngTm)+1)== 4) {
				startMin = (Integer.parseInt((bgngTm+"").substring(0,2))*60) + Integer.parseInt((bgngTm+"").substring(2,4));
			}else {
				startMin = (Integer.parseInt((bgngTm+"").substring(0,1))*60) + Integer.parseInt((bgngTm+"").substring(1,3));
			}	
		}
		int endMin = 0;	
		if(!empWorkSttsVO.getWorkEndTm().isEmpty()) {
			int endTm = Integer.parseInt(empWorkSttsVO.getWorkEndTm());

			if((int)(Math.log10(endTm)+1)== 4) {
				endMin = (Integer.parseInt((endTm+"").substring(0,2))*60) + Integer.parseInt((endTm+"").substring(2,4));
			}else {
				endMin = (Integer.parseInt((endTm+"").substring(0,1))*60) + Integer.parseInt((endTm+"").substring(1,3));
			}	
			
		}
		empWorkSttsVO.setWorkTm((endMin-startMin)+"");
		
		int result = 0;
		
		if(empWorkSttsVO.getWorkSttsCd().isEmpty()) {
			result =  workStatusService.startWork(empWorkSttsVO);
		}else {
			result = workmanagementSerivce.updateEmpTodayWorkStts(empWorkSttsVO);
		}
		
		if(result == 1) {
			return new ResponseEntity<String>("success",HttpStatus.OK);
		}
		return new ResponseEntity<String>("",HttpStatus.BAD_REQUEST);
	}
	
	@ResponseBody
	@PostMapping("/delEmpTodayWorkStts.do")
	public ResponseEntity<String>delEmpTodayWorkStts (@RequestBody String wscd){
		int result = workmanagementSerivce.delEmpTodayWorkStts(wscd);
		if (result == 1) {
			return new ResponseEntity<String>("success",HttpStatus.OK);
		}
		return new ResponseEntity<String>("",HttpStatus.BAD_REQUEST);
	}
	
}

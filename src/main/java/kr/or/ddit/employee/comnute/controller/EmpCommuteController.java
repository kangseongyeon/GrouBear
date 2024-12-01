package kr.or.ddit.employee.comnute.controller;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import kr.or.ddit.company.work.vo.workStatusVO;
import kr.or.ddit.company.workform.vo.WorkFormVO;
import kr.or.ddit.employee.comnute.service.ICommuteService;
import kr.or.ddit.employee.workStatus.service.IEmpWorkStatusService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/employee")
@PreAuthorize("hasRole('ROLE_EMPLOYEE')")
public class EmpCommuteController {
	
	@Inject
	private ITIlesService tilesService;
	
	@Inject 
	private ICommuteService commuteService;
	
	@Inject
	private IEmpWorkStatusService  workStatusService;
	
	
	@GetMapping("/commute/management.do")
	public String CommuteManagement(Locale locale, Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		//지각 횟수 가져오기
		int lateCnt = commuteService.getLateCnt(empVO);
		
		//결근 횟수 가져오기
		int absenceCnt = commuteService.getAbsenceCnt(empVO); 
		
		//총 휴가일수 가져오기
		int totalVctCnt = commuteService.gettotalVctCnt(empVO);
		
		//사용 휴가 일수 가져오기
		int uesVctCnt = commuteService.getuseVctCnt(empVO);
		
		//잔여 휴가
		int remainVctCnt = totalVctCnt - uesVctCnt;
		
		//총 근무 시간 가져오기
		String workTm = "";
		long workTime = commuteService.getWorkTime(empVO);
		if(workTime > 60) {
			 workTm = (workTime/60)+"시간"+(workTime%60)+"분";
		}else {
			workTm = workTime+"분";
		}
		
		//총 근무일수 가져오기
		long workCnt = commuteService.getWorkCnt(empVO);
		
		//근무 시간 가져오기
		WorkFormVO wfVO = commuteService.getworkSettingTm(empVO);
		//금일 근무 현황 가져오기
		int chkResult = workStatusService.chkworksttsVO(empVO);
		workStatusVO wsVO = new workStatusVO();
		if(chkResult == 1) {
			wsVO = commuteService.getWorkStatus(empVO);
			String tm = "";
			String fTm = "";
			String sTm = "";
			if (wsVO.getWorkBgngTm() != null) {
				tm = wsVO.getWorkBgngTm();
				if(tm.length() == 3) {
					fTm = tm.substring(0, 1);
					sTm = tm.substring(1,3);
					tm = fTm + ":" + sTm;
					wsVO.setWorkBgngTm(tm);
				}else {
					fTm = tm.substring(0, 2);
					sTm = tm.substring(2,4);
					tm = fTm + ":" + sTm;
					wsVO.setWorkBgngTm(tm);
				}
			}
			
			if(wsVO.getWorkEndTm() != null) {
				tm = wsVO.getWorkEndTm();
				if(tm.length() == 3) {
					fTm = tm.substring(0, 1);
					sTm = tm.substring(1,3);
					tm = fTm + ":" + sTm;
					wsVO.setWorkEndTm(tm);
				}else {
					fTm = tm.substring(0, 2);
					sTm = tm.substring(2,4);
					tm = fTm + ":" + sTm;
					wsVO.setWorkEndTm(tm);
				}
			}
		}else {
			wsVO = new workStatusVO();
			wsVO.setWorkBgngTm("-");
			wsVO.setWorkEndTm("-");
		}
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("lateCnt", lateCnt);
		model.addAttribute("absenceCnt", absenceCnt);
		model.addAttribute("remainVctCnt", remainVctCnt);
		model.addAttribute("uesVctCnt", uesVctCnt);
		model.addAttribute("workTm", workTm);
		model.addAttribute("workCnt", workCnt);
		model.addAttribute("wfVO", wfVO);
		model.addAttribute("wsVO", wsVO);
		// 사이드바 메뉴 아코디언 고정하기	
		model.addAttribute("workMenu", "show");	
		model.addAttribute("workCommute", "active");
		
		
		return "employee/commute/EmpCommuteManagement";
	}
	
}

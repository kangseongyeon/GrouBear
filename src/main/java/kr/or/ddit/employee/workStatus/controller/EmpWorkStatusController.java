package kr.or.ddit.employee.workStatus.controller;


import java.text.SimpleDateFormat;
import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.workform.service.IComWorkManagementService;
import kr.or.ddit.company.workform.vo.WorkFormVO;
import kr.or.ddit.employee.workStatus.service.IEmpWorkStatusService;
import kr.or.ddit.employee.workStatus.vo.EmpWorkStatusVO;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/employee")
@PreAuthorize("hasRole('ROLE_EMPLOYEE')")
public class EmpWorkStatusController {

	@Inject
	private IEmpWorkStatusService  workStatusService;
	
	@Inject
	private IComWorkManagementService workFormService;
	
	@PostMapping("/workstatus/startWork.do")
	public ResponseEntity<String> startWork(HttpSession session){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		EmpWorkStatusVO worksttsVO = new EmpWorkStatusVO();
		WorkFormVO wfVO = new WorkFormVO();
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("HHmm");
		
		String sdfTm = sdf.format(now);
		
		int chkResult = workStatusService.chkworksttsVO(empVO);
		
		if(chkResult != 1) {
			wfVO = workFormService.getDeptWorkForm(empVO.getDeptCd());
			if (wfVO == null) {
				wfVO = workFormService.getBaseWorkForm(empVO);
			}
			
			session.setAttribute("startWork", "Y");
			
			if (Integer.parseInt(wfVO.getWorkFormGtwkTm().replace(":","")) < Integer.parseInt(sdfTm)) {
				worksttsVO.setWorkType("WS002");
			}else {
				worksttsVO.setWorkType("WS001");
			}
		 	worksttsVO.setWorkBgngTm(sdfTm);
		 	
			worksttsVO.setEmpId(empVO.getEmpId());
			
			
			int startWorkResult = workStatusService.startWork(worksttsVO);
			
			if(startWorkResult == 1) {
				return new ResponseEntity<String>("success", HttpStatus.OK);
			}else {
				return new ResponseEntity<String>("failed", HttpStatus.BAD_REQUEST);
			}
		}
		return new ResponseEntity<String>("already", HttpStatus.OK);
	}
	
	@PostMapping("/workstatus/stopWork.do")
	public ResponseEntity<String> stopWork(HttpSession session){
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		EmpWorkStatusVO worksttsVO = new EmpWorkStatusVO();
		worksttsVO.setEmpId(empVO.getEmpId());
		
		worksttsVO = workStatusService.startWorkChk(empVO);
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("HHmm");
		String nowTime =  sdf.format(now);
		//0930
		//1300
		String bgngTm = worksttsVO.getWorkBgngTm();
		
		int startMin = 0;
		int endMin = 0;
		
		if(bgngTm.length() == 4) {
			startMin = (Integer.parseInt(bgngTm.substring(0,2))*60) + Integer.parseInt(bgngTm.substring(2,4));
		}else {
			startMin = (Integer.parseInt(bgngTm.substring(0,1))*60) + Integer.parseInt(bgngTm.substring(1,3));
		}
		if (nowTime.length() == 4) {
			endMin = (Integer.parseInt(nowTime.substring(0,2))*60) + Integer.parseInt(nowTime.substring(2,4));
		}else {
			endMin = (Integer.parseInt(nowTime.substring(0,1))*60) + Integer.parseInt(nowTime.substring(1,3)); 		
		}
		
		worksttsVO.setWorkEndTm(nowTime);
		worksttsVO.setWorkTm((endMin-startMin)+"");
		
		int stopWorkResult = workStatusService.stopWork(worksttsVO);
		
		session.setAttribute("startWork", "N");
		
		if (stopWorkResult == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("failed", HttpStatus.BAD_REQUEST);
		}
		
		
		
		
	}
	
	
	
}

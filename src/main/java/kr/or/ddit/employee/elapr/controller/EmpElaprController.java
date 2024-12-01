package kr.or.ddit.employee.elapr.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.or.ddit.comm.alarm.service.IAlarmService;
import kr.or.ddit.comm.alarm.vo.AlarmVO;
import kr.or.ddit.comm.elapr.service.IElaprService;
import kr.or.ddit.comm.elapr.vo.AplnVO;
import kr.or.ddit.comm.elapr.vo.ElaprPrslVO;
import kr.or.ddit.comm.elapr.vo.ElaprVO;
import kr.or.ddit.comm.elapr.vo.RerncVO;
import kr.or.ddit.comm.empallinfo.service.IEmpAllInfoService;
import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.form.service.IFormService;
import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
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
@PreAuthorize("hasAnyRole('ROLE_EMPLOYEE')")
@RequestMapping("/employee")
public class EmpElaprController {

	@Inject
	private IEmpAllInfoService empAllInfoService;
	
	@Inject
	private IElaprService elaprService;
	
	@Inject
	private IFormService formService;
	
	@Inject
	private ITIlesService tilesService;

	@Inject
	private IInformationService infoService;

	@Inject
	private IAlarmService alarmService;
	  
	
	/**
	 *  전자결재 메인 홈
	 * @param model
	 * @return
	 */
	@GetMapping("/elaprMain.do")
	public String elaprMain(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		String empId = empVO.getEmpId();
		
		// 메인 홈 카드 상단 3개
		List<ElaprVO> cardList = elaprService.selectElaprCardList(empId);
		// 메인 홈 테이블
		List<ElaprVO> tableList = elaprService.selectElaprTableList(empId);
		
		model.addAttribute("cardList", cardList);
		model.addAttribute("tableList", tableList);
		return "employee/elapr/elaprMain";
	}
	
	/**
	 *  전자결재 양식 목록 출력 (Jstree)
	 * @param model
	 * @return
	 */
	@GetMapping("/elaprSelectJstree.do")
	public ResponseEntity<JsonArray> elaprSelectJstree (Model model) {
		// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		// 아래처럼 treeList를 프론트에 전달
		// id, text, parent, type 변수그대로사용
		JsonArray treeList = new JsonArray();
		List<FormVO> formList = elaprService.selectFormListJstree(empVO.getCoCd());
		
		// jstree에게 전달하기 위한 제이슨 형태의 객체로 데이터 가공하기
		if(formList.size() > 0) {
		    for(int i = 0; i < formList.size(); i++){
		    	JsonObject json = new JsonObject();		// JSON 객체를 만들기 위한 준비
		    	json.addProperty("id", formList.get(i).getDocFormNo());
		    	json.addProperty("text", formList.get(i).getDocFormNm());
		    	json.addProperty("parent", formList.get(i).getDocFormKndUp());
		    	if (formList.get(i).getDocFormKndUp().equals("#")) {
		    		json.addProperty("type", "default"); //css icon 폴더 아이콘
		    	} else {
		    		json.addProperty("type", "file"); //css icon 파일 아이콘
		    	}
		        treeList.add(json);
		    }
		}
		return new ResponseEntity<JsonArray>(treeList, HttpStatus.OK);
	}
	
     
	/**
	 *  선태한 양식 정보 가져오기
	 * @param docFormNo
	 * @param model
	 * @return
	 */
	@GetMapping("/elaprSelectForm.do")
	public ResponseEntity<FormVO> elaprSelectForm(@RequestParam("docFormNo") int docFormNo, Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		FormVO formVO = formService.selectForm(docFormNo);
		
		return new ResponseEntity<FormVO>(formVO, HttpStatus.OK);
	}
	
	/**
	 *  전자결재 데이터 가져오기
	 * @param model
	 * @return
	 */
	@GetMapping("/elaprSelectImpl.do")
	public ResponseEntity<EmployeeAllVO> elaprSelectImpl(Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		EmployeeAllVO employeeAllVO = elaprService.elaprSelectImpl(empVO);
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		

		// 날짜 세팅
		LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
        String currentDt = today.format(formatter);
        String empJncmpYmd = employeeAllVO.getEmpJncmpYmd().substring(0, 10);
//        String empRsgntnYmd = employeeAllVO.getEmpRsgntnYmd().substring(0, 10);
//        String elaprBgngDt = employeeAllVO.getElaprBgngDt().substring(0, 10);
        
        employeeAllVO.setCurrentDt(currentDt);
        employeeAllVO.setEmpJncmpYmd(empJncmpYmd);
//        employeeAllVO.setEmpRsgntnYmd(empRsgntnYmd);
//        employeeAllVO.setElaprBgngDt(elaprBgngDt);
        
		
		return new ResponseEntity<EmployeeAllVO>(employeeAllVO, HttpStatus.OK);
	}
	
	// //////////////////// 전자결재 CRUD ////////////////////
	
	/**
	 *  전자결재 추가폼
	 * @param model
	 * @return
	 */
	@GetMapping("/elaprForm.do") 
	public String elaprForm(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
		
		// 결재정보
		CompanyVO companyVO = tilesService.getCompany(empVO);

		List<EmployeeVO> empAllList = infoService.orgEmpList(empVO);
		List<DepartmentVO> deptTeamList = infoService.selectDeptTeamList(empVO);
		List<JobGradeVO> jbgdList = infoService.selectJBGDList(empVO);
		List<TeamVO> teamList = infoService.selectTeamListByDept(empVO);
				
		model.addAttribute("companyVO",companyVO);
		model.addAttribute("empAllList", empAllList);
		model.addAttribute("deptTeamList", deptTeamList);
		model.addAttribute("jbgdList", jbgdList);
		model.addAttribute("teamList", teamList);
		
		log.info("companyVO : " + companyVO.getCeoId());
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		FormVO formVO = new FormVO();
		formVO.setCoCd(empVO.getCoCd());
		 
		// 양식 종류 가져오기
		List<FormVO> docFormKndNmList = formService.groubearSelectDocFormKndNm(formVO);
		model.addAttribute("docFormKndNmList", docFormKndNmList);
		
		model.addAttribute("formVO", formVO);
		model.addAttribute("status", "i");
		
		// 발표용 하드코딩
		ElaprVO elaprVO = new ElaprVO();
		elaprVO.setElaprNm("사용자 로그 생성 프로젝트");
		
		model.addAttribute("elaprVO", elaprVO);
		
		return "employee/elapr/elaprInsert";
	}      
	
	/**
	 *  전자결재 신청하기
	 * @param elaprVO
	 * @param model
	 * @param docFormNo
	 * @param request
	 * @param ra
	 * @return
	 */
	@PostMapping("/elaprInsert.do")
	public String elaprInsert(ElaprVO elaprVO, Model model, 
			HttpServletRequest request, RedirectAttributes ra) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		String goPage = "";
		

		if (empVO != null) {	// 로그인을 정상적으로 한 상태일 때만
			elaprVO.setEmpId(empVO.getEmpId());
			elaprVO.setCoCd(empVO.getCoCd());
			
			// 결재선 등록
			List<AplnVO> aplnList = elaprVO.getAplnList();
			if (aplnList == null || aplnList.isEmpty()) {
				log.info("null");
			} else {
				log.info("aplnList : " + aplnList.size());
			}
			
			// 참조자 등록
			List<RerncVO> rerncList = elaprVO.getRerncList();
			if (rerncList == null || rerncList.isEmpty()) {
				log.info("null");
			} else {
				log.info("rerncList : " + rerncList.size());
			}
			
			// 열람자 등록
			List<ElaprPrslVO> prslList = elaprVO.getPrslList();
			if (prslList == null || prslList.isEmpty()) {
				log.info("null");
			} else {
				log.info("prslList : " + prslList.size());
			}
			
			
			ServiceResult result = elaprService.elaprInsert(request, elaprVO);

			if (result.equals(ServiceResult.OK)) {	// 정상적으로 DB에 연결됐다면	
				ra.addFlashAttribute("message", "정상적으로 등록되었습니다.");
				goPage = "redirect:/employee/elaprDetail.do?elaprNo=" + elaprVO.getElaprNo();
			} else {	// DB 연결에 문제가 생겼다면
				model.addAttribute("message", "서버에 오류가 생겼습니다. 다시 시도해주세요.");
				goPage = "redirect:/employee/elaprMain.do";
			}
			
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
			goPage = "redirect:/login.do";
		}
		
		return goPage;
	}

	
	/**
	 *  전자결재 상세보기
	 * @param elaprNo
	 * @param model
	 * @param ra
	 * @return
	 */
	@GetMapping("/elaprDetail.do")
	public String elaprDetail(
	        @RequestParam("elaprNo") int elaprNo, 
	        @RequestParam(name = "status", required = false) String status,
	        Model model, RedirectAttributes ra) {

	    // 로그인한 사용자 정보를 가져옴
	    CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    EmployeeVO empVO = user.getMember();
	    
	    // 부서 정보 및 팀 정보 가져오기
	    DepartmentVO epmtVO = tilesService.getEpmt(empVO);
	    TeamVO teamVO = tilesService.getTeam(empVO);
	    
	    // Model에 사용자, 부서, 팀 정보를 담음
	    model.addAttribute("employeeVO", empVO);
	    model.addAttribute("departmentVO", epmtVO);
	    model.addAttribute("teamVO", teamVO);

	    String goPage = "";
	    
	    // 사용자가 로그인한 상태일 때만 처리
	    if (empVO != null) {    
	        // 전자 결재 상세 정보 가져오기
	        ElaprVO param = new ElaprVO();
	        param.setElaprNo(elaprNo);
	         
	        ElaprVO elaprVO = elaprService.elaprDetail(param);
	        model.addAttribute("elaprVO", elaprVO);  // 결재 정보 전달
	        
	        // 상태 코드 설정
	        model.addAttribute("status", status);  // 상태코드 받아오기
	        
	        List<AplnVO> aplnList = elaprService.selectAplnList(param);			// 결재자 리스트
	        List<RerncVO> rerncList = elaprService.selectRerncList(param);		// 참조자 리스트
	        List<ElaprPrslVO> prslList = elaprService.selectPrslList(param);		// 열람자 리스트
	        
	        model.addAttribute("aplnList", aplnList);  	// 결재자 리스트 전달
	        model.addAttribute("rerncList", rerncList);	// 참조자 리스트 전달
	        model.addAttribute("prslList", prslList);	// 열람자 리스트 전달
	        
	        // 상신취소 유무 (결재승인이 한명이라도 있을 경우 상신 불가능)
	        boolean isCancelable = (elaprService.getApprovalCount(elaprNo) == 0);
	        model.addAttribute("isCancelable", isCancelable);

	        
			List<EmployeeVO> empAllList = infoService.comAllEmpList(empVO);
			List<DepartmentVO> deptTeamList = infoService.selectDeptTeamList(empVO);
			List<JobGradeVO> jbgdList = infoService.selectJBGDList(empVO);
			List<TeamVO> teamList = infoService.selectTeamListByDept(empVO);
					
			model.addAttribute("empAllList", empAllList);
			model.addAttribute("deptTeamList", deptTeamList);
			model.addAttribute("jbgdList", jbgdList);
			model.addAttribute("teamList", teamList);
			
	        
	        goPage = "employee/elapr/elaprDetail";
	    } else {
	        ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
	        goPage = "redirect:/login.do";
	    }

	    String authrityNm = empVO.getAuthList().get(0).getAuthrityNm();
	    model.addAttribute("authrityNm", authrityNm);
	    
	    return goPage;
	}

	
	/**
	 *  전자결재 수정폼
	 * @param elaprNo
	 * @param model
	 * @return
	 */
	@GetMapping("/elaprUpdate.do")
	public String elaprUpdate (int elaprNo, Model model) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		ElaprVO elaprVO = elaprService.selectElapr(elaprNo);
		model.addAttribute("elaprVO", elaprVO);
		model.addAttribute("status", "u");
		
		String authrityNm = empVO.getAuthList().get(0).getAuthrityNm();
		model.addAttribute("authrityNm", authrityNm);
		
		return "employee/elapr/elaprInsert";
	}
	
	/**
	 *  전자결재 수정
	 * @param elaprVO
	 * @param model
	 * @param request
	 * @param ra
	 * @return
	 */
	@PostMapping("/elaprUpdate.do")
	public String elaprUpdate(ElaprVO elaprVO, Model model, HttpServletRequest request, RedirectAttributes ra) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		String goPage = "";
		
		
		if (empVO != null) {	// 로그인을 정상적으로 한 상태일 때만
			elaprVO.setEmpId(empVO.getEmpId());
			
			ServiceResult result = elaprService.elaprUpdate(request, elaprVO);
			
			if (result.equals(ServiceResult.OK)) {	// 정상적으로 DB에 연결됐다면	
				ra.addFlashAttribute("message", "수정이 완료되었습니다");
				goPage = "redirect:/employee/elaprDetail.do?elaprNo=" + elaprVO.getElaprNo();		// 경로 수정 필요
				
			} else {	// DB 연결에 문제가 생겼다면
				model.addAttribute("message", "수정에 실패했습니다.");
				model.addAttribute("elaprVO", elaprVO);
				model.addAttribute("status", "u");
				goPage = "/employee/elapr/elaprInsert";
			}
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
			goPage = "redirect:/login.do";
		}
		return goPage;
	}
	
	/**
	 * 전자결재 삭제
	 * @param ra
	 * @param request
	 * @param elaprNo
	 * @param model
	 * @return
	 */
	@PostMapping("/elaprDelete.do")
	public String elaprDelete (
			RedirectAttributes ra, HttpServletRequest request,
			int elaprNo, Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		
		String goPage = "";
		
		ServiceResult result = elaprService.elaprDelete(request, elaprNo);
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "삭제가 완료되었습니다.");
			goPage = "redirect:/employee/elaprMain.do";
		} else {
			ra.addFlashAttribute("message", "서버에러, 다시 시도해주세요");
			goPage = "redirect:/employee/elaprUpdate.do?elaprNo=" + elaprNo;
		}
		return goPage;
	}
	
	// //////////////////// 결재 대기 문서함 //////////////////// 
	/**
	 * 결재 대기 문서
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empElaprWating.do")
	public String empElaprWating(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		TeamVO teamVO = tilesService.getTeam(empVO);
				
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		model.addAttribute("status", "statusWating");
		
		// 페이징 처리
		PaginationInfoVO<ElaprVO> pagingVO = new PaginationInfoVO<ElaprVO>(10, 5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = elaprService.selectWatingCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = elaprService.selectWatingList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		return "employee/elapr/elaprWating";
	}
	
	/**
	 * 결재 대기 -> 결재 진행
	 * @param aplnVO
	 * @param model
	 * @param request
	 * @param ra
	 * @return
	 */
	@PostMapping("/elaprWatingUpdate.do")
	public String elaprWatingUpdate(AplnVO aplnVO, Model model, HttpServletRequest request, RedirectAttributes ra) {

	    CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    EmployeeVO empVO = user.getMember();

	    DepartmentVO epmtVO = tilesService.getEpmt(empVO);
	    TeamVO teamVO = tilesService.getTeam(empVO);

	    model.addAttribute("employeeVO", empVO);
	    model.addAttribute("departmentVO", epmtVO);
	    model.addAttribute("teamVO", teamVO);

	    String goPage = "";

	    if (empVO != null) { // 로그인이 정상적인 상태일 때만

	        aplnVO.setEmpId(empVO.getEmpId());

	        ServiceResult result = elaprService.elaprWatingUpdate(request, aplnVO);

	        if (result.equals(ServiceResult.OK)) { // DB에 정상적으로 업데이트되었을 때

	            // 결재 상태가 모두 완료되었는지 확인
	            int pendingCount = elaprService.countPendingApprovals(aplnVO.getElaprNo());
	            
	            if (pendingCount == 0) {
	                // 모든 결재가 완료된 경우 전자결재 상태를 업데이트
	                elaprService.updateApprovalStatus(aplnVO.getElaprNo(), "APRZ002");
	                int  updateElaprEndDt = elaprService.updateElaprEndDt(aplnVO.getElaprNo());
	                
		             // 모든 결재 완료 알림
	                sendApprovalComplete(aplnVO);
	            } else {
	                // 개별 결재 완료 시 알림 전송
	                sendIndividualApproval(aplnVO, empVO);
	            }

	            ra.addFlashAttribute("message", "수정이 완료되었습니다");
	            goPage = "redirect:/employee/empElaprWating.do";

	            
	        } else { // DB 연결에 문제가 생겼다면
	            model.addAttribute("message", "수정에 실패했습니다.");
	            model.addAttribute("aplnVO", aplnVO);
	            model.addAttribute("status", "u");
	            goPage = "/employee/elapr/elaprInsert";
	        }
	    } else {
	        ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
	        goPage = "redirect:/login.do";
	    }
	    return goPage;
	}
	

	/**
	 * 모든 결재 완료 알림
	 * @param aplnVO
	 */
	private void sendApprovalComplete(AplnVO aplnVO) {
		ElaprVO elaprVO = new ElaprVO();
	    elaprVO.setElaprNo(aplnVO.getElaprNo());
	    
		List<AplnVO> approvalLine = elaprService.selectAplnList(elaprVO);

	    for (AplnVO apln : approvalLine) {
	        if ("APLN002".equals(apln.getAplnSttsCd())) { // 결재 완료 상태
	            AlarmVO alarmVO = new AlarmVO();
	            alarmVO.setAlarmCategory("elapr");
	            alarmVO.setAlarmTarget(apln.getEmpId());
	            alarmVO.setAlarmCn("모든 결재가 완료되었습니다.");

	            EmployeeVO param = new EmployeeVO();
				param.setEmpId(aplnVO.getEmpId());
	            EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(param);
	            if (employeeAllVO.getAuthrityNm().equals("ROLE_COMPANY")) {
	                alarmVO.setAlarmUrl("/company/elaprDetail.do?elaprNo=" + aplnVO.getElaprNo() + "&status=statusComplete");
	            } else if (employeeAllVO.getAuthrityNm().equals("ROLE_EMPLOYEE")) {
	                alarmVO.setAlarmUrl("/employee/elaprDetail.do?elaprNo=" + aplnVO.getElaprNo() + "&status=statusComplete");
	            }

	            alarmService.insertAlarm(alarmVO);
	        }
	    }
	}

	/**
	 * 개별 결재 완료 시 알림 전송
	 * @param aplnVO
	 * @param empVO
	 */
	private void sendIndividualApproval(AplnVO aplnVO, EmployeeVO empVO) {
		ElaprVO elaprVO = new ElaprVO();
	    elaprVO.setElaprNo(aplnVO.getElaprNo());

	    List<AplnVO> approvalLine = elaprService.selectAplnList(elaprVO);
	
	    for (AplnVO apln : approvalLine) {
	        AlarmVO alarmVO = new AlarmVO();
	        alarmVO.setAlarmCategory("elapr");
	        alarmVO.setAlarmTarget(apln.getEmpId());
	        alarmVO.setAlarmCn("결재가 완료되었습니다.");

	        EmployeeVO approver = new EmployeeVO();
	        approver.setEmpId(apln.getEmpId());
	        EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(approver);

	        if (employeeAllVO.getAuthrityNm().equals("ROLE_COMPANY")) {
	            alarmVO.setAlarmUrl("/company/elaprDetail.do?elaprNo=" + aplnVO.getElaprNo() + "&status=statusComplete");
	        } else if (employeeAllVO.getAuthrityNm().equals("ROLE_EMPLOYEE")) {
	            alarmVO.setAlarmUrl("/employee/elaprDetail.do?elaprNo=" + aplnVO.getElaprNo() + "&status=statusComplete");
	        }

	        alarmService.insertAlarm(alarmVO);
	    }
	}

	/**
	 * 결재 대기 -> 결재 반려
	 * @param aplnVO
	 * @param model
	 * @param request
	 * @param ra
	 * @return
	 */
	@PostMapping("/elaprRjctUpdate.do")
	public String elaprRjctUpdate(AplnVO aplnVO, Model model, HttpServletRequest request, RedirectAttributes ra) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		TeamVO teamVO = tilesService.getTeam(empVO);
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		String goPage = "";
		
		if (empVO != null) { // 로그인이 정상적인 상태일 때만
			
			aplnVO.setEmpId(empVO.getEmpId());
			
			ServiceResult result = elaprService.elaprRjctUpdate(request, aplnVO);
			
			if (result.equals(ServiceResult.OK)) { // DB에 정상적으로 업데이트되었을 때
				
				int  rjctElaprUpdate = elaprService.rjctElaprUpdate(aplnVO.getElaprNo());
				
				// 반려 완료 알람
				ElaprVO elaprVO = new ElaprVO();
			    elaprVO.setElaprNo(aplnVO.getElaprNo());
				
			    List<AplnVO> approvalLine = elaprService.selectAplnList(elaprVO);
			
			    for (AplnVO apln : approvalLine) {
			        AlarmVO alarmVO = new AlarmVO();
			        alarmVO.setAlarmCategory("elapr");
			        alarmVO.setAlarmTarget(apln.getEmpId());
			        alarmVO.setAlarmCn("결재가 반려되었습니다.");
			
			        EmployeeVO approver = new EmployeeVO();
			        approver.setEmpId(apln.getEmpId());
			        EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(approver);
			
			        if (employeeAllVO.getAuthrityNm().equals("ROLE_COMPANY")) {
			            alarmVO.setAlarmUrl("/company/elaprDetail.do?elaprNo=" + aplnVO.getElaprNo() + "&status=statusRjct");
			        } else if (employeeAllVO.getAuthrityNm().equals("ROLE_EMPLOYEE")) {
			            alarmVO.setAlarmUrl("/employee/elaprDetail.do?elaprNo=" + aplnVO.getElaprNo() + "&status=statusRjct");
			        }
			
			        alarmService.insertAlarm(alarmVO);
			    }
				
				
				ra.addFlashAttribute("message", "반려가 완료되었습니다");
				goPage = "redirect:/employee/empElaprRjct.do";
				
			} else { // DB 연결에 문제가 생겼다면
				model.addAttribute("message", "수정에 실패했습니다.");
				model.addAttribute("aplnVO", aplnVO);
				goPage = "/employee/elapr/elaprInsert";
			}
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
			goPage = "redirect:/login.do";
		}
		return goPage;
	}
	
	
}
package kr.or.ddit.employee.provedoc.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.or.ddit.comm.alarm.service.IAlarmService;
import kr.or.ddit.comm.alarm.vo.AlarmVO;
import kr.or.ddit.comm.cmnty.vo.CmntyVO;
import kr.or.ddit.comm.empallinfo.service.IEmpAllInfoService;
import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.form.service.IFormService;
import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import kr.or.ddit.employee.provedoc.service.IEmpProvedocService;
import kr.or.ddit.employee.provedoc.vo.EmpProvedocVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_EMPLOYEE')")
@RequestMapping("/employee")
public class EmpProvedocController {
	
	@Inject
	private IEmpProvedocService provedocService;
	
	@Inject
	private IFormService formService;
	
	@Inject
	private IEmpAllInfoService empAllInfoService;
	
	@Inject
	private ITIlesService tilesService;

	@Inject
	private IAlarmService alarmService;
	
	// 증명서 목록 게시물 조회 (사원)
	@GetMapping("/provedocAplyList.do")
	public String provedocAplyList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model,
			HttpServletRequest request) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		DepartmentVO epmtVO = tilesService.getEpmt(employeeVO);
		
		TeamVO teamVO = tilesService.getTeam(employeeVO);
		
		model.addAttribute("employeeVO", employeeVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		// 증명서 신청에서 양식 불러오기 용
		FormVO formVO = new FormVO();
		formVO.setCoCd(employeeVO.getCoCd());
		
		// 리스트 페이징 처리하기
		PaginationInfoVO<EmpProvedocVO> pagingVO = new PaginationInfoVO<EmpProvedocVO>(10,5);
		pagingVO.setCoCd(employeeVO.getCoCd());
		pagingVO.setEmpId(employeeVO.getEmpId());
		
		// 검색 기능 추가
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		// startRow, endRow, startpage, endPage를 결정한다.
		pagingVO.setCurrentPage(currentPage); 
		
		// 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
		int totalRecord = provedocService.empSelectProvedocCount(pagingVO);
		
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord); 
		
		// 총 게시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의 리스트 데이터를 가져온다.
		List<EmpProvedocVO> formList = provedocService.empSelectProvedocList(pagingVO);
		pagingVO.setDataList(formList);
		
		// 다른 메서드 (insert, update, delete 등)에서 전달한 메시지 함께 보내기
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("provedocMenu", "show");
		model.addAttribute("provedocAply", "active");
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n totalRecord : " + totalRecord);
		return "employee/provedoc/provedocAplyList";
	}
	
	// 증명서 양식 목록 가져오기 - Jstree에 출력할 form 계층형 데이터 
	@GetMapping("/provedocSelectJstree.do")
	public ResponseEntity<JsonArray> provedocSelectJstree(Model model) {
		// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		// 아래처럼 treeList를 프론트에 전달
		// id, text, parent, type 변수그대로사용
		JsonArray treeList = new JsonArray();
		List<FormVO> formList = provedocService.selectFormListJstree(employeeVO.getCoCd());
		
		// jstree에게 전달하기 위한 제이슨 형태의 객체로 데이터 가공하기
		if(formList.size() > 0) {
		    for(int i = 0; i < formList.size(); i++){
		    	JsonObject json = new JsonObject();		// JSON 객체를 만들기 위한 준비
		    	json.addProperty("id", formList.get(i).getDocFormNo());
		    	json.addProperty("text", formList.get(i).getDocFormNm());
		    	json.addProperty("parent", formList.get(i).getDocFormKndUp());
		    	if (formList.get(i).getDocFormKndNm() == null) {
		    		json.addProperty("type", "default"); //css icon 폴더 아이콘
		    	} else {
		    		json.addProperty("type", "file"); //css icon 파일 아이콘
		    	}
		        treeList.add(json);
		    }
		}
		return new ResponseEntity<JsonArray>(treeList, HttpStatus.OK);
	}
	
	
	@GetMapping("/proveSelectForm.do")
	public ResponseEntity<FormVO> proveSelectForm(@RequestParam("docFormNo") int docFormNo) {
		// 선택한 양식의 정보 가져오기
		FormVO formVO = formService.selectForm(docFormNo);
		// log.info(">>>>>>>>>>>>>>>>>>>>\n formVO : " + formVO.toString());
		
		return new ResponseEntity<FormVO>(formVO, HttpStatus.OK);
	}
	
	@GetMapping("/selectEmpImpl.do")
	public ResponseEntity<EmployeeAllVO> selectEmpImpl() {
		// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(employeeVO);
        
		// 날짜 세팅
		LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
        String currentDt = today.format(formatter);
        String empJncmpYmd = employeeAllVO.getEmpJncmpYmd().substring(0, 10);
        if (employeeAllVO.getEmpRsgntnYmd() != null) {
        	String empRsgntnYmd = employeeAllVO.getEmpRsgntnYmd().substring(0, 10);
        	employeeAllVO.setEmpRsgntnYmd(empRsgntnYmd);
        } else {
        	employeeAllVO.setEmpRsgntnYmd("재직중");
        }
        employeeAllVO.setCurrentDt(currentDt);
        employeeAllVO.setEmpJncmpYmd(empJncmpYmd);
        
        // 생일 및 주민번호 뒷자리(남여구분) 세팅
        String empBrdt = employeeAllVO.getEmpBrdt().substring(0, 10);
        empBrdt = empBrdt.replace("-", "");
        
        if (empBrdt.substring(0, 1).equals("1")) {		// 2000년 이전 생일이라면
        	empBrdt = empBrdt.substring(2, 8);
        	if (employeeAllVO.getEmpGndr().equals("GNDR01")) {	// 2000년 이전 남자라면 1
        		empBrdt += " - 1";
        	} else if (employeeAllVO.getEmpGndr().equals("GNDR02")) {	// 2000년 이전 여자라면 1
        		empBrdt += " - 2";
        	}
        } else {		// 2000년 이후 생일이라면
        	empBrdt = empBrdt.substring(2, 8);
        	
        	if (employeeAllVO.getEmpGndr().equals("GNDR01")) {	// 2000년 이전 남자라면 1
        		empBrdt += " - 3";
        	} else if (employeeAllVO.getEmpGndr().equals("GNDR02")) {	// 2000년 이전 여자라면 1
        		empBrdt += " - 4";
        	}
        }
        employeeAllVO.setEmpBrdt(empBrdt);
		
		return new ResponseEntity<EmployeeAllVO>(employeeAllVO, HttpStatus.OK);
	}
	
	// 증명서 상세보기
	@GetMapping("/provedocDetail.do")
	public String provedocDetail(@RequestParam("prdocNo") int prdocNo, Model model, RedirectAttributes ra) {
		String goPage = "";
		
		// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		if (employeeVO != null) {	// 로그인을 정상적으로 한 상태일 때만
			EmpProvedocVO param = new EmpProvedocVO();
			param.setPrdocNo(prdocNo);
			
			EmpProvedocVO provedocVO = provedocService.provedocDetail(param);
			model.addAttribute("provedocVO", provedocVO);
			model.addAttribute("employeeVO", employeeVO);

			// 사이드바 메뉴 아코디언 고정하기
			model.addAttribute("provedocMenu", "show");
			model.addAttribute("provedocAply", "active");
			
			goPage = "employee/provedoc/provedocDetail";
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
			goPage = "redirect:/login.do";
		}
		log.info(">>>>>>>>>>>>>>>>>>>>>>>> employeeVO : \n" + employeeVO.toString());
		String authrityNm = employeeVO.getAuthList().get(0).getAuthrityNm();
		model.addAttribute("authrityNm", authrityNm);
		
		return goPage;
	}
	
	
	// 증명서 신청 (사원)
	@PostMapping("/empProvedocAplyInsert.do")
	public String empProvedocAplyInsert(EmpProvedocVO provedocVO, Model model, HttpServletRequest request, RedirectAttributes ra) {
		String goPage = "";
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>> provedocVO : \n" + provedocVO.toString());
		
		// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		if (employeeVO != null) {	// 로그인을 정상적으로 한 상태일 때만
			provedocVO.setPrdocAplyEmpId(employeeVO.getEmpId());
			provedocVO.setPrdocInfoEmpId(employeeVO.getEmpId());
			provedocVO.setCoCd(employeeVO.getCoCd());
			
			ServiceResult result = provedocService.empProvedocAplyInsert(provedocVO);
			
			HttpSession session = request.getSession();
			if (result.equals(ServiceResult.OK)) {	// 정상적으로 DB에 연결됐다면	
				
				
				// 실시간 알림 코드 추가
				// 소속 기업의 기업관리자 정보 가져오기
				EmployeeAllVO empManegerVO = empAllInfoService.selectComManagerEmpImpl(employeeVO.getCoCd());
				// 로그인한 사람의 모든 정보 가져오기
				EmployeeAllVO empMyAllVO = empAllInfoService.selectEmpImpl(employeeVO);
				
				AlarmVO alarmVO = new AlarmVO();
				alarmVO.setAlarmCategory("prove");
				alarmVO.setAlarmTarget(empManegerVO.getEmpId());
				alarmVO.setAlarmCn("'"+empMyAllVO.getDeptNm()+" "+empMyAllVO.getTeamNm()+"' "+"'"+empMyAllVO.getEmpNm()+"' "+empMyAllVO.getJbgdNm()+"님이 증명서를 신청하였습니다.");
				alarmVO.setAlarmUrl("/company/provedocAplyList.do");
				
				alarmService.insertAlarm(alarmVO);
				
				session.setAttribute("message", "정상적으로 신청되었습니다.");
				goPage = "redirect:/employee/provedocAplyList.do";
				
			} else {	// DB 연결에 문제가 생겼다면
				model.addAttribute("message", "서버에 오류가 생겼습니다. 다시 시도해주세요.");
				goPage = "redirect:/employee/provedocAplyList.do";
			}
			
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
			goPage = "redirect:/login.do";
		}
		
		return goPage;
	}
	
}

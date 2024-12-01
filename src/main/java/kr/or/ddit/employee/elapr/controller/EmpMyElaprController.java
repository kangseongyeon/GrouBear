package kr.or.ddit.employee.elapr.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.comm.elapr.service.IMyElaprService;
import kr.or.ddit.comm.elapr.vo.ElaprVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_EMPLOYEE')")
@RequestMapping("/employee")
public class EmpMyElaprController {
	
	@Inject
	private IMyElaprService myElaprService;
	
	@Inject
	private ITIlesService tilesService;

	
	// //////////////////// 기안 문서함 //////////////////// 
	/**
	 *  개인 - 기안 문서함 리스트
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empElaprDraft.do")
	public String elaprDraft(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, 
			Model model,
			HttpServletRequest request) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		DepartmentVO epmtVO = tilesService.getEpmt(empVO);
		TeamVO teamVO = tilesService.getTeam(empVO);
		
		model.addAttribute("employeeVO", empVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		
		model.addAttribute("status", "statusDraft");

		// 문서함 토글 열기
		model.addAttribute("elaprMenu", "show");
		model.addAttribute("elaprMyMenu", "show");
		model.addAttribute("empElaprDraft", "active");


		PaginationInfoVO<ElaprVO> pagingVO = new PaginationInfoVO<ElaprVO>(10,5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage); 
		
		int totalRecord = myElaprService.selectDraftCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord); 
		
		List<ElaprVO> dataList = myElaprService.selectMyElaprDraftList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		
		return "employee/elapr/elaprDraft";
	}
	
	
	// //////////////////// 참조/열람 문서함 ////////////////////
	/**
	 * 참조 문서함 리스트
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empElaprRernc.do")
	public String empElaprRernc (
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
		
		model.addAttribute("status", "statusRernc");
		
		// 문서함 토글 열기
		model.addAttribute("elaprMenu", "show");
		model.addAttribute("elaprMyMenu", "show");
		model.addAttribute("empElaprRernc", "active");


		PaginationInfoVO<ElaprVO> pagingVO = new PaginationInfoVO<ElaprVO>(10, 5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = myElaprService.selectRerncCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectRerncList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);

		return "employee/elapr/elaprRernc";
	}
	
	/**
	 * 열람 문서함 리스트
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empElaprPrsl.do")
	public String empElaprPrsl (
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
		
		model.addAttribute("status", "statusPrsl");
		
		// 문서함 토글 열기
		model.addAttribute("elaprMenu", "show");
		model.addAttribute("elaprMyMenu", "show");
		model.addAttribute("empElaprPrsl", "active");

		
		PaginationInfoVO<ElaprVO> pagingVO = new PaginationInfoVO<ElaprVO>(10, 5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = myElaprService.selectPrslCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectPrslList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employee/elapr/elaprPrsl";
	}
	
	
	// //////////////////// 결재 전체 문서함 //////////////////// 
	/**
	 * 결재 전체 문서함
	 * @param currentPage
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empElaprAll.do")
	public String empElaprAll(
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
		
		model.addAttribute("status", "statusAll");
		
		PaginationInfoVO<ElaprVO> pagingVO = new PaginationInfoVO<ElaprVO>(10, 5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = myElaprService.selectAllCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectAllList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employee/elapr/empElaprAll";
	}
	
	// //////////////////// 결재 긴급 문서함 ////////////////////
	/**
	 * 결재 긴급 문서함 
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empElaprEmrg.do")
	public String empElaprEmrg(
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
		
		model.addAttribute("status", "statusEmrg");
		
		PaginationInfoVO<ElaprVO> pagingVO = new PaginationInfoVO<ElaprVO>(10, 5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = myElaprService.selectEmrgCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectEmrgList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employee/elapr/empElaprAll";
	}
	
	
	// //////////////////// 결재 진행 문서함 ////////////////////
	/**
	 * 결재 진행 문서함 
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empElaprProgress.do")
	public String empElaprProgress(
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
		
		model.addAttribute("status", "statusProgress");
		
		PaginationInfoVO<ElaprVO> pagingVO = new PaginationInfoVO<ElaprVO>(10, 5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = myElaprService.selectProgressCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectProgressList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employee/elapr/empElaprAll";
	}
	
	// //////////////////// 결재 완료 문서함 //////////////////// 
	/**
	 * 결재 완료 문서함
	 * @param currentPage
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empElaprComplete.do")
	public String empElaprComplete(
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
		
		model.addAttribute("status", "statusComplete");
		
		PaginationInfoVO<ElaprVO> pagingVO = new PaginationInfoVO<ElaprVO>(10, 5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = myElaprService.selectCompleteCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectCompleteList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employee/elapr/empElaprAll";
	}
	
	// //////////////////// 결재 반려 문서함 //////////////////// 
	/**
	 *  결재 반려 문서함
	 * @param currentPage
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empElaprRjct.do")
	public String empElaprRjct(
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
		
		model.addAttribute("status", "statusRjct");
		
		PaginationInfoVO<ElaprVO> pagingVO = new PaginationInfoVO<ElaprVO>(10, 5);
		pagingVO.setEmpId(empVO.getEmpId());
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = myElaprService.selectRjctCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectRjctList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employee/elapr/empElaprAll";
	}
	
	// //////////////////// 개인 결재 전체 문서함 //////////////////// 
	/**
	 *  개인 - 결재 전체 문서함
	 * @param currentPage
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empMyElaprAll.do")
	public String empMyElaprAll(
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
		
		model.addAttribute("status", "statusMyAll");

		// 문서함 토글 열기
		model.addAttribute("elaprMenu", "show");
		model.addAttribute("elaprMyMenu", "show");
		model.addAttribute("empMyElaprAll", "active");

		
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
		
		int totalRecord = myElaprService.selectMyAllCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectMyAllList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employee/elapr/empMyElaprAll";
	}
	
	// //////////////////// 개인 결재 긴급 문서함 //////////////////// 
	/**
	 *  개인 - 결재 긴급 문서함
	 * @param currentPage
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empMyElaprEmrg.do")
	public String empMyElaprEmrg(
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
		
		model.addAttribute("status", "statusMyEmrg");
		
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
		
		int totalRecord = myElaprService.selectMyEmrgCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectMyEmrgList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employee/elapr/empMyElaprAll";
	}
	
	// //////////////////// 개인 결재 진행 문서함 //////////////////// 
	/**
	 *  개인 - 결재 진행 문서함
	 * @param currentPage
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empMyElaprProgress.do")
	public String empMyElaprProgress(
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
		
		model.addAttribute("status", "statusMyProgress");
		
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
		
		int totalRecord = myElaprService.selectMyProgressCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectMyProgressList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employee/elapr/empMyElaprAll";
	}
	
	// //////////////////// 개인 결재 완료 문서함 //////////////////// 
	/**
	 *  개인 - 결재 완료 문서함
	 * @param currentPage
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empMyElaprComplete.do")
	public String empMyElaprComplete(
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
		
		model.addAttribute("status", "statusMyComplete");
		
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
		
		int totalRecord = myElaprService.selectMyCompleteCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectMyCompleteList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employee/elapr/empMyElaprAll";
	}
	
	// //////////////////// 개인 결재 반려 문서함 //////////////////// 
	/**
	 *  개인 - 결재 반려 문서함
	 * @param currentPage
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/empMyElaprRjct.do")
	public String empMyElaprRjct(
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
		
		model.addAttribute("status", "statusMyRjct");
		
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
		
		int totalRecord = myElaprService.selectMyRjctCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<ElaprVO> dataList = myElaprService.selectMyRjctList(pagingVO);
		
		pagingVO.setDataList(dataList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employee/elapr/empMyElaprAll";
	}
}

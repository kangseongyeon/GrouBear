package kr.or.ddit.company.elapr.controller;

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

import com.github.mustachejava.MustacheTimeoutException;

import kr.or.ddit.comm.elapr.service.IMyElaprService;
import kr.or.ddit.comm.elapr.vo.ElaprVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;

@Controller
@RequestMapping("/company")
@PreAuthorize("hasRole('ROLE_COMPANY')")
public class ComMyElaprController {

	@Inject
	private IMyElaprService myElaprService;
	
	@Inject
	private ITIlesService tilesService;
	
	// //////////////////// 참조/열람 문서함 ////////////////////
	/**
	 * 참조 문서함
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/comElaprRernc.do")
	public String comElaprRernc(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		model.addAttribute("status", "statusRernc");
		

		// 문서함 토글 열기
		model.addAttribute("elaprMenu", "show");
		model.addAttribute("elaprMyMenu", "show");
		model.addAttribute("comElaprRernc", "active");

		
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
		
		return "company/elapr/elaprRernc";
	}
	
	/**
	 *  열람 문서함
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/comElaprPrsl.do")
	public String comElaprPrsl(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		model.addAttribute("status", "statusPrsl");
		
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
		
		return "company/elapr/elaprPrsl";
	}
	
	/**
	 *  결재 전체 문서함
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/comElaprAll.do")
	public String comElaprAll(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);

		model.addAttribute("status", "statusAll");
		

		// 문서함 토글 열기
		model.addAttribute("elaprMenu", "show");
		model.addAttribute("elaprMyMenu", "show");
		model.addAttribute("comElaprAll", "active");

		
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

		return "company/elapr/elaprAll";
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
	@GetMapping("/comElaprEmrg.do")
	public String comElaprEmrg(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
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
		
		return "company/elapr/elaprAll";
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
	@GetMapping("/comElaprProgress.do")
	public String comElaprProgress(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
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
		
		return "company/elapr/elaprAll";
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
	@GetMapping("/comElaprComplete.do")
	public String comElaprComplete(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
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
		
		return "company/elapr/elaprAll";
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
	@GetMapping("/comElaprRjct.do")
	public String comElaprRjct(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
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
		
		return "company/elapr/elaprAll";
	}
}

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

import kr.or.ddit.comm.elapr.service.IElaprService;
import kr.or.ddit.comm.elapr.vo.ElaprVO;
import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_COMPANY')")
@RequestMapping("/company")
public class ComElaprController {
	
	@Inject
	private IElaprService elaprService;
	

	@Inject
	private ITIlesService tilesService;
	
	// 기업 전자결재 메인 홈
	@GetMapping("/elaprMain.do")
	public String elaprMain(Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		return "company/elapr/elaprMain";
	}
	
	@GetMapping("/elaprList.do")
	public String elaprList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, 
			Model model, HttpServletRequest request
			) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		model.addAttribute("employeeVO", employeeVO);
		
		// 증명서 가져오기
		FormVO formVO = new FormVO();
		formVO.setCoCd(employeeVO.getCoCd());
	
		// 페이징 처리
		PaginationInfoVO<ElaprVO> pagingVO = new PaginationInfoVO<ElaprVO>(10, 5);
		pagingVO.setCoCd(employeeVO.getCoCd());
		pagingVO.setEmpId(employeeVO.getEmpId());
		
		// 검색 기능
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
//		int totalRecord = elaprService.selectElaprCount(pagingVO);
		
//		pagingVO.setTotalRecord(totalRecord);
		
//		List<ElaprVO> formList = elaprService.selectElaprList(pagingVO);
//		pagingVO.setDataList(formList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
	

		return "company/elapr/elaprList";
	}
	
	/**
	 * 결재 대기 문서
	 * @param model
	 * @return
	 */
	@GetMapping("/comElaprWating.do")
	public String comElaprWating(Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		

		// 수정 필요
		return "company/elapr/elaprWating";
	}
}

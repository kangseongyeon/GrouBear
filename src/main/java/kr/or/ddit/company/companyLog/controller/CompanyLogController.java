package kr.or.ddit.company.companyLog.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.companyLog.service.ICompanyLogService;
import kr.or.ddit.groubear.log.vo.LogVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/company")
public class CompanyLogController {
	
	@Inject
	private ICompanyLogService cLogService;
	
	@GetMapping("/companylog.do")
	public Object companyLog(
	        @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
	        @RequestParam(required = false, defaultValue = "title") String searchType,
	        @RequestParam(required = false) String searchWord, Model model) {

	    // PaginationInfoVO 초기화 (LogVO 타입)
	    PaginationInfoVO<LogVO> pagingVO = new PaginationInfoVO<>(10, 5);
	    
	    // 검색 기능 추가
	    if (StringUtils.isNotBlank(searchWord)) {
	        pagingVO.setSearchWord(searchWord);
	        pagingVO.setSearchType(searchType);
	        model.addAttribute("searchWord", searchWord);
	        model.addAttribute("searchType", searchType);
	    }
	    
	    // 현재 페이지 설정
	    pagingVO.setCurrentPage(currentPage);

	    // 사용자 정보 가져오기
	    CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    EmployeeVO empVO = user.getMember();
	    log.info("로그인한 사람 로그확인 >>>" + empVO);

	    // 총 로그 수를 얻어오기
	    int totalRecord = cLogService.selectCompanyLog(empVO);
	    pagingVO.setTotalRecord(totalRecord);

	    // 매개변수를 Map에 담기
//	    Map<String, Object> params = new HashMap<>();
//	    params.put("empVO", empVO);
//	    log.info("empVO >>>>>>" + empVO);
//	    params.put("pagingVO", pagingVO);
//	    log.info("pagingVO >>>>>>" + pagingVO);
//	    log.info("params >>>>>>" + params);
	    
	    pagingVO.setCoCd(empVO.getCoCd());
	    pagingVO.setJbgdCd(empVO.getJbgdCd());

	    // 회사 로그 조회
	    List<LogVO> companyLog = cLogService.getcompanyLog(pagingVO); 
	    log.info("companyLog >>>>>>" + companyLog);

	    model.addAttribute("companyLog", companyLog);
	    model.addAttribute("pagingVO", pagingVO); // 모델에 페이징 정보 추가

	    return "company/companyLog/companyLog"; // JSP 파일 경로
	}

	

}

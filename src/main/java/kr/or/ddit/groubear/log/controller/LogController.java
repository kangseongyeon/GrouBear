package kr.or.ddit.groubear.log.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.aop.support.AopUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.project.service.IProjectService;
import kr.or.ddit.groubear.log.service.ILogService;
import kr.or.ddit.groubear.log.vo.LogVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groubear")
public class LogController {
	
	@Inject
	private IProjectService service;
	
	@Inject
	private ILogService logService;

	@PostConstruct
	public void init() {
		log.info("Service 빈 주입 상태: {}", service != null ? "주입됨" : "주입되지 않음");
		// AopProxy는 인터페이스 기반의 프록시를 생성한 Dynamic Proxy를 사용하여 위빙을 지정한다.
		// - 인터페이스를 구현하고 해당 인터페이스를 참조해서 구현한 클래스를 사용하는 형태이어야 한다. (service, impl)
		log.info("aopProxy 상태(interface 기반) : {}", AopUtils.isAopProxy(service));
		// 인터페이스 기반이 아닌 클래스 기반의 프록시를 생성한 Cglib Proxy를 사용하여 위빙을 지정한다.
		// - 인터페이스 구현 없이 클래스로만 사용되는 형태
		log.info("aopProxy 상태(클래스 상속 기반) : {}", AopUtils.isCglibProxy(service));
	}
	
	@RequestMapping(value="/log.do", method = RequestMethod.GET)
	public String logList(
	        @RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
	        @RequestParam(required = false, defaultValue = "title") String searchType,
	        @RequestParam(required = false) String searchWord, Model model,
	        @RequestParam(required = false) String startDate, // 시작 날짜 추가
	        @RequestParam(required = false) String endDate   // 종료 날짜 추가
	) {
	    PaginationInfoVO<LogVO> pagingVO = new PaginationInfoVO<LogVO>(10, 5);

	    // 검색 기능 추가
	    if (StringUtils.isNotBlank(searchWord)) {
	        pagingVO.setSearchWord(searchWord);
	        pagingVO.setSearchType(searchType);
	        model.addAttribute("searchWord", searchWord);
	        model.addAttribute("searchType", searchType);
	    }

	 // 날짜 검색 기능 추가
	    if (StringUtils.isNotBlank(startDate) && StringUtils.isNotBlank(endDate)) {
	        log.info("Input Start Date: {}", startDate); // 로그 추가
	        log.info("Input End Date: {}", endDate);     // 로그 추가
	        pagingVO.setStartDate(startDate + " 00:00:00"); // 시작 날짜 설정
	        pagingVO.setEndDate(endDate + " 23:59:59");     // 종료 날짜 설정
	        model.addAttribute("startDate", startDate);
	        model.addAttribute("endDate", endDate);
	    }

	    // startRow, endRow, startPage, endPage를 결정한다.
	    pagingVO.setCurrentPage(currentPage);

	    // 디버깅 로그 추가
	    log.info("Current Page: {}", pagingVO.getCurrentPage());
	    log.info("Start Row: {}", pagingVO.getStartRow());
	    log.info("End Row: {}", pagingVO.getEndRow());

	    // 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
	    int totalRecord = logService.selectLog(pagingVO);
	    pagingVO.setTotalRecord(totalRecord);

	    // 리스트 데이터를 가져온다
	    List<LogVO> dataList = logService.selectLogList(pagingVO);
	    pagingVO.setDataList(dataList);
	    model.addAttribute("pagingVO", pagingVO); 

	    return "groubear/log/log";
	}
	
	// 날짜 검색 요청 처리
	@RequestMapping(value="/log/dateSearch", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> logDateSearch(
	        @RequestParam(required = false) String startDate,
	        @RequestParam(required = false) String endDate,
	        @RequestParam(name="page", required = false, defaultValue = "1") int currentPage) {

	    log.info("Received Start Date: {}", startDate);
	    log.info("Received End Date: {}", endDate);

	    PaginationInfoVO<LogVO> pagingVO = new PaginationInfoVO<>(10, 5);
	    pagingVO.setCurrentPage(currentPage); // 현재 페이지 설정

	    if (StringUtils.isNotBlank(startDate) && StringUtils.isNotBlank(endDate)) {
	        pagingVO.setStartDate(startDate + " 00:00:00");
	        pagingVO.setEndDate(endDate + " 23:59:59");
	    }

	    int totalRecord = logService.selectLog(pagingVO); // 총 레코드 수
	    pagingVO.setTotalRecord(totalRecord); // 총 레코드 수 설정

	    List<LogVO> dataList = logService.selectLogList(pagingVO);

	    // 페이징 HTML 생성
	    String pagingHTML = pagingVO.getPagingHTML();

	    // 페이징 정보와 데이터 반환
	    Map<String, Object> response = new HashMap<>();
	    response.put("dataList", dataList);
	    response.put("totalPages", pagingVO.getTotalPages()); // 총 페이지 수 추가
	    response.put("pagingHTML", pagingHTML); // 페이징 HTML 추가
	    return response; // JSON으로 반환

	}

}

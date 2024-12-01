package kr.or.ddit.groubear.stats.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kotlin.Result;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.groubear.log.vo.LogVO;
import kr.or.ddit.groubear.stats.service.IStatsService;
import kr.or.ddit.groubear.stats.vo.StatsVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/groubear")
public class StatsController {

	@Inject
	private IStatsService statsService;

//	@GetMapping("/salesmanagementMonth.do")
//	public String salesManagementMonth(Model model) {
//	    List<StatsVO> monthlyData = statsService.getMonthlyData(); // 월별 데이터 가져오기
//	    model.addAttribute("monthlyData", monthlyData); 		   // monthlyData로 설정
//	    model.addAttribute("salesMsg", "month");	
//	    return "groubear/stats/salesManagement";
//	}
//
//	@GetMapping("/salesmanagementYear.do")
//	public String salesManagementYear(Model model) {
//	    List<StatsVO> yearlyData = statsService.getYearlyData(); // 연간 데이터 가져오기
//	    model.addAttribute("yearlyData", yearlyData); 			 // yearlyData로 설정
//	    model.addAttribute("salesMsg", "year");	
//	    return "groubear/stats/salesManagement";
//	}
	
	@GetMapping("/usermanagementMonth.do")
	public String userManagementMonth(Model model) {
		List<StatsVO> monthlyEmp = statsService.getMothlyEmp();
		List<StatsVO> monthlyData = statsService.getMonthlyData();
		List<StatsVO> monthlyCom = statsService.getMothlyCom();
		List<StatsVO> count = statsService.getCountInfo();
		
		log.info("monthlyEmp >>>>>>>>>> " + monthlyEmp);
		log.info("montlyCom >>>>>>>>>> " + monthlyCom);
		log.info("count>>>>>>>>>>>" + count);
		
		model.addAttribute("count", count);	
		model.addAttribute("monthlyCom", monthlyCom);	
		model.addAttribute("monthlyData", monthlyData);
		model.addAttribute("monthlyEmp", monthlyEmp);
		model.addAttribute("salesMsg", "month");

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("statusMenu", "show");
		model.addAttribute("statusSalesAndUser", "active");
		
		return "groubear/stats/userManagement";
	}
	
	@GetMapping("/usermanagementYear.do")
	public String userManagementYear(Model model) {
		List<StatsVO> yearlyEmp = statsService.getYearlyEmp();
		List<StatsVO> yearlyData = statsService.getYearlyData();
		List<StatsVO> yearlyCom = statsService.getYearlyCom();
		List<StatsVO> count = statsService.getCountInfo();
		
		log.info("yearlyEmp >>>>>>>>>> " + yearlyEmp);
		log.info("yearlyCom >>>>>>>>>> " + yearlyCom);
		
		model.addAttribute("count", count);	
		model.addAttribute("yearlyCom", yearlyCom);
		model.addAttribute("yearlyData", yearlyData); 
		model.addAttribute("yearlyEmp", yearlyEmp);
		model.addAttribute("salesMsg", "year");	

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("statusMenu", "show");
		model.addAttribute("statusSalesAndUser", "active");
		
		return "groubear/stats/userManagement";
	}
	

	/**
	 * 구성원 통계
	 * @param model
	 * @return
	 */
	@GetMapping("/companydetailnumofmem.do")
	public String numOfMem(Model model) {
		List<StatsVO> numOfMem = statsService.getnumOfMem();
		log.info("구성원수 >>>>>" + numOfMem);
		model.addAttribute("numOfMem", numOfMem);
		model.addAttribute("comMsg","numOfMem");

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("statusMenu", "show");
		model.addAttribute("companyStatus", "active");
		
		return "groubear/stats/companytDetail";
	}
	
	/**
	 * 프리미엄 통계
	 * @param model
	 * @return
	 */
	@GetMapping("/companydetailpremium.do")
	public String premium(Model model) {
		List<StatsVO> premium = statsService.getpremium();
		log.info("프리미엄 >>>>>" + premium);
		
		model.addAttribute("premium", premium);
		model.addAttribute("comMsg","premium");

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("statusMenu", "show");
		model.addAttribute("companyStatus", "active");
		
		return "groubear/stats/companytDetail";
	}
	
	/**
	 * 개월수 통계
	 * @param model
	 * @return
	 */
	@GetMapping("/companydetailnumofmon.do")
	public String numOfMon(Model model) {
		List<StatsVO> numOfMon = statsService.getnumOfMon();
		log.info("계약기간 >>>>>" + numOfMon);
		model.addAttribute("numOfMon", numOfMon);
		model.addAttribute("comMsg","numOfMon");

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("statusMenu", "show");
		model.addAttribute("companyStatus", "active");
		
		return "groubear/stats/companytDetail";
	}
	
	
	
	@GetMapping("/usermanagementCompany.do")
	public String userManagementCompany(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model
			) {
		PaginationInfoVO<StatsVO> pagingVO = new PaginationInfoVO<StatsVO>(10,5);

		// 검색 기능 추가
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		// startRow, endRow, startPage, endPage를 결정한다,.
		pagingVO.setCurrentPage(currentPage);
		
		// 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
		int totalRecord = statsService.selectCocd(pagingVO);
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord);
		// 총 데시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의
		// 리스트 데이터를 가져온다
		List<StatsVO> dataList = statsService.getComInfo(pagingVO);
		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO); 
		
		
//		List<StatsVO> comInfo = statsService.getComInfo();
		
		model.addAttribute("comInfo", dataList);
		model.addAttribute("salesMsg", "company");	
		
		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("statusMenu", "show");
		model.addAttribute("statusSalesAndUser", "active");
		
		return "groubear/stats/userManagementCompany";
	}
	
	@GetMapping("/statsdetail.do")
	public ResponseEntity<StatsVO> comDetail(String coCd){
		
		StatsVO statsVO = new StatsVO();
		statsVO.setCoCd(coCd);
		
		StatsVO result = statsService.comDetail(statsVO);
		return new ResponseEntity<StatsVO>(result, HttpStatus.OK);
	}
	
	@GetMapping("/statschart.do")
	public ResponseEntity<List<StatsVO>> comOfEmp(@RequestParam String coCd){
		
		StatsVO statsEmpVO = new StatsVO();
		statsEmpVO.setCoCd(coCd);
		System.out.println("statsEmpVO >>>>>> " + statsEmpVO);
		
		List<StatsVO> result = statsService.comOfEmp(statsEmpVO);
		return new ResponseEntity<List<StatsVO>>(result, HttpStatus.OK);
	}

	
}

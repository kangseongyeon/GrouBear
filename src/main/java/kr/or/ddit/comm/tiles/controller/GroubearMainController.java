package kr.or.ddit.comm.tiles.controller;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.comm.alarm.service.IAlarmService;
import kr.or.ddit.comm.cmnty.vo.CmntyVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.groubear.cmnty.service.IGroCmntyService;
import kr.or.ddit.groubear.stats.service.IStatsService;
import kr.or.ddit.groubear.stats.vo.StatsVO;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/groubear")
@PreAuthorize("hasRole('ROLE_GROUBEAR')")
public class GroubearMainController {

	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IGroCmntyService groCmntyService;
	
	@Inject
	private IStatsService statsService;

	@GetMapping("/main.do")
	public String home(Locale locale, Model model) {
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		// 공지사항 위젯
		List<CmntyVO> cmntyNoticeList = groCmntyService.groNoticeSelectListWidjet();
		model.addAttribute("cmntyNoticeList", cmntyNoticeList);
		
		// Q&A 위젯
		// Q&A 카테고리별 전체 게시물과 Q&A 미답변 게시물 카운트하기
		List<CmntyVO> qstnCountList = groCmntyService.qstnSttsAndListCount();
		model.addAttribute("qstnListCount", qstnCountList);
		
		List<StatsVO> monthlyEmp = statsService.getMothlyEmp();
		List<StatsVO> monthlyData = statsService.getMonthlyData();
		List<StatsVO> monthlyCom = statsService.getMothlyCom();
		List<StatsVO> count = statsService.getCountInfo();
		
		model.addAttribute("count", count);	
		model.addAttribute("monthlyCom", monthlyCom);	
		model.addAttribute("monthlyData", monthlyData);
		model.addAttribute("monthlyEmp", monthlyEmp);
		model.addAttribute("salesMsg", "month");
		
		List<StatsVO> yearlyEmp = statsService.getYearlyEmp();
		List<StatsVO> yearlyData = statsService.getYearlyData();
		List<StatsVO> yearlyCom = statsService.getYearlyCom();
		
		model.addAttribute("yearlyCom", yearlyCom);
		model.addAttribute("yearlyData", yearlyData); 
		model.addAttribute("yearlyEmp", yearlyEmp);
		model.addAttribute("salesMsg", "year");	
		
		return "groubear/mainPage/home";
	}
	
}

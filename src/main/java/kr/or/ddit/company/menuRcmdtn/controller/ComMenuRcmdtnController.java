package kr.or.ddit.company.menuRcmdtn.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.comm.menuRcmdtn.service.IMenuRcmdtnService;
import kr.or.ddit.comm.menuRcmdtn.vo.FoodVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.groubear.map.service.IMapService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_COMPANY')")
@RequestMapping("/company")
public class ComMenuRcmdtnController {
	
	@Inject
	private IMenuRcmdtnService menuRcmdtnService;
	
	@Inject
	private IMapService mapService;
	
	@GetMapping("/menuRecommend.do")
	public String menuRecommend (Model model, HttpServletRequest request) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		// 소속된 회사의 경도와 위도 좌표 위치 가져오기
		CompanyVO companyVO = mapService.comMapSelectOne(empVO.getCoCd());
		model.addAttribute("companyVO", companyVO);

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("eventMenu", "show");
		model.addAttribute("rcmdtnInternal", "active");
		
		return "company/menuRcmdtn/menuRcmdtn";
	}
	
	@GetMapping("/foodSelectList.do")
	public ResponseEntity<List<FoodVO>> foodSelectList () {
		
		// 음식 전체 리스트 가져오기
		List<FoodVO> foodList = menuRcmdtnService.foodSelectList();
		
		return new ResponseEntity<List<FoodVO>>(foodList, HttpStatus.OK);
	}
	
}

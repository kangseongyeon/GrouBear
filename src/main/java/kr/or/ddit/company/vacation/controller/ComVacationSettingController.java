package kr.or.ddit.company.vacation.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.vacation.service.IComVacationSettingSerivce;
import kr.or.ddit.company.vacation.service.IComVacationStatusSerivce;
import kr.or.ddit.company.vacation.vo.YearVctVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/company")
@PreAuthorize("hasAnyRole('ROLE_COMPANY')")
public class ComVacationSettingController {

	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IComVacationSettingSerivce vcsettingService;
	
	
	@GetMapping("/vacation/setting.do")
	public String vacationCreateForm(Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);

		// 설정되어있는 년차별 휴가 정보 가져오기
		List<YearVctVO> getvctSettingValList = vcsettingService.getvctSettingval(empVO);
		
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		model.addAttribute("getvctSettingValList",getvctSettingValList);
		model.addAttribute("workMenu", "show");	
		model.addAttribute("vacationStatus", "active");
		return "company/vacation/comVacationSetting";
	}
	
	@ResponseBody
	@PostMapping("/setyearvct.do")
	public ResponseEntity<String> setYearForm(@RequestBody String arr) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		log.info(arr+"");
		
		arr = arr.substring(0, arr.length() - 1); 
		log.info(arr);
		
		String[] vctarr = arr.split(",");
		List<YearVctVO> yvList = new ArrayList<>();
		for (int i = 0; i < vctarr.length; i++) {
			YearVctVO yvVO = new YearVctVO();
			yvVO.setCoCd(empVO.getCoCd());
			yvVO.setYearCnt(i);
			yvVO.setYearVctCnt(Integer.parseInt(vctarr[i]));
			
			yvList.add(yvVO);
		}
		
		int inputResult = vcsettingService.setYearVctCnt(yvList);
		
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}


package kr.or.ddit.groubear.map.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.comm.alarm.vo.AlarmVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.groubear.map.service.IMapService;
import kr.or.ddit.groubear.map.vo.MapVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groubear")
@PreAuthorize("hasRole('ROLE_GROUBEAR')")
public class MapController {

	@Inject
	private IMapService mapService;

	@GetMapping("/map.do")
	public String mapList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, CompanyVO companyVO, MapVO mapVO, Model model,
			HttpServletRequest request) {

		// 페이징 처리
		PaginationInfoVO<CompanyVO> pagingVO = new PaginationInfoVO<CompanyVO>(6, 5);

		// 검색 기능
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);

		int totalRecord = mapService.countList(pagingVO);
		pagingVO.setTotalRecord(totalRecord);


//		List<CompanyVO> mapList = mapService.mapList(companyVO);
		List<CompanyVO> dataList = mapService.mapList(pagingVO);
		List<MapVO> mapLocation = mapService.mapLocation(mapVO);
		log.info("mapList ::: " + dataList);
		log.info("mapLocation ::: " + mapLocation);

		model.addAttribute("dataList", dataList);
		model.addAttribute("mapLocation", mapLocation);
		model.addAttribute("companyVO", companyVO);
		model.addAttribute("pagingVO", pagingVO);
		return "groubear/map/mapList";
	}

	public String mapMain(CompanyVO companyVO, MapVO mapVO, Model model) {
		List<MapVO> mapLocation = mapService.mapLocation(mapVO);
		log.info("mapLocation ::: " + mapLocation);

		model.addAttribute("mapLocation", mapLocation);
		model.addAttribute("companyVO", companyVO);
		return "groubear/mainPage/home";
	}

}

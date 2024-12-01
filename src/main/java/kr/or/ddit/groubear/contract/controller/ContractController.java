package kr.or.ddit.groubear.contract.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.payment.vo.SettlementVO;
import kr.or.ddit.groubear.contract.service.IContractService;
import kr.or.ddit.groubear.contract.vo.ContractVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groubear")
@PreAuthorize("hasRole('ROLE_GROUBEAR')")
public class ContractController {
	
	@Inject
	private IContractService ctrtService;

	@RequestMapping(value="/contract.do", method= RequestMethod.GET)
	public String contractList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, String searchOrder, Model model
			) {
		PaginationInfoVO<ContractVO> pagingVO = new PaginationInfoVO<ContractVO>(10,5);

		
		
		// 검색 기능 추가
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchOrder(searchOrder);
			
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		// startRow, endRow, startPage, endPage를 결정한다,.
		pagingVO.setCurrentPage(currentPage);
		
		// 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
		int totalRecord = ctrtService.selectCtrt(pagingVO);
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord);
		// 총 데시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의
		// 리스트 데이터를 가져온다
		List<ContractVO> dataList = ctrtService.selectCtrtList(pagingVO);
		pagingVO.setDataList(dataList);
		log.info("데이터가 뭐가들었나 >>>>>>> " + dataList);
		model.addAttribute("pagingVO", pagingVO); 
		
		return "groubear/contract/contract";
	}
	
	@GetMapping("/detail.do")
	public ResponseEntity<ContractVO> ctrtDetail(int ctrtNo) {
		ContractVO ctrtVO = new ContractVO();
		ctrtVO.setCtrtNo(ctrtNo);
		
		ContractVO result = ctrtService.detail(ctrtVO);
		return new ResponseEntity<ContractVO>(result, HttpStatus.OK);
	}
	
	@GetMapping("/comDetail.do")
	public ResponseEntity<ContractVO> companyDetail(int ctrtNo){
		
		ContractVO ctrtVO = new ContractVO();
		ctrtVO.setCtrtNo(ctrtNo);
		
		ContractVO result = ctrtService.comDetail(ctrtVO);
		return new ResponseEntity<ContractVO>(result, HttpStatus.OK );
	}
	
	
	
	
}

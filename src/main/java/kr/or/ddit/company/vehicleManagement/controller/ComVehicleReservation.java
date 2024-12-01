package kr.or.ddit.company.vehicleManagement.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.company.vehicleManagement.vo.VHCLRSVTVO;
import kr.or.ddit.company.vehicleManagement.vo.VHCLVO;
import kr.or.ddit.employee.vehicleReservation.service.IVehicleService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/comvehicle")
@PreAuthorize("hasAnyRole('ROLE_COMPANY')")
public class ComVehicleReservation {
//	private final String KAKAO_API_URL = "https://apis-navi.kakaomobility.com/v1/directions";

	@Resource(name = "localPath")
	private String localPath;

	@Inject
	private IVehicleService vehicleService;

	/**
	 * 기능 : 차량 목록, 예약 폼, 모달을 통해 차량 등록 가능 메뉴명 : 기업관리자 / 차량 관리 사원 / 차량 예약
	 * 
	 * @return
	 */
	@GetMapping("/vehicledashboard.do")
	public String vehicleDashBoard(Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = user.getMember();

		List<VHCLVO> vhclList = vehicleService.selectVhclList(userVO.getCoCd());
		model.addAttribute("vhclList", vhclList);
		model.addAttribute("userVO", userVO);

		return "company/vehicleForm/vehicleDashBoard";
	}

	@ResponseBody
	@PostMapping("/findvhclvo.do")
	public VHCLVO findVhclVO(@RequestBody VHCLVO vhclVO) {
	    String vhclNo = vhclVO.getVhclNo();
	    log.info("vhclNo값 : " + vhclNo);
	    VHCLVO newVhclVO = vehicleService.findVhclVO(vhclNo);
	    log.info("newVhclVO : " + newVhclVO);
	    return newVhclVO;
	}

	
	/**
	 * 기능 : 차량 예약현황 페이지 메뉴명 : 기업관리자 , 사원 / 차량 예약 내역
	 * 
	 * @return
	 */
	@GetMapping("/reservationhistory.do")
	public String reservationHistory(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, @RequestParam(required = false) String searchOrder,
			Model model, HttpServletRequest request) {

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = user.getMember();
		log.info("userVO.getCoCd() : " + userVO.getCoCd());
		
		if (searchOrder == "" || searchOrder == null) {
			searchOrder = null;
		}
		
		PaginationInfoVO<VHCLRSVTVO> pagingVO = new PaginationInfoVO<VHCLRSVTVO>(10, 5);
		pagingVO.setCoCd(userVO.getCoCd());
		
		if (StringUtils.isNotBlank(searchWord) || StringUtils.isNotBlank(searchOrder)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchOrder(searchOrder);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchOrder", searchOrder);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = vehicleService.selectRSVTPage(pagingVO);

		pagingVO.setTotalRecord(totalRecord);

		List<VHCLRSVTVO> dataList = vehicleService.selectRSVTPaging(pagingVO);

		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);
		
		List<VHCLRSVTVO> vhclRsvtList = vehicleService.selectAllRSVTHistory(userVO.getCoCd());
		model.addAttribute("vhclRsvtList", vhclRsvtList);
		return "company/vehicleForm/reservationHistory";
	}

	@PostMapping("/vhcldelte.do")
	public String vhclDelte(VHCLVO vhclVO) {
		String goPage = "";
		
		log.info("deleForm으로 들어오는 중");
		log.info("vhclNo 값 : " + vhclVO.getVhclNo());
		ServiceResult result = vehicleService.vhclDelte(vhclVO.getVhclNo()); 
		if (result.equals(ServiceResult.OK)) {
			log.info("수정 완료!");
			goPage = "redirect:/comvehicle/vehicledashboard.do";
		} else {
			log.info("수정 실패!");
			goPage = "redirect:/comvehicle/vehicledashboard.do";
		}
		return goPage;
	}
	
	@PostMapping("/vhclmodify.do")
	public String vhclModify(RedirectAttributes ra, HttpServletRequest req, VHCLVO vhclVO, Model model)
			throws Exception {
		String goPage = "";

		log.info("vhclVO 수정 들어왔을 때 : " + vhclVO);
		MultipartFile file = vhclVO.getVehicleImgFile();
		String createdFileName = vhclVO.getVhclImgPath();
		if (file != null && !file.isEmpty()) {
			createdFileName = uploadFile(file.getOriginalFilename(), file.getBytes());
			vhclVO.setVhclImgPath(createdFileName);
		} else {
			// MultipartFile이 비어있다면 기존 파일 URL을 유지
			createdFileName = vhclVO.getVhclImgPath();
			vhclVO.setVhclImgPath(createdFileName);
			log.info("수정 안 했을 때 : " + vhclVO.getVhclImgPath());
		}
		log.info("수정 직전 : " + ra);
		log.info("수정 직전 : " + req);

		ServiceResult result = vehicleService.vhclInfoModify(req, vhclVO);
		if (result.equals(ServiceResult.OK)) {
			log.info("수정 완료!");
			model.addAttribute("message", "수정이 완료되었습니다!");
			goPage = "redirect:/comvehicle/vehicledashboard.do";
		} else {
			log.info("수정 실패!");
			model.addAttribute("message", "수정에 실패하였습니다!");
			goPage = "redirect:/comvehicle/vehicledashboard.do";
		}
		return goPage;
	}

	@PostMapping("/vhclinsert.do")
	public String vhclInsert(HttpServletRequest req, RedirectAttributes ra, @ModelAttribute VHCLVO vhclVO, Model model)
			throws Exception {
		String goPage = "";
		Map<String, String> errors = new HashMap<String, String>();
		if (StringUtils.isBlank(vhclVO.getVhclNo())) {
			errors.put("값 미입력", "값을 입력해주세요!");
		}

		if (errors.size() > 0) {
			model.addAttribute("errors", errors);
			model.addAttribute("vhclVO", vhclVO);
			goPage = "redirect:/comvehicle/vehicledashboard.do";
		} else {
			CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmployeeVO userVO = user.getMember();
			MultipartFile file = vhclVO.getVehicleImgFile();
			String createdFileName;
			if (file != null && !file.isEmpty()) {
				createdFileName = uploadFile(file.getOriginalFilename(), file.getBytes());
			} else {
				createdFileName = "noimg.jpg";
			}
			vhclVO.setVhclImgPath(createdFileName);
			if (userVO != null) {
				ServiceResult result = vehicleService.insertVHCL(req, vhclVO);
				if (result.equals(ServiceResult.OK)) {
					ra.addFlashAttribute("message", "차량 등록 완료!");
					goPage = "redirect:/comvehicle/vehicledashboard.do";
				} else {
					model.addAttribute("empvehicle", "서버에러, 다시 시도해주세요!");
					goPage = "redirect:/comvehicle/vehicledashboard.do";
				}
			} else {
				ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
				goPage = "redirect:/login.do";

			}
		}
		return goPage;
	}

	private String uploadFile(String originalFilename, byte[] bytes) throws Exception {
		log.info("uploadFile()실행...!");

		UUID uuid = UUID.randomUUID();
		String createdFileName = uuid.toString() + "_" + originalFilename;

		// localPath 활용
		File file = new File(localPath);
		if (!file.exists()) {
			file.mkdirs();
		}
		File target = new File(localPath, createdFileName);
		FileCopyUtils.copy(bytes, target);
		return createdFileName;
	}

	@GetMapping("/callKakaoApi")
	public ResponseEntity<String> callKakaoApi() {
		String apiUrl = "https://apis-navi.kakaomobility.com/v1/directions"; // 실제 API URL
		String apiKey = "17644fb9da903ca514386f792886c4d9"; // 발급받은 API 키

		// API 호출 로직 (예: RestTemplate 사용)
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK " + apiKey);
		HttpEntity<String> entity = new HttpEntity<>(headers);

		ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);

		return ResponseEntity.ok(response.getBody());
	}

}

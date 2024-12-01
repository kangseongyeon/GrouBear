package kr.or.ddit.company.facilities.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.http.HttpStatus;
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
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.comm.file.service.IFileService;
import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.file.vo.AtchFileVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.community.service.IComCommunityService;
import kr.or.ddit.company.facilities.service.IFacilititesCategoryService;
import kr.or.ddit.company.facilities.service.IFacilititesService;
import kr.or.ddit.company.facilities.vo.FacilityCategoryVO;
import kr.or.ddit.company.facilities.vo.FacilityVO;
import kr.or.ddit.company.facilities.vo.FaciltyEquipmentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/company")
@PreAuthorize("hasRole('ROLE_COMPANY')")
public class comFacilitiesAddController {

	@Resource(name = "localPath")
	private String localPath;
	
	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IFacilititesCategoryService fcltctgrService;
	
	@Inject
	private IFacilititesService fcltService;
	
	@Inject
	private IFileService fileService;
	
	@GetMapping("/facilities/add.do")
	public String facilitiesAdd(Locale locale, Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
  		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		//FacilityCategory 정보 가져오기
		List<FacilityCategoryVO> fcltCtgrList = fcltctgrService.getCategoryList(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		model.addAttribute("fcltCtgrList",fcltCtgrList);
		model.addAttribute("facilitesMenu", "show");
		model.addAttribute("facilitesAdd", "active");
		
		return "company/facilities/comFacilitesAdd";
	}
	
	private String uploadFile(String originalFilename, byte[] bytes) throws Exception {
		log.info("uploadFile in..!");
		UUID uuid = UUID.randomUUID(); // UUID로 파일명 생성
		// UUID 원본 파일명
		String createdFileName = uuid.toString() + "_" + originalFilename;

		// localPath 활용
		File file = new File(localPath);
		if (!file.exists()) {
			file.mkdirs();
		}
		File target = new File(localPath, createdFileName); // 파일 업로드 준비
		FileCopyUtils.copy(bytes, target); // 파일 복사

		return createdFileName;
	}
	
	@PostMapping("/facilties/category/insert.do")
	@ResponseBody
	public ResponseEntity<String> communityInsert(FacilityCategoryVO fcltCtgrVO) throws Exception{
		// 유저 정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		// FacilityCategoryVO - 기업 코드
		fcltCtgrVO.setCoCd(empVO.getCoCd());
		
		
		
		// FacilityCategoryVO - 이미지 링크
		MultipartFile file = fcltCtgrVO.getImgFile();
		String fileName = uploadFile(file.getOriginalFilename(), file.getBytes());
		fcltCtgrVO.setFcltCtgrImgUrl(fileName); 
		
		//DB 저장
		int result = fcltctgrService.insertCtgr(fcltCtgrVO);
		
		if (result == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		return new ResponseEntity<String>("error", HttpStatus.BAD_REQUEST);
	}
	
	@ResponseBody
	@PostMapping("/facilties/category/changeTurn.do")
	public ResponseEntity<String> changeCateTurn(@RequestBody String value){
		
		//끝 ',' 삭제
		value = value.substring(0, value.length() - 1);
		
		// value 
		String[] arr = value.split(",");
		
		// 카테고리VO 생성
		FacilityCategoryVO fcltctgrVO = new FacilityCategoryVO();
		for (int i = 0; i < arr.length; i++) {
			fcltctgrVO.setFcltCtgrCd(arr[i]);
			fcltctgrVO.setFcltCtgrTurn(i+"");
			fcltctgrService.changeCateTurn(fcltctgrVO);
		}

		return new ResponseEntity<String>("success",HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping("/facilties/category/getInfo.do")
	public ResponseEntity<FacilityCategoryVO> geICtgrInfo( @RequestBody FacilityCategoryVO fcltCtgrVO){
		
		//카테고리 정보
		fcltCtgrVO = fcltctgrService.getCtgrInfo(fcltCtgrVO);
		
		//카테고리별  시설 정보
		List<FacilityVO> fcltList = fcltService.getFcltList(fcltCtgrVO);
		fcltCtgrVO.setFcltList(fcltList);
		if (fcltCtgrVO.getFcltCtgrNm() == null ) {
			return new ResponseEntity<FacilityCategoryVO>(fcltCtgrVO,HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<FacilityCategoryVO>(fcltCtgrVO,HttpStatus.OK);
	}
	
	@PostMapping("/facilties/category/modify.do")
	@ResponseBody
	public ResponseEntity<String> categoryModify(FacilityCategoryVO fcltCtgrVO) throws Exception{
		log.info(fcltCtgrVO+"");
		int result = fcltctgrService.ctgrModify(fcltCtgrVO);
		if (result == 1) {
			return new ResponseEntity<String>("success",HttpStatus.OK);
		}
		return new ResponseEntity<String>("error",HttpStatus.BAD_REQUEST);
		
	}
	
	@PostMapping("/facilties/category/delete.do")
	public ResponseEntity<String> categoryDelete(@RequestBody FacilityCategoryVO fcltCtgrVO) {
		log.info(fcltCtgrVO+"");
		int result = fcltctgrService.delCategory(fcltCtgrVO);
		if (result == 1) {
			return new ResponseEntity<String>("success",HttpStatus.OK);
		}
		return new ResponseEntity<String>("error",HttpStatus.BAD_REQUEST);
	}
	
	@ResponseBody
	@PostMapping("/facilities/add.do")
	public ResponseEntity<String> addFacilities(FacilityVO fcltVO) throws Exception{
		log.info(fcltVO+"");
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		String userId = employeeVO.getEmpId();
		// 첨부파일 파일 코드 얻기
		String atchCd = fileService.setatchCd();

		//시설 코드 얻기
		String fcltCd = fcltService.setfcltCd();
		
		//시설 내용 등록
 		fcltVO.setFcltCd(fcltCd);
		fcltVO.setAtchFileCd(atchCd);
		int result = fcltService.insertFclt(fcltVO); 
		
		//첨부파일 등록
		AtchFileVO atchVO = new AtchFileVO();
		atchVO.setAtchFileCd(atchCd);
		atchVO.setEmpId(fcltCd);
		result = fileService.insertAtchFile(atchVO);
		
		//첨부파일 상세 등록
		List<MultipartFile> pictures = fcltVO.getAtchFiles();
	    List<AtchFileDetailVO> savedAtchFileDetail = new ArrayList<AtchFileDetailVO>();

	    // 파일이 존재하는 경우에만 처리
	    if (pictures != null && !pictures.isEmpty()) {
	        for (MultipartFile file : pictures) {
	            if (!file.isEmpty()) { // 파일이 비어있지 않은 경우에만 처리
	                log.info("# fileName : " + file.getOriginalFilename());

	                // UUID_원본파일명
	                String savedName = uploadFile(file.getOriginalFilename(), file.getBytes()); // 파일 업로드

	                long bytes = file.getSize();
	                String fancysize;

	                if (bytes > 1024 * 1024) {
	                    fancysize = (bytes / (1024 * 1024)) + " MB"; // MB 단위
	                } else if (bytes > 1024) {
	                    fancysize = (bytes / 1024) + " KB"; // KB 단위
	                } else {
	                    fancysize = bytes + " Byte"; // Byte 단위
	                }

	                AtchFileDetailVO afdVO = new AtchFileDetailVO();
	                afdVO.setAtchFileCd(atchCd);
	                afdVO.setAtchFileDetailPathNm(localPath + savedName);
	                afdVO.setAtchFileDetailExtnNm(savedName.substring(savedName.lastIndexOf(".") + 1));
	                afdVO.setAtchFileDetailSize((int) bytes);
	                afdVO.setAtchFileDetailFancysize(fancysize); // fancysize 설정
	                afdVO.setAtchFileDetailOrgnlNm(file.getOriginalFilename());
	                afdVO.setAtchFileDetailStrgNm(savedName);
	                afdVO.setEmpId(userId);

	                log.info("fileInfo ::: " + file);
	                log.info("afdVO ::: " + afdVO);
	                fileService.insertAtchFileDetail(afdVO);
	            }
	        }
	    } else {
	        log.info("첨부파일이 없습니다."); // 파일이 없을 경우 로그 추가
	    }
	    // 비품 등록
	    FaciltyEquipmentVO fcltEmVO = new FaciltyEquipmentVO();
	    fcltEmVO.setFcltCd(fcltCd);
	    if (fcltVO.getEq1().equals("Y")) {
	    	fcltEmVO.setEquipmentCd("EQ1");
			fcltService.setequipment(fcltEmVO);
		}
	    if (fcltVO.getEq2().equals("Y")) {
	    	fcltEmVO.setEquipmentCd("EQ2");
	    	fcltService.setequipment(fcltEmVO);
	    }
	    if (fcltVO.getEq3().equals("Y")) {
	    	fcltEmVO.setEquipmentCd("EQ3");
	    	fcltService.setequipment(fcltEmVO);
	    }
	    if (fcltVO.getEq4().equals("Y")) {
	    	fcltEmVO.setEquipmentCd("EQ4");
	    	fcltService.setequipment(fcltEmVO);
	    }
	    if (fcltVO.getEq5().equals("Y")) {
	    	fcltEmVO.setEquipmentCd("EQ4");
	    	fcltService.setequipment(fcltEmVO);
	    }
	    
	    
	    if (result == 1) {
			return new ResponseEntity<String>("success",HttpStatus.OK);
		}
		return new ResponseEntity<String>("error",HttpStatus.BAD_REQUEST);
	}
	
	@ResponseBody
	@PostMapping("/facilties/getInfo.do")
	public ResponseEntity<FacilityVO> getFcltInfo( @RequestBody FacilityVO fcltVO){
		
		fcltVO = fcltService.getFcltInfo(fcltVO);
		fcltVO.setFclteqList(fcltService.getFcltEq(fcltVO));
		if (fcltVO == null ) {
			return new ResponseEntity<FacilityVO>(fcltVO,HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<FacilityVO>(fcltVO,HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping("/facilities/del.do")
	public ResponseEntity<String> deleteFclt( @RequestBody FacilityVO fcltVO){
		int result = fcltService.deleteFclt(fcltVO);
		if (result != 1 ) {
			return new ResponseEntity<String>("ERROR",HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
	}
}

package kr.or.ddit.employee.cloud.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.or.ddit.comm.cloud.service.ICloudService;
import kr.or.ddit.comm.cloud.vo.CloudFileVO;
import kr.or.ddit.comm.cloud.vo.CloudFldrAuthrtVO;
import kr.or.ddit.comm.cloud.vo.CloudFldrOrFileVO;
import kr.or.ddit.comm.cloud.vo.CloudStrgFldrVO;
import kr.or.ddit.comm.cloud.vo.CloudStrgVO;
import kr.or.ddit.comm.cloud.vo.CloudUploadFileVO;
import kr.or.ddit.comm.cloud.vo.StrgListVO;
import kr.or.ddit.comm.empallinfo.service.IEmpAllInfoService;
import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_EMPLOYEE')")
@RequestMapping("/employee")
public class EmpCloudController {
	// 동일한 파일 이름이 있는지 여부를 확인하고 다른 이름을 붙이기 위한 리스트 (파일명 검색 후, 동일한 이름의 파일을 다운받을 때 활용)
	int num = 0;
	List<String> nameCheckList = new ArrayList<String>();
	
	@Resource(name = "cloudPath")
	private String cloudPath;
	
	@Inject
	private ICloudService cloudService;
	
	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private IEmpAllInfoService empAllInfoService;
	
	// 전사, 부서, 개인 클라우드함 가져오기, 클라우드함 내부 폴더 및 파일 불러오기
	@GetMapping("/cloudList.do")
	public String cloudList (Model model, RedirectAttributes ra,
			@RequestParam(name="selectStrgCd", required = false) String selectStrgCd) {
		String goPage = "";

		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);

		if (empVO != null) {	// 로그인을 정상적으로 한 상태일 때만
			// 선택한 클라우드함의 용량
			long cloudStrgFileSizeSumBytes = 0;
			String cloudStrgFileSizeSumStr = "";
			
			EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(empVO);
			
			// 로그인한 사람의 전사, 부서, 개인 클라우드함 가져오기 (사이드바 클라우드함 리스트)
			List<CloudStrgVO> allCloudStrgList = cloudService.selectMainCloudStrgList(employeeAllVO);
			
			// 전사 및 개인 클라우드함 꺼내기 (사이드바 클라우드함 리스트)
			CloudStrgVO comCloudStrgVO = new CloudStrgVO();
			CloudStrgVO myCloudStrgVO = new CloudStrgVO();
			
			for (CloudStrgVO strgVO : allCloudStrgList) {
				if (strgVO.getCloudStrgKnd().equals("com")) {
					comCloudStrgVO = strgVO;
				} else if (strgVO.getCloudStrgKnd().equals("prvt")) {
					myCloudStrgVO = strgVO;
				}
			}
			
			// 선택한 클라우드함의 폴더 및 파일 리스트
			List<CloudStrgVO> cloudFolderAndFileList;
			// 선택한 클라우드함의 경로 계층형으로 가져오기
			List<CloudStrgVO> cloudPathList;
			// 선택한 폴더 또는 클라우드함의 가장 상위 클라우드함 가져오기
			CloudStrgVO parentCloud;
			// 가져온 폴더 및 파일의 총 카운트 수
			int selectFldrAndFileCount = 0;
			
			// 클라우드함이나 폴더를 선택하지 않았을 경우
 			if (selectStrgCd == null || selectStrgCd.equals("")) {
				// 클라우드에 들어온 순간 기본적으로 전사 클라우드함 출력
				// 클라우드함 내부의 폴더 및 파일 불러오기 
				selectStrgCd = comCloudStrgVO.getCloudStrgCd();
				selectFldrAndFileCount += cloudService.selectCloudStrgInFldrAndFileCount(comCloudStrgVO.getCloudStrgCd());
				cloudFolderAndFileList = cloudService.selectCloudStrgInFldrAndFileList(comCloudStrgVO.getCloudStrgCd());
				cloudPathList = cloudService.selectCloudPath(comCloudStrgVO.getCloudStrgCd());
				parentCloud = cloudService.selectParentCloud(comCloudStrgVO.getCloudStrgCd());
				
				// 선택한 클라우드함의 총 용량 가져오기
				cloudStrgFileSizeSumBytes = cloudService.cloudStrgFileSizeSumSelect(selectStrgCd);
			} else {	// 클라우드함이나 폴더를 선택했을 경우
 				selectFldrAndFileCount += cloudService.selectCloudFldrInFldrAndFileCount(selectStrgCd);
				cloudFolderAndFileList = cloudService.selectCloudFldrInFldrAndFileList(selectStrgCd);
 				cloudPathList = cloudService.selectCloudPath(selectStrgCd);
         		parentCloud = cloudService.selectParentCloud(selectStrgCd);
				
				if (parentCloud.getCloudStrgDefaultYn().equals("N")) {	// 부모가 커스텀 클라우드함 선택이라면
 					cloudStrgFileSizeSumBytes = cloudService.cloudStrgFileSizeSumSelect(myCloudStrgVO.getCloudStrgCd());
				} else {	// 부모가 기본 클라우드함 선택이라면
					cloudStrgFileSizeSumBytes = cloudService.cloudStrgFileSizeSumSelect(parentCloud.getCloudCd());
				}
			}
 			
 			// 각 폴더가 내 직급으로 열람 권한이 있는지 여부를 확인하기
 			// 빈 폴더 리스트
 			
 			// 쿼리로 가져온 클라우드함 리스트
 			for (int i = 0; i < cloudFolderAndFileList.size(); i++) {
 				// 쿼리로 가져온 클라우드함 또는 폴더 내의 폴더 리스트를 하나씩 꺼내기
 				List<CloudStrgFldrVO> cloudStrgFldrList =  new ArrayList<CloudStrgFldrVO>();
 				List<CloudStrgFldrVO> cloudFldrList = cloudFolderAndFileList.get(i).getCloudStrgFldrList();
 				
 				// 폴더 리스트 내의 폴더를 하나씩 꺼내기
 				for (CloudStrgFldrVO cloudFldrVO : cloudFldrList) {
 					Map<String, String> map = new HashMap<String, String>();
 					map.put("cloudStrgFldrCd", cloudFldrVO.getCloudStrgFldrCd());
 					map.put("jbgdCd", employeeAllVO.getJbgdCd());
 					String cloudFldrAuthYn = cloudService.cloudFldrAuthCheckOne(map);
 					
 					// 반환받은 열람여부를 vo에 세팅한 후 리스트에 넣기
 					cloudFldrVO.setCloudFldrAuthYn(cloudFldrAuthYn);
 					cloudStrgFldrList.add(cloudFldrVO);
 					cloudFolderAndFileList.get(i).setCloudStrgFldrList(cloudStrgFldrList);
				}
			}
 			// 폴더 열람여부를 모두 추가한 폴더 리스트를 다시 기존의 폴더 및 파일 리스트에 넣기
 			for (int i = 0; i < cloudFolderAndFileList.size(); i++) {
 				
			}
 			
			// 바이트를 읽기 쉬운 형식으로 변환
			String fancySize = FileUtils.byteCountToDisplaySize(cloudStrgFileSizeSumBytes);
	        // 읽기 쉬운 형식에서 숫자와 단위를 분리
	        String[] parts = fancySize.split(" "); 
	        cloudStrgFileSizeSumStr = parts[0] + parts[1];
	        
	        // 10GB를 바이트로 변환
	        long totalBytes = 10L * 1024 * 1024 * 1024; // 10GB in bytes
	        double percentUsed = Double.valueOf(cloudStrgFileSizeSumBytes) / totalBytes * 100;		// 퍼센트 계산
	        // 반올림해서 정수로 변환
	        int fileSizePercent = (int)Math.round(percentUsed);
			
			model.addAttribute("parentCloud", parentCloud);
			model.addAttribute("selectFldrAndFileCount", selectFldrAndFileCount);
			model.addAttribute("selectStrgCd", selectStrgCd);
			model.addAttribute("jbgdCd", employeeAllVO.getJbgdCd());
			model.addAttribute("cloudStrgFileSizeSumStr", cloudStrgFileSizeSumStr);
			model.addAttribute("fileSizePercent", fileSizePercent);
			
			log.info(">>>>>>>>>>>>>>>>>>> parentCloud : " + parentCloud.toString());
			log.info(">>>>>>>>>>>>>>>>>>> selectFldrAndFileCount : " + selectFldrAndFileCount);
			
			// 개인 클라우드함에 속한 커스텀 클라우드함 불러오기
			List<CloudStrgVO> myCloudStrgCustomList = cloudService.selectMyCloudStrgCustomList(empVO);

			// 가져온 데이터 Map에 넣어서 model에 넣기
			Map<String, List<CloudStrgVO>> cloudStrgListMap = new HashMap<String, List<CloudStrgVO>>();
			
			cloudStrgListMap.put("allCloudStrgList", allCloudStrgList);				// 사이드바 클라우드함 리스트
 			cloudStrgListMap.put("cloudFolderAndFileList", cloudFolderAndFileList);	// 전사 클라우드의 폴더 및 파일 리스트
			cloudStrgListMap.put("myCloudStrgCustomList", myCloudStrgCustomList);	// 개인 클라우드의 커스텀 클라우드함 목록
			cloudStrgListMap.put("cloudPathList", cloudPathList);	// 선택한 클라우드함의 경로

 			model.addAttribute("cloudStrgListMap", cloudStrgListMap);

 			// 사이드바 메뉴 아코디언 고정하기
 			model.addAttribute("cloudMenu", "show");
 			model.addAttribute("cloudInternal", "active");
 				
 			goPage = "employee/cloud/cloudList";
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
			goPage = "redirect:/login.do";
		}
		
		return goPage;
	}
	
	@GetMapping("/cloudListSearch.do")
	public String cloudListSearch (@RequestParam("searchWord") String searchWord, Model model, HttpServletRequest request) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(employeeVO);
		
		// 회원정보
		model.addAttribute("employeeVO", employeeVO);
		
		// 리스트 페이징 처리하기
		PaginationInfoVO<CloudStrgVO> pagingVO = new PaginationInfoVO<CloudStrgVO>(10,5);
		pagingVO.setCoCd(employeeVO.getCoCd());
		
		// 검색 기능 추가
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}
		
		// 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
		int totalRecord = cloudService.cloudListSearchCount(pagingVO);
		
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord); 
		
		// 총 게시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의 리스트 데이터를 가져온다.
		List<CloudStrgVO> cloudList = cloudService.cloudListSearch(pagingVO);
		
		for (int i = 0; i < cloudList.size(); i++) {
			
			// 만약에 폴더 리스트가 null이 아니거나 비어있지 않다면
			if ( cloudList.get(i).getCloudStrgFldrList() != null && !cloudList.get(i).getCloudStrgFldrList().isEmpty() ) {
 				// 쿼리로 가져온 클라우드함 또는 폴더 내의 폴더 리스트를 하나씩 꺼내기
 				List<CloudStrgFldrVO> cloudStrgFldrList =  new ArrayList<CloudStrgFldrVO>();
 				
				// 폴더 리스트 내의 폴더를 하나씩 꺼내기
				for (CloudStrgFldrVO cloudFldrVO : cloudList.get(i).getCloudStrgFldrList()) {
 				
 					Map<String, String> map = new HashMap<String, String>();
 					map.put("cloudStrgFldrCd", cloudFldrVO.getCloudStrgFldrCd());
 					map.put("jbgdCd", employeeAllVO.getJbgdCd());
 					String cloudFldrAuthYn = cloudService.cloudFldrAuthCheckOne(map);
 					
 					// 반환받은 열람여부를 vo에 세팅한 후 리스트에 넣기
 					cloudFldrVO.setCloudFldrAuthYn(cloudFldrAuthYn);
 					cloudStrgFldrList.add(cloudFldrVO);
 					cloudList.get(i).setCloudStrgFldrList(cloudStrgFldrList);
				
 				}
			}
		}
		
		pagingVO.setDataList(cloudList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n totalRecord : " + totalRecord);
		
		///

		// 로그인한 사람의 전사, 부서, 개인 클라우드함 가져오기 (사이드바 클라우드함 리스트)
		List<CloudStrgVO> allCloudStrgList = cloudService.selectMainCloudStrgList(employeeAllVO);
		
		// 전사 및 개인 클라우드함 꺼내기 (사이드바 클라우드함 리스트)
		CloudStrgVO comCloudStrgVO = new CloudStrgVO();
		CloudStrgVO myCloudStrgVO = new CloudStrgVO();
		
		for (CloudStrgVO strgVO : allCloudStrgList) {
			if (strgVO.getCloudStrgKnd().equals("com")) {
				comCloudStrgVO = strgVO;
			} else if (strgVO.getCloudStrgKnd().equals("prvt")) {
				myCloudStrgVO = strgVO;
			}
		}
		
		// 개인 클라우드함에 속한 커스텀 클라우드함 불러오기
		List<CloudStrgVO> myCloudStrgCustomList = cloudService.selectMyCloudStrgCustomList(employeeVO);

		// 가져온 데이터 Map에 넣어서 model에 넣기
		Map<String, List<CloudStrgVO>> cloudStrgListMap = new HashMap<String, List<CloudStrgVO>>();
		
		// 검색시, 기본적으로 전사 클라우드함 용량 노출
		// 선택한 클라우드함의 용량
		CloudStrgVO parentCloud = cloudService.selectParentCloud(comCloudStrgVO.getCloudStrgCd());
		long cloudStrgFileSizeSumBytes = cloudService.cloudStrgFileSizeSumSelect(parentCloud.getCloudCd());
		
		// 가져온 클라우드함 용량 GB 단위로 변환
		double fileSizeInGB = ((double) cloudStrgFileSizeSumBytes / (1024 * 1024 * 1024)); // GB로 변환
		fileSizeInGB = Math.round(fileSizeInGB * 10.0) / 10.0;
		String cloudStrgFileSizeSumStr = fileSizeInGB + "GB";
		
		// 바이트를 읽기 쉬운 형식으로 변환
		String fancySize = FileUtils.byteCountToDisplaySize(cloudStrgFileSizeSumBytes);
        // 읽기 쉬운 형식에서 숫자와 단위를 분리
        String[] parts = fancySize.split(" "); 
        cloudStrgFileSizeSumStr = parts[0] + parts[1];
        
        // 10GB를 바이트로 변환
        long totalBytes = 10L * 1024 * 1024 * 1024; // 10GB in bytes
        double percentUsed = Double.valueOf(cloudStrgFileSizeSumBytes) / totalBytes * 100;		// 퍼센트 계산
        // 반올림해서 정수로 변환
        int fileSizePercent = (int)Math.round(percentUsed);
		
		
		model.addAttribute("parentCloud", parentCloud);
		model.addAttribute("cloudStrgFileSizeSumStr", cloudStrgFileSizeSumStr);
		model.addAttribute("fileSizePercent", fileSizePercent);

		model.addAttribute("jbgdCd", employeeAllVO.getJbgdCd());
		
		cloudStrgListMap.put("allCloudStrgList", allCloudStrgList);				// 사이드바 클라우드함 리스트
		cloudStrgListMap.put("myCloudStrgCustomList", myCloudStrgCustomList);	// 개인 클라우드의 커스텀 클라우드함 목록

		model.addAttribute("cloudStrgListMap", cloudStrgListMap);

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("cloudMenu", "show");
		model.addAttribute("cloudInternal", "active");
			
		return "employee/cloud/cloudListSearch";
	}

	// Jstree에 출력할 클라우드 계층형 데이터
	@GetMapping("/cloudSelectJstree.do")
	public ResponseEntity<JsonArray> cloudSelectJstree(Model model) {
		// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		// 컨트롤러에서 사용자 권한 정보 가져오기
		/* Collection<GrantedAuthority> auth = user.getAuthorities(); */

		CompanyVO companyVO = tilesService.getCompany(employeeVO);
		
		model.addAttribute("employeeVO",employeeVO);
		model.addAttribute("companyVO",companyVO);
		
		// 아래처럼 treeList를 프론트에 전달
		// id, text, parent, type 변수그대로사용
		JsonArray treeList = new JsonArray();
		
		// 로그인한 사람의 전사, 부서, 개인 클라우드함 가져오기 (사이드바 클라우드함 리스트)
		EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(employeeVO);
		List<CloudStrgVO> allCloudStrgList = cloudService.selectMainCloudStrgList(employeeAllVO);
		
		for (CloudStrgVO cloudStrg : allCloudStrgList) {
			log.info(">>>>>>>>>>>>>>cloudStrg : " + cloudStrg);
		}
		
		// 전사, 부서, 기본 클라우드함 코드  파라미터로 전달
		Map<String, String> map = new HashMap<String, String>();
		
		for (CloudStrgVO cloudStrgVO : allCloudStrgList) {
			if (cloudStrgVO.getCloudStrgKnd().equals("com")) {
				map.put("com", cloudStrgVO.getCloudStrgCd());
			} else if (cloudStrgVO.getCloudStrgKnd().equals("dept")) {
				map.put("dept", cloudStrgVO.getCloudStrgCd());
			} else if (cloudStrgVO.getCloudStrgKnd().equals("prvt")) {
				map.put("my", cloudStrgVO.getCloudStrgCd());
			}
		}
		
		map.put("coCd", employeeVO.getCoCd());
		map.put("empId", employeeVO.getEmpId());
		
		List<StrgListVO> StrgList = cloudService.cloudSelectJstree(map);
		
		// jstree에게 전달하기 위한 제이슨 형태의 객체로 데이터 가공하기
		if(StrgList.size() > 0) {
		    for(int i = 0; i < StrgList.size(); i++){
		    	JsonObject json = new JsonObject();		// JSON 객체를 만들기 위한 준비
		    	json.addProperty("id", StrgList.get(i).getStrgCd());
		    	json.addProperty("text", StrgList.get(i).getStrgNm());
		    	json.addProperty("parent", StrgList.get(i).getStrgUpCd());
		    	if (StrgList.get(i).getStrgCd().contains("STR")) {
		    		json.addProperty("type", "cloudStrg"); //css icon 폴더 아이콘 (파랑)
		    	} else {
		    		json.addProperty("type", "cloudFlrd"); //css icon 폴더 아이콘 (노랑)
		    	}
		        treeList.add(json);
		    }
		}
		return new ResponseEntity<JsonArray>(treeList, HttpStatus.OK);
	}
	
	@PostMapping("/fileUpload.do")
	public ResponseEntity<Object> fileUpload(CloudUploadFileVO cloudUploadFileVO) {
		ServiceResult result = null;
		String strgSelectCd = cloudUploadFileVO.getStrgSelectCd();
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		Map<String, String> map = new HashMap<String, String>();

		if (empVO != null) {	// 로그인을 정상적으로 한 상태일 때만
			
			// 전달받은 CloudUploadFileVO 내 파일 데이터들을 세팅하여 List에 담기
			List<CloudFileVO> cloudFileList = new ArrayList<CloudFileVO>();
			
			for (MultipartFile multipartFile : cloudUploadFileVO.getFiles()) {
				// VO내에서 파일 데이터 세팅하기
				CloudFileVO file = new CloudFileVO(strgSelectCd, empVO, multipartFile);
				
				// 선택한 클라우드함 또는 폴더에 해당 동일한 파일명이 있으면 업로드 불가처리
				CloudFileVO param = new CloudFileVO();
				param.setCoCd(empVO.getCoCd());
				param.setCloudFileOrgnlNm(multipartFile.getOriginalFilename());
				param.setCloudFileUpCd(cloudUploadFileVO.getStrgSelectCd());
				result = cloudService.cloudFileNameCheck(param);
				
				if (result.equals(ServiceResult.EXIST)) {
					map.put("result", "EXIST");
					return new ResponseEntity<Object>(map, HttpStatus.OK);
				}
				
				cloudFileList.add(file);
			}
			
			result = cloudService.cloudFileListInsert(strgSelectCd, empVO, cloudFileList);
			
			map.put("selectStrgCd", strgSelectCd);
			if (result.equals(ServiceResult.OK)) {
				map.put("result", "OK");
			} else {
				map.put("result", "FAILED");
			}
		} else {
			map.put("result", "LOGOUT");
		}
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}
	
	@PostMapping("/cloudMoveList.do")
	public ResponseEntity<ServiceResult> cloudMoveList(@RequestBody CloudFldrOrFileVO cloudFldrOrFileVO) {
		ServiceResult result = null;
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		if (empVO != null) {	// 로그인을 정상적으로 한 상태일 때만
			
			List<String> selectList = cloudFldrOrFileVO.getCheckArr();
			String strgSelectCd = cloudFldrOrFileVO.getCloudUpCd();
			
			List<CloudFldrOrFileVO> cloudMoveList = new ArrayList<CloudFldrOrFileVO>();
			for (String fldrOrFileCd : selectList) {
				CloudFldrOrFileVO param = new CloudFldrOrFileVO();
				param.setFldrOrFileCd(fldrOrFileCd);
				param.setCloudUpCd(strgSelectCd);
				cloudMoveList.add(param);
			}
			
			// 하위 폴더가 있는지 여부 체크
			int count = 0;
			
			for (CloudFldrOrFileVO moveVO : cloudMoveList) {
				count += cloudService.innerDownFlrdCheck(moveVO);
			}
			//>>>>>>>>>>>>>>>>>>>>>>>> innerDownFlrdCheck count : 0
			log.info(">>>>>>>>>>>>>>>>>>>>>>>> innerDownFlrdCheck count : " + count);
			
			if (count > 0) {		// 선택한 폴더 중에 하위 폴더가 있는지 여부 확인
				result = ServiceResult.FAILED;
			} else {
				/*
				cloudMoveList : [CloudFldrOrFileVO(fldrOrFileCd=FIL259, cloudUpCd=FDR131, checkArr=null)]
				 */
				log.info("cloudMoveList->cloudMoveList : " + cloudMoveList);
				for (CloudFldrOrFileVO moveVO : cloudMoveList) {
					//moveVO(fldrOrFileCd=FIL259, cloudUpCd=FDR131, checkArr=null)
					log.info("moveVO : " + moveVO);
					//empVO.getCoCd() : b001
					log.info("empVO.getCoCd() : " + empVO.getCoCd());
					result = cloudService.cloudMove(moveVO, empVO.getCoCd());
				}
			}
		} else {
			result = ServiceResult.NOTEXIST;
		}
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@PostMapping("/cloudDeleteList.do")
	public ResponseEntity<ServiceResult> cloudDeleteList(@RequestBody CloudFldrOrFileVO cloudFldrOrFileVO) {
		ServiceResult result = null;
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		if (empVO != null) {	// 로그인을 정상적으로 한 상태일 때만
			
			List<String> selectList = cloudFldrOrFileVO.getCheckArr();
//			String strgSelectCd = cloudFldrOrFileVO.getCloudUpCd();
			
			List<CloudFldrOrFileVO> cloudDelList = new ArrayList<CloudFldrOrFileVO>();
			for (String fldrOrFileCd : selectList) {
				CloudFldrOrFileVO param = new CloudFldrOrFileVO();
				param.setFldrOrFileCd(fldrOrFileCd);
				cloudDelList.add(param);
			}
			
			// 하위 폴더가 있는지 여부 체크
			int count = 0;
			
			for (CloudFldrOrFileVO delVO : cloudDelList) {
				count += cloudService.innerDownFlrdCheck(delVO);
			}
			log.info(">>>>>>>>>>>>>>>>>>>>>>>> innerDownFlrdCheck count : " + count);
			
			if (count > 0) {		// 선택한 폴더 중에 하위 폴더가 있는지 여부 확인
				result = ServiceResult.FAILED;
			} else {
				for (CloudFldrOrFileVO moveVO : cloudDelList) {
					result = cloudService.cloudFldrOrFileDelete(empVO, moveVO);
				}
			}
		}  else {
			result = ServiceResult.NOTEXIST;
		}
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@PostMapping("/cloudStrgCustomInsert.do")
	public ResponseEntity<CloudStrgVO> cloudStrgCustomInsert(@RequestBody CloudStrgVO cloudStrgVO) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		cloudStrgVO.setCoCd(empVO.getCoCd());
		cloudStrgVO.setEmpId(empVO.getEmpId());
		
		log.info(">>>>>>>>>>>>>>>>>>>>> cloudStrgVO : " + cloudStrgVO.toString());
		
		cloudService.cloudStrgCustomInsert(cloudStrgVO);

		return new ResponseEntity<CloudStrgVO>(cloudStrgVO, HttpStatus.OK);
	}
	
	@PostMapping("/cloudStrgCustomDelete.do")
	public ResponseEntity<ServiceResult> cloudStrgCustomDelete(@RequestBody CloudStrgVO cloudStrgVO) {
		ServiceResult result = null;
		
		CloudFldrOrFileVO delVO = new CloudFldrOrFileVO();
		delVO.setFldrOrFileCd(cloudStrgVO.getCloudStrgCd());
		
		// 하위 폴더가 있는지 여부 체크
		int count = cloudService.innerDownFlrdCheck(delVO);
		log.info(">>>>>>>>>>>>>>>>>>>>>>>> innerDownFlrdCheck count : " + count);
		
		if (count > 0) {		// 선택한 폴더 중에 하위 폴더가 있는지 여부 확인
			result = ServiceResult.FAILED;
		} else {
			result = cloudService.cloudStrgCustomDelete(cloudStrgVO);
		}
		
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@GetMapping("/jobgradeSelectList.do")
	public ResponseEntity<List<JobGradeVO>> jobgradeSelectList() {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		List<JobGradeVO> jobGradeList = cloudService.jobgradeSelectList(empVO.getCoCd());
		
		return new ResponseEntity<List<JobGradeVO>>(jobGradeList, HttpStatus.OK);
	}
	
	@GetMapping("/cloudFldrAuthrtListSelect.do")
	public ResponseEntity<List<CloudFldrAuthrtVO>> cloudFldrAuthrtListSelect(@RequestParam("cloudStrgFldrCd") String cloudStrgFldrCd) {
		List<CloudFldrAuthrtVO> CloudFldrAuthrtList = cloudService.cloudFldrAuthrtListSelect(cloudStrgFldrCd);

		return new ResponseEntity<List<CloudFldrAuthrtVO>>(CloudFldrAuthrtList, HttpStatus.OK);
	}
	
	@PostMapping("/unAuthFldrListSelect.do")
	public ResponseEntity<List<CloudStrgFldrVO>> unAuthFldrListSelect(@RequestBody CloudFldrOrFileVO cloudFldrOrFileVO) {
		List<String> unAuthFldrList = cloudFldrOrFileVO.getCheckArr();
		
		List<CloudStrgFldrVO> CloudStrgFldrVOList = new ArrayList<CloudStrgFldrVO>();
		for (String unAuthFldr : unAuthFldrList) {
			CloudFldrOrFileVO param = new CloudFldrOrFileVO();
			param.setFldrOrFileCd(unAuthFldr);
			
			CloudStrgFldrVO fldrVO = cloudService.selectCloudFldr(param);
			CloudStrgFldrVOList.add(fldrVO);
		}
		
		return new ResponseEntity<List<CloudStrgFldrVO>>(CloudStrgFldrVOList, HttpStatus.OK);
	}
	
	@GetMapping("/newCloudFldrNameCheck.do")
	public ResponseEntity<String> newCloudFldrNameCheck(@RequestParam("cloudFldrName") String cloudFldrName,
								@RequestParam(name="cloudFldrCd", required = false) String cloudFldrCd) {
		String result = "";
		CloudStrgFldrVO cloudStrgFldrVO = new CloudStrgFldrVO();
		cloudStrgFldrVO.setCloudStrgFldrNm(cloudFldrName);
		cloudStrgFldrVO.setCloudStrgFldrCd(cloudFldrCd);
		
		int status = cloudService.newCloudFldrNameCheck(cloudStrgFldrVO);
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> status : " + status);
		
		if (status > 0) {
			result = "EXIST";
		} else {
			result = "NOEXIST";
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@GetMapping("/modifyCloudFldrNameCheck.do")
	public ResponseEntity<String> modifyCloudFldrNameCheck(@RequestParam("cloudFldrName") String cloudFldrName,
			@RequestParam(name="cloudFldrCd", required = false) String cloudFldrCd) {
		String result = "";
		CloudStrgFldrVO cloudStrgFldrVO = new CloudStrgFldrVO();
		cloudStrgFldrVO.setCloudStrgFldrNm(cloudFldrName);
		cloudStrgFldrVO.setCloudStrgFldrCd(cloudFldrCd);
		
		int status = cloudService.modifyCloudFldrNameCheck(cloudStrgFldrVO);
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> status : " + status);
		
		if (status > 0) {
			result = "EXIST";
		} else {
			result = "NOEXIST";
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@PostMapping("/cloudNewFldrInsert.do")
	public String cloudNewFldrInsert(CloudStrgFldrVO cloudStrgFldrVO, RedirectAttributes ra) {
		String goPage = "";
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		cloudStrgFldrVO.setCloudStrgFldrRegEmpId(empVO.getEmpId());
		log.info(">>>>>>>>>>>>>>>>> cloudStrgFldrVO : " + cloudStrgFldrVO.toString());
		
		// 새폴더 만들기
		int status = cloudService.cloudNewFldrInsert(cloudStrgFldrVO);
		
		if (status > 0) {	// 새폴더 만들기가 성공했다면
			// 선택한 직급을 배열로 가져오기
			String[] authList = cloudStrgFldrVO.getCloudFldrAuthrtArray();
			
			// 해당 회사의 직급 리스트 가져오기
			List<JobGradeVO> jobGradeList = cloudService.jobgradeSelectList(empVO.getCoCd());
			
			// 데이터를 가공해서 넣을 직급권한VO 리스트
			List<CloudFldrAuthrtVO> CloudFldrAuthrtList = new ArrayList<CloudFldrAuthrtVO>();		
			
			// CloudFldrAuthrtList에 넣을 VO 세팅하기
			for (JobGradeVO jobGradeVO : jobGradeList) {	// 회사의 전체 직급 돌리기
				
				CloudFldrAuthrtVO cloudFldrAuthrtVO = new CloudFldrAuthrtVO();
				String jbgdCd = jobGradeVO.getJbgdCd();
				cloudFldrAuthrtVO.setCloudFldrCd(cloudStrgFldrVO.getCloudStrgFldrCd());
				cloudFldrAuthrtVO.setJbgdCd(jbgdCd);
				
				// 전체 직급을 돌렸을 때, 해당 직급이 선택한 직급에 포함되있다면
				boolean flag = ArrayUtils.contains(authList, jbgdCd);
				
				if (flag) {	// 선택된 직급이라면
					cloudFldrAuthrtVO.setCloudFldrAuthrtYn("Y");
				} else {	// 선택되지 않은 직급이라면
					cloudFldrAuthrtVO.setCloudFldrAuthrtYn("N");
				}
				CloudFldrAuthrtList.add(cloudFldrAuthrtVO);
			}
			ServiceResult result = cloudService.cloudFldrAuthListInsert(CloudFldrAuthrtList);
			
			if (result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("message", "폴더 생성이 완료되었습니다.");
				goPage = "redirect:/employee/cloudList.do?selectStrgCd=" + cloudStrgFldrVO.getCloudFldrUpCd();
			} else {
				ra.addFlashAttribute("message", "폴더 생성이 실패했습니다. 다시 시도해주세요.");
				goPage = "redirect:/employee/cloudList.do?selectStrgCd=" + cloudStrgFldrVO.getCloudFldrUpCd();
			}
		}
		return goPage;
	}
	
	@PostMapping("/modifyCloudFldr.do")
	public String modifyCloudFldr(CloudStrgFldrVO cloudStrgFldrVO, RedirectAttributes ra) {
		String goPage = "";
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		cloudStrgFldrVO.setCloudStrgFldrRegEmpId(empVO.getEmpId());
		log.info(">>>>>>>>>>>>>>>>> cloudStrgFldrVO : " + cloudStrgFldrVO.toString());
		
		int status = 0;
		// 폴더명 수정하기
		status += cloudService.cloudFldrUpdate(cloudStrgFldrVO);
		
		if (status > 0) {	// 폴더명 수정이 성공했다면
			// 선택한 직급을 배열로 가져오기
			String[] authList = cloudStrgFldrVO.getCloudFldrAuthrtArray();
			
			// 해당 폴더의 열람권한 리스트 가져오기
			List<CloudFldrAuthrtVO> fldrAuthrtList = cloudService.fldrAuthrtSelectList(cloudStrgFldrVO.getCloudStrgFldrCd());
			
			int result = 0;
			
			// 해당 폴더의 열람권한 리스트 돌리기
			for (CloudFldrAuthrtVO authrtVO : fldrAuthrtList) {	
				
				// 전체 직급을 돌렸을 때, 해당 직급이 선택한 직급에 포함되있다면
				boolean flag = ArrayUtils.contains(authList, Integer.toString(authrtVO.getCloudFldrAuthrtNo()));
				
				if (flag) {	// 선택된 직급이라면
					result += cloudService.cloudFldrAuthListUpdateY(authrtVO);
				} else {	// 선택되지 않은 직급이라면
					result += cloudService.cloudFldrAuthListUpdateN(authrtVO);
				}
			}
			
			if (result > 0) {
				ra.addFlashAttribute("message", "폴더 수정이 완료되었습니다.");
				goPage = "redirect:/employee/cloudList.do?selectStrgCd=" + cloudStrgFldrVO.getCloudFldrUpCd();
			} else {
				ra.addFlashAttribute("message", "폴더 수정이 실패했습니다. 다시 시도해주세요.");
				goPage = "redirect:/employee/cloudL`ist.do?selectStrgCd=" + cloudStrgFldrVO.getCloudFldrUpCd();
			}
		}
		return goPage;
	}
	
	@PostMapping("/cloudDownList.do")
	public ResponseEntity<String> cloudDownList(@RequestBody CloudFldrOrFileVO cloudDownloadVO) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		// 사용자의 기본 경로과 운영체제별로 다운로드 경로 세팅하기
	    String userHome = System.getProperty("user.home");
	    String os = System.getProperty("os.name").toLowerCase();
	    String downloadDir;

	    if (os.contains("win")) {
	        downloadDir = userHome + "\\Downloads\\"; // 윈도우
	    } else if (os.contains("mac")) {
	        downloadDir = userHome + "/Downloads/"; // 맥
	    } else if (os.contains("nix") || os.contains("nux") || os.contains("aix")) {
	        downloadDir = userHome + "/Downloads/"; // 리눅스
	    } else {
	        downloadDir = userHome + "/Downloads/"; // 기타 (예비용)
	    }
		
		// 파일을 다운받을 기본 경로
	    LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy.MM.dd HHmmss");
        String formattedDate = now.format(formatter);
        String downZipName = formattedDate + "_groubear.zip";
        
        log.info(">>>>>>>>>>>>>>>>> 다운로드");
        log.info(">>>>>>>>>>>>>>>>> cloudDownloadVO.getDownList() : " + cloudDownloadVO.getDownList().toString());
        
        // 넘겨받은 다운 목록 리스트 꺼내기
        List<String> downloadList = cloudDownloadVO.getDownList();
		
        // 다운받을 경로 및 압축 파일의 이름 세팅하기
		String dowmloadPath = downloadDir + downZipName;

        try (ZipOutputStream zos = new ZipOutputStream(Files.newOutputStream(Paths.get(dowmloadPath)))) {
            for (String down : downloadList) {
            	log.info(">>>>>>>>>>>>>>> down : " + down);
            	
            	if (down.contains("FDR")) {		// 폴더라면 
					// 폴더 위치 경로 세팅하기
					List<CloudStrgVO> CloudStrgList = cloudService.selectCloudPath(down);	// 경로 가져오기
					String cloudFldrPath = "";
					
					// \STR1\FDR138
					for (CloudStrgVO cloudStrgVO : CloudStrgList) {
						if (cloudStrgVO.getCloudCd().contains("STR")) {
							CloudStrgVO strgVO = cloudService.selectCloudStrg(cloudStrgVO.getCloudCd());
							cloudFldrPath = File.separator + strgVO.getCloudStrgCd() + "_" + strgVO.getCloudStrgNm();
						} else {
							CloudFldrOrFileVO param = new CloudFldrOrFileVO();
							param.setFldrOrFileCd(cloudStrgVO.getCloudCd());
							
							CloudStrgFldrVO cloudStrgFldrVO = cloudService.selectCloudFldr(param);
							cloudFldrPath +=  File.separator + cloudStrgFldrVO.getCloudStrgFldrCd() + "_" + cloudStrgFldrVO.getCloudStrgFldrNm();
						}
					}
					String fldrPath = cloudPath + File.separator + empVO.getCoCd() + cloudFldrPath;
					File fldrToZip = new File(fldrPath);
					
					// 폴더 압축 메서드
	                if (fldrToZip.exists()) {
	                	int index = fldrToZip.getName().lastIndexOf('_'); // 마지막 '_' 위치 찾기
	                	String fldrOrgnName = fldrToZip.getName().substring(index + 1); // '_' 뒤의 부분
	                	
	                	zipDirectory(fldrToZip, fldrOrgnName, zos);
	                } else {
	                    log.info("폴더 없음 : " + fldrPath); 
	                }
            	} else if (down.contains("FIL")) {
            		CloudFldrOrFileVO cloudFile = new CloudFldrOrFileVO();
            		cloudFile.setFldrOrFileCd(down);
        			CloudFileVO fileVO = cloudService.selectCloudFile(cloudFile);
            		
        			String filePath = fileVO.getCloudFilePathNm() + File.separator + fileVO.getCloudFileStrgNm();
					File fileToZip = new File(filePath);
        			
					// 파일 압축 메서드
	                if (fileToZip.exists()) {
	                	int index = fileToZip.getName().lastIndexOf('_'); // 마지막 '_' 위치 찾기
	                	String fileOrgnName = fileToZip.getName().substring(index + 1); // '_' 뒤의 부분
	                	
	                	zipFile(fileToZip, zos, fileOrgnName);
	                } else {
	                    log.info("파일 없음 : " + filePath);
	                }
            	}
            }
        } catch (IOException e) {
            log.error("ZIP 파일 생성 중 오류 발생: " + e.getMessage(), e);
            return new ResponseEntity<String>("FAIL", HttpStatus.OK);
        }
		return new ResponseEntity<String>("OK", HttpStatus.OK);
	}
	
	private void zipDirectory(File fldrToZip, String fldrName, ZipOutputStream zos) throws IOException {
		// 폴더 내의 폴더 및 파일 여부 확인 후 재귀함수 호출
		for (File file : fldrToZip.listFiles()) {
        	int index1 = file.getName().lastIndexOf('_'); // 마지막 '_' 위치 찾기
        	String fldrOrgnName = fldrName + File.separator + file.getName().substring(index1 + 1); // '_' 뒤의 부분

            if (file.isDirectory()) {
                zos.putNextEntry(new ZipEntry(fldrOrgnName + "/")); // 디렉토리 엔트리 추가
                zos.closeEntry(); // 디렉토리 엔트리 종료
                zipDirectory(file, fldrOrgnName, zos); 
            } else {
            	int index2 = file.getName().lastIndexOf('_'); // 마지막 '_' 위치 찾기
            	String fileOrgnName = fldrName + File.separator + file.getName().substring(index2 + 1); // '_' 뒤의 부분
            	
            	zipFile(file, zos, fileOrgnName);
            }
		}
	}

    private void zipFile(File fileToZip, ZipOutputStream zos, String fileName) throws IOException {
    	// 동일한 파일 이름이 있는지 여부를 확인하고 다른 이름을 붙이기 위한 리스트 (파일명 검색 후, 동일한 이름의 파일을 다운받을 때 활용)
		if (nameCheckList.contains(fileName)) {
			String[] splitFileName = fileName.split("\\.");
			splitFileName[0] += "(" + ++num + ")";
			fileName = splitFileName[0] + "." + splitFileName[1];
		}
		nameCheckList.add(fileName);
    	
    	// try-with-resources 구문으로, 해당 구문이 끝나면 자동으로 InputStream이 종료됨
        try (InputStream fis = Files.newInputStream(fileToZip.toPath())) {
        	// ZipEntry 객체를 생성하여 ZIP 파일 내에 추가할 항목을 정의 
        	// 파일의 이름을 가져와서 ZIP 아카이브 내에서 이 이름으로 저장 
            ZipEntry zipEntry = new ZipEntry(fileName);
            
            // ZipOutputStream(zos)에 새로 생성한 zipEntry를 추가, ZIP 아카이브에서 다음 항목을 추가할 준비
            zos.putNextEntry(zipEntry);
            
            // 실제 파일 데이터를 ZIP 아카이브에 저장
            Files.copy(fileToZip.toPath(), zos);
            zos.closeEntry();
        }
    }
    
	// 이미지 미리보기
	@ResponseBody
	@GetMapping("/imgPreview.do")
	public ResponseEntity<byte[]> imgPreview(@RequestParam("cloudFileCd") String cloudFileCd) {
		
		// InputStream -> Byte단위의 자바 입력에 사용되는 최상위 클래스로서, 데이터를 입력받기 위한 입력 스트림 클래스(추상 클래스)
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		HttpHeaders headers = new HttpHeaders();
		
		// 파일 정보 가져오기
		CloudFldrOrFileVO param = new CloudFldrOrFileVO();
		param.setFldrOrFileCd(cloudFileCd);
		CloudFileVO cloudFileVO = cloudService.selectCloudFile(param);
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>> cloudFileCd: " + cloudFileCd);
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>> cloudFileVO: " + cloudFileVO.toString());
	    
	    try {
	        in = new FileInputStream(cloudFileVO.getCloudFilePathNm() + File.separator + cloudFileVO.getCloudFileStrgNm());

	        // 파일 확장자에 따라 Content-Type 설정
	        String extension = cloudFileVO.getCloudFileExtnNm().toLowerCase(); // 대소문자 구분 없이 비교
	        switch (extension) {
            case "png":
                headers.setContentType(MediaType.IMAGE_PNG);
                break;
            case "jpg":
            case "jpeg":
                headers.setContentType(MediaType.IMAGE_JPEG);
                break;
            case "gif":
                headers.setContentType(MediaType.IMAGE_GIF);
                break;
            default:
                headers.setContentType(MediaType.APPLICATION_OCTET_STREAM); // 기본 처리 (다운로드 하도록 처리)
                break;
        }
	        // InputStream의 내용을 byte[]로 변환하여 반환
	        entity = new ResponseEntity<>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    } finally {
	        try {
	            if (in != null) {
	                in.close();
	            }
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	    return entity;
	}
	
}

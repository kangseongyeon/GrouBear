package kr.or.ddit.company.community.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
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

import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.file.vo.AtchFileVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.community.service.IComCommunityService;
import kr.or.ddit.company.community.vo.ComCommunityVO;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import kr.or.ddit.employee.workStatus.service.IEmpWorkStatusService;
import kr.or.ddit.employee.workStatus.vo.EmpWorkStatusVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/company")
@PreAuthorize("hasRole('ROLE_COMPANY')")
public class ComCommunityController {

	@Resource(name = "localPath")
	private String localPath;
	
	
	@Inject
	private IEmpWorkStatusService workStatusService;

	@Inject
	private ITIlesService tilesService;

	@Inject
	private IComCommunityService service;

	// 회사 공지
	@GetMapping("/communityCompany.do")
	public String communityCompany(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model, HttpServletRequest request) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();

		DepartmentVO epmtVO = tilesService.getEpmt(employeeVO);

		TeamVO teamVO = tilesService.getTeam(employeeVO);
		
		EmpWorkStatusVO EmpWorkStatusVO = workStatusService.getTodayWorkStatus(employeeVO);

		// 페이징 처리
		PaginationInfoVO<ComCommunityVO> pagingVO = new PaginationInfoVO<ComCommunityVO>(10, 5);
		pagingVO.setCoCd(employeeVO.getCoCd());
		pagingVO.setEmpId(employeeVO.getEmpId());
		pagingVO.setCmntyType("company");

		// 검색 기능
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}

		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = service.selectCmntyCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);


		List<ComCommunityVO> dataList = service.selectCmntyList(pagingVO);
		pagingVO.setDataList(dataList);

		model.addAttribute("employeeVO", employeeVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("EmpWorkStatusVO", EmpWorkStatusVO);
		model.addAttribute("dataList", dataList);
		model.addAttribute("pagingVO", pagingVO);
		return "company/community/list";
	}

	// 정보공유
	@GetMapping("/communityInfo.do")
	public String communityInfo(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model, HttpServletRequest request) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();

		DepartmentVO epmtVO = tilesService.getEpmt(employeeVO);

		TeamVO teamVO = tilesService.getTeam(employeeVO);
		
		EmpWorkStatusVO EmpWorkStatusVO = workStatusService.getTodayWorkStatus(employeeVO);

		// 페이징 처리
		PaginationInfoVO<ComCommunityVO> pagingVO = new PaginationInfoVO<ComCommunityVO>(10, 5);
		pagingVO.setCoCd(employeeVO.getCoCd());
		pagingVO.setEmpId(employeeVO.getEmpId());
		pagingVO.setCmntyType("info");

		// 검색 기능
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}

		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = service.selectCmntyCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);


		List<ComCommunityVO> dataList = service.selectCmntyList(pagingVO);
		pagingVO.setDataList(dataList);

		model.addAttribute("employeeVO", employeeVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("EmpWorkStatusVO", EmpWorkStatusVO);
		model.addAttribute("dataList", dataList);
		model.addAttribute("pagingVO", pagingVO);
		return "company/community/list";
	}

	// 자유
	@GetMapping("/communityFree.do")
	public String communityFree(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model, HttpServletRequest request) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();

		DepartmentVO epmtVO = tilesService.getEpmt(employeeVO);

		TeamVO teamVO = tilesService.getTeam(employeeVO);
		
		EmpWorkStatusVO EmpWorkStatusVO = workStatusService.getTodayWorkStatus(employeeVO);

		// 페이징 처리
		PaginationInfoVO<ComCommunityVO> pagingVO = new PaginationInfoVO<ComCommunityVO>(10, 5);
		pagingVO.setCoCd(employeeVO.getCoCd());
		pagingVO.setEmpId(employeeVO.getEmpId());
		pagingVO.setCmntyType("free");

		// 검색 기능
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}

		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = service.selectCmntyCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);


		List<ComCommunityVO> dataList = service.selectCmntyList(pagingVO);
		pagingVO.setDataList(dataList);

		model.addAttribute("employeeVO", employeeVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("EmpWorkStatusVO", EmpWorkStatusVO);
		model.addAttribute("dataList", dataList);
		model.addAttribute("pagingVO", pagingVO);
		return "company/community/list";
	}
	
	@PostMapping("/insert/{type}")
	@ResponseBody
	public ResponseEntity<String> communityInsert(@ModelAttribute ComCommunityVO comCommunityVO, Model model)
	        throws Exception {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    EmployeeVO employeeVO = user.getMember();

	    String userId = employeeVO.getEmpId();
	    comCommunityVO.setEmpId(userId);
	    comCommunityVO.setCoCd(employeeVO.getCoCd());
	    comCommunityVO.setEmpNm(employeeVO.getEmpNm());

	    // 첨부파일
	    AtchFileVO afVO = new AtchFileVO();
	    afVO.setEmpId(userId);

	    // 첨부파일 디테일
	    List<MultipartFile> pictures = comCommunityVO.getAtchFiles();
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
	                afdVO.setAtchFileCd(savedName);
	                afdVO.setAtchFileDetailPathNm(localPath + savedName);
	                afdVO.setAtchFileDetailExtnNm(savedName.substring(savedName.lastIndexOf(".") + 1));
	                afdVO.setAtchFileDetailSize((int) bytes);
	                afdVO.setAtchFileDetailFancysize(fancysize); // fancysize 설정
	                afdVO.setAtchFileDetailOrgnlNm(file.getOriginalFilename());
	                afdVO.setAtchFileDetailStrgNm(savedName);
	                afdVO.setEmpId(userId);

	                log.info("fileInfo ::: " + file);
	                log.info("afdVO ::: " + afdVO);
	                savedAtchFileDetail.add(afdVO);
	                model.addAttribute("afdVO", afdVO);
	            }
	        }
	    } else {
	        log.info("첨부파일이 없습니다."); // 파일이 없을 경우 로그 추가
	    }

	    // 첨부파일 정보가 없을 경우 null로 설정
	    if (!savedAtchFileDetail.isEmpty()) {
	        afVO.setAtchFileDetailList(savedAtchFileDetail);
	        String atchFileCd = service.atchFileInsert(afVO);
	        comCommunityVO.setAtchFileCd(atchFileCd);
	    } else {
	    	comCommunityVO.setAtchFileCd(null); // 파일이 없을 경우 null 설정
	    }

	    service.insertCommunity(comCommunityVO);
	    return new ResponseEntity<String>("SUCCESS :: ", HttpStatus.OK);
	}

	private String uploadFile(String originalFilename, byte[] bytes) throws Exception {
		log.info("uploadFile in..!");
		
//		localPath += File.separator + "community";
		
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

	@GetMapping("/communityDetail.do")
	public String communityDetail(int cmntyNo, Model model) throws Exception {
		log.info("read 실행");
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		AtchFileVO atchFileVO = new AtchFileVO();
		AtchFileDetailVO atchFileDetailVO = new AtchFileDetailVO();
		ComCommunityVO comCommunityVO = service.communityDetail(cmntyNo);

		DepartmentVO epmtVO = tilesService.getEpmt(employeeVO);

		TeamVO teamVO = tilesService.getTeam(employeeVO);
		
		EmpWorkStatusVO EmpWorkStatusVO = workStatusService.getTodayWorkStatus(employeeVO);
		
		model.addAttribute("employeeVO", employeeVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("EmpWorkStatusVO", EmpWorkStatusVO);

		model.addAttribute("atchFileVO", atchFileVO);
		model.addAttribute("atchFileDetailVO", atchFileDetailVO);
		model.addAttribute("comCommunityVO", comCommunityVO);
		model.addAttribute("employeeVO", employeeVO);
		return "company/community/detail";
	}

	@PostMapping("/communityModify/{type}")
	@ResponseBody
	public ResponseEntity<String> communityModify(@ModelAttribute ComCommunityVO comCommunityVO, String arr, Model model)
			throws IOException, Exception {
		log.info("ModiFy 실행 !~!");
		log.info("ComCommunityVO ::: " + comCommunityVO);

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		String userId = employeeVO.getEmpId();
		comCommunityVO.setEmpId(userId);
		comCommunityVO.setCoCd(employeeVO.getCoCd());

		// 일단 있던 첨부파일 수정
		int delYResult = service.deleteYAtchFile(comCommunityVO.getAtchFileCd());

		arr = arr.substring(0, arr.length() - 1);
		String[] cdArr = arr.split(",");

		for (int i = 0; i < cdArr.length; i++) {
			int delNResult = service.deleteNAtchFile(cdArr[i]);

		}

		// 첨부파일 추가 시작
		AtchFileVO afVO = new AtchFileVO();
		afVO.setEmpId(userId);
		afVO.setAtchFileCd(comCommunityVO.getAtchFileCd());
		List<MultipartFile> pictures = comCommunityVO.getAtchFiles();

		List<AtchFileDetailVO> savedAtchFileDetail = new ArrayList<AtchFileDetailVO>();
		for (MultipartFile file : pictures) {
			log.info("# fileName : " + file.getOriginalFilename());

			// UUID_원본파일명
			String savedName = uploadFile(file.getOriginalFilename(), file.getBytes()); // 파일 업로드

			long bytes = file.getSize();
			String fancysize; // fancysize를 String 타입으로 선언합니다.

			if (bytes > 1024 * 1024) { // 1MB 이상
				fancysize = (bytes / (1024 * 1024)) + " MB"; // MB 단위
				log.info(bytes + "MB");
			} else if (bytes > 1024) { // 1KB 이상 1MB 미만
				fancysize = (bytes / 1024) + " KB"; // KB 단위
				log.info(bytes + "KB");
			} else { // 1KB 미만
				fancysize = bytes + " Byte"; // Byte 단위
				log.info(bytes + "Byte");
			}

			AtchFileDetailVO afdVO = new AtchFileDetailVO();
			afdVO.setAtchFileCd(comCommunityVO.getAtchFileCd());

			afdVO.setAtchFileDetailPathNm(localPath + savedName);
			afdVO.setAtchFileDetailExtnNm(savedName.substring(savedName.lastIndexOf(".") + 1));
			afdVO.setAtchFileDetailSize((int) bytes);
			afdVO.setAtchFileDetailFancysize(fancysize); // fancysize 설정
			afdVO.setAtchFileDetailOrgnlNm(file.getOriginalFilename());
			afdVO.setAtchFileDetailStrgNm(savedName);
			afdVO.setEmpId(userId);

			log.info("fileInfo ::: " + file);
			log.info("afdVO ::: " + afdVO);
			savedAtchFileDetail.add(afdVO);
		}
		afVO.setAtchFileDetailList(savedAtchFileDetail);
		log.info("list:::" + afVO);
		// 파일 추가 끝

		for (AtchFileDetailVO i : savedAtchFileDetail) {
			service.addAtchFile(i);
		}

		// 제목 내용 수정
		service.communityModify(comCommunityVO);
		model.addAttribute("ComCommunityVO", comCommunityVO);

		return new ResponseEntity<String>("SUCCESS ::: ", HttpStatus.OK);
	}

	@PostMapping("/communityRemove.do")
	public ResponseEntity<String> removeCommunity(@RequestBody ComCommunityVO comCommunityVO, Model model) {
		service.removeCommunity(comCommunityVO.getCmntyNo());
		return new ResponseEntity<String>("SUCCESS : ", HttpStatus.OK);
	}

	@PostMapping("/downloadAtchFile")
	public ResponseEntity<String> downloadAtchFile(@RequestBody ComCommunityVO comCommunityVO, @RequestBody AtchFileVO atchFileVO, Model model) {
		AtchFileDetailVO atchFileDetailVO = new AtchFileDetailVO();
		atchFileDetailVO.setAtchFileCd(atchFileVO.getAtchFileCd());
		List<AtchFileDetailVO> atchFileDetailList = atchFileVO.getAtchFileDetailList();
		log.info("list ::: " + atchFileDetailList);
		
		service.downloadFile(atchFileDetailVO);
		model.addAttribute("comCommunityVO", comCommunityVO);
		model.addAttribute("atchFileVO", atchFileVO);
		model.addAttribute("atchFileDetailVO", atchFileDetailVO);
		model.addAttribute("atchFileDetailList", atchFileDetailList);
		return new ResponseEntity<String>("SUCCESS : ", HttpStatus.OK);
	}

}

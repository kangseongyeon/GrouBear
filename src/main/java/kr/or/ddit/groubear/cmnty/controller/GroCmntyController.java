package kr.or.ddit.groubear.cmnty.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.comm.alarm.service.IAlarmService;
import kr.or.ddit.comm.alarm.vo.AlarmVO;
import kr.or.ddit.comm.cmnty.service.ICmntyService;
import kr.or.ddit.comm.cmnty.vo.CmntyVO;
import kr.or.ddit.comm.cmnty.vo.CmtVO;
import kr.or.ddit.comm.commcode.service.ICommCodeService;
import kr.or.ddit.comm.empallinfo.service.IEmpAllInfoService;
import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.groubear.cmnty.service.IGroCmntyService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_GROUBEAR')")
@RequestMapping("/groubear")
public class GroCmntyController {
	
	@Inject
	private IEmpAllInfoService empAllInfoService;
	
	@Inject
	private ITIlesService tilesService;
	
	@Inject
	private ICmntyService cmntyService;
	
	@Inject
	private IGroCmntyService groCmntyService;
	
	@Inject
	private ICommCodeService commCodeService;

	@Inject
	private IAlarmService alarmService;
	
	@GetMapping("/cmntyNoticeList.do")
	public String cmntyNoticeList (
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model,
			HttpServletRequest request) {
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		// 리스트 페이징 처리하기
		PaginationInfoVO<CmntyVO> pagingVO = new PaginationInfoVO<CmntyVO>(10,5);
		pagingVO.setCoCd(empVO.getCoCd());
		
		// 검색 기능 추가
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		// startRow, endRow, startpage, endPage를 결정한다.
		pagingVO.setCurrentPage(currentPage); 
		
		// 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
		int totalRecord = groCmntyService.groNoticeSelectListCount(pagingVO);
		
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord); 
		
		// 총 게시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의 리스트 데이터를 가져온다.
		List<CmntyVO> noticeList = groCmntyService.groNoticeSelectList(pagingVO);
		
		pagingVO.setDataList(noticeList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n totalRecord : " + totalRecord);

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("cmntyMenu", "show");
		model.addAttribute("cmntyNotice", "active");
		
		return "groubear/cmnty/cmntyNoticeList";
	}
	
	@GetMapping("/cmntyNoticeInsert.do")
	public String cmntyNoticeInsert(Model model, RedirectAttributes ra) {
		String goPage = "";
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		// 로그인인 된 상태일 때만 진입가능
		if (empVO != null) {
			CompanyVO companyVO = tilesService.getCompany(empVO);

			model.addAttribute("employeeVO", empVO);
			model.addAttribute("companyVO", companyVO);
		
			// 발표를 위한 데이터 세팅
			CmntyVO cmntyVO = new CmntyVO();
			cmntyVO.setCmntyTtl("[인사정보관리] 이용자 프로필 정보 추가 제공 관련 공지");
			cmntyVO.setCmntyCn(
			"<p>안녕하세요. 그루베어입니다.</p>\r\n" + 
			"\r\n" + 
			"<p>이용자 동의하에 조회 가능한 이용자 프로필 항목 중 휴대전화번호, 출생년도 정보가 추가되었습니다.&nbsp;</p>\r\n" + 
			"\r\n" + 
			"<p>&nbsp;</p>\r\n" + 
			"\r\n" + 
			"<p><strong>1. 적용일</strong>&nbsp;: 2020년 12월 22일&nbsp;</p>\r\n" + 
			"\r\n" + 
			"<p><strong>2. 변경사항</strong>&nbsp;:&nbsp;이용자&nbsp;동의하에 조회 가능한프로필 정보 추가</p>\r\n" + 
			"\r\n" + 
			"<p>- AS-IS : 이름, 이메일 주소, 별명, 프로필 사진, 생일, 연령대, 성별</p>\r\n" + 
			"\r\n" + 
			"<p>- TO-BE : 이름, 메일 주소, 별명, 프로필 사진, 생일, 연령대, 성별,&nbsp;<strong>휴대전화번호, 출생년도</strong></p>\r\n" + 
			"\r\n" + 
			"<p>​</p>\r\n" + 
			"\r\n" + 
			"<p><strong>3. 설정방법&nbsp;</strong></p>\r\n" + 
			"\r\n" + 
			"<p>개발자센터(https://developers.naver.com/main/) &gt; Application &gt; 내 애플리케이션 &gt; 추가할 애플리케이션을 선택 &gt; [API 설정] 탭에서 &#39;사용API&#39; 항목을 통해 설정 가능</p>\r\n" + 
			"\r\n" + 
			"<p>네아로 연동API 설정 시 네아로를 통해 제공받고자 하는 정보로 휴대전화번호, 출생년도를 선택하신 경우,</p>\r\n" + 
			"\r\n" + 
			"<p>사전검수 단계에서 해당 정보가 실제 서비스에 활용되는 사례를 확인하며, 서비스에서 명확한 활용 사례가 확인되지 않을 경우 사전검수에서 반려될 수 있습니다. &nbsp;</p>\r\n" + 
			"\r\n" + 
			"<p>또한, 휴대전화번호, 출생년도 역시 다른 정보와 마찬가지로 해당 정보를 외부 서비스에 제공할지는 사용자가 직접 선택할 수 있으며,&nbsp;사용자의 선택에 따라서 사용자가 본인의 정보를 조회할 수 있는 권한을 거부할 경우, 해당 정보가 제공되지 않을 수 있습니다.&nbsp;</p>\r\n" + 
			"\r\n" + 
			"<p>​</p>\r\n" + 
			"\r\n" + 
			"<p><strong>※ 이미 연동이 완료된 서비스의 추가정보 조회 방법&nbsp;</strong></p>\r\n" + 
			"\r\n" + 
			"<p>이미 네아로를 연동하여 사용중인 서비스도 위의 &#39;설정방법&#39;을 참고하여 API 설정탭에서 사용API 설정을 추가/변경하면 해당 정보의 추가 조회가 가능합니다.&nbsp;</p>\r\n" + 
			"\r\n" + 
			"<p>단, 사전검수를 이미 통과한 상태에서 변경이 발생하였기 때문에 이후 사후검수 시스템에서 변경된 사항이 확인되면 추가된 정보의 활용처 제출을 요청드릴 수 있습니다.</p>\r\n" + 
			"\r\n" + 
			"<p>따라서 추가된 정보가 실제 서비스에 활용되는 사례를 사전에&nbsp;dl_naverid@navercorp.com으로&nbsp;보내셔서 검토를 받으신 후 변경하시는 것을 권장 드립니다.</p>\r\n" + 
			"\r\n" + 
			"<p>또한, 위 방법으로&nbsp;제공 정보를 추가&nbsp;하더라도 설정 변경&nbsp;전에 연동한 사용자들은 새로 설정한&nbsp;정보의 제공에 동의하지 않은 상태이기 때문에, 해당 사용자들의 정보는&nbsp;조회할 수 없습니다.</p>\r\n" + 
			"\r\n" + 
			"<p>이 경우&nbsp;아래 재동의 프로세스를 구현하여 기존 연동 사용자에게 새로&nbsp;추가한 프로필 항목들의 동의를 요청할 수 있습니다.</p>\r\n" + 
			"\r\n" + 
			"<p>[재동의&nbsp;프로세스&nbsp;개발&nbsp;가이드]</p>\r\n" + 
			"\r\n" + 
			"<p>감사합니다.</p>\r\n" + 
			""
					);
			model.addAttribute("cmntyVO", cmntyVO);

			// 사이드바 메뉴 아코디언 고정하기
			model.addAttribute("cmntyMenu", "show");
			model.addAttribute("cmntyNotice", "active");
			
			goPage = "groubear/cmnty/cmntyNoticeForm";
					
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다.");
			goPage = "redirect:/login.do";
		}
		
		return goPage;
	}
	
	@PostMapping("/cmntyNoticeInsert.do")
	public ResponseEntity<Integer> cmntyNoticeInsert(CmntyVO cmntyVO, Model model, RedirectAttributes ra, HttpServletRequest req) {
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		cmntyVO.setCoCd(empVO.getCoCd());
		cmntyVO.setEmpId(empVO.getEmpId());
		
		// 필수 공지가 체크되지 않으면 기본값 N으로 세팅
		if (cmntyVO.getCmntyNoticeYn() == null || cmntyVO.getCmntyNoticeYn().equals("")) {
			cmntyVO.setCmntyNoticeYn("N");
		}
		
		groCmntyService.cmntyNoticeInsert(cmntyVO);
		
		return new ResponseEntity<Integer>(cmntyVO.getCmntyNo(), HttpStatus.OK);
	}
	
	@GetMapping("/cmntyNoticeModify.do")
	public String cmntyNoticeModify(@RequestParam("cmntyNo") int cmntyNo, Model model, RedirectAttributes ra) {
		String goPage = "";
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		// 로그인인 된 상태일 때만 진입가능
		if (empVO != null) {
			CompanyVO companyVO = tilesService.getCompany(empVO);

			model.addAttribute("employeeVO", empVO);
			model.addAttribute("companyVO", companyVO);
		
			CmntyVO cmntyVO = groCmntyService.groNoticeSelectOne(cmntyNo);
			model.addAttribute("cmntyVO", cmntyVO);

			model.addAttribute("status", "u");		
			
			// 사이드바 메뉴 아코디언 고정하기
			model.addAttribute("cmntyMenu", "show");
			model.addAttribute("cmntyNotice", "active");
			
			goPage = "groubear/cmnty/cmntyNoticeForm";
					
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다.");
			goPage = "redirect:/login.do";
		}
		
		return goPage;
	}
	
	@ResponseBody
	@PostMapping("/cmntyNoticeModify.do")
	public String cmntyNoticeModify(CmntyVO cmntyVO) {
		String res = "";
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		cmntyVO.setEmpId(empVO.getEmpId());
		
		// 수정하면서 모든 파일을 삭제했을 때
		if (cmntyVO.getAtchFileUpdateList() == null) {
			List<AtchFileDetailVO> updateList = new ArrayList<AtchFileDetailVO>();
			
			AtchFileDetailVO atchFileDetailVO = new AtchFileDetailVO();
			atchFileDetailVO.setAtchFileCd(cmntyVO.getAtchFileCd());
			atchFileDetailVO.setAtchFileDetailCd(".");
			updateList.add(atchFileDetailVO);
			
			cmntyVO.setAtchFileUpdateList(updateList);
		}
		
		// 필수 공지가 체크되지 않으면 기본값 N으로 세팅
		if (cmntyVO.getCmntyNoticeYn() == null || cmntyVO.getCmntyNoticeYn().equals("")) {
			cmntyVO.setCmntyNoticeYn("N");
		}
		
		ServiceResult result = this.groCmntyService.cmntyNoticeModify(cmntyVO);
		
		if (result.equals(ServiceResult.OK)) {
			res = "updateOK";
		} else {
			res = "FAILED";
		}
		return res;
	}
	
	@PostMapping("/cmntyNoticeDelete.do")
	public String cmntyNoticeDelete(CmntyVO cmntyVO, RedirectAttributes ra, Model model, HttpServletRequest request) {
		String goPage = "";
		
		ServiceResult result = groCmntyService.cmntyNoticeDelete(cmntyVO);
		
		if (result.equals(ServiceResult.OK)) {
			HttpSession session = request.getSession();
			session.setAttribute("message", "게시물이 삭제되었습니다.");
			goPage = "redirect:/groubear/cmntyNoticeList.do";
		} else {
			model.addAttribute("message", "수정에 실패하였습니다.");
			
			CmntyVO noticeVo = groCmntyService.groNoticeSelectOne(cmntyVO.getCmntyNo());
			model.addAttribute("status", "u");
			model.addAttribute("cmntyVO", noticeVo);

			// 사이드바 메뉴 아코디언 고정하기
			model.addAttribute("cmntyMenu", "show");
			model.addAttribute("cmntyNotice", "active");
			
			goPage = "groubear/cmnty/cmntyNoticeForm";
		}
		return goPage;
	}
	
	@GetMapping("/cmntyNoticeDetail.do")
	public String cmntyNoticeDetail (@RequestParam("cmntyNo") int cmntyNo, Model model, RedirectAttributes ra) {
		String goPage = "";
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		// 로그인인 된 상태일 때만 진입가능
		if (empVO != null) {
			CompanyVO companyVO = tilesService.getCompany(empVO);
			EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(empVO);

			model.addAttribute("employeeVO", empVO);
			model.addAttribute("companyVO", companyVO);
			model.addAttribute("employeeAllVO", employeeAllVO);
		
			CmntyVO cmntyVO = groCmntyService.groNoticeSelectOne(cmntyNo);
			model.addAttribute("cmntyVO", cmntyVO);

			// 사이드바 메뉴 아코디언 고정하기
			model.addAttribute("cmntyMenu", "show");
			model.addAttribute("cmntyNotice", "active");
			
			goPage = "groubear/cmnty/cmntyNoticeDetail";
					
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다.");
			goPage = "redirect:/login.do";
		}
		
		return goPage;
	}
	
	/**
	 * 단일 파일 다운로드 받기
	 * @param atchFileDetailVO
	 * @return
	 */
	@ResponseBody
	@GetMapping("/cmntyDownOne.do")
	public void cmntyDownOne(@RequestParam("atchFileDetailCd") String atchFileDetailCd,
							HttpServletRequest request, HttpServletResponse response) {
		// 파일 정보 불러오기
		AtchFileDetailVO atchFileDetailVO = groCmntyService.atchFileDetailOneSelect(atchFileDetailCd);
		String filePath = atchFileDetailVO.getAtchFileDetailPathNm();
		
		File saveFile = new File(filePath);
		String filename = atchFileDetailVO.getAtchFileDetailOrgnlNm();
		String filesize = String.valueOf(atchFileDetailVO.getAtchFileDetailSize());
		
		// 파일명이 한글로 되어있을 때
		// 요청 Header 정보들 중, User-Agent 영역 안에 여러 키워드 정보들을 가지고
		// 특정 키워드가 포함되어 있는지를 체크해서 파일며으이 출력 인코딩 부분을 설정합니다.
		// 사용 브라우저 또는 어떠한 현상에 따라 발생하는 알고리즘이므로, 내가 사용하는 브라우저의 버전이나 
		// 얻어온 header 정보들의 값에 따라 차이가 발생할 수 있습니다.
		String agent = request.getHeader("User-Agent");
		try {
			// (agent, "trident") 이 두가지를 포함한다면 IE, Chrome일 것임
			if (StringUtils.containsIgnoreCase(agent, "msie") || 
					StringUtils.containsIgnoreCase(agent, "trident")) {	// IE, Chrome
				filename = URLEncoder.encode(filename, "UTF-8");
			} else {	// firefox, chrome (소문자 대문자에 따라서 크롬이 다름)
				filename = new String(filename.getBytes(), "ISO-8859-1");
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.setHeader("content-Disposition", "attachment; filename=\"" + filename + "\"");
		response.setHeader("Content-Length", filesize);
		
		
		// 아래와 같이 사용하면 try() 내부에서 사용한 객체에 대해서 {} 안의 로직이 끝나고 나면 자동으로 () 내부의 객체가 닫힘
		// try(){} ::: try with resource
		// () 안에서 명시한 객체는 finally로 최종 열린 객체에 대한 close()를 처리하지 않아도 자동으로 close()가 이루어진다.
		// try/catch의 확장판
		try(OutputStream os = response.getOutputStream()) {
			FileUtils.copyFile(saveFile, os);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 파일 리스트 알집으로 다운로드 받기
	 * @param cmntyVO
	 * @return
	 */
	@PostMapping("/cmntyDownList.do")
	public ResponseEntity<String> cloudDownList(@RequestBody CmntyVO cmntyVO) {
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
	    
        // 다운받을 경로 및 압축 파일의 이름 세팅하기
		String dowmloadPath = downloadDir + downZipName;
		
	    // 파일 디테일 리스트 불러오기
		List<AtchFileDetailVO> atchFileDetailList = groCmntyService.atchFileDetailListSelect(cmntyVO.getAtchFileCd());
		
		try (ZipOutputStream zos = new ZipOutputStream(Files.newOutputStream(Paths.get(dowmloadPath)))) {
			for (AtchFileDetailVO fileVO : atchFileDetailList) {
				String filePath = fileVO.getAtchFileDetailPathNm();
				File fileToZip = new File(filePath);
				
				// 파일 압축 메서드
				if (fileToZip.exists()) {
					zipFile(fileToZip, zos, fileVO.getAtchFileDetailOrgnlNm());
				} else {
					log.info("파일 없음 : " + filePath);
				}
			}
		} catch (IOException e) {
            log.error("ZIP 파일 생성 중 오류 발생: " + e.getMessage(), e);
            return new ResponseEntity<String>("FAIL", HttpStatus.OK);
        }
		
		return new ResponseEntity<String>("OK", HttpStatus.OK);
	}

	/**
	 * 파일을 알집으로 압축하는 메소드
	 * @param fileToZip
	 * @param zos
	 * @param fileName
	 * @throws IOException
	 */
    private void zipFile(File fileToZip, ZipOutputStream zos, String fileName) throws IOException {
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
    
    /**
     * 파일 미리보기
     * @param cloudFileCd
     * @return
     */
	@ResponseBody
	@GetMapping("/imgPreview.do")
	public ResponseEntity<byte[]> imgPreview(@RequestParam("atchFileDetailCd") String atchFileDetailCd) {
		
		// InputStream -> Byte단위의 자바 입력에 사용되는 최상위 클래스로서, 데이터를 입력받기 위한 입력 스트림 클래스(추상 클래스)
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		HttpHeaders headers = new HttpHeaders();
		
		// 파일 정보 가져오기
		AtchFileDetailVO atchFileDetailVO = groCmntyService.atchFileDetailOneSelect(atchFileDetailCd);
		
	    try {
	        in = new FileInputStream(atchFileDetailVO.getAtchFileDetailPathNm());

	        // 파일 확장자에 따라 Content-Type 설정
	        String extension = atchFileDetailVO.getAtchFileDetailExtnNm().toLowerCase(); // 대소문자 구분 없이 비교
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
	        entity = new ResponseEntity<>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
	    } catch (Exception e) {
	        e.printStackTrace();
	        entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    } finally {
	        try {
	        	in.close();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	    return entity;
	}

	@GetMapping("/cmntyQstnList.do")
	public String cmntyQstnList (
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(name="cmntyType", required = false) String cmntyType,
			@RequestParam(name="cmntyQstnSttsYn", required = false) String cmntyQstnSttsYn,
			@RequestParam(required = false) String searchWord, Model model,
			HttpServletRequest request) {
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(empVO);
		
		model.addAttribute("employeeVO",empVO);
		model.addAttribute("companyVO",companyVO);
		
		// 리스트 페이징 처리하기
		PaginationInfoVO<CmntyVO> pagingVO = new PaginationInfoVO<CmntyVO>(10,5);
		pagingVO.setCoCd(empVO.getCoCd());
		
		// 검색 기능 추가
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}
		model.addAttribute("cmntyQstnSttsYn", cmntyQstnSttsYn);
		model.addAttribute("cmntyType", cmntyType);
		
		// startRow, endRow, startpage, endPage를 결정한다.
		pagingVO.setCurrentPage(currentPage); 
		pagingVO.setCmntyType(cmntyType); 
		pagingVO.setCmntyQstnSttsYn(cmntyQstnSttsYn);
		
		// 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
		int totalRecord = groCmntyService.qstnSelectListCount(pagingVO);
		
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord); 
		
		// 총 게시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의 리스트 데이터를 가져온다.
		List<CmntyVO> qstnList = groCmntyService.qstnSelectList(pagingVO);
		pagingVO.setDataList(qstnList);
		
		// Q&A 카테고리별 전체 게시물과 Q&A 미답변 게시물 카운트하기
		List<CmntyVO> qstnCountList = groCmntyService.qstnSttsAndListCount();
		model.addAttribute("qstnListCount", qstnCountList);
		
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("cmntyMenu", "show");
		model.addAttribute("cmntyQstn", "active");
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n totalRecord : " + totalRecord);
		
		return "groubear/cmnty/cmntyQstnList";
	}
	
	@GetMapping("/cmntyQstnDetail.do")
	public String cmntyQstnDetail (@RequestParam("cmntyNo") int cmntyNo, Model model, RedirectAttributes ra) {
		String goPage = "";
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		// 로그인인 된 상태일 때만 진입가능
		if (empVO != null) {
			CompanyVO companyVO = tilesService.getCompany(empVO);
			EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(empVO);

			model.addAttribute("employeeVO", empVO);
			model.addAttribute("companyVO", companyVO);
			model.addAttribute("employeeAllVO", employeeAllVO);
			
			CmntyVO cmntyVO = cmntyService.qstnSelectOne(cmntyNo);
			
			if (cmntyVO.getCmntyCn() != null && cmntyVO.getCmntyCn().contains("\n")) {
				cmntyVO.setCmntyCn(cmntyVO.getCmntyCn().replace("\n","<br>"));
			}

			if (cmntyVO.getCmntCn() != null && cmntyVO.getCmntCn().contains("\n")) {
				cmntyVO.setCmntCn(cmntyVO.getCmntCn().replace("\n","<br>"));
			}
			
//			// 발표를 위한 데이터 세팅
//			cmntyVO.setCmntCn(
//			"안녕하세요!\r\n" + 
//			"\r\n" + 
//			"'베이직'은 메인 홈페이지에서 소개하는 인사관리, 양식, 증명서, 전자결재, 클라우드 등의\r\n" + 
//			"기본적인 메뉴들을 사용할 수 있고,\r\n" + 
//			"'프리미엄'은 그 외에 추가로 차량관리, 시설예약, 보안 등의 메뉴를 추가로 사용하실 수 있습니다.\r\n" + 
//			"\r\n" + 
//			"감사합니다."
//					);
			
			 
			model.addAttribute("cmntyVO", cmntyVO);

			// Q&A 카테고리별 전체 게시물과 Q&A 미답변 게시물 카운트하기
			List<CmntyVO> qstnCountList = groCmntyService.qstnSttsAndListCount();
			model.addAttribute("qstnListCount", qstnCountList);

			// 사이드바 메뉴 아코디언 고정하기
			model.addAttribute("cmntyMenu", "show");
			model.addAttribute("cmntyQstn", "active");
			
			goPage = "groubear/cmnty/cmntyQstnDetail";
					
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다.");
			goPage = "redirect:/login.do";
		}
		
		return goPage;
	}
	
	@PostMapping("/cmntyReplyInsert.do")
	public String cmntyReplyInsert(CmtVO cmtVO, RedirectAttributes ra, Model model, HttpServletRequest request) {
		String goPage = "";
		Map<String, String> error = new HashMap<String, String>();
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		// 로그인인 된 상태일 때만 진입가능
		if (empVO != null) {
			if (StringUtils.isBlank(cmtVO.getCmntCn())) {
				error.put("cmntCn", "답변 내용을 입력해주세요.");
			}
			
			// 필수입력  빈칸이 있다면
			if (error.size() > 0) {
				model.addAttribute("error", error);
				model.addAttribute("cmtVO", cmtVO);
				goPage = "groubear/cmnty/cmntyQstnDetail";
				
			} else {	// 필수 입력 빈칸이 없다면
				cmtVO.setEmpId(empVO.getEmpId());
				ServiceResult result = groCmntyService.cmntyReplyInsert(cmtVO);
				
				if (result.equals(ServiceResult.OK)) {
					ra.addFlashAttribute("message", "답변이 등록되었습니다.");
					goPage = "redirect:/groubear/cmntyQstnDetail.do?cmntyNo=" + cmtVO.getCmntyNo();
					
					// 실시간 알림 코드 추가
					CmntyVO cmntyVO = groCmntyService.qstnSelectOne(cmtVO.getCmntyNo());
					EmployeeVO param = new EmployeeVO();
					param.setEmpId(cmntyVO.getQstnEmpId());
					EmployeeAllVO employeeAllVO = empAllInfoService.selectEmpImpl(param);
					
					AlarmVO alarmVO = new AlarmVO();
					alarmVO.setAlarmCategory("QnA");
					alarmVO.setAlarmTarget(cmntyVO.getQstnEmpId());
					alarmVO.setAlarmCn("QnA에 답글이 달렸습니다.");
					
					if (employeeAllVO.getAuthrityNm().equals("ROLE_COMPANY")) {
						alarmVO.setAlarmUrl("/company/cmntyQstnDetail.do?cmntyNo=" + cmntyVO.getCmntyNo());
					} else if (employeeAllVO.getAuthrityNm().equals("ROLE_EMPLOYEE")) {
						alarmVO.setAlarmUrl("/employee/cmntyQstnDetail.do?cmntyNo=" + cmntyVO.getCmntyNo());
					} else if (employeeAllVO.getAuthrityNm().equals("ROLE_GROUBEAR")) {
						alarmVO.setAlarmUrl("/groubear/cmntyQstnDetail.do?cmntyNo=" + cmntyVO.getCmntyNo());
					}
					
					alarmService.insertAlarm(alarmVO);
				} else { 
					model.addAttribute("message", "서버에 오류가 발생했습니다.");
					
					CmntyVO astnVo = groCmntyService.groNoticeSelectOne(cmtVO.getCmntyNo());
					model.addAttribute("status", "u");
					model.addAttribute("cmntyVO", astnVo);
					model.addAttribute("cmtVO", cmtVO);

					// 사이드바 메뉴 아코디언 고정하기
					model.addAttribute("cmntyMenu", "show");
					model.addAttribute("cmntyQstn", "active");
					
					goPage = "groubear/cmnty/cmntyQstnDetail";
				}
			}
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다.");
			goPage = "redirect:/login.do";
		}
		return goPage;
	}
	
	@PostMapping("/cmntyReplyModify.do")
	public String cmntyReplyModify(CmtVO cmtVO, RedirectAttributes ra, Model model, HttpServletRequest request) {
		String goPage = "";
		Map<String, String> error = new HashMap<String, String>();
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		// 로그인인 된 상태일 때만 진입가능
		if (empVO != null) {
			if (StringUtils.isBlank(cmtVO.getCmntCn())) {
				error.put("cmntCn", "답변 내용을 입력해주세요.");
			}
			
			// 필수입력  빈칸이 있다면
			if (error.size() > 0) {
				model.addAttribute("error", error);
				model.addAttribute("cmtVO", cmtVO);
				goPage = "groubear/cmnty/cmntyQstnDetail";
				
			} else {	// 필수 입력 빈칸이 없다면
				cmtVO.setEmpId(empVO.getEmpId());
				ServiceResult result = groCmntyService.cmntyReplyModify(cmtVO);
				
				if (result.equals(ServiceResult.OK)) {
					ra.addFlashAttribute("message", "답변이 수정되었습니다.");
					goPage = "redirect:/groubear/cmntyQstnDetail.do?cmntyNo=" + cmtVO.getCmntyNo();
				} else { 
					model.addAttribute("message", "서버에 오류가 발생했습니다.");
					
					CmntyVO astnVo = groCmntyService.groNoticeSelectOne(cmtVO.getCmntyNo());
					model.addAttribute("status", "u");
					model.addAttribute("cmntyVO", astnVo);
					model.addAttribute("cmtVO", cmtVO);

					// 사이드바 메뉴 아코디언 고정하기
					model.addAttribute("cmntyMenu", "show");
					model.addAttribute("cmntyQstn", "active");
					
					goPage = "groubear/cmnty/cmntyQstnDetail";
				}
			}
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다.");
			goPage = "redirect:/login.do";
		}
		return goPage;
	}
	
	@PostMapping("/cmntyReplyDelete.do")
	public String cmntyReplyDelete(CmtVO cmtVO, RedirectAttributes ra, Model model, HttpServletRequest request) {
		String goPage = "";
		
		// 회원정보 가져오기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		// 로그인인 된 상태일 때만 진입가능
		if (empVO != null) {
			ServiceResult result = groCmntyService.cmntyReplyDelete(cmtVO);
			
			if (result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("message", "답변이 삭제되었습니다.");
				goPage = "redirect:/groubear/cmntyQstnDetail.do?cmntyNo=" + cmtVO.getCmntyNo();
			} else { 
				model.addAttribute("message", "서버에 오류가 발생했습니다.");
				
				CmntyVO astnVo = groCmntyService.groNoticeSelectOne(cmtVO.getCmntyNo());
				model.addAttribute("status", "u");
				model.addAttribute("cmntyVO", astnVo);
				model.addAttribute("cmtVO", cmtVO);

				// 사이드바 메뉴 아코디언 고정하기
				model.addAttribute("cmntyMenu", "show");
				model.addAttribute("cmntyQstn", "active");
				
				goPage = "groubear/cmnty/cmntyQstnDetail";
			}
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다.");
			goPage = "redirect:/login.do";
		}
		return goPage;
	}
}

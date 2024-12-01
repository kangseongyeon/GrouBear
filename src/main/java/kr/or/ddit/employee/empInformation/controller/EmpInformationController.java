package kr.or.ddit.employee.empInformation.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.comm.cloud.service.ICloudService;
import kr.or.ddit.comm.empallinfo.service.IEmpAllInfoService;
import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.login.service.ILoginService;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.project.vo.ProjectVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeAuthVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.service.IInformationService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;
import kr.or.ddit.company.personnelInformation.vo.TeamDetailVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import kr.or.ddit.company.vehicleManagement.vo.VHCLRSVTVO;
import kr.or.ddit.employee.vehicleReservation.service.IVehicleService;
import kr.or.ddit.groubear.contract.service.IContractService;
import kr.or.ddit.groubear.contract.vo.ContractVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/empinformation")
@PreAuthorize("hasAnyRole('ROLE_EMPLOYEE')")
public class EmpInformationController {
	@Resource(name = "localPath")
	private String localPath;
	@Inject
	private IContractService ctrtService;
	@Inject
	private ICloudService cloudService;
	@Inject
	private ILoginService loginService;
	@Inject
	private IEmpAllInfoService empAllInfoService;
	@Inject
	private ITIlesService tilesService;
	@Inject
	private IInformationService infoService;
	@Inject
	private IVehicleService vehicleService;
	@Inject
	private PasswordEncoder pe;
	
	// 권한 : 기업관리자
	// 메뉴 : 기업관리자 - 인사정보관리 - 전체사원목록
	// 설명 : 시큐리티안의 세션에서 coCd(기업코드) 파라미터로 받아와서 회사 전체 사원 출력
	@GetMapping("/allinfo.do")
	public String empInformationAllList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, @RequestParam(required = false) String searchOrder,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		DepartmentVO epmtVO = tilesService.getEpmt(employeeVO);
		TeamVO teamVO = tilesService.getTeam(employeeVO);
		ContractVO contractVO = ctrtService.currentContractStatus(employeeVO.getCoCd());
		
		model.addAttribute("contractVO", contractVO);
		model.addAttribute("departmentVO", epmtVO);
		model.addAttribute("teamVO", teamVO);

		if (searchOrder == "" || searchOrder == null) {
			searchOrder = null;
		}

		PaginationInfoVO<EmployeeAllVO> pagingVO = new PaginationInfoVO<EmployeeAllVO>(10, 5);
		pagingVO.setCoCd(employeeVO.getCoCd());
		pagingVO.setEmpId(employeeVO.getEmpId());

		if (StringUtils.isNotBlank(searchWord) || StringUtils.isNotBlank(searchOrder)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchOrder(searchOrder);
			log.info("searchOrder 찍어보기 : " + searchOrder);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchOrder", searchOrder);
		}

		pagingVO.setCurrentPage(currentPage);

		int totalRecord = infoService.selectEmpPage(pagingVO);

		pagingVO.setTotalRecord(totalRecord);

		List<EmployeeAllVO> dataList = infoService.selectEmpPaging(pagingVO);

		pagingVO.setDataList(dataList);

		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");

		model.addAttribute("pagingVO", pagingVO);

		CompanyVO companyVO = tilesService.getCompany(employeeVO);
		model.addAttribute("companyVO", companyVO);
		List<EmployeeVO> empAllList = infoService.comAllEmpList(employeeVO);
		List<DepartmentVO> deptList = infoService.selectDeptList(employeeVO);
		List<JobGradeVO> jbgdList = infoService.selectJBGDList(employeeVO);
		List<TeamVO> teamList = infoService.selectTeamList(employeeVO);
		model.addAttribute("employeeVO", employeeVO);
		model.addAttribute("empAllList", empAllList);
		model.addAttribute("deptList", deptList);
		model.addAttribute("jbgdList", jbgdList);
		model.addAttribute("teamList", teamList);

		return "employee/empInformation/empInfoListForm";
	}

	@GetMapping("/teamdetail.do")
	public String teamDetail(String teamCd, Model model) {
		
		TeamVO teamVO = infoService.selectDetailTeam(teamCd);
		
		List<VHCLRSVTVO> rsvtList = vehicleService.selectRsvt(teamCd);
		List<EmployeeAllVO> empList = infoService.selectEmpTeam(teamCd);
		List<EmployeeAllVO> todayVCT = infoService.todayVacationSelect(teamCd);
		
		TeamDetailVO completedCnt = infoService.completedProject(teamCd);
		
		log.info("empList 찍어보기" +  empList);
		log.info("completedCnt 찍어보기" +  completedCnt);
		
		model.addAttribute("todayVCT", todayVCT);
		model.addAttribute("rsvtList", rsvtList);
		model.addAttribute("teamVO", teamVO);
		model.addAttribute("completedCnt", completedCnt);
		model.addAttribute("empList", empList);
		
		return "employee/empInformation/teamDetail";
	}
	
	@ResponseBody
	@GetMapping("/teamcanlendar.do")
	public List<Map<String, Object>> teamCanlendar(@RequestParam String teamCd, Model model){
		
		log.info("teamCd 값 " + teamCd);
		
		List<Map<String, Object>> events = new ArrayList<Map<String,Object>>();
		
		List<ProjectVO> proCardList = infoService.selectTeamProjectList(teamCd);

	    for (ProjectVO project : proCardList) {
	        Map<String, Object> projectEvent = new HashMap<String, Object>();
	        projectEvent.put("id", project.getProNo());
	        projectEvent.put("title", project.getProNm());
	        projectEvent.put("description", project.getProCn());
	        projectEvent.put("start", project.getProStartDt());
	        projectEvent.put("end", project.getProEndDt());
	        projectEvent.put("allDay", true);
	        projectEvent.put("classNames", Arrays.asList("project-event"));
	        events.add(projectEvent);
	    } 
	    
		return events;
	}
	@ResponseBody
	@PostMapping("/empidchk.do")
	public ResponseEntity<String> empIdChk(@RequestBody String empId) {
		// empId를 사용하여 서비스에서 중복 검사
		ServiceResult result = infoService.empIdChk(empId);

		log.info("result 찍어보기 : " + result);

		if (result == null) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>("error", HttpStatus.BAD_REQUEST);
		}
	}

	@ResponseBody
	@GetMapping("/getteam.do")
	public List<TeamVO> getTeams(@RequestParam String deptCd) {
		return infoService.getTeamsByDept(deptCd);
	}

	@GetMapping("/empdetail.do")
	public String empDetail(EmployeeVO employeeVO, Model model) {
		
		EmployeeAllVO empVO = empAllInfoService.selectEmpImpl(employeeVO);
		employeeVO.setCoCd(empVO.getCoCd());
		List<DepartmentVO> deptList = infoService.selectDeptList(employeeVO);
		List<JobGradeVO> jbgdList = infoService.selectJBGDList(employeeVO);
		List<TeamVO> teamList = infoService.selectTeamList(employeeVO);
		
		model.addAttribute("empVO", empVO);
		model.addAttribute("deptList", deptList);
		model.addAttribute("jbgdList", jbgdList);
		model.addAttribute("teamList", teamList);

		log.info("employeeVO 찍어보기 : " + employeeVO);
		log.info("empVO 찍어보기 : " + empVO);
		log.info("deptList 찍어보기 : " + deptList);
		log.info("jbgdList 찍어보기 : " + jbgdList);
		log.info("teamList 찍어보기 : " + teamList);
		return "employee/empInformation/empInfoDetail";
	}
	
	@ResponseBody
	@PostMapping("/empinfomodify.do")
	public ResponseEntity<Map<String, Object>> empInfoModify(HttpServletRequest req, EmployeeVO employeeVO) throws Exception {
	    Map<String, Object> response = new HashMap<>();
	    
	    log.info("employeeVO 수정 들어왔을 때 : " + employeeVO);
	    MultipartFile file = employeeVO.getImgFile();
	    String createdFileName = employeeVO.getImgFileUrl();
	    
	    // MultipartFile이 비어있지 않은 경우에만 새로운 파일 업로드
	    if (file != null && !file.isEmpty()) {
	        createdFileName = uploadFile(file.getOriginalFilename(), file.getBytes());
	        employeeVO.setImgFileUrl(createdFileName);
	    } else {
	        // MultipartFile이 비어있다면 기존 파일 URL을 유지
	        employeeVO.setImgFileUrl(createdFileName);
	    }

	    ServiceResult result = infoService.empInfoModify(req, employeeVO);
	    if (result.equals(ServiceResult.OK)) {
	        response.put("status", "success");
	        response.put("message", "수정이 완료되었습니다!");
	        log.info("employeeVO 수정 끝났을 때 : " + employeeVO);
	    } else {
	        response.put("status", "error");
	        response.put("message", "수정에 실패하였습니다!");
	    }
	    return ResponseEntity.ok(response);
	}


	@PostMapping("/empdelete.do")
	public String empDelete(RedirectAttributes ra, HttpServletRequest req, @ModelAttribute EmployeeVO employeeVO,
			Model model) {
		String goPage = "";
		ServiceResult result = infoService.empDelete(req, employeeVO);
		if (result.equals(ServiceResult.OK)) {
			model.addAttribute("message", "퇴사처리 완료되었습니다!");
			log.info("퇴사처리 완료");
			goPage = "redirect:/empinformation/allinfo.do";
		} else {
			model.addAttribute("message", "퇴사처리에 실패하였습니다!");
			log.info("퇴사처리 실패");
			goPage = "redirect:/empinformation/allinfo.do";
		}
		return goPage;
	}

	// 권한 : 기업관리자
	// 메뉴 : 기업관리자 - 인사정보관리 - 전체사원목록 - 사원추가
	// 설명 : 전체사원목록 페이지에서 모달로 form 정보를 submit받아와 사원 정보 insert
	@PostMapping("/empinsert.do")
	public String empInsert(HttpServletRequest req, RedirectAttributes ra, @ModelAttribute EmployeeVO employeeVO,
			Model model) throws Exception {
		String goPage = "";
		// 넘겨받은 데이터 검증 후, 에러가 발생한 데이터에 대한 에러정보 담을 공간
		Map<String, String> errors = new HashMap<String, String>();
		if (StringUtils.isBlank(employeeVO.getEmpId())) {
			errors.put("값 미입력", "값을 입력해주세요!");
		}

		if (errors.size() > 0) {
			model.addAttribute("errors", errors);
			model.addAttribute("employeeVO", employeeVO);
			goPage = "redirect:/empinformation/allinfo.do";
		} else {
			CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmployeeVO userVO = user.getMember();
			EmployeeAuthVO authVO = new EmployeeAuthVO();
			employeeVO.setEmpPw(pe.encode(employeeVO.getEmpPw()));
			authVO.setAuthrityNm("ROLE_EMPLOYEE");
			authVO.setEmpId(employeeVO.getEmpId());
			MultipartFile file = employeeVO.getImgFile();
			String createdFileName;
			if (file != null && !file.isEmpty()) {
				createdFileName = uploadFile(file.getOriginalFilename(), file.getBytes());
			} else {
				createdFileName = "noimg.jpg";
			}
			employeeVO.setImgFileUrl(createdFileName);

			if (userVO != null) {
				employeeVO.setCoCd(userVO.getCoCd());
				ServiceResult result = infoService.insertEmployee(req, employeeVO);
				cloudService.empCloudStrgCreate(employeeVO);
				loginService.insertAuth(authVO);
				if (result.equals(ServiceResult.OK)) {
					ra.addFlashAttribute("message", "사원 등록 완료!");
					goPage = "redirect:/empinformation/allinfo.do";
				} else {
					model.addAttribute("message", "서버에러, 다시 시도해주세요!");
					goPage = "redirect:/empinformation/allinfo.do";
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
	
}
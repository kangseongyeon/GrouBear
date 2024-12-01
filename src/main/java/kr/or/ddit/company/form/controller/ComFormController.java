package kr.or.ddit.company.form.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.or.ddit.comm.form.service.IFormService;
import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@PreAuthorize("hasAnyRole('ROLE_COMPANY')")
@RequestMapping("/company")
public class ComFormController {
	
	@Inject
	private IFormService formService;
	
	@Inject
	private ITIlesService tilesService;
	
	// 양식 리스트 조회 (기업 관리자)
	@GetMapping("/formList.do")
	public String formList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model,
			HttpServletRequest request) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		CompanyVO companyVO = tilesService.getCompany(employeeVO);
		
		model.addAttribute("employeeVO",employeeVO);
		model.addAttribute("companyVO",companyVO);
		
		// 회원정보
		model.addAttribute("employeeVO", employeeVO);
		
		FormVO formVO = new FormVO();
		formVO.setCoCd(employeeVO.getCoCd());
		
		// 양식 종류 가져오기
		List<FormVO> docFormKndNmList = formService.companySelectDocFormKndNm(formVO);
		model.addAttribute("docFormKndNmList", docFormKndNmList);
		
		// 리스트 페이징 처리하기
		PaginationInfoVO<FormVO> pagingVO = new PaginationInfoVO<FormVO>(10,5);
		pagingVO.setCoCd(employeeVO.getCoCd());
		
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
		int totalRecord = formService.companySelectFormCount(pagingVO);
		
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord); 
		
		// 총 게시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의 리스트 데이터를 가져온다.
		List<FormVO> formList = formService.companySelectFormList(pagingVO);
		pagingVO.setDataList(formList);
		
		// 다른 메서드 (insert, update, delete 등)에서 전달한 메시지 함께 보내기
		HttpSession session = request.getSession();
		model.addAttribute("message", session.getAttribute("message"));
		session.removeAttribute("message");
		
		model.addAttribute("pagingVO", pagingVO);

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("formMenu", "show");
		model.addAttribute("formInternal", "active");
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n totalRecord : " + totalRecord);
		return "company/form/formList";
	}
	
	// 양식 편집
	@GetMapping("/formEdit.do")
	public String formEdit(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		FormVO formVO = new FormVO();
		formVO.setCoCd(employeeVO.getCoCd());
		
		// 양식 종류 가져오기
		List<FormVO> docFormKndNmList = formService.companySelectDocFormKndNm(formVO);
		model.addAttribute("docFormKndNmList", docFormKndNmList);

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("formMenu", "show");
		model.addAttribute("formInternal", "active");
		
		return "company/form/formEdit";
	}                         

	// 양식 등록
	@GetMapping("/formInsert.do")
	public String formInsert(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		FormVO formVO = new FormVO();
		formVO.setCoCd(employeeVO.getCoCd());
		
		// 양식 종류 가져오기
		List<FormVO> docFormKndNmList = formService.companySelectDocFormKndNm(formVO);
		model.addAttribute("docFormKndNmList", docFormKndNmList);
		
		// 발표를 위한 데이터 세팅
		FormVO formVO2 = new FormVO();
		formVO2.setDocFormNm("재직증명서3");
		formVO2.setDocFormExpln("재직증명서3 회사 양식");
		formVO2.setDocFormKndNm("증명서");
		formVO2.setDocFormCn(
		"<p style=\"text-align:center\">&nbsp;</p>\r\n" + 
		"\r\n" + 
		"<p style=\"text-align:center\"><span style=\"font-size:26px\"><strong>재 직 증 명 서</strong></span></p>\r\n" + 
		"\r\n" + 
		"<p style=\"text-align:center\">&nbsp;</p>\r\n" + 
		"\r\n" + 
		"<p><strong><span style=\"font-size:18px\">&nbsp; 1. 인적사항</span></strong></p>\r\n" + 
		"\r\n" + 
		"<table align=\"center\" border=\"2\" cellpadding=\"0\" cellspacing=\"0\" id=\"employeeInfo\" style=\"height:100px; padding:0px; width:650px\">\r\n" + 
		"	<tbody>\r\n" + 
		"		<tr>\r\n" + 
		"			<td style=\"background-color:#dddddd; text-align:center; width:150px\"><span style=\"font-size:16px\"><strong>성&nbsp; &nbsp; 명</strong></span></td>\r\n" + 
		"			<td style=\"text-align:center; width:200px\">\r\n" + 
		"			<div>#{empNm}</div>\r\n" + 
		"			</td>\r\n" + 
		"			<td style=\"background-color:#dddddd; text-align:center; width:150px\"><span style=\"font-size:16px\"><strong>주민등록번호</strong></span></td>\r\n" + 
		"			<td style=\"text-align:center; width:200px\">\r\n" + 
		"			<div>#{empBrdt}</div>\r\n" + 
		"			</td>\r\n" + 
		"		</tr>\r\n" + 
		"		<tr>\r\n" + 
		"			<td style=\"background-color:#dddddd; text-align:center; width:150px\"><span style=\"font-size:16px\"><strong>주&nbsp; &nbsp; 소</strong></span></td>\r\n" + 
		"			<td colspan=\"3\" rowspan=\"1\" style=\"text-align:center; width:200px\">\r\n" + 
		"			<div>#{empAddr} #{empDaddr} (#{empZip})</div>\r\n" + 
		"			</td>\r\n" + 
		"		</tr>\r\n" + 
		"	</tbody>\r\n" + 
		"</table>\r\n" + 
		"\r\n" + 
		"<p>&nbsp;</p>\r\n" + 
		"\r\n" + 
		"<p><strong><span style=\"font-size:18px\">&nbsp; 2. 재직사항</span></strong></p>\r\n" + 
		"\r\n" + 
		"<table align=\"center\" border=\"2\" cellpadding=\"0\" cellspacing=\"0\" id=\"employeeInfo\" style=\"height:200px; padding:0px; width:650px\">\r\n" + 
		"	<tbody>\r\n" + 
		"		<tr>\r\n" + 
		"			<td style=\"background-color:#dddddd; text-align:center; width:150px\"><span style=\"font-size:16px\"><strong>회사명</strong></span></td>\r\n" + 
		"			<td style=\"text-align:center; width:200px\">\r\n" + 
		"			<div>#{coNm}</div>\r\n" + 
		"			</td>\r\n" + 
		"			<td style=\"background-color:#dddddd; text-align:center; width:150px\"><span style=\"font-size:16px\"><strong>사업자등록번호</strong></span></td>\r\n" + 
		"			<td style=\"text-align:center; width:200px\">\r\n" + 
		"			<div>#{coBrno}</div>\r\n" + 
		"			</td>\r\n" + 
		"		</tr>\r\n" + 
		"		<tr>\r\n" + 
		"			<td style=\"background-color:#dddddd; text-align:center; width:150px\"><span style=\"font-size:16px\"><strong>소재지</strong></span></td>\r\n" + 
		"			<td colspan=\"3\" rowspan=\"1\" style=\"text-align:center; width:200px\">\r\n" + 
		"			<div>#{coAddr} #{coDaddr} (#{coZip})</div>\r\n" + 
		"			</td>\r\n" + 
		"		</tr>\r\n" + 
		"		<tr>\r\n" + 
		"			<td style=\"background-color:#dddddd; text-align:center; width:150px\"><span style=\"font-size:16px\"><strong>부&nbsp; &nbsp; 서</strong></span></td>\r\n" + 
		"			<td style=\"text-align:center; width:200px\">\r\n" + 
		"			<div>#{deptNm}</div>\r\n" + 
		"			</td>\r\n" + 
		"			<td style=\"background-color:#dddddd; text-align:center; width:150px\"><span style=\"font-size:16px\"><strong>소&nbsp; &nbsp; 속</strong></span></td>\r\n" + 
		"			<td style=\"text-align:center; width:200px\">\r\n" + 
		"			<div>#{teamNm}</div>\r\n" + 
		"			</td>\r\n" + 
		"		</tr>\r\n" + 
		"		<tr>\r\n" + 
		"			<td style=\"background-color:#dddddd; text-align:center; width:150px\"><span style=\"font-size:16px\"><strong>재직기간</strong></span></td>\r\n" + 
		"			<td colspan=\"3\" style=\"text-align:center; width:200px\">\r\n" + 
		"			<div>#{empJncmpYmd} ~ #{empRsgntnYmd}</div>\r\n" + 
		"			</td>\r\n" + 
		"		</tr>\r\n" + 
		"	</tbody>\r\n" + 
		"</table>\r\n" + 
		"\r\n" + 
		"<p>&nbsp;</p>\r\n" + 
		"\r\n" + 
		"<p>&nbsp;</p>\r\n" + 
		"\r\n" + 
		"<p>&nbsp;</p>\r\n" + 
		"\r\n" + 
		"<p style=\"text-align:center\"><span style=\"font-size:22px\">상기와 같이 재직하고 있음을 증명합니다.</span></p>\r\n" + 
		"\r\n" + 
		"<p style=\"text-align:center\">&nbsp;</p>\r\n" + 
		"\r\n" + 
		"<p style=\"text-align:center\">&nbsp;</p>\r\n" + 
		"\r\n" + 
		"<p style=\"text-align:center\">&nbsp;</p>\r\n" + 
		"\r\n" + 
		"<p style=\"text-align:center\"><span style=\"font-size:20px\">#{currentDt}</span></p>\r\n" + 
		"\r\n" + 
		"<p style=\"text-align:center\">&nbsp;</p>\r\n" + 
		"\r\n" + 
		"<p style=\"text-align:center\">&nbsp;</p>\r\n" + 
		"\r\n" + 
		"<div style=\"display:flex; justify-content:center\">\r\n" + 
		"<div style=\"text-align:center\"><span style=\"font-size:22px\">#{coNm}</span></div>\r\n" + 
		"\r\n" + 
		"<div style=\"text-align:center\"><span style=\"font-size:22px\">&nbsp; &nbsp;대표이사</span></div>\r\n" + 
		"\r\n" + 
		"<div style=\"text-align:center\"><span style=\"font-size:22px\">&nbsp; #{ceoNm}</span></div>\r\n" + 
		"\r\n" + 
		"<div style=\"text-align:center; position: relative;\"><span style=\"font-size:22px\">&nbsp; &nbsp;(인)</span></div>\r\n" + 
		"</div>\r\n" + 
		""
				);
		model.addAttribute("formVO", formVO2);
		
		model.addAttribute("status", "i");

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("formMenu", "show");
		model.addAttribute("formInternal", "active");
		
		return "company/form/formEdit";
	}     

	// 양식 등록
	@PostMapping("/formInsert.do")
	public String formInsert(FormVO formVO, Model model, RedirectAttributes ra, HttpServletRequest request) {
		String goPage = "";
		Map<String, String> error = new HashMap<String, String>();
		
		// docFormKndUp (계층형 쿼리를 위한 데이터 세팅)
		FormVO formDocFormKndUpVO = formService.selectForm(Integer.valueOf(formVO.getDocFormKndUp()));
		formVO.setDocFormKndNm(formDocFormKndUpVO.getDocFormNm());
		
		if (StringUtils.isBlank(formVO.getDocFormNm())) {
			error.put("docFormNm", "양식명을 입력해주세요.");
		}
		if (StringUtils.isBlank(formVO.getDocFormKndNm())) {
			error.put("docFormKndNm", "양식종류를 입력해주세요.");
		}
		if (StringUtils.isBlank(formVO.getDocFormCn())) {
			error.put("docFormCn", "양식내용을 입력해주세요.");
		}
		
		// 필수입력  빈칸이 있다면
		if (error.size() > 0) {
			model.addAttribute("error", error);
			model.addAttribute("formVO", formVO);
			goPage = "company/form/formEdit";
			
		} else {	// 필수 입력 빈칸이 없다면
			// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
			CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmployeeVO employeeVO = user.getMember();
			
			if (employeeVO != null) {	// 로그인을 정상적으로 한 상태일 때만
				formVO.setEmpId(employeeVO.getEmpId());
				formVO.setCoCd(employeeVO.getCoCd());
				
				ServiceResult result = formService.formInsert(formVO);
				
				if (result.equals(ServiceResult.OK)) {	// 정상적으로 DB에 연결됐다면	
					HttpSession session = request.getSession();
					session.setAttribute("message", "정상적으로 등록되었습니다.");

					// 사이드바 메뉴 아코디언 고정하기
					model.addAttribute("formMenu", "show");
					model.addAttribute("formInternal", "active");
					
					goPage = "redirect:/company/formList.do";
					
				} else {	// DB 연결에 문제가 생겼다면
					model.addAttribute("formVO", "formVO");
					model.addAttribute("message", "서버에 오류가 생겼습니다. 다시 시도해주세요.");

					// 사이드바 메뉴 아코디언 고정하기
					model.addAttribute("formMenu", "show");
					model.addAttribute("formInternal", "active");
					
					goPage = "company/form/formEdit";
				}
				
			} else {
				ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
				goPage = "redirect:/login.do";
			}
		} 
		return goPage;
	}

	// 양식 수정
	@GetMapping("/formUpdate.do")
	public String formUpdate(int docFormNo, Model model) {
		log.info("formUpdate 들어옴");
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		FormVO formVO1 = new FormVO();
		formVO1.setCoCd(employeeVO.getCoCd());
		
		// 양식 종류 가져오기
		List<FormVO> docFormKndNmList = formService.companySelectDocFormKndNm(formVO1);
		model.addAttribute("docFormKndNmList", docFormKndNmList);
		
		FormVO formVO = formService.selectForm(docFormNo);
		
		model.addAttribute("docFormKndNm", docFormKndNmList);
		model.addAttribute("status", "u");
		model.addAttribute("formVO", formVO);

		// 사이드바 메뉴 아코디언 고정하기
		model.addAttribute("formMenu", "show");
		model.addAttribute("formInternal", "active");
		
		return "company/form/formEdit";
	}

	// 양식 수정
	@PostMapping("/formUpdate.do")
	public String formUpdate(FormVO formVO, Model model, RedirectAttributes ra, HttpServletRequest request) {
		log.info("formUpdate 들어옴");
		
		String goPage = "";
		Map<String, String> error = new HashMap<String, String>();
		
		// docFormKndUp (계층형 쿼리를 위한 데이터 세팅)
		FormVO formDocFormKndUpVO = formService.selectForm(Integer.valueOf(formVO.getDocFormKndUp()));
		formVO.setDocFormKndNm(formDocFormKndUpVO.getDocFormNm());
		
		if (StringUtils.isBlank(formVO.getDocFormNm())) {
			error.put("docFormNm", "양식명을 입력해주세요.");
		}
		if (StringUtils.isBlank(formVO.getDocFormKndNm())) {
			error.put("docFormKndNm", "양식종류를 입력해주세요.");
		}
		if (StringUtils.isBlank(formVO.getDocFormCn())) {
			error.put("docFormCn", "양식내용을 입력해주세요.");
		}
		
		// 필수입력  빈칸이 있다면
		if (error.size() > 0) {
			model.addAttribute("error", error);
			model.addAttribute("formVO", formVO);
			model.addAttribute("status", "u");
			goPage = "company/form/formEdit";
			
		} else {	// 필수 입력 빈칸이 없다면
			// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
			CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmployeeVO employeeVO = user.getMember();
			
			if (employeeVO != null) {	// 로그인을 정상적으로 한 상태일 때만
				formVO.setEmpId(employeeVO.getEmpId());
				formVO.setCoCd(employeeVO.getCoCd());
				log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n" + formVO.toString());
				
				ServiceResult result = formService.formUpdate(formVO);
				
				if (result.equals(ServiceResult.OK)) {	// 정상적으로 DB에 연결됐다면	
					HttpSession session = request.getSession();
					session.setAttribute("message", "정상적으로 수정되었습니다.");
					goPage = "redirect:/company/formList.do";
				} else {	// DB 연결에 문제가 생겼다면
					model.addAttribute("formVO", "formVO");
					model.addAttribute("message", "서버에 오류가 생겼습니다. 다시 시도해주세요.");

					// 사이드바 메뉴 아코디언 고정하기
					model.addAttribute("formMenu", "show");
					model.addAttribute("formInternal", "active");
					
					goPage = "company/form/formEdit";
				}
				
			} else {
				ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
				goPage = "redirect:/login.do";
			}
		} 
		return goPage;
	}

	// 양식 삭제 (1개일 때)
	@PostMapping("/formDelete.do")
	public String formDelete(int docFormNo, Model model, RedirectAttributes ra) {
		log.info("formDelete 들어옴");
		String goPage = "";
		
		// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		if (employeeVO != null) {	// 로그인을 정상적으로 한 상태일 때만
			log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n" + docFormNo);
			
			ServiceResult result = formService.formDelete(docFormNo);
			
			if (result.equals(ServiceResult.OK)) {	// 정상적으로 DB에 연결됐다면	
				model.addAttribute("message", "정상적으로 삭제되었습니다.");
				goPage = "redirect:/company/formList.do";
			} else {	// DB 연결에 문제가 생겼다면
				model.addAttribute("message", "서버에 오류가 생겼습니다. 다시 시도해주세요.");

				// 사이드바 메뉴 아코디언 고정하기
				model.addAttribute("formMenu", "show");
				model.addAttribute("formInternal", "active");
				
				goPage = "company/form/formEdit";
			}
			
		} else {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
			goPage = "redirect:/login.do";
		}
		return goPage;
	}
	
	// Jstree에 출력할 form 계층형 데이터 (기업 관리자)
	@GetMapping("/formSelectJstree.do")
	public ResponseEntity<JsonArray> selectJstree(Model model) {
		// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		// 아래처럼 treeList를 프론트에 전달
		// id, text, parent, type 변수그대로사용
		JsonArray treeList = new JsonArray();
		List<FormVO> formList = formService.companySelectFormListJstree(employeeVO.getCoCd());
		
		// jstree에게 전달하기 위한 제이슨 형태의 객체로 데이터 가공하기
		if(formList.size() > 0) {
		    for(int i = 0; i < formList.size(); i++){
		    	JsonObject json = new JsonObject();		// JSON 객체를 만들기 위한 준비
		    	json.addProperty("id", formList.get(i).getDocFormNo());
		    	json.addProperty("text", formList.get(i).getDocFormNm());
		    	json.addProperty("parent", formList.get(i).getDocFormKndUp());
		    	if (formList.get(i).getDocFormKndNm() == null) {
		    		json.addProperty("type", "default"); //css icon 폴더 아이콘
		    	} else {
		    		json.addProperty("type", "file"); //css icon 파일 아이콘
		    	}
		        treeList.add(json);
		    }
		}
		return new ResponseEntity<JsonArray>(treeList, HttpStatus.OK);
	}

	// 양식 종류 추가
	@PostMapping("/docFormKndNmAdd.do")
	public ResponseEntity<List<FormVO>> docFormKndNmAdd(@RequestBody Map<String, String> map) {
		
		// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		String docFormKndNm = map.get("docFormKndNm");
		String docFormKndUp = map.get("docFormKndUp");
		
		FormVO formVO = new FormVO();
		formVO.setCoCd(employeeVO.getCoCd());
		formVO.setEmpId(employeeVO.getEmpId());
		formVO.setDocFormNm(docFormKndNm);
		formVO.setDocFormKndUp(docFormKndUp);
		
		// 양식 종류 추가하기
		ServiceResult result = formService.docFormKndNmAdd(formVO);
		
		// 양식 종류 가져오기
		List<FormVO> docFormKndNmList = formService.companySelectDocFormKndNm(formVO);
						
		return new ResponseEntity<List<FormVO>>(docFormKndNmList, HttpStatus.OK);
	}

	// 양식 종류 삭제하기
	@PostMapping("/docFormKndNmDel.do")
	public ResponseEntity<FormVO> docFormKndNmDel(@RequestBody Map<String, String> map) {
		
		// 시큐리티에서 로그인 정보 및 커스텀 유저 객체 가져오기 
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		
		int docFormNo = Integer.valueOf(map.get("docFormNo"));
		
		FormVO formVO = new FormVO();
		formVO.setDocFormNo(docFormNo);
		
		// 양식 종류 삭제하기
		ServiceResult result = formService.docFormKndNmDel(formVO);
		
		return new ResponseEntity<FormVO>(formVO, HttpStatus.OK);
	}

	// 양식 상세 조회
	@GetMapping("/selectForm.do")
	public ResponseEntity<FormVO> selectForm(@RequestParam("docFormNo") int docFormNo) {
		// 선택한 양식의 정보 가져오기
		FormVO formVO = formService.selectForm(docFormNo);
		
		return new ResponseEntity<FormVO>(formVO, HttpStatus.OK);
	}

	// 양식 종류 삭제 전, 하위 글 유무 확인하기
	@GetMapping("/docFormKndWriteCheck.do")
	public ResponseEntity<Integer> docFormKndWriteCheck(@RequestParam("docFormNo") int docFormNo) {
		int writingNo = formService.docFormKndWriteCheck(docFormNo);
		
		return new ResponseEntity<Integer>(writingNo, HttpStatus.OK);
	}

	// 선택한 양식 삭제 (1 또는 N)
	@PostMapping("/selectWriteListDelete.do")
	public ResponseEntity<ServiceResult> selectWriteListDelete(@RequestBody Map<String, List<Integer>> map) {
		
		List<Integer> selectWriteList = map.get("checkArr");
		for (Integer integer : selectWriteList) {
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> : " + integer);
		}
		
		ServiceResult result = formService.selectWriteListDelete(selectWriteList);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>> : " + result);
		
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
}

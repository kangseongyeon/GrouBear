package kr.or.ddit.company.addressBook.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.service.IInformationService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/addressbook")
@PreAuthorize("hasAnyRole('ROLE_EMPLOYEE', 'ROLE_COMPANY')")
public class AddressBookController {

	@Inject
	private ITIlesService tilesService;

	@Inject
	private IInformationService infoService;

	@GetMapping("/addressbookmain.do")
	public String addressBookMain(Model model) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();

		CompanyVO companyVO = tilesService.getCompany(employeeVO);

		List<EmployeeVO> empAllList = infoService.comAllEmpList(employeeVO);
		List<DepartmentVO> deptTeamList = infoService.selectDeptTeamList(employeeVO);
		List<JobGradeVO> jbgdList = infoService.selectJBGDList(employeeVO);
		List<TeamVO> teamList = infoService.selectTeamListByDept(employeeVO);
		model.addAttribute("companyVO", companyVO);
		model.addAttribute("employeeVO", employeeVO);
		model.addAttribute("empAllList", empAllList);
		model.addAttribute("deptTeamList", deptTeamList);
		model.addAttribute("jbgdList", jbgdList);
		model.addAttribute("teamList", teamList);

		log.info("companyVO : " + companyVO.getCeoId());

		return "company/comAddressBook/comAddressBookForm";
	}

	@ResponseBody
	@GetMapping("/getaddremp.do")
	public List<EmployeeVO> getAddrEmployee(@RequestParam("teamCd") String teamCd) {
		List<EmployeeVO> empList = infoService.getAddrEmployee(teamCd);
		log.info("teamCd" + teamCd);
		log.info("empList : " + empList);
		return empList;
	}

	@ResponseBody
	@GetMapping("/getaddrallemp.do")
	public List<EmployeeVO> getAddrAllEmployee() {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();

		List<EmployeeVO> empList = infoService.comAllEmpList(employeeVO);
		log.info("employeeVO" + employeeVO.getCoCd());
		log.info("empList : " + empList);
		return empList;
	}

	@ResponseBody
	@GetMapping("/getaddempid.do")
	public EmployeeVO getaddempid(@RequestParam("empId") String empId) {
		EmployeeVO empVO = infoService.selectEmployee(empId);
		log.info("empId" + empVO);
		return empVO;
	}
}

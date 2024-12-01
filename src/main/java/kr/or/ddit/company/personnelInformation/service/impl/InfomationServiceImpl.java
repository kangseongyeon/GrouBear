package kr.or.ddit.company.personnelInformation.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.project.vo.ProjectVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.company.personnelInformation.mapper.IInformationMapper;
import kr.or.ddit.company.personnelInformation.service.IInformationService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentMenuVO;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;
import kr.or.ddit.company.personnelInformation.vo.MenuVO;
import kr.or.ddit.company.personnelInformation.vo.TeamDetailVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class InfomationServiceImpl implements IInformationService {

	@Inject
	private IInformationMapper infoMapper;

	public List<EmployeeVO> comAllEmpList(EmployeeVO employeeVO) {
		return infoMapper.comAllEmpList(employeeVO);
	}

	@Override
	public List<DepartmentVO> comAllDeptList(EmployeeVO employeeVO) {
		return infoMapper.comAllDeptList(employeeVO);
	}

	@Override
	public List<DepartmentVO> selectDeptList(EmployeeVO employeeVO) {
		return infoMapper.selectDeptList(employeeVO);
	}

	@Override
	public List<TeamVO> getTeamsByDept(String deptCd) {
		return infoMapper.getTeamsByDept(deptCd);
	}

	@Override
	public List<JobGradeVO> selectJBGDList(EmployeeVO employeeVO) {
		log.info("empVO 서비스 값 : " + employeeVO);
		log.info("coCd 값 : " + employeeVO.getCoCd());
		return infoMapper.selectJBGDList(employeeVO);
	}

	@Override
	public ServiceResult insertEmployee(HttpServletRequest req, EmployeeVO employeeVO) {
		ServiceResult result = null;
		
		int status = infoMapper.insertEmployee(employeeVO);
		
		if (status > 0 ) {
			// 공지사항 게시글 등록시 업로드 한 파일 목록을 가져온다.
//			List<EmployeeVO> noticeFileList = employeeVO.getNoticeFileList();
			
			// 공지사항 파일 업로드 처리
//			noticeFileUpload(noticeFileList, employeeVO.getBoNo(), req);
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult insertDepartment(HttpServletRequest req, DepartmentVO departmentVO) {
		ServiceResult result = null;
		
		int status = infoMapper.insertDepartment(departmentVO);
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<MenuVO> comAllMenuList() {
		return infoMapper.comAllMenuList();
	}

	@Override
	public EmployeeVO selectEmployee(String empId) {
		return infoMapper.selectEmployee(empId);
	}

	@Override
	public ServiceResult empInfoModify(HttpServletRequest req, EmployeeVO employeeVO) {
		ServiceResult result = null;
		int status = infoMapper.empInfoModify(employeeVO);
		
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<TeamVO> selectTeamList(EmployeeVO employeeVO) {
		return infoMapper.selectTeamList(employeeVO);
	}

	@Override
	public ServiceResult empDelete(HttpServletRequest req, EmployeeVO employeeVO) {
		ServiceResult result = null;
		int status = infoMapper.empDelete(employeeVO);
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<TeamVO> selectTeamListByDept(EmployeeVO employeeVO) {
		return infoMapper.selectTeamListByDept(employeeVO);
	}

	@Override
	public List<DepartmentVO> selectDeptTeamList(EmployeeVO employeeVO) {
		return infoMapper.selectDeptTeamList(employeeVO);
	}

	@Override
	public List<EmployeeVO> getAddrEmployee(String teamCd) {
		return infoMapper.getAddrEmployee(teamCd);
	}

	@Override
	public MenuVO getMenu(String menuNo) {
		return infoMapper.getMenu(menuNo);
	}

	@Override
	public String recentlyDept() {
		return infoMapper.recentlyDept();
	}

	@Override
	public ServiceResult insertMenu(HttpServletRequest req, DepartmentMenuVO departmentMenuVO) {
		ServiceResult result = null;
		int status = infoMapper.insertMenu(departmentMenuVO);
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult insertTeam(HttpServletRequest req, TeamVO teamVO) {
		ServiceResult result = null;
		int status = infoMapper.insertTeam(teamVO);
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<DepartmentMenuVO> getSidebar(String deptCd) {
		return infoMapper.getSidebar(deptCd);
	}

	@Override
	public int selectEmpPage(PaginationInfoVO<EmployeeAllVO> pagingVO) {
		return infoMapper.selectEmpPage(pagingVO);
	}

	@Override
	public List<EmployeeAllVO> selectEmpPaging(PaginationInfoVO<EmployeeAllVO> pagingVO) {
		return infoMapper.selectEmpPaging(pagingVO);
	}

	@Override
	public ServiceResult empIdChk(String empId) {
		ServiceResult result = null;
		int status = infoMapper.empIdChk(empId);
		if (status > 0) {
			result = ServiceResult.FAILED;
		}else {
			result = null;
		}
		return result;
	}

	@Override
	public ServiceResult deptModifyNm(DepartmentVO departmentVO) {
		ServiceResult result = null;
		int status = infoMapper.deptModifyNm(departmentVO);
		
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult delDept(DepartmentVO departmentVO) {
		ServiceResult result = null;
		int status = infoMapper.delDept(departmentVO);
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult insertModalTeam(TeamVO teamVO) {
		ServiceResult result = null;
		int status = infoMapper.insertModalTeam(teamVO);
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult delTeam(TeamVO teamVO) {
		ServiceResult result = null;
		int status = infoMapper.delTeam(teamVO);
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public DepartmentVO deptNmChk(DepartmentVO departmentVO) {
		return infoMapper.deptNmChk(departmentVO);
	}

	@Override
	public TeamVO selectDetailTeam(String teamCd) {
		return infoMapper.selectDetailTeam(teamCd);
	}

	@Override
	public List<EmployeeAllVO> selectEmpTeam(String teamCd) {
		return infoMapper.selectEmpTeam(teamCd);
	}

	@Override
	public List<EmployeeVO> orgEmpList(EmployeeVO employeeVO) {
		return infoMapper.orgEmpList(employeeVO);
	}

	@Override
	public List<ProjectVO> selectTeamProjectList(String teamCd) {
		return infoMapper.selectTeamProjectList(teamCd);
	}

	@Override
	public TeamDetailVO completedProject(String teamCd) {
		return infoMapper.completedProject(teamCd);
	}

	@Override
	public List<EmployeeAllVO> todayVacationSelect(String teamCd) {
		return infoMapper.todayVacationSelect(teamCd);
	}

}

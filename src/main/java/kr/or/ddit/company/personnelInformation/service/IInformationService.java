package kr.or.ddit.company.personnelInformation.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.project.vo.ProjectVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.company.personnelInformation.vo.DepartmentMenuVO;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;
import kr.or.ddit.company.personnelInformation.vo.MenuVO;
import kr.or.ddit.company.personnelInformation.vo.TeamDetailVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;

public interface IInformationService {

	public List<EmployeeVO> comAllEmpList(EmployeeVO employeeVO);

	public List<DepartmentVO> comAllDeptList(EmployeeVO employeeVO);

	public List<DepartmentVO> selectDeptList(EmployeeVO employeeVO);

	public List<TeamVO> getTeamsByDept(String deptCd);

	public List<JobGradeVO> selectJBGDList(EmployeeVO employeeVO);

	public ServiceResult insertEmployee(HttpServletRequest req, EmployeeVO employeeVO);

	public ServiceResult insertDepartment(HttpServletRequest req, DepartmentVO departmentVO);

	public List<MenuVO> comAllMenuList();

	public EmployeeVO selectEmployee(String empId);

	public ServiceResult empInfoModify(HttpServletRequest req, EmployeeVO employeeVO);

	public List<TeamVO> selectTeamList(EmployeeVO employeeVO);

	public ServiceResult empDelete(HttpServletRequest req, EmployeeVO employeeVO);

	public List<TeamVO> selectTeamListByDept(EmployeeVO employeeVO);

	public List<DepartmentVO> selectDeptTeamList(EmployeeVO employeeVO);

	public List<EmployeeVO> getAddrEmployee(String teamCd);

	public MenuVO getMenu(String menuNo);

	public String recentlyDept();

	public ServiceResult insertMenu(HttpServletRequest req, DepartmentMenuVO departmentMenuVO);

	public ServiceResult insertTeam(HttpServletRequest req, TeamVO teamVO);

	public List<DepartmentMenuVO> getSidebar(String deptCd);

	public int selectEmpPage(PaginationInfoVO<EmployeeAllVO> pagingVO);

	public List<EmployeeAllVO> selectEmpPaging(PaginationInfoVO<EmployeeAllVO> pagingVO);

	public ServiceResult empIdChk(String empId);

	public ServiceResult deptModifyNm(DepartmentVO departmentVO);

	public ServiceResult delDept(DepartmentVO departmentVO);

	public ServiceResult insertModalTeam(TeamVO teamVO);

	public ServiceResult delTeam(TeamVO teamVO);

	public DepartmentVO deptNmChk(DepartmentVO departmentVO);

	public TeamVO selectDetailTeam(String teamCd);

	public List<EmployeeAllVO> selectEmpTeam(String teamCd);

	public List<EmployeeVO> orgEmpList(EmployeeVO employeeVO);

	public List<ProjectVO> selectTeamProjectList(String teamCd);

	public TeamDetailVO completedProject(String teamCd);

	public List<EmployeeAllVO> todayVacationSelect(String teamCd);

}

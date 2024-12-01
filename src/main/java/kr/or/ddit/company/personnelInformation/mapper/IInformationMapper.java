package kr.or.ddit.company.personnelInformation.mapper;

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


public interface IInformationMapper {

	public List<EmployeeVO> comAllEmpList(EmployeeVO employeeVO);

	public List<DepartmentVO> comAllDeptList(EmployeeVO employeeVO);

	public ServiceResult insertEmployee(HttpServletRequest req, EmployeeVO employeeVO);

	public List<DepartmentVO> selectDeptList(EmployeeVO employeeVO);

	public List<TeamVO> getTeamsByDept(String deptCd);

	public List<JobGradeVO> selectJBGDList(EmployeeVO employeeVO);

	public int insertEmployee(EmployeeVO employeeVO);

	public int insertDepartment(DepartmentVO departmentVO);

	public List<MenuVO> comAllMenuList();

	public EmployeeVO selectEmployee(String empId);

	public int empInfoModify(EmployeeVO employeeVO);

	public List<TeamVO> selectTeamList(EmployeeVO employeeVO);

	public int empDelete(EmployeeVO employeeVO);

	public List<TeamVO> selectTeamListByDept(EmployeeVO employeeVO);

	public List<DepartmentVO> selectDeptTeamList(EmployeeVO employeeVO);

	public List<EmployeeVO> getAddrEmployee(String teamCd);
	
	public MenuVO getMenu(String menuNo);

	public String recentlyDept();

	public int insertMenu(DepartmentMenuVO departmentMenuVO);

	public int insertTeam(TeamVO teamVO);

	public List<DepartmentMenuVO> getSidebar(String deptCd);
	
	public int selectEmpPage(PaginationInfoVO<EmployeeAllVO> pagingVO);

	public List<EmployeeAllVO> selectEmpPaging(PaginationInfoVO<EmployeeAllVO> pagingVO);

	public int empIdChk(String empId);

	public int deptModifyNm(DepartmentVO departmentVO);

	public int delDept(DepartmentVO departmentVO);

	public int insertModalTeam(TeamVO teamVO);

	public int delTeam(TeamVO teamVO);

	public DepartmentVO deptNmChk(DepartmentVO departmentVO);

	public TeamVO selectDetailTeam(String teamCd);

	public List<EmployeeAllVO> selectEmpTeam(String teamCd);

	public List<EmployeeVO> orgEmpList(EmployeeVO employeeVO);

	public List<ProjectVO> selectTeamProjectList(String teamCd);

	public TeamDetailVO completedProject(String teamCd);

	public List<EmployeeAllVO> todayVacationSelect(String teamCd);

}

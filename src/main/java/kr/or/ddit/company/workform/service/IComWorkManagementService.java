package kr.or.ddit.company.workform.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.workform.vo.CompanyWorkFormVO;
import kr.or.ddit.company.workform.vo.WorkFormVO;
import kr.or.ddit.employee.workStatus.vo.EmpWorkStatusVO;

public interface IComWorkManagementService {

	public int insertBaseWorkForm(WorkFormVO wfVO);

	public WorkFormVO getBaseWorkForm(EmployeeVO empVO);

	public int insertDeptWorkForm(WorkFormVO wfVO);

	public WorkFormVO getDeptWorkForm(String deptCd);

	public int udtDeptWorkForm(WorkFormVO wfVO);

	public int udtBaseWorkForm(WorkFormVO getwfVO);

	public List<CompanyWorkFormVO> getWorkFormList(EmployeeVO empVO);


	public int getTodayWorkStatustCount(PaginationInfoVO<EmpWorkStatusVO> pagingVO);

	public List<EmpWorkStatusVO> getTodayWorkStatus(PaginationInfoVO<EmpWorkStatusVO> pagingVO);

	public EmpWorkStatusVO getEmpTodayWorkStts(String empId);

	public int updateEmpTodayWorkStts(EmpWorkStatusVO empWorkSttsVO);

	public int delEmpTodayWorkStts(String wscd);

	public void setBasicworkForm(WorkFormVO workFormVO);

}

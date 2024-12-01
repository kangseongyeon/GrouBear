package kr.or.ddit.company.work.mapper;

import java.util.List;

import kr.or.ddit.company.work.vo.weekWorkStatusVO;
import kr.or.ddit.company.workform.vo.WorkFormVO;
import kr.or.ddit.employee.workStatus.vo.EmpWorkStatusVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.work.vo.searchWeekWorkStatusVO;

public interface IComWorkMapper {

	public List<weekWorkStatusVO> getWeekWorkStatus(searchWeekWorkStatusVO searchVO);

	public int getWeekWorkStatusCount(PaginationInfoVO<searchWeekWorkStatusVO> pagingVO);

	public WorkFormVO chkDeptWorkForm(EmployeeVO empVO);

	public int empListCount(PaginationInfoVO<EmployeeVO> pagingVO);

	public List<EmpWorkStatusVO> getEwsList(EmpWorkStatusVO ewsVO);

}

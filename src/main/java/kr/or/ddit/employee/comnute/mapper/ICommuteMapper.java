package kr.or.ddit.employee.comnute.mapper;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.work.vo.workStatusVO;
import kr.or.ddit.company.workform.vo.WorkFormVO;

public interface ICommuteMapper {

	public int getLateCnt(EmployeeVO empVO);

	public int getAbsenceCnt(EmployeeVO empVO);

	public int remainVctCnt(EmployeeVO empVO);

	public int gettotalVctCnt(EmployeeVO empVO);

	public int getuseVctCnt(EmployeeVO empVO);

	public long getWorkTime(EmployeeVO empVO);

	public long getWorkCnt(EmployeeVO empVO);

	public WorkFormVO getdeptWorkSettingTm(EmployeeVO empVO);

	public WorkFormVO getComWorkSettingTm(EmployeeVO empVO);

	public workStatusVO getWorkStatus(EmployeeVO empVO);

}

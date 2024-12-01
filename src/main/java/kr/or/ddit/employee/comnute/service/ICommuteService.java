package kr.or.ddit.employee.comnute.service;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.work.vo.workStatusVO;
import kr.or.ddit.company.workform.vo.WorkFormVO;

public interface ICommuteService {

	public int getLateCnt(EmployeeVO empVO);

	public int getAbsenceCnt(EmployeeVO empVO);

	public int gettotalVctCnt(EmployeeVO empVO);

	public int getuseVctCnt(EmployeeVO empVO);

	public long getWorkTime(EmployeeVO empVO);

	public long getWorkCnt(EmployeeVO empVO);

	public WorkFormVO getworkSettingTm(EmployeeVO empVO);

	public workStatusVO getWorkStatus(EmployeeVO empVO);

}

package kr.or.ddit.employee.workStatus.mapper;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.employee.workStatus.vo.EmpWorkStatusVO;

public interface IEmpWorkStatusMapper {

	public EmpWorkStatusVO getTodayWorkStatus(EmployeeVO empVO);

	public int startWork(EmpWorkStatusVO worksttsVO);

	public int stopWork(EmpWorkStatusVO worksttsVO);

	public EmpWorkStatusVO startWorkChk(EmployeeVO empVO);

	public int chkworksttsVO(EmployeeVO empVO);

}

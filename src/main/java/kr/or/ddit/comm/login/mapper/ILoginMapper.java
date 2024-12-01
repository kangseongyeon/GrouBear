package kr.or.ddit.comm.login.mapper;

import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.EmployeeAuthVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;

public interface ILoginMapper {

	public EmployeeVO readByUserId(String username);

	public EmployeeVO loginCheck(EmployeeVO member);

	public EmployeeVO idchk(EmployeeVO employeeVO);

	public int brNoChk(CompanyVO comVO);

	public void insertEmployee(EmployeeVO empVO);

	public void insertAuth(EmployeeAuthVO authVO);
	

	
}

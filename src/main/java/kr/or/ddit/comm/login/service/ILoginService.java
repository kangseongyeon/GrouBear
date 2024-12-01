package kr.or.ddit.comm.login.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.EmployeeAuthVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;

public interface ILoginService {

	public EmployeeVO loginCheck(EmployeeVO member);

	public EmployeeVO idchk(EmployeeVO employeeVO);

	public int brNoChk(CompanyVO comVO);

	public void insertEmployee(EmployeeVO empVO);

	public void insertAuth(EmployeeAuthVO authVO);


	

}

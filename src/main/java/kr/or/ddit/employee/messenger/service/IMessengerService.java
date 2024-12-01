package kr.or.ddit.employee.messenger.service;

import java.util.List;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.employee.messenger.vo.MessengerVO;

public interface IMessengerService {

	public List<MessengerVO> MessengerMain(EmployeeVO employeeVO);

}

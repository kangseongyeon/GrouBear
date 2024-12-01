package kr.or.ddit.employee.messenger.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.employee.messenger.mapper.IMessengerMapper;
import kr.or.ddit.employee.messenger.service.IMessengerService;
import kr.or.ddit.employee.messenger.vo.MessengerVO;

@Service
public class MessengerServiceImpl implements IMessengerService {
	
	@Inject
	private IMessengerMapper msgMapper;

	@Override
	public List<MessengerVO> MessengerMain(EmployeeVO employeeVO) {
		return msgMapper.MessengerMain(employeeVO);
	}

}

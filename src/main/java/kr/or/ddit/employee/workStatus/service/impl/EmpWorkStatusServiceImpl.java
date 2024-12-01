package kr.or.ddit.employee.workStatus.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.work.vo.workStatusVO;
import kr.or.ddit.employee.workStatus.mapper.IEmpWorkStatusMapper;
import kr.or.ddit.employee.workStatus.service.IEmpWorkStatusService;
import kr.or.ddit.employee.workStatus.vo.EmpWorkStatusVO;

@Service
public class EmpWorkStatusServiceImpl implements IEmpWorkStatusService {

	@Inject
	private IEmpWorkStatusMapper mapper;
	
	@Override
	public EmpWorkStatusVO getTodayWorkStatus(EmployeeVO empVO) {
		return mapper.getTodayWorkStatus(empVO);
	}

	@Override
	public int startWork(EmpWorkStatusVO worksttsVO) {
		return mapper.startWork(worksttsVO);
	}

	@Override
	public int stopWork(EmpWorkStatusVO worksttsVO) {
		return mapper.stopWork(worksttsVO);
	}

	@Override
	public EmpWorkStatusVO startWorkChk(EmployeeVO empVO) {
		return mapper.startWorkChk(empVO);
	}

	@Override
	public int chkworksttsVO(EmployeeVO empVO) {
		return mapper.chkworksttsVO(empVO);
	}

}

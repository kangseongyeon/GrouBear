package kr.or.ddit.employee.comnute.service.Impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.work.vo.workStatusVO;
import kr.or.ddit.company.workform.vo.WorkFormVO;
import kr.or.ddit.employee.comnute.mapper.ICommuteMapper;
import kr.or.ddit.employee.comnute.service.ICommuteService;

@Service
public class CommuteService implements ICommuteService{

	@Inject
	private ICommuteMapper commuteMapper;
	
	@Override
	public int getLateCnt(EmployeeVO empVO) {
		
		return commuteMapper.getLateCnt(empVO);
	}

	@Override
	public int getAbsenceCnt(EmployeeVO empVO) {
		return commuteMapper.getAbsenceCnt(empVO);
	}

	@Override
	public int gettotalVctCnt(EmployeeVO empVO) {
		return commuteMapper.gettotalVctCnt(empVO);
	}

	@Override
	public int getuseVctCnt(EmployeeVO empVO) {
		return commuteMapper.getuseVctCnt(empVO);
	}

	@Override
	public long getWorkTime(EmployeeVO empVO) {
		return commuteMapper.getWorkTime(empVO);
	}

	@Override
	public long getWorkCnt(EmployeeVO empVO) {
		return commuteMapper.getWorkCnt(empVO);
	}

	@Override
	public WorkFormVO getworkSettingTm(EmployeeVO empVO) throws NullPointerException {
		WorkFormVO wfVO = commuteMapper.getdeptWorkSettingTm(empVO);
		if(wfVO == null) {
			wfVO = commuteMapper.getComWorkSettingTm(empVO);
		}
			return wfVO;
		
	}

	@Override
	public workStatusVO getWorkStatus(EmployeeVO empVO) {
		return commuteMapper.getWorkStatus(empVO);
	}

}

package kr.or.ddit.comm.findempinfo.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.findempinfo.mapper.IFindEmpInfoMapper;
import kr.or.ddit.comm.findempinfo.service.IFindEmpInfoService;
import kr.or.ddit.comm.findempinfo.vo.MailAuthVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;

@Service
public class FindEmpInfoServiceImpl implements IFindEmpInfoService{

	@Inject
	private IFindEmpInfoMapper IFindEmpInfoMapper;
	
	@Override
	public String findId(EmployeeVO empVO) {
		return IFindEmpInfoMapper.findId(empVO);
	}

	@Override
	public String findemail(EmployeeVO empVO) {
		return IFindEmpInfoMapper.findemail(empVO);
	}

	@Override
	public int insertAuthNum(MailAuthVO mailAuthVO) {
		return IFindEmpInfoMapper.insertAuthNum(mailAuthVO);
	}

	@Override
	public int getAuthNum(MailAuthVO mailAuthVO) {
		return IFindEmpInfoMapper.getAuthNum(mailAuthVO);
	}

	@Override
	public int delAuthNum(MailAuthVO mailAuthVO) {
		return IFindEmpInfoMapper.delAuthNum(mailAuthVO);
	}

	@Override
	public int changePw(EmployeeVO empVO) {
		return IFindEmpInfoMapper.changepw(empVO);
	}


}

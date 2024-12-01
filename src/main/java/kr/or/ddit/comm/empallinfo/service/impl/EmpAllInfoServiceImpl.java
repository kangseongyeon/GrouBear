package kr.or.ddit.comm.empallinfo.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.empallinfo.mapper.IEmpAllInfoMapper;
import kr.or.ddit.comm.empallinfo.service.IEmpAllInfoService;
import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;

@Service
public class EmpAllInfoServiceImpl implements IEmpAllInfoService {

	@Inject
	private IEmpAllInfoMapper empAllInfoMapper;

	// 사원 정보 가져오기 (회사정보, 사원정보, 부서정보, 팀정보, 권한 등)
	@Override
	public EmployeeAllVO selectEmpImpl(EmployeeVO employeeVO) {
		return empAllInfoMapper.selectEmpImpl(employeeVO);
	}

	// 소속 기업의 기업 관리자 정보 가져오기
	@Override
	public EmployeeAllVO selectComManagerEmpImpl(String coCd) {
		return empAllInfoMapper.selectComManagerEmpImpl(coCd);
	}
	
	
	@Override
	public List<EmployeeAllVO> selectGroubearEmpList() {
		return empAllInfoMapper.selectGroubearEmpList();
	}
	
}

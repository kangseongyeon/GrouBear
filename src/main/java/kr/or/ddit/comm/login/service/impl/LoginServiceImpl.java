package kr.or.ddit.comm.login.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.comm.login.mapper.ILoginMapper;
import kr.or.ddit.comm.login.service.ILoginService;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.EmployeeAuthVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;

@Service
public class LoginServiceImpl implements ILoginService {

	@Inject
	private PasswordEncoder pe;
	
	@Inject
	private ILoginMapper loginMapper;
	
	@Override
	public EmployeeVO loginCheck(EmployeeVO member) {
		return loginMapper.loginCheck(member);
	}

	@Override
	public EmployeeVO idchk(EmployeeVO employeeVO) {
		return loginMapper.idchk(employeeVO);
	}

	@Override
	public int brNoChk(CompanyVO comVO) {
		return loginMapper.brNoChk(comVO);
	}

	@Override
	public void insertEmployee(EmployeeVO empVO) {
		loginMapper.insertEmployee(empVO);
		
	}

	@Override
	public void insertAuth(EmployeeAuthVO authVO) {
		loginMapper.insertAuth(authVO);
		
	}

	

	

}

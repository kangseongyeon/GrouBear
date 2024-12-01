package kr.or.ddit.comm.security.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.comm.login.mapper.ILoginMapper;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.personnelInformation.mapper.IInformationMapper;
import kr.or.ddit.company.personnelInformation.vo.DepartmentMenuVO;

public class CustomUserDetailsService implements UserDetailsService{

	private static final Logger log = LoggerFactory.getLogger(CustomUserDetailsService.class);
	
	@Inject
	private ILoginMapper loginMapper;
	
	@Inject
	private IInformationMapper infoMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
	    log.info("# CustomUserDetailsService : loadUserByUsername : " + username);
	    
	    try {
	        EmployeeVO member = loginMapper.readByUserId(username);
	        if (member != null) {
	            // 부서별 메뉴를 가져오는 로직 추가
	            List<DepartmentMenuVO> departmentMenuList = infoMapper.getSidebar(member.getDeptCd());
	            return new CustomUser(member, departmentMenuList); // 두 번째 생성자를 호출해야 함
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return null;
	}

}

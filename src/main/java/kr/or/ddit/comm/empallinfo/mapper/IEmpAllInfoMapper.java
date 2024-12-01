package kr.or.ddit.comm.empallinfo.mapper;

import java.util.List;

import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;

public interface IEmpAllInfoMapper {

	/**
	 * 사원 정보 가져오기 (회사정보, 사원정보, 부서정보, 팀정보, 권한 등)
	 * @param employeeVO
	 * @return
	 */
	public EmployeeAllVO selectEmpImpl(EmployeeVO employeeVO);

	/**
	 * 소속 기업의 기업 관리자 정보 가져오기
	 * @param coCd
	 * @return
	 */
	public EmployeeAllVO selectComManagerEmpImpl(String coCd);
	
	/**
	 * 그룹웨어 관리자 리스트 가져오기
	 * @return
	 */
	public List<EmployeeAllVO> selectGroubearEmpList();
	
}

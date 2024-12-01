package kr.or.ddit.comm.tiles.mapper;

import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;

public interface ITilesMapper {

	public DepartmentVO getEpmt(EmployeeVO empVO);

	public TeamVO getTeam(EmployeeVO empVO);

	public CompanyVO getCompany(EmployeeVO empVO);

}

package kr.or.ddit.comm.tiles.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.tiles.mapper.ITilesMapper;
import kr.or.ddit.comm.tiles.service.ITIlesService;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import kr.or.ddit.company.personnelInformation.vo.TeamVO;


@Service
public class TilesService implements ITIlesService{

	@Inject
	private ITilesMapper tilesMapper;
	
	@Override
	public DepartmentVO getEpmt(EmployeeVO empVO) {
		return tilesMapper.getEpmt(empVO);
	}

	@Override
	public TeamVO getTeam(EmployeeVO empVO) {
		return tilesMapper.getTeam(empVO);
	}

	@Override
	public CompanyVO getCompany(EmployeeVO empVO) {
		return tilesMapper.getCompany(empVO);
	}

}

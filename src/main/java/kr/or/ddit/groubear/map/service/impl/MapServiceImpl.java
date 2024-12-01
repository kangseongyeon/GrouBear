package kr.or.ddit.groubear.map.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.alarm.vo.AlarmVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.groubear.map.mapper.IMapMapper;
import kr.or.ddit.groubear.map.service.IMapService;
import kr.or.ddit.groubear.map.vo.MapVO;

@Service
public class MapServiceImpl implements IMapService {
	
	@Inject
	private IMapMapper mapMapper;

	@Override
	public List<CompanyVO> mapList(CompanyVO companyVO) {
		return mapMapper.mapList(companyVO);
	}

	@Override
	public List<MapVO> mapLocation(MapVO mapVO) {
		return mapMapper.mapLocation(mapVO);
	}

	@Override
	public int countList(PaginationInfoVO<CompanyVO> pagingVO) {
		return mapMapper.countList(pagingVO);
	}

	@Override
	public List<CompanyVO> mapList(PaginationInfoVO<CompanyVO> pagingVO) {
		return mapMapper.mapList(pagingVO);
	}

	@Override
	public CompanyVO comMapSelectOne(String coCd) {
		return mapMapper.comMapSelectOne(coCd);
	}


}

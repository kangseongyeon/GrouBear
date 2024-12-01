package kr.or.ddit.groubear.map.service;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.groubear.map.vo.MapVO;

public interface IMapService {

	public List<CompanyVO> mapList(CompanyVO companyVO);

	public List<MapVO> mapLocation(MapVO mapVO);

	public int countList(PaginationInfoVO<CompanyVO> pagingVO);

	public List<CompanyVO> mapList(PaginationInfoVO<CompanyVO> pagingVO);

	/**
	 * 소속된 회사의 경도와 위도 좌표 위치 가져오기
	 * @param coCd
	 * @return
	 */
	public CompanyVO comMapSelectOne(String coCd);

}

package kr.or.ddit.company.facilities.service.Impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.facilities.mapper.IFacilititesCategoryMapper;
import kr.or.ddit.company.facilities.service.IFacilititesCategoryService;
import kr.or.ddit.company.facilities.vo.FacilityCategoryVO;

@Service
public class FacilititesCategoryService implements IFacilititesCategoryService {

	@Inject
	private IFacilititesCategoryMapper fcltCtgrMapper;
	
	@Override
	public int insertCtgr(FacilityCategoryVO fcltCtgrVO) {
		return fcltCtgrMapper.insertCtgr(fcltCtgrVO);
	}

	@Override
	public List<FacilityCategoryVO> getCategoryList(EmployeeVO empVO) {
		return fcltCtgrMapper.getCategoryList(empVO);
	}

	@Override
	public void changeCateTurn(FacilityCategoryVO fcltctgrVO) {
		fcltCtgrMapper.changeCateTurn(fcltctgrVO);
	}

	@Override
	public FacilityCategoryVO getCtgrInfo(FacilityCategoryVO fcltCtgrVO) {
		return fcltCtgrMapper.getCtgrInfo(fcltCtgrVO);
	}

	@Override
	public int ctgrModify(FacilityCategoryVO fcltCtgrVO) {
		return fcltCtgrMapper.ctgrModify(fcltCtgrVO);
	}

	@Override
	public int delCategory(FacilityCategoryVO fcltCtgrVO) {
		return fcltCtgrMapper.delCategory(fcltCtgrVO);
	}
	
}

package kr.or.ddit.company.facilities.mapper;

import java.util.List;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.facilities.vo.FacilityCategoryVO;

public interface IFacilititesCategoryMapper {

	public int insertCtgr(FacilityCategoryVO fcltCtgrVO);

	public List<FacilityCategoryVO> getCategoryList(EmployeeVO empVO);

	public void changeCateTurn(FacilityCategoryVO fcltctgrVO);

	public FacilityCategoryVO getCtgrInfo(FacilityCategoryVO fcltCtgrVO);

	public int ctgrModify(FacilityCategoryVO fcltCtgrVO);

	public int delCategory(FacilityCategoryVO fcltCtgrVO);

}

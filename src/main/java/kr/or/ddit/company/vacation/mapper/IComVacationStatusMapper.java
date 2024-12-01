package kr.or.ddit.company.vacation.mapper;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.company.vacation.vo.VacationStatusVO;

public interface IComVacationStatusMapper {

	public List<VacationStatusVO> getAllVctSttsList(String coCd);

	public List<VacationStatusVO> getPagingVctSttsList(PaginationInfoVO<VacationStatusVO> pagingVO);

	public int getPagingVctSttsCount(PaginationInfoVO<VacationStatusVO> pagingVO);

}

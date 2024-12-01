package kr.or.ddit.company.vacation.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.company.vacation.mapper.IComVacationStatusMapper;
import kr.or.ddit.company.vacation.service.IComVacationStatusSerivce;
import kr.or.ddit.company.vacation.vo.VacationStatusVO;

@Service
public class ComVacationStatusServiceImpl implements IComVacationStatusSerivce{

	@Inject
	private IComVacationStatusMapper vctSttsMapper;
	
	@Override
	public List<VacationStatusVO> getAllVctSttsList(String coCd) {
		return vctSttsMapper.getAllVctSttsList(coCd);
	}

	@Override
	public List<VacationStatusVO> getPagingVctSttsList(PaginationInfoVO<VacationStatusVO> pagingVO) {
		return vctSttsMapper.getPagingVctSttsList(pagingVO);
	}

	@Override
	public int getPagingVctSttsCount(PaginationInfoVO<VacationStatusVO> pagingVO) {
		return vctSttsMapper.getPagingVctSttsCount(pagingVO);
	}
	
}

package kr.or.ddit.company.vacation.service;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.vacation.vo.VacationStatusVO;
import kr.or.ddit.company.vacation.vo.YearVctVO;

public interface IComVacationStatusSerivce {

	public List<VacationStatusVO> getAllVctSttsList(String coCd);

	public List<VacationStatusVO> getPagingVctSttsList(PaginationInfoVO<VacationStatusVO> pagingVO);

	public int getPagingVctSttsCount(PaginationInfoVO<VacationStatusVO> pagingVO);


}

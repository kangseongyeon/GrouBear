package kr.or.ddit.company.work.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.work.mapper.IComWorkMapper;
import kr.or.ddit.company.work.service.IComWorkService;
import kr.or.ddit.company.work.vo.weekWorkStatusVO;
import kr.or.ddit.company.workform.vo.WorkFormVO;
import kr.or.ddit.employee.workStatus.vo.EmpWorkStatusVO;
import kr.or.ddit.company.work.vo.searchWeekWorkStatusVO;


@Service
public class ComWorkServiceImpl implements IComWorkService {

	@Inject
	IComWorkMapper mapper;
	
	@Override
	public List<weekWorkStatusVO> getWeekWorkStatus(searchWeekWorkStatusVO searchVO) {
		return mapper.getWeekWorkStatus(searchVO);
	}

	@Override
	public int getWeekWorkStatusCount(PaginationInfoVO<searchWeekWorkStatusVO> pagingVO) {
		return mapper.getWeekWorkStatusCount(pagingVO);
	}

	@Override
	public WorkFormVO chkDeptWorkForm(EmployeeVO empVO) {
		return mapper.chkDeptWorkForm(empVO);
	}

	@Override
	public int empListCount(PaginationInfoVO<EmployeeVO> pagingVO) {
		return mapper.empListCount(pagingVO);
	}

	@Override
	public List<EmpWorkStatusVO> getEwsList(EmpWorkStatusVO ewsVO) {
		return mapper.getEwsList(ewsVO);
	}


}

package kr.or.ddit.company.companyLog.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.companyLog.mapper.ICompanyLogMapper;
import kr.or.ddit.company.companyLog.service.ICompanyLogService;
import kr.or.ddit.groubear.log.vo.LogVO;

@Service
public class CompanyLogServiceImpl implements ICompanyLogService{

	@Inject
	private ICompanyLogMapper mapper;

	@Override
	public List<LogVO> getcompanyLog(PaginationInfoVO<LogVO> pagingVO) {
		return mapper.getcompanyLog(pagingVO);
	}

	@Override
	public int selectCompanyLog(EmployeeVO empVO) {
		return mapper.selectCompanyLog(empVO);
	}


	
	
	
	
}

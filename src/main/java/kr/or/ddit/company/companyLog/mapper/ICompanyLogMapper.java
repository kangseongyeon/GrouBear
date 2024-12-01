package kr.or.ddit.company.companyLog.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.groubear.log.vo.LogVO;

public interface ICompanyLogMapper {

	public List<LogVO> getcompanyLog(PaginationInfoVO<LogVO> pagingVO);

	public int selectCompanyLog(EmployeeVO empVO);

}

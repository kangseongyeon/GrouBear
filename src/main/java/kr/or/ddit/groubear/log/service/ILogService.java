package kr.or.ddit.groubear.log.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.groubear.log.vo.LogVO;

public interface ILogService {

	public void insert(LogVO logVO);
	public void loginInsert(HttpServletRequest request);
	public int selectLog(PaginationInfoVO<LogVO> pagingVO);
	public List<LogVO> selectLogList(PaginationInfoVO<LogVO> pagingVO);
	

}

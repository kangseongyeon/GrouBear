package kr.or.ddit.groubear.log.mapper;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.groubear.log.vo.LogVO;

public interface ILogMapper {

	public void insert(LogVO logVO);


	public int selectLogCount(PaginationInfoVO<LogVO> pagingVO);
	public List<LogVO> selectLogList(PaginationInfoVO<LogVO> pagingVO);


	public int selectLogCountByDateRange(PaginationInfoVO<LogVO> pagingVO);

	public List<LogVO> selectLogListByDateRange(PaginationInfoVO<LogVO> pagingVO);

}

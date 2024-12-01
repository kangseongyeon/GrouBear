package kr.or.ddit.groubear.stats.mapper;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.groubear.stats.vo.StatsVO;

public interface IStatsMapper {

	public List<StatsVO> getMonthlyData();

	public List<StatsVO> getYearlyData();

	public List<StatsVO> getMothlyEmp();

	public List<StatsVO> getYearlyEmp();

	public List<StatsVO> getComInfo(PaginationInfoVO<StatsVO> pagingVO);

	public StatsVO comDetail(StatsVO statsVO);

	public int selectCocd(PaginationInfoVO<StatsVO> pagingVO);

	public List<StatsVO> comOfEmp(StatsVO statsEmpVO);

	public List<StatsVO> getnumOfMem();

	public List<StatsVO> getpremium();

	public List<StatsVO> getnumOfMon();

	public List<StatsVO> getMothlyCom();

	public List<StatsVO> getYearlyCom();

	public List<StatsVO> getCountInfo();

}

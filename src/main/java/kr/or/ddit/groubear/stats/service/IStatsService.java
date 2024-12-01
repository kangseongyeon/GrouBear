package kr.or.ddit.groubear.stats.service;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.groubear.stats.vo.StatsVO;

public interface IStatsService {

	/**
	 * 월간매출
	 * @return
	 */
	public List<StatsVO> getMonthlyData();

	/**
	 * 연간매출
	 * @return
	 */
	public List<StatsVO> getYearlyData();

	/**
	 * 월간사원
	 * @return
	 */
	public List<StatsVO> getMothlyEmp();

	/**
	 * 연간사원
	 * @return
	 */
	public List<StatsVO> getYearlyEmp();

	/**
	 * 기업정보
	 * @param pagingVO 
	 * @return
	 */
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

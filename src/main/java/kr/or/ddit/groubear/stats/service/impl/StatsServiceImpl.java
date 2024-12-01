package kr.or.ddit.groubear.stats.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.groubear.stats.mapper.IStatsMapper;
import kr.or.ddit.groubear.stats.service.IStatsService;
import kr.or.ddit.groubear.stats.vo.StatsVO;

@Service
public class StatsServiceImpl implements IStatsService{

	@Inject
	private IStatsMapper statsMapper;

	@Override
	public List<StatsVO> getMonthlyData() {
		return statsMapper.getMonthlyData();
	}

	@Override
	public List<StatsVO> getYearlyData() {
		return statsMapper.getYearlyData();
	}

	@Override
	public List<StatsVO> getMothlyEmp() {
		return statsMapper.getMothlyEmp();
	}

	@Override
	public List<StatsVO> getYearlyEmp() {
		return statsMapper.getYearlyEmp();
	}

	@Override
	public StatsVO comDetail(StatsVO statsVO) {
		return statsMapper.comDetail(statsVO);
	}

	@Override
	public List<StatsVO> getComInfo(PaginationInfoVO<StatsVO> pagingVO) {
		return statsMapper.getComInfo(pagingVO);
	}

	@Override
	public int selectCocd(PaginationInfoVO<StatsVO> pagingVO) {
		return statsMapper.selectCocd(pagingVO);
	}

	@Override
	public List<StatsVO> comOfEmp(StatsVO statsEmpVO) {
		return statsMapper.comOfEmp(statsEmpVO);
	}

	@Override
	public List<StatsVO> getnumOfMem() {
		return statsMapper.getnumOfMem();
	}

	@Override
	public List<StatsVO> getpremium() {
		return statsMapper.getpremium();
	}

	@Override
	public List<StatsVO> getnumOfMon() {
		return statsMapper.getnumOfMon();
	}

	@Override
	public List<StatsVO> getMothlyCom() {
		return statsMapper.getMothlyCom();
	}

	@Override
	public List<StatsVO> getYearlyCom() {
		return statsMapper.getYearlyCom();
	}

	@Override
	public List<StatsVO> getCountInfo() {
		return statsMapper.getCountInfo();
	}

	


	

}

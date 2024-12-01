package kr.or.ddit.comm.alarm.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.alarm.mapper.IAlarmMapper;
import kr.or.ddit.comm.alarm.service.IAlarmService;
import kr.or.ddit.comm.alarm.vo.AlarmVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;

@Service
public class AlarmServiceImpl implements IAlarmService{

	@Inject
	private IAlarmMapper mapper;

	@Override
	public List<AlarmVO> selectList(AlarmVO alarmVO) {
		return mapper.selectList(alarmVO);
	}

	@Override
	public void insertAlarm(AlarmVO alarmVO) {
		mapper.insertAlarm(alarmVO);
	}

	@Override
	public int countList(PaginationInfoVO<AlarmVO> pagingVO) {
		return mapper.countList(pagingVO);
	}

	@Override
	public int alarmRemove(int alarmNo) {
		return mapper.alarmRemove(alarmNo);
	}

	@Override
	public List<AlarmVO> alarmList(PaginationInfoVO<AlarmVO> pagingVO) {
		return mapper.alarmList(pagingVO);
	}

	@Override
	public void alarmRead(int alarmNo) {
		mapper.alarmRead(alarmNo);
	}
	
}

package kr.or.ddit.comm.alarm.service;

import java.util.List;

import kr.or.ddit.comm.alarm.vo.AlarmVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;

public interface IAlarmService {

	public List<AlarmVO> selectList(AlarmVO alarmVO);

	public void insertAlarm(AlarmVO alarmVO);

	public int countList(PaginationInfoVO<AlarmVO> pagingVO);

	public int alarmRemove(int alarmNo);

	public List<AlarmVO> alarmList(PaginationInfoVO<AlarmVO> pagingVO);

	public void alarmRead(int alarmNo);

}

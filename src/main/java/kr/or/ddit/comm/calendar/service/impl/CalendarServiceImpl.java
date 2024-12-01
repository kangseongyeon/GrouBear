package kr.or.ddit.comm.calendar.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.calendar.mapper.ICalendarMapper;
import kr.or.ddit.comm.calendar.service.ICalendarService;
import kr.or.ddit.comm.calendar.vo.CalendarVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;

@Service
public class CalendarServiceImpl implements ICalendarService {

	@Inject
	private ICalendarMapper calendarMapper;
	

	/**
	 * 캘린더 일정 리스트
	 */
	@Override
	public List<CalendarVO> calendarList(String empId) {
		return calendarMapper.calendarList(empId);
	}
	
	/**
	 * 캘린더 일정 추가
	 */
	@Override
	public ServiceResult calendarInsert(HttpServletRequest req, CalendarVO calendarVO) {
		ServiceResult result = null;
		int status = calendarMapper.calendarInsert(calendarVO);
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	/**
	 * 캘린더 일정 수정 폼
	 */
	@Override
	public CalendarVO selectCalendar(int calendarNo) {
		return calendarMapper.selectCalendar(calendarNo);
	}

	/**
	 * 캘린더 일정 수정
	 */
	@Override
	public ServiceResult calendarUpdate(HttpServletRequest req, CalendarVO calendarVO) {
		ServiceResult result = null;
		int status = calendarMapper.calendarUpdate(calendarVO);
		if(status > 0) {	// 수정 성공
			result = ServiceResult.OK;
		}else {	// 수정 실패
			result = ServiceResult.FAILED;
		}
		return result;
	}

	
	/**
	 * 캘린더 일정 삭제
	 */
	@Override
	public ServiceResult calendarDelete(HttpServletRequest req, int calendarNo) {
		ServiceResult result = null;
		
		int status = calendarMapper.calendarDelete(calendarNo);
		if(status > 0) {	// 수정 성공
			result = ServiceResult.OK;
		}else {	
			result = ServiceResult.FAILED;
		}
		return result;
	}

	/**
	 * 일정 드래그 시 날짜 업데이트
	 */
	@Override
	public ServiceResult updateCalendarDate(CalendarVO updateEvent) {
		ServiceResult result = null;
		int stauts = calendarMapper.updateCalendarDate(updateEvent);
		if (stauts > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}


}

package kr.or.ddit.comm.calendar.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.comm.calendar.vo.CalendarVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;

public interface ICalendarService {

	/**
	 * 캘린더 일정 리스트
	 * @param empId
	 * @return
	 */
	public List<CalendarVO> calendarList(String empId);

	
	/**
	 * 캘린더 일정 추가
	 * @param req
	 * @param calendarVO
	 * @return
	 */
	public ServiceResult calendarInsert(HttpServletRequest req, CalendarVO calendarVO);

	
	/**
	 * 캘린더 일정 수정 폼
	 * @param calendarNo
	 * @return
	 */
	public CalendarVO selectCalendar(int calendarNo);

	/**
	 * 캘린더 일정 수정
	 * @param req
	 * @param calendarVO
	 * @return
	 */
	public ServiceResult calendarUpdate(HttpServletRequest req, CalendarVO calendarVO);
	
	/**
	 * 캘린더 일정 삭제
	 * @param req
	 * @param calendarNo
	 * @return
	 */
	public ServiceResult calendarDelete(HttpServletRequest req, int calendarNo);

	/**
	 * 일정 드래그 시 날짜 업데이트
	 * @param updateEvent
	 * @return
	 */
	public ServiceResult updateCalendarDate(CalendarVO updateEvent);

}

package kr.or.ddit.comm.calendar.mapper;

import java.util.List;

import kr.or.ddit.comm.calendar.vo.CalendarVO;

public interface ICalendarMapper {
	
	/**
	 * 캘린더 일정 리스트
	 * @param empId
	 * @return
	 */
	public List<CalendarVO> calendarList(String empId);
	
	/**
	 * 캘린더 일정 추가
	 * @param calendarVO
	 * @return
	 */
	public int calendarInsert(CalendarVO calendarVO);

	/**
	 * 캘린더 일정 수정 폼
	 * @param calendarNo
	 * @return
	 */
	public CalendarVO selectCalendar(int calendarNo);

	/**
	 * 캘린더 일정 수정
	 * @param calendarVO
	 * @return
	 */
	public int calendarUpdate(CalendarVO calendarVO);
	
	/**
	 * 캘린더 일정 삭제
	 * @param calendarNo
	 * @return
	 */
	public int calendarDelete(int calendarNo);


	/**
	 * 일정 드래그 시 날짜 업데이트
	 * @param updateEvent
	 * @return
	 */
	public int updateCalendarDate(CalendarVO updateEvent);

}

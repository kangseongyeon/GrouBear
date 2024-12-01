package kr.or.ddit.comm.calendar.vo;

import lombok.Data;

@Data
public class CalendarVO {
	private int calendarNo;				// 일정번호
	private String calendarSeNo;		// 일정구분코드번호
	private String empId;				// 일정생성자
	private String coCd;				// 기업코드
	private String calendarNm;			// 일정명
	private String calendarBtgngDt;		// 일정생성일시
	private String calendarMdfcnDt;		// 일정수정일시
	private String calendarDt;			// 일정시작일시
	private String calendarEndDt;		// 일정마감일시
	private String calendarDaddr;		// 일정장소
	private String calendarCn;			// 일정내용
	private int calendarAlarmSetting;	// 일정알람
	private String calendarDelYn;		// 일정삭제
	private String calendarColrNm;		// 일정색깔
	private String calendarAlldayYn;	// 일정종일여부
	
	private String calendarStartTime;	// 일정시작시간
	private String calendarEndTime;		// 일정종료시간
	
}

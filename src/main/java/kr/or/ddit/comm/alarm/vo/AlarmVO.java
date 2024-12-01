package kr.or.ddit.comm.alarm.vo;

import java.util.List;

import lombok.Data;

@Data
public class AlarmVO {

	private int alarmNo;			// 알림구분번호 
	
	private String alarmTarget;		// 알림받은 사원아이디
	
	private int alarmCnt;			// 알림 수

	private String alarmCn;			// 알림 내용
	
	private String alarmCrtDt;		// 알림을 받은 시간
	
	private String alarmReadDt;		// 알림을 확인한 시간
	
	private String alarmYn;			// 알림 확인 여부
	
	private String alarmDelYn;		// 알림 삭제 여부
	
	private String alarmCategory;	// 알림 카테고리 구분
	
	private String alarmUrl;		// 알림 Url
	
	private List<AlarmVO> alarmList;
}

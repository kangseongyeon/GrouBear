package kr.or.ddit.company.work.vo;


import lombok.Data;

@Data
public class searchWeekWorkStatusVO {
	
	private String coCd;				// 기업 코드
	private String startDay; 			// 일주일 시작일 
	private String endDay; 				// 일주일 종료일 
	
}

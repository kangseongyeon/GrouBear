package kr.or.ddit.company.work.vo;

import lombok.Data;

@Data
public class workStatusVO {
	
	// 출근 정보 검색
	
	// 아이디
	// 사원명
	// 부서명
	// 팀명
	// 총 근무 일수
	// 출근 일수
	// 휴가 일수
	// 지각 일수
	// 결근 일수
	
	private String workSttsCd;
	private String empId;
	private String empNm;
	private String workSttsYmd;
	private String workBgngTm;
	private String workEndTm;
	private String workTm;
	private String workType;
	private String workRegDt;
	private String workMdfcnDt;
	private String workMdfcnRsn;
	private String deptNm;
	private String teamNm;

}

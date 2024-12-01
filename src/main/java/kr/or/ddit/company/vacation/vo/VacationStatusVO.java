package kr.or.ddit.company.vacation.vo;

import lombok.Data;

@Data
public class VacationStatusVO {
	private String empId;		// 사원 아이디
	private String empNm;		// 사원명
	private int vctTotalDayCnt;		// 총 휴가일
	private int vctCrtDayCnt; 		// 년도 휴가 생성일
	private int vctRmndDayCnt;		// 잔여 휴가일
	private int vctUseDayCnt;		// 사용 휴가일
	private String empJncmpYmd;		// 입사일
	private String deptNm;			// 부서명
	private String teamNm;			// 팀명
	private String jbgdNm;			// 직급명
	private String vctCnt;
}

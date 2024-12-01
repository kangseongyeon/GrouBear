package kr.or.ddit.employee.vacation.vo;

import lombok.Data;

@Data
public class VacationApplyVO {

	private String vctAplyCd;
	private String empId;
	private String vctRsn;
	private String vctBgngDt;
	private String vctEndDt;
	private String vctUseDayCnt;
	private String vctRegDt;
	private String vctRegUser;
	private String vctMdfcnDt;
	private String vctMdfcnUser;
	private String vctAprId;
	private String vctAprStts;
	private String vctAprDt;
	private String vctAplyAprStts;
	private String vctAplyAprReason;
	private String vctAplyAprYmd;
	private String empNm;
	private String deptNm;
	private String jbgdNm;
	private String teamNm;
	
}

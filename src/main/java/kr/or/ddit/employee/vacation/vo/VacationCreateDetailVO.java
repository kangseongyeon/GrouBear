package kr.or.ddit.employee.vacation.vo;

import lombok.Data;

@Data
public class VacationCreateDetailVO {

	private String vctCrtDetailCd;
	private String empId;
	private String vctCrtCnt;
	private String vctCrtYmd;
	private String empNm;
	private String deptNm;
	private String teamNm;
}

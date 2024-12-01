package kr.or.ddit.company.vacation.vo;

import lombok.Data;

@Data
public class VacationCreateVO {
	private String vctCrtDetailCd;
	private String empId;
	private int vctCrtCnt;
	private String vctCrtYmd;
}

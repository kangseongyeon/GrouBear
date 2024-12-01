package kr.or.ddit.employee.workStatus.vo;

import lombok.Data;

@Data
public class EmpWorkStatusVO {

	private String workSttsCd;
	private String coCd;
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

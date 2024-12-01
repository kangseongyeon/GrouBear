package kr.or.ddit.employee.provedoc.vo;

import lombok.Data;

@Data
public class EmpProvedocVO {
	private int prdocNo;
	private String prdocIsprEmpId;		// 증명서 발급자
	private String prdocAplyEmpId;		// 증명서 신청자
	private String prdocAplyDt;			// 증명서 신청일시
	private String prdocAprvYn;			// 증명서 신청상태
	private String prdocCn;				// 증명서 내용
	private String prdocIsprDt;			// 증명서 발급일시
	private String coCd;
	
	private String empNm;
	private String docFormNo;
	private String docFormNm;
	private String deptCo;
	private String deptNm;
	private String teamCo;
	private String teamNm;
	private String prdocInfoEmpId;
	
}

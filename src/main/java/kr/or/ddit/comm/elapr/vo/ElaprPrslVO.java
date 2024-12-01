package kr.or.ddit.comm.elapr.vo;

import lombok.Data;

@Data
public class ElaprPrslVO {
	private int elaprPrslNo;		// 열람번호
	private int elaprNo;			// 전자결재번호
	private String empId;			// 열람자아이디
	private String elaprPrslDt;		// 결재열람일시
	private String elaprPrslYn;		// 결재열람여부
	private String elaprPrslDelYn;	// 열람자삭제여부
	


	private String docFormNm;		// 전자결재양식제목
	private String empNm;			// 기안자이름
	private String jbgdNm;			// 직급명
	private String imgFileUrl;		// 프로필이미지
	private String deptNm;			// 부서명
}

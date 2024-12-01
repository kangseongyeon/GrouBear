package kr.or.ddit.comm.elapr.vo;

import lombok.Data;

@Data
public class RerncVO {
	private int rerncNo;		// 참조자번호
	private int elaprNo;		// 전자결재번호
	private String empId;		// 참조자아이디
	private String rerncDelYn;	// 참조자삭제여부
	

	private String docFormNm;		// 전자결재양식제목
	private String empNm;			// 기안자이름
	private String jbgdNm;			// 직급명
	private String imgFileUrl;		// 프로필이미지
	private String deptNm;			// 부서명
	
}

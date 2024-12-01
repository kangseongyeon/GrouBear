package kr.or.ddit.comm.elapr.vo;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.personnelInformation.vo.DepartmentVO;
import lombok.Data;

@Data
public class AplnVO {
	private int aplnNo;				// 결재라인 번호
	private int elaprNo;			// 전자결재 번호
	private String empId;			// 결재자 아이디
	private int aplnSeq;			// 결재순서
	private String aplnSttsCd;		// 결재상태코드
	private String aplnDt;			// 결재일시
	private String aplnLastId;		// 최종승인자
	private String aplnLastYn;		// 최종승인여부
	private String aplnRjctRsn;		// 결재반려사유
	private String aplnRealId;		// 실결재자 아이디
	private String aplnDelYn;		// 결재자삭제여부
	private String aplnOpninCn;		// 결재자결재의견
	

	private String docFormNm;		// 전자결재양식제목
	private String empNm;			// 기안자이름
	private String jbgdNm;			// 직급명
	private String imgFileUrl;		// 프로필이미지
	private String deptNm;			// 부서명
	
	
	private EmployeeVO employeeVO;  // 결재자 정보
	private DepartmentVO departmentVO;  // 부서 정보
}

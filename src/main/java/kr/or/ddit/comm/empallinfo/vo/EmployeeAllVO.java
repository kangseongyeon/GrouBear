package kr.or.ddit.comm.empallinfo.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.comm.security.vo.EmployeeAuthVO;
import kr.or.ddit.company.personnelInformation.vo.DepartmentMenuVO;
import lombok.Data;

@Data
public class EmployeeAllVO {

	private String empId;
	private String coCd;
	private String deptCd;
	private String jbgdCd;
	private String empPw;
	private String empEmlAddr;
	private String empNm;
	private long empNo;
	private int empZip;
	private String empAddr;
	private String empDaddr;
	private String empTelno;
	private String empBrdt;
	private String empGndr;
	private String empNtn;
	private String empJncmpYmd;
	private String empRsgntnYmd;
	private String empCrtYmd;
	private String empMdfcnYmd;
	private String empDelYn;
	private String empAprvYn;
	private int enabled;
	private String empDlnYn;
	private String imgFileUrl;
	private String teamCd;
	
	private MultipartFile imgFile;		// 프로필 이미지 파일을 받을 때 사용
	
	private String deptNm;
	private String deptCrtDt;
	private String deptActvtnYn;
	private String deptImgFileUrl;
	
	private MultipartFile deptImgFile;

	private String teamNm;
	private String teamCrtDt;
	private String teamActvtnYn;
	
	private String coNm;
	private String coRegDt;
	private int coCnt;
	private String coBrno;
	private String ceoNm;
	private int coZip;
	private String coAddr;
	private String coDaddr;
	private String coTel; 
	
	private String currentDt; 
	
	// JobGradeVO 필드
	private String jbgdNm;
	private String jbgdCrtDt;
	private String jbgdActvtnYn;
	private int jbgdAuthPrord;
	
	// 권한 정보
	private int authrityNo;
	private String authrityNm;

	private int elaprNo;			// 전자결재번호
	private int docFormNo;			// 전자결재양식
	private String atchFileCode;	// 첨부파일코드
	private String elaprNm;			// 전자결재제목
	private String elaprCn;			// 전자결재내용
	private String elaprBgngDt;		// 전자결재등록일시
	private String elaprMdfcnDt;	// 전자결재수정일시
	private String elaprEndDt;		// 전자결재마감일시
	private String elaprSttsCd;		// 전자결재진행상태
	private String elaprDelYn;		// 전자결재삭제여부
	private String elaprEmrgYn;		// 전자결재긴급여부
	private String elaprOpnnCn;		// 기안자의견
	
	List<EmployeeAuthVO> authList;
	List<DepartmentMenuVO> menuList;	// 로그인한 사용자의 메뉴 목록
}

package kr.or.ddit.comm.security.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.company.personnelInformation.vo.DepartmentMenuVO;
import lombok.Data;

@Data
public class EmployeeVO {

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
	
	private String deptNm;
	private String teamNm;
	private String jbgdNm;
	private String coNm;
	
	private MultipartFile imgFile;		// 프로필 이미지 파일을 받을 때 사용
	List<EmployeeAuthVO> authList;
	List<DepartmentMenuVO> menuList;	// 로그인한 사용자의 메뉴 목록
}


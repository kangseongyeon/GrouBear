package kr.or.ddit.groubear.stats.vo;

import java.time.LocalDate;

import lombok.Data;

@Data
public class StatsVO {
	
	// 결제정보
	private String rglStlmNo;		// 결제정보
	private String gdsNm;			// 상품명
	private String empId;			// 구매자
	private String rglStlmDt;		// 정기결제일
	private String rglStlmBgngYmd;	// 결제시작일
	private String rglStlmEndYmd;	// 결제종료일
	private String rglStlmStplPrd;	// 약정기간
	private String rglStlmNope;		// 인원수
	private String rglStlmPrc;		// 결제금액
	
	// company
	private String coCd;
	private LocalDate coRegDt;
	private String coBrno;
	private String ceoNm;
	private int coZip;
	private String coAddr;
	private String coDaddr;
	private String coTel;
	private String ceoId;
	
	
	// EmployeeVO
	private String deptCd;
	private String jbgdCd;
	private String empPw;
	private String empEmlAddr;
	private String empNm;
	private int empNo;
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
	
	
	private String coNm;
	private String empCnt; 		// 회사당 사원수
	private String coCnt;		// 회사당 계약사원수
	
	// 통계 사용
	private String month;
	private String year;  
	private String joinMonth;
	private String joinYear;
	private String comMonth;
	private String comYear;
	
	private String employeeCount;
	private String companyCount;
	private String totalPayment;

	
	private String chartData;
	private String categories;
	private String comEmpCnt;
	
	// 통계사용
	// 구성원수
	private String fiftyPeople;
	private String hundredPeople;
	private String hundredPeopleHalf;
	private String twoHundredPeople;
	private String twoHundredPeopleHalf;
	private String totalPeople;

	// 프리미엄
	private String premium;
	private String normal;
	private String totalPremium;

	// 계약기간
	private String threeMon;
	private String sixMon;
	private String oneYear;
	private String twoYear;
	private String overYear;
	private String totalPre;

	private String name;
	private String count;
	
	
	
	
}

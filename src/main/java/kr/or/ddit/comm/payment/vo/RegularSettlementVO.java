package kr.or.ddit.comm.payment.vo;

import lombok.Data;

@Data 
public class RegularSettlementVO {
	private String rglStlmNo;
	private String gdsNm;
	private String empId;
	private String rglStlmDt;
	private String rglStlmBgngYmd;
	private String rglStlmEndYmd;
	private String rglStlmStplPrd;
	private String rglStlmNope;
	private String rglStlmPrc;
}

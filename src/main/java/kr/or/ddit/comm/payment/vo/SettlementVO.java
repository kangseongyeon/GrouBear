package kr.or.ddit.comm.payment.vo;

import lombok.Data;

@Data
public class SettlementVO {
	private String stlmNo;
	private String empId;
	private String rglStlmNo;
	private int stlmPrc;
	private String stlmDt;
}

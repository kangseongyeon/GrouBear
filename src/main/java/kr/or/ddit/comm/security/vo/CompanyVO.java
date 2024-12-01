package kr.or.ddit.comm.security.vo;

import lombok.Data;

@Data
public class CompanyVO {
	
	private String coCd;
	private String coNm;
	private String ceoId;
	private String coRegDt;
	private int coCnt;
	private String coBrno;
	private String ceoNm;
	private int coZip;
	private String coAddr;
	private String coDaddr;
	private String coTel;
	
	private String lat;		// 위도
	private String lot;		// 경도
}

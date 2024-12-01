package kr.or.ddit.groubear.contract.vo;

import lombok.Data;

@Data
public class ContractVO {
	private int ctrtNo;
	private String gdsNo;
	private String ctrtCon;
	private String ctrtBgngDt;
	private String ctrtExpryDt;
	private String ctrtPre;
	private String ctrtDt;
	private String ctrtAmt;
	private String ctrtNm;
	private String ctrtBrno;
	private String ctrtCnt;
	private String premiumYn;
	private String status;
	
	
	// CompanyVO
	private String coCd;
	private String coNm;
	private String coRegDt;
	private int coCnt;
	private String coBrno;
	private String ceoNm;
	private int coZip;
	private String coAddr;
	private String coDaddr;
	private String coTel;
	
	// 날짜 포맷팅 메서드 추가
    public String getFormattedCtrtBgngDt() {
        if (ctrtBgngDt != null && !ctrtBgngDt.isEmpty()) {
            return ctrtBgngDt.split(" ")[0]; // 날짜 부분만 반환
        }
        return "";
    }

    public String getFormattedCtrtExpryDt() {
        if (ctrtExpryDt != null && !ctrtExpryDt.isEmpty()) {
            return ctrtExpryDt.split(" ")[0]; // 날짜 부분만 반환
        }
        return "";
    }
	
	
	
}

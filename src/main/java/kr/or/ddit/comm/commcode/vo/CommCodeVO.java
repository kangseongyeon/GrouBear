package kr.or.ddit.comm.commcode.vo;

import lombok.Data;

@Data
public class CommCodeVO {
	private String comCd;
	private String comNm;
	private String empId;
	private String comCdRegDt;
	private String comCdUseYn;
	
	private String comDtlCd;
	private String comDtlCdNm;
	private String comDtlCdUseYn;
}

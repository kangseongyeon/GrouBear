package kr.or.ddit.company.vehicleManagement.vo;

import lombok.Data;

@Data
public class VHCLRSVTVO {

	private String rsvtCd;
	private String vhclNo;
	private String empId;
	private String vhclRsvtDt;
	private String vhclRntlDt;
	private String vhclRtnDt;
	private String rntlRsn;
	private String vhclBtdst;
	
	private String empNm;
	private VHCLVO vhclVO;
	
}

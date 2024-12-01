package kr.or.ddit.employee.facilities.vo;

import lombok.Data;

@Data
public class FacilityReservationDetailVO {
	private String fcltRsvtDsctnCd;
	private String memId;
	private String fcltCd;
	private String rsvtYmd;
	private String rsvtBgngTm;
	private String rsvtEndTm;
	private String empNm;
	private String fcltNm;
	private String fcltCtgrNm;
	
}

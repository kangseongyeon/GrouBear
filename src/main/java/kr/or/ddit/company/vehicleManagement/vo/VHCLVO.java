package kr.or.ddit.company.vehicleManagement.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class VHCLVO {

	private String vhclNo;
	private String vhclImgPath;
	private String coCd;
	private String vhclMdlNm;
	private String vhclAvgFuel;
	private String vhclKndNm;
	private String vhclRsvtPsbltyYn;
	private String vhclTypeFuel;
	private String vhclIndt;
	
	private MultipartFile vehicleImgFile;
}

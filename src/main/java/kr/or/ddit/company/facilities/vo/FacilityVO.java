package kr.or.ddit.company.facilities.vo;


import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FacilityVO {
	private String fcltCd;
	private String fcltCtgrCd;
	private String fcltNm;
	private String fcltStartTm;
	private String fcltEndTm;
	private String fcltNope;
	private String fcltInfo;
	private String atchFileCd;
	
	private String eq1;
	private String eq2;
	private String eq3;
	private String eq4;
	private String eq5;
	
	private List<MultipartFile> atchFiles;
	private List<EquipmentVO> eqipmentList;
	private List<FaciltyEquipmentVO> fclteqList;
	
}

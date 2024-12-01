package kr.or.ddit.company.facilities.vo;


import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FacilityCategoryVO {
	private String fcltCtgrCd;
	private String coCd;
	private String fcltCtgrNm;
	private String fcltCtgrImgUrl;
	private String fcltCtgrTurn;
	
	private List<FacilityVO> fcltList;
	
	private MultipartFile imgFile;
}

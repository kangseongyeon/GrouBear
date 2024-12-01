package kr.or.ddit.comm.cloud.vo;

import java.util.List;

import lombok.Data;

@Data
public class CloudStrgFldrVO {
	private String cloudStrgFldrCd;
	private String cloudStrgFldrNm;
	private String cloudFldrUpCd;
	private String cloudStrgFldrRegEmpId;
	
	private String[] cloudFldrAuthrtArray;
	
	// 폴더의 열람권한 리스트
	List<CloudFldrAuthrtVO> cloudFldrAuthrtList;
	
	// 폴더의 열람권한 여부
	private String cloudFldrAuthYn;
	
}

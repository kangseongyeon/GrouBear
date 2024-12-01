package kr.or.ddit.comm.cloud.vo;

import java.util.List;

import lombok.Data;

@Data
public class CloudStrgVO {
	private String cloudStrgCd;
	private String coCd;
	private String deptCd;
	private String empId;
	private String cloudStrgNm;
	private String cloudStrgCrtDt;
	private String cloudStrgDefaultYn;
	private String cloudStrgKnd;
	private String cloudStrgUpCd;
	
	// 저장소 내부의 폴더 리스트
	List<CloudStrgFldrVO> cloudStrgFldrList;
	
	// 저장소 내부의 파일 리스트
	List<CloudFileVO> cloudFileList;
	
	// 선택한 저장소의 계층형 경로
	private String cloudNm;
	private String cloudCd;
	private String cloudUpCd;
	private String cloudKnd;

}

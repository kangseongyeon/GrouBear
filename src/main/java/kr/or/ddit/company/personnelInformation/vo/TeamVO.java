package kr.or.ddit.company.personnelInformation.vo;

import java.time.LocalDate;

import lombok.Data;

@Data
public class TeamVO {

	private String teamCd;
	private String deptCd;
	private String teamNm;
	private LocalDate teamCrtDt;
	private String teamActvtnYn;

	private int empCnt;
	private String deptNm;
}

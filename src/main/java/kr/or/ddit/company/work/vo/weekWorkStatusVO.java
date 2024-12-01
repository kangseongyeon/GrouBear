package kr.or.ddit.company.work.vo;

import java.util.List;

import lombok.Data;

@Data
public class weekWorkStatusVO {
	private String coCd;
	private String empId;				// 사원 아이디
	private String empNm; 				// 사원 이름
	private String deptNm;				// 부서명
	private String jbgdNm;				// 팀명
	private String teamNm;				// 팀명
	private List<workStatusVO> week; 	// 일요일 출근 정보
	
}
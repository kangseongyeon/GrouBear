package kr.or.ddit.comm.project.vo;

import lombok.Data;

@Data
public class ProjectParticipantVO {
	public int participantNo;		// 프로젝트참가자번호
	public int proNo;				// 프로젝트번호
	public String empId;			// 프로젝트참가자
	public String proAtndYn;		// 프로젝트참여여부
	
	public String empNm;			// 프로젝트참가자이름
}

package kr.or.ddit.comm.project.vo;

import java.util.List;

import lombok.Data;

@Data
public class ProjectVO {
	private int proNo;				// 프로젝트번호
	private String coCd;			// 기업코드
	private String empId;			// 프로젝트생성자
	private String proSttsCd;		// 프로젝트진행상태
	private String proNm;			// 프로젝트이름
	private String proCn;			// 프로젝트설명
	private String proBgngDt;		// 프로젝트생성일시
	private String proMdfcnDt;		// 프로젝트수정일시
	private String proStartDt;		// 프로젝트시작일시
	private String proEndDt;		// 프로젝트마감일시
	private int proPregrt;			// 프로젝트진행률
	private String proDelYn;		// 프로젝트삭제여부
	
	private String empNm;					// 프로젝트생성자이름
	private String imgFileUrl;				// 프로젝트생성자이미지경로
	private String participantEmpNames;		// 프로젝트참가자이름			
	private String participantImgFileUrls;	// 프로젝트생성자이름
	
	private List<ProjectParticipantVO> participantList;			// 참가자 리스트
	private List<ProjectTaskVO> taskList;						// 일감 리스트
	
	private List<String> participantEmpNamesList;				// 프로젝트생성자이름리스트
	private List<String> participantImgFileUrlsList;			// 프로젝트생성자이름리스트

	private Integer[] delProjectNo;
}

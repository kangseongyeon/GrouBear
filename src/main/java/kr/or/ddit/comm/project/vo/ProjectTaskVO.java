package kr.or.ddit.comm.project.vo;

import java.util.List;

import lombok.Data;

@Data
public class ProjectTaskVO {
	private int proTaskNo;				// 프로젝트일감번호
	private int proNo;					// 프로젝트번호
	private String empId;				// 프로젝트일감담당자
	private String proTaskNm;			// 프로젝트일감명
	private String proTaskCn;			// 프로젝트일감내용
	private String proTaskSttsCd;		// 프로젝트일감상태
	private String proTaskBangDt;		// 프로젝트생성일시
	private String proTaskMdfcnDt;		// 프로젝트수정일시
	private String proTaskStartDt;		// 프로젝트시작일시
	private String proTaskEndDt;		// 프로젝트마감일시
	private String proTaskPregrt;		// 프로젝트일감진행률
	private String proTaskDelYn;		// 프로젝트일감삭제
	
	private String empNm;				// 프로젝트생성자이름
	private String imgFileUrl;			// 프로젝트생성자이미지경로


	private String participantEmpNames;		// 프로젝트참가자이름			
	private String participantImgFileUrls;	// 프로젝트생성자이름

	private List<String> participantEmpNamesList;				// 프로젝트생성자이름리스트
	private List<String> participantImgFileUrlsList;			// 프로젝트생성자이름리스트

}

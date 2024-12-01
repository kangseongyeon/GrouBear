package kr.or.ddit.company.community.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.comm.file.vo.AtchFileVO;
import lombok.Data;

@Data
public class ComCommunityVO {


	private int cmntyNo;
	private String empId;
	private String empNm;
	private String coCd;
	private String atchFileCd;	// 경로
	private String cmntyType;
	private String cmntyTtl;
	private String cmntyRegDt;
	private String cmntyMdfcnDt;
	private String cmntyCn;
	private String cmntyDelYn;
	private int cmntyInqCnt;
	private String cmntyNoticeYn;
	private String cmntyQstnKndNm;
	private String cmntyQstnSttsYn;

	// VO는 필요에 의해 확장해서 사용하는 것임. 고정된 것이 아님
	private MultipartFile atchFile;
	private List<MultipartFile> atchFiles;
}

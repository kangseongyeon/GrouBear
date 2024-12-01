package kr.or.ddit.comm.cmnty.vo;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import freemarker.template.utility.StringUtil;
import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.file.vo.AtchFileVO;
import lombok.Data;

@Data
public class CmntyVO {
	private int cmntyNo;
	private String empId;
	private String coCd;
	private String atchFileCd;
	private String cmntyType;
	private String cmntyTtl;
	private String cmntyRegDt;
	private String cmntyMdfcnDt;
	private String cmntyCn;
	private String cmntyDelYn;
	private int cmntyInqCnt;
	private String cmntyNoticeYn;
	private String comDtlCd;
	private String cmntyQstnSttsYn;
	private String cmntyPrvtPstYn;
	
	private String comDtlCdNm;	// 공통코드 디테일명
	
	private String mineWrite; // 내 글만 보기 체크 여부
	
	// 댓글 필드
	private int commentNo;
	private String cmntCn;
	private String cmntRegDt;
	
	private String qstnEmpId;	// Q&A 질문자 필드
	private String answrEmpId;	// Q&A 답변자 필드
	
	// Q&A 통계 필드
	private String cmntyQstnSttsYCount;	// 답변이 완료된 Q&A 글 갯수
	private String cmntyQstnSttsNCount;	// 답변이 미완료된 Q&A 글 갯수
	private String cmntyQstnAllcount;	// 전체 Q&A 글 갯수
	private String cmntyQstnSttsAllN;	// 전체 Q&A 글 중, 답변이 미완료된 글 갯수
	
	// 파일 그룹
	private String atchFileDelYn;
	private String atchFileRegDt;
	
	// 파일 디테일
	private List<AtchFileDetailVO> atchFileDetailList;
	
	// 파일 수정용 디테일 VO 리스트
	private List<AtchFileDetailVO> atchFileUpdateList;
	
	private MultipartFile atchFile;
	private List<MultipartFile> atchFiles;
	
	// 파일 정보 세팅하기
	public void setAtchFiles(List<MultipartFile> atchFiles) {
		this.atchFiles = atchFiles;
		if (atchFiles != null) {	// 넘어온 파일이 있다면
			List<AtchFileDetailVO> atchFileDetailList = new ArrayList<AtchFileDetailVO>();
			
			for (MultipartFile file : atchFiles) {
				if (StringUtils.isBlank(file.getOriginalFilename())) {
					continue;	// 파일 이름이 비어있거나 공백이면 반복문 패스
				}
				AtchFileDetailVO atchFileDetailVO = new AtchFileDetailVO(empId, file);
				atchFileDetailList.add(atchFileDetailVO);
			}
			this.atchFileDetailList = atchFileDetailList;
		}
	}
	
}

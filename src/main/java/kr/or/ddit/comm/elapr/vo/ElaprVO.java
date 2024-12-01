package kr.or.ddit.comm.elapr.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import lombok.Data;

@Data
public class ElaprVO {
	private int elaprNo;			// 전자결재번호
	private int docFormNo;			// 전자결재양식
	private String empId;			// 기안자아이디
	private String coCd;			// 기업코드
	private String atchFileCode;	// 첨부파일코드
	private String elaprNm;			// 전자결재제목
	private String elaprCn;			// 전자결재내용
	private String elaprBgngDt;		// 전자결재등록일시
	private String elaprMdfcnDt;	// 전자결재수정일시
	private String elaprEndDt;		// 전자결재마감일시
	private String elaprSttsCd;		// 전자결재진행상태
	private String elaprDelYn;		// 전자결재삭제여부
	private String elaprEmrgYn;		// 전자결재긴급여부
	private String elaprOpnnCn;		// 기안자의견
	
	private String docFormNm;		// 전자결재양식제목
	private String empNm;			// 기안자이름
	private String jbgdNm;			// 직급명
	private String imgFileUrl;		// 프로필이미지
	private String deptNm;			// 부서명 
	
	private String atchFileCd;
	
	
	private List<AplnVO> aplnList;		// 결재선
	private List<RerncVO> rerncList;		// 참조
	private List<ElaprPrslVO> prslList;	// 열람
	
	

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

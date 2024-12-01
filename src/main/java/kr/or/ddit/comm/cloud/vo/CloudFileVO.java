package kr.or.ddit.comm.cloud.vo;

import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import lombok.Data;

@Data
public class CloudFileVO {
	// 파일 복사를 위한 필드
	private MultipartFile multiFile;
	
	private String cloudFileCd;
	private String cloudFileUpCd;
	private String cloudFileRegEmpId;
	private String cloudFileRegDt;
	private String cloudFilePathNm;
	private String cloudFileExtnNm;
	private long cloudFileSize;
	private String cloudFileFancysize;
	private String cloudFileOrgnlNm;
	private String cloudFileStrgNm;
	
	private String coCd;
	
	public CloudFileVO() {}
	
	public CloudFileVO(String strgSelectCd, EmployeeVO empVO, MultipartFile multipartFile) {
		this.multiFile = multipartFile;
		this.cloudFileUpCd = strgSelectCd;
		this.cloudFileRegEmpId = empVO.getEmpId();
		this.cloudFileExtnNm = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".") + 1);
		this.cloudFileSize = multipartFile.getSize();
		this.cloudFileFancysize = FileUtils.byteCountToDisplaySize(multipartFile.getSize());
		this.cloudFileOrgnlNm = multipartFile.getOriginalFilename();
		this.cloudFileStrgNm = UUID.randomUUID().toString() + "_" + multipartFile.getOriginalFilename();
	}
	
}

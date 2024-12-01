package kr.or.ddit.comm.file.vo;

import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AtchFileDetailVO {
	// 파일 복사를 위한 필드
	private MultipartFile multiFile;
	
	private String atchFileDetailCd; //
	private String atchFileCd;
	private String atchFileDetailPathNm; //
	private String atchFileDetailExtnNm;
	private long atchFileDetailSize;
	private String atchFileDetailFancysize;
	private String atchFileDetailOrgnlNm;
	private String atchFileDetailStrgNm;
	private String atchFileDetailRegDt; //
	private String empId;
	private String atchFileDetailDelYn; //
	
	
	public AtchFileDetailVO() {}

	public AtchFileDetailVO(String empId, MultipartFile file) {
		this.multiFile = file;
		this.atchFileDetailExtnNm = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
		this.atchFileDetailSize = file.getSize();
		this.atchFileDetailFancysize = FileUtils.byteCountToDisplaySize(file.getSize());
		this.atchFileDetailOrgnlNm = file.getOriginalFilename();
		this.atchFileDetailStrgNm = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
		this.empId = empId;
	}
	
}

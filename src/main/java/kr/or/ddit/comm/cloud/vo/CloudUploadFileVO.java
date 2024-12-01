package kr.or.ddit.comm.cloud.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CloudUploadFileVO {
	private String strgSelectCd;
	private List<MultipartFile> files;
}

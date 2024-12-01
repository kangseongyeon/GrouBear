package kr.or.ddit.company.personnelInformation.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class DepartmentVO {

	private String deptCd;
	private String coCd;
	private String deptNm;
	private String deptCrtDt;
	private String deptActvtnYn;
	private String deptImgFileUrl;
	
	private MultipartFile deptImgFile;
	private List<TeamVO> teamVO;
}

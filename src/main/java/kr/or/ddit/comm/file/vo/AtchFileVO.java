package kr.or.ddit.comm.file.vo;

import java.util.List;

import lombok.Data;

@Data
public class AtchFileVO {

	private String atchFileCd;
	private String empId;
	private String atchFileDelYn;
	private String atchFileRegDt;
	
	private List<AtchFileDetailVO> atchFileDetailList;
}

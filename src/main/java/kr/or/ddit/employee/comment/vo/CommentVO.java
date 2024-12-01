package kr.or.ddit.employee.comment.vo;

import lombok.Data;

@Data
public class CommentVO {

	private int commentNo;
	private int cmntyNo;
	private String empId;
	private int upCmntNo;
	private String cmntCn;
	private String cmntRegDt;
	
	private String imgFileUrl;
}

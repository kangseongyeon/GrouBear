package kr.or.ddit.employee.messenger.vo;

import lombok.Data;

@Data
public class MessengerVO {

	// chatMsg
	private int chatmsgNo;
	private String empId;
	private String chatroomId;
	private String atchFileCode;
	private String chatmsgCn;
	private String chatmsgDt;
	
}

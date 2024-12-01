package kr.or.ddit.employee.videoChatting.vo;

import lombok.Data;

@Data
public class VideoChattingVO {

   private String roomTitle;         
   private String roomUrlId;         
   private String roomType;   
   private String callType;      
   private boolean liveMode;         
   private Integer maxJoinCount;         
   private Integer liveMaxJoinCount;         
   private String passwd;         
   private String startDate;         
   private String endDate;         
   private String durationMinutes;         
   private String layoutType;         
   private boolean sfuIncludeAll;      
   private String sfuIncludeRole;   
   
   private String chatNo;
   private String videoChatNm;
   private String videoChatDate;
   private String videoChatMas;
   private String videoChatCom;
   private String videoChatId;
   private String videoChatUrl;
   private String videoChatPw;
   private String videoChatDelyn;
   private String password;
   private boolean passwordRequired;
   private String coNm;
   
   
   
}

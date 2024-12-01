package kr.or.ddit.comm.cloud.vo;

import java.util.List;

import kr.or.ddit.comm.cmnty.vo.CmntyVO;
import lombok.Data;

@Data
public class CloudFldrOrFileVO {
	private String fldrOrFileCd;
	private String cloudUpCd;
	
	List<String> checkArr;
	
	List<String> downList;
}

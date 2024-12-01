package kr.or.ddit.company.vacation.vo;

import lombok.Data;

@Data
public class RemianVacationVO {
	private String empId;
	private int vctTotalDayCnt;
	private int vctRmndDayCnt;
	private int vctUseDayCnt;
}

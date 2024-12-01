package kr.or.ddit.company.vacation.service;

import java.util.List;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.vacation.vo.YearVctVO;

public interface IComVacationSettingSerivce {

	public List<YearVctVO> getvctSettingval(EmployeeVO empVO);

	public int setYearVctCnt(List<YearVctVO> yvList);

	public void setBasicVct(YearVctVO yvVO);

}

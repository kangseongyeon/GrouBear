package kr.or.ddit.company.vacation.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.vacation.vo.YearVctVO;

public interface IComVacationSettingMapper {

	public List<YearVctVO> getvctSettingval(EmployeeVO empVO);

	public int setYearVctCnt(Map<String, Object> requestMap);

	public void setBasicVct(YearVctVO yvVO);


}

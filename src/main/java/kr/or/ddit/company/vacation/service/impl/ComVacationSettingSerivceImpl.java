package kr.or.ddit.company.vacation.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.vacation.mapper.IComVacationSettingMapper;
import kr.or.ddit.company.vacation.service.IComVacationSettingSerivce;
import kr.or.ddit.company.vacation.vo.YearVctVO;


@Service
public class ComVacationSettingSerivceImpl implements IComVacationSettingSerivce {

	@Inject
	private IComVacationSettingMapper settingMapper;
	
	@Override
	public List<YearVctVO> getvctSettingval(EmployeeVO empVO) {
		return settingMapper.getvctSettingval(empVO);
	}

	@Override
	public int setYearVctCnt(List<YearVctVO> yvList) {
		Map<String, Object> requestMap = new HashMap<String, Object>();
		requestMap.put("yvList", yvList);
				
//		return settingMapper.setYearVctCnt(requestMap);
		return settingMapper.setYearVctCnt(requestMap);
	}

	@Override
	public void setBasicVct(YearVctVO yvVO) {
		settingMapper.setBasicVct(yvVO);
		
	}

}

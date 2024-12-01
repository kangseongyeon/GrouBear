package kr.or.ddit.company.vacation.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.company.vacation.mapper.IComVacationCreateMapper;
import kr.or.ddit.company.vacation.mapper.IComVacationStatusMapper;
import kr.or.ddit.company.vacation.service.IComVacationCreateService;
import kr.or.ddit.company.vacation.vo.VacationCreateVO;

@Service
public class ComVacationCreateService implements IComVacationCreateService {

	@Inject
	private IComVacationCreateMapper Mapper;
	
	@Override
	public int addVctAtEmpId(VacationCreateVO vctCrtVO) {
		return Mapper.addVctAtEmpId(vctCrtVO);
	}

}

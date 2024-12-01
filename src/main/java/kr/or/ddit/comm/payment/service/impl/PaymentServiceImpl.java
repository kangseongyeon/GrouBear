package kr.or.ddit.comm.payment.service.impl;


import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.payment.mapper.IPaymentMapper;
import kr.or.ddit.comm.payment.service.IPaymentService;
import kr.or.ddit.comm.payment.vo.RegularSettlementVO;
import kr.or.ddit.comm.payment.vo.SettlementVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;


@Service
public class PaymentServiceImpl implements IPaymentService {
	
	@Inject
	private IPaymentMapper payMapper;

	@Override
	public void insertCompany(CompanyVO companyVO) {
		payMapper.insertCompany(companyVO);
		
	}

	@Override
	public void insertRgSt(RegularSettlementVO rgstVO) {
		payMapper.insertRgSt(rgstVO);
		
	}

	@Override
	public void insertStm(SettlementVO stmVO) {
		payMapper.insertStm(stmVO);
		
	}

	@Override
	public String getComCd(EmployeeVO empVO) {
		return payMapper.getComCd(empVO);
	}



	
	
	

	

}

package kr.or.ddit.comm.payment.mapper;

import kr.or.ddit.comm.payment.vo.RegularSettlementVO;
import kr.or.ddit.comm.payment.vo.SettlementVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;

public interface IPaymentMapper {

	public void insertCompany(CompanyVO companyVO);

	public void insertRgSt(RegularSettlementVO rgstVO);

	public void insertStm(SettlementVO stmVO);

	public String getComCd(EmployeeVO empVO);

	public void setBasicVct(EmployeeVO empVO);

}

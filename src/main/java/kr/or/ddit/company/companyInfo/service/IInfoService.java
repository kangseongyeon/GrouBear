package kr.or.ddit.company.companyInfo.service;

import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.groubear.contract.vo.ContractVO;

public interface IInfoService {

	public ContractVO getContract(CompanyVO companyVO);

}

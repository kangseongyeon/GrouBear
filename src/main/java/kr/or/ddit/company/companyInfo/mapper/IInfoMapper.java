package kr.or.ddit.company.companyInfo.mapper;

import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.groubear.contract.vo.ContractVO;

public interface IInfoMapper {

	public ContractVO getContract(CompanyVO companyVO);

}

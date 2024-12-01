package kr.or.ddit.company.companyInfo.service.Impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.company.companyInfo.mapper.IInfoMapper;
import kr.or.ddit.company.companyInfo.service.IInfoService;
import kr.or.ddit.groubear.contract.vo.ContractVO;

@Service
public class InfoService implements IInfoService{

	@Inject
	private IInfoMapper mapper;
	
	@Override
	public ContractVO getContract(CompanyVO companyVO) {
		return mapper.getContract(companyVO);
	}

}

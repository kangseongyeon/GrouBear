package kr.or.ddit.groubear.contract.service;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.groubear.contract.vo.ContractVO;

public interface IContractService {

	public int selectCtrt(PaginationInfoVO<ContractVO> pagingVO);
	public List<ContractVO> selectCtrtList(PaginationInfoVO<ContractVO> pagingVO);
	public void insertCtrt(ContractVO ctrtVO);
	
	public ContractVO detail(ContractVO ctrtVO);
	public int insertContract(ContractVO contractVO);
	
	public ContractVO comDetail(ContractVO ctrtVO);
	public ContractVO currentContractStatus(String coCd);
	
	

}

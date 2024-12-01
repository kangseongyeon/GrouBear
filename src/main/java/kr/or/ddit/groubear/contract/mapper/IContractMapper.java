package kr.or.ddit.groubear.contract.mapper;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.groubear.contract.vo.ContractVO;

public interface IContractMapper {

	public int selectCtrtCount(PaginationInfoVO<ContractVO> pagingVO);
	public List<ContractVO> selectCtrtList(PaginationInfoVO<ContractVO> pagingVO);
	public void insertCtrt(ContractVO ctrtVO);
	
	public ContractVO detail(ContractVO ctrtVO);
	public ContractVO comDetail(ContractVO ctrtVO);
	
	public int insertContract(ContractVO contractVO);
	public ContractVO currentContractStatus(String coCd);

}

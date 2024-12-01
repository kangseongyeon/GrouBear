package kr.or.ddit.groubear.contract.mapper;

import java.util.List;

import kr.or.ddit.groubear.contract.vo.ContractVO;

public interface IContractDownloadMapper {

	List<ContractVO> createExcelContract();

}

package kr.or.ddit.groubear.contract.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.groubear.contract.mapper.IContractMapper;
import kr.or.ddit.groubear.contract.service.IContractService;
import kr.or.ddit.groubear.contract.vo.ContractVO;

@Service
public class ContractServiceImpl implements IContractService {

	@Inject
	private IContractMapper mapper;
	
	@Override
	public int selectCtrt(PaginationInfoVO<ContractVO> pagingVO) {
		return mapper.selectCtrtCount(pagingVO);
	}

	@Override
	public List<ContractVO> selectCtrtList(PaginationInfoVO<ContractVO> pagingVO) {
		return mapper.selectCtrtList(pagingVO);
	}

	@Override
	public void insertCtrt(ContractVO ctrtVO) {
		ctrtVO.setCtrtBgngDt(getCurrentTime());
		ctrtVO.setCtrtExpryDt(getCurrentTime());
		mapper.insertCtrt(ctrtVO);
		
	}
	
	// 작업시간 불러옴
		private String getCurrentTime() {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();
			calendar.setTimeInMillis(System.currentTimeMillis());
			return formatter.format(calendar.getTime());
		}

		@Override
		public ContractVO detail(ContractVO ctrtVO) {
			return mapper.detail(ctrtVO);
		}

		@Override
		public int insertContract(ContractVO contractVO) {
			return mapper.insertContract(contractVO);
		}

		@Override
		public ContractVO comDetail(ContractVO ctrtVO) {
			return mapper.comDetail(ctrtVO);
		}

		@Override
		public ContractVO currentContractStatus(String coCd) {
			return mapper.currentContractStatus(coCd);
		}

	
}

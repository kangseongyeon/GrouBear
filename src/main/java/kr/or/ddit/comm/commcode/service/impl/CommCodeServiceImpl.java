package kr.or.ddit.comm.commcode.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.commcode.mapper.ICommCodeMapper;
import kr.or.ddit.comm.commcode.service.ICommCodeService;
import kr.or.ddit.comm.commcode.vo.CommCodeVO;

@Service
public class CommCodeServiceImpl implements ICommCodeService {

	@Inject
	ICommCodeMapper commCodeMapper;

	@Override
	public List<CommCodeVO> commCodeDetailSelectList() {
		return commCodeMapper.commCodeDetailSelectList();
	}
	
}

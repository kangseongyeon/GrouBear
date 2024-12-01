package kr.or.ddit.comm.commcode.service;

import java.util.List;

import kr.or.ddit.comm.commcode.vo.CommCodeVO;

public interface ICommCodeService {
	/**
	 * 공통코드 디테일 리스트 가져오기
	 * @return
	 */
	public List<CommCodeVO> commCodeDetailSelectList();
}

package kr.or.ddit.comm.commcode.mapper;

import java.util.List;

import kr.or.ddit.comm.commcode.vo.CommCodeVO;

public interface ICommCodeMapper {
	/**
	 * 공통코드 디테일 리스트 가져오기
	 * @return
	 */
	public List<CommCodeVO> commCodeDetailSelectList();
}

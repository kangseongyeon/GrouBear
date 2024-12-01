package kr.or.ddit.comm.menuRcmdtn.mapper;

import java.util.List;

import kr.or.ddit.comm.menuRcmdtn.vo.FoodVO;

public interface IMenuRcmdtnMapper {

	/**
	 * 음식 전체 리스트 가져오기
	 * @return
	 */
	List<FoodVO> foodSelectList();
}

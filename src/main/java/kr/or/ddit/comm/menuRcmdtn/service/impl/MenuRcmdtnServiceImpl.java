package kr.or.ddit.comm.menuRcmdtn.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.menuRcmdtn.mapper.IMenuRcmdtnMapper;
import kr.or.ddit.comm.menuRcmdtn.service.IMenuRcmdtnService;
import kr.or.ddit.comm.menuRcmdtn.vo.FoodVO;

@Service
public class MenuRcmdtnServiceImpl implements IMenuRcmdtnService {

	@Inject
	private IMenuRcmdtnMapper menuRcmdtnMapper;

	@Override
	public List<FoodVO> foodSelectList() {
		return menuRcmdtnMapper.foodSelectList();
	}
	
}

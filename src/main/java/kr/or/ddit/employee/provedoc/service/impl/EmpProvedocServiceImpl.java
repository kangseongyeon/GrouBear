package kr.or.ddit.employee.provedoc.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.employee.provedoc.mapper.IEmpProvedocMapper;
import kr.or.ddit.employee.provedoc.service.IEmpProvedocService;
import kr.or.ddit.employee.provedoc.vo.EmpProvedocVO;

@Service
public class EmpProvedocServiceImpl implements IEmpProvedocService {

	@Inject
	private IEmpProvedocMapper provedocMapper;

	// 증명서 목록 게시물 수 조회 (사원)
	@Override
	public int empSelectProvedocCount(PaginationInfoVO<EmpProvedocVO> pagingVO) {
		return provedocMapper.empSelectProvedocCount(pagingVO);
	}	
	
	// 증명서 목록 게시물 리스트 조회 (사원)
	@Override
	public List<EmpProvedocVO> empSelectProvedocList(PaginationInfoVO<EmpProvedocVO> pagingVO) {
		return provedocMapper.empSelectProvedocList(pagingVO);
	}

	// 증명서 신청 (사원)
	@Override
	public ServiceResult empProvedocAplyInsert(EmpProvedocVO provedocVO) {
		ServiceResult result;
		
		int status = provedocMapper.empProvedocAplyInsert(provedocVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}


	// 증명서 양식 목록 가져오기 - Jstree에 출력할 form 계층형 데이터 
	@Override
	public List<FormVO> selectFormListJstree(String coCd) {
		return provedocMapper.selectFormListJstree(coCd);
	}

	// 증명서 상세보기
	@Override
	public EmpProvedocVO provedocDetail(EmpProvedocVO provedocVO) {
		return provedocMapper.provedocDetail(provedocVO);
	}
	
}

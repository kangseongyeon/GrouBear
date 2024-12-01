package kr.or.ddit.company.provedoc.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.company.provedoc.mapper.IComProvedocMapper;
import kr.or.ddit.company.provedoc.service.IComProvedocService;
import kr.or.ddit.company.provedoc.vo.ComProvedocVO;

@Service
public class ComProvedocServiceImpl implements IComProvedocService {

	@Inject
	private IComProvedocMapper provedocMapper;

	// 증명서 목록 게시물 수 조회 (기업 관리자 - 증명서 요청관리)
	@Override
	public int comSelectProvedocAplyCount(PaginationInfoVO<ComProvedocVO> pagingVO) {
		return provedocMapper.comSelectProvedocAplyCount(pagingVO);
	}	
	
	// 증명서 목록 게시물 수 조회 (기업 관리자 - 증명서 발급)
	@Override
	public int comSelectProvedocIsprCount(PaginationInfoVO<ComProvedocVO> pagingVO) {
		return provedocMapper.comSelectProvedocIsprCount(pagingVO);
	}	

	// 증명서 목록 게시물 리스트 조회 (기업 관리자 - 증명서 요청관리)
	@Override
	public List<ComProvedocVO> comSelectProvedocAplyList(PaginationInfoVO<ComProvedocVO> pagingVO) {
		return provedocMapper.comSelectProvedocAplyList(pagingVO);
	}
	
	// 증명서 목록 게시물 리스트 조회 (기업 관리자 - 증명서 발급)
	@Override
	public List<ComProvedocVO> comSelectProvedocIsprList(PaginationInfoVO<ComProvedocVO> pagingVO) {
		return provedocMapper.comSelectProvedocIsprList(pagingVO);
	}
	

	// 증명서 신청 및 발급 (기업 관리자)
	@Override
	public ServiceResult comProvedocAplyAndIsprInsert(ComProvedocVO provedocVO) {
		ServiceResult result;
		
		int status = provedocMapper.comProvedocAplyAndIsprInsert(provedocVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	// 증명서 사원 발급 (기업 관리자)
	@Override
	public ServiceResult comProvedocIsprUpdate(ComProvedocVO provedocVO) {
		ServiceResult result;
		
		int status = provedocMapper.comProvedocIsprUpdate(provedocVO);
		
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
	public ComProvedocVO provedocDetail(ComProvedocVO provedocVO) {
		return provedocMapper.provedocDetail(provedocVO);
	}

	// 현재 전체 증명서와 미발급 증명서 수 카운트하기
	@Override
	public ComProvedocVO provedocComCount(String coCd) {
		return provedocMapper.provedocComCount(coCd);
	}
	
}

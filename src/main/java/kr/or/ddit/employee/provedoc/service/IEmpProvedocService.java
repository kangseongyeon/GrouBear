package kr.or.ddit.employee.provedoc.service;

import java.util.List;

import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.employee.provedoc.vo.EmpProvedocVO;

public interface IEmpProvedocService {

	// 증명서 목록 게시물 수 조회 (사원)
	public int empSelectProvedocCount(PaginationInfoVO<EmpProvedocVO> pagingVO);
	
	// 증명서 목록 게시물 리스트 조회 (사원)
	public List<EmpProvedocVO> empSelectProvedocList(PaginationInfoVO<EmpProvedocVO> pagingVO);
	
	// 증명서 신청 (사원)
	public ServiceResult empProvedocAplyInsert(EmpProvedocVO provedocVO);
	
	// 증명서 양식 목록 가져오기 - Jstree에 출력할 form 계층형 데이터 
	public List<FormVO> selectFormListJstree(String coCd);

	// 증명서 상세보기
	public EmpProvedocVO provedocDetail(EmpProvedocVO provedocVO);

}

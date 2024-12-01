package kr.or.ddit.employee.provedoc.mapper;

import java.util.List;

import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.employee.provedoc.vo.EmpProvedocVO;

public interface IEmpProvedocMapper {
	
	// 증명서 목록 게시물 수 조회 (사원)
	public int empSelectProvedocCount(PaginationInfoVO<EmpProvedocVO> pagingVO);
	
	// 증명서 목록 게시물 리스트 조회 (사원)
	public List<EmpProvedocVO> empSelectProvedocList(PaginationInfoVO<EmpProvedocVO> pagingVO);
	
	// 증명서 신청 및 발급 (기업 관리자)
	public int empProvedocAplyAndIsprInsert(EmpProvedocVO provedocVO);
	
	// 증명서 신청 (사원)
	public int empProvedocAplyInsert(EmpProvedocVO provedocVO);

	// 증명서 양식 목록 가져오기 - Jstree에 출력할 form 계층형 데이터 
	public List<FormVO> selectFormListJstree(String coCd);

	// 증명서 상세보기
	public EmpProvedocVO provedocDetail(EmpProvedocVO provedocVO);
	
}

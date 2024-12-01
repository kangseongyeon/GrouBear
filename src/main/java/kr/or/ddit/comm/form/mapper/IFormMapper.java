package kr.or.ddit.comm.form.mapper;

import java.util.List;

import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;

public interface IFormMapper {
	
	/**
	 * 양식 등록
	 * @param formVO
	 * @return
	 */
	public int formInsert(FormVO formVO);

	// 양식 전체 게시물 수 조회 (그룹웨어 관리자)
	public int groubearSelectFormCount(PaginationInfoVO<FormVO> pagingVO);

	// 양식 리스트 조회 (그룹웨어 관리자)
	public List<FormVO> groubearSelectFormList(PaginationInfoVO<FormVO> pagingVO);
	
	// 양식 전체 게시물 수 조회 (기업 관리자)
	public int companySelectFormCount(PaginationInfoVO<FormVO> pagingVO);
	
	// 양식 리스트 조회 (기업 관리자)
	public List<FormVO> companySelectFormList(PaginationInfoVO<FormVO> pagingVO);
	
	// 양식 상세 조회
	public FormVO selectForm(int docFormNo);

	// 양식 수정
	public int formUpdate(FormVO formVO);

	// 양식 삭제 (1개일 때)
	public int formDelete(int docFormNo);

	// Jstree에 출력할 form 계층형 데이터 (그룹웨어 관리자)
	public List<FormVO> groubearSelectFormListJstree(String coCd);
	
	// Jstree에 출력할 form 계층형 데이터 (기업 관리자)
	public List<FormVO> companySelectFormListJstree(String coCd);

	// 양식 종류 추가
	public int docFormKndNmAdd(FormVO formVO);

	// 양식 종류 가져오기 (그룹웨어 관리자)
	public List<FormVO> groubearSelectDocFormKndNm(FormVO formVO);
	
	// 양식 종류 가져오기 (기업 관리자)
	public List<FormVO> companySelectDocFormKndNm(FormVO formVO);

	// 양식 종류 삭제하기
	public int docFormKndNmDel(FormVO formVO);

	// 양식 종류 삭제 전, 하위 글 유무 확인하기
	public int docFormKndWriteCheck(int docFormNo);

}

package kr.or.ddit.company.provedoc.mapper;

import java.util.List;

import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.company.provedoc.vo.ComProvedocVO;

public interface IComProvedocMapper {

	/**
	 * 증명서 목록 게시물 수 조회 (기업 관리자 - 증명서 요청관리)
	 * @param pagingVO
	 * @return
	 */
	public int comSelectProvedocAplyCount(PaginationInfoVO<ComProvedocVO> pagingVO);

	/**
	 * 증명서 목록 게시물 수 조회 (기업 관리자 - 증명서 발급)
	 * @param pagingVO
	 * @return
	 */
	public int comSelectProvedocIsprCount(PaginationInfoVO<ComProvedocVO> pagingVO);
	
	/**
	 * 증명서 목록 게시물 리스트 조회 (기업 관리자 - 증명서 요청관리)
	 * @param pagingVO
	 * @return
	 */
	public List<ComProvedocVO> comSelectProvedocAplyList(PaginationInfoVO<ComProvedocVO> pagingVO);
	
	/**
	 * 증명서 목록 게시물 리스트 조회 (기업 관리자 - 증명서 발급)
	 * @param pagingVO
	 * @return
	 */
	public List<ComProvedocVO> comSelectProvedocIsprList(PaginationInfoVO<ComProvedocVO> pagingVO);
	
	/**
	 * 증명서 목록 게시물 수 조회 (사원)
	 * @param pagingVO
	 * @return
	 */
	public int empSelectProvedocCount(PaginationInfoVO<ComProvedocVO> pagingVO);
	
	/**
	 * 증명서 목록 게시물 리스트 조회 (사원)
	 * @param pagingVO
	 * @return
	 */
	public List<ComProvedocVO> empSelectProvedocList(PaginationInfoVO<ComProvedocVO> pagingVO);
	
	/**
	 * 증명서 신청 및 발급 (기업 관리자)
	 * @param provedocVO
	 * @return
	 */
	public int comProvedocAplyAndIsprInsert(ComProvedocVO provedocVO);
	
	/**
	 * 증명서 신청 (사원)
	 * @param provedocVO
	 * @return
	 */
	public int empProvedocAplyInsert(ComProvedocVO provedocVO);
	
	/**
	 * 증명서 사원 발급 (기업 관리자)
	 * @param provedocVO
	 * @return
	 */
	public int comProvedocIsprUpdate(ComProvedocVO provedocVO);

	/**
	 * 증명서 양식 목록 가져오기 - Jstree에 출력할 form 계층형 데이터 
	 * @param coCd
	 * @return
	 */
	public List<FormVO> selectFormListJstree(String coCd);

	/**
	 * 증명서 상세보기
	 * @param provedocVO
	 * @return
	 */
	public ComProvedocVO provedocDetail(ComProvedocVO provedocVO);

	/**
	 * 현재 전체 증명서와 미발급 증명서 수 카운트하기
	 * @param coCd
	 * @return
	 */
	public ComProvedocVO provedocComCount(String coCd);
	
}

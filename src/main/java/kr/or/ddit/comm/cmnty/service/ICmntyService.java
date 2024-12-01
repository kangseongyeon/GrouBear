package kr.or.ddit.comm.cmnty.service;

import java.util.List;

import kr.or.ddit.comm.cmnty.vo.CmntyVO;
import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;

public interface ICmntyService {

	/**
	 * 그루베어 시스템 공지사항 목록 갯수 가져오기
	 * @param pagingVO
	 * @return
	 */
	public int noticeSelectListCount(PaginationInfoVO<CmntyVO> pagingVO);

	/**
	 * 그루베어 시스템 공지사항 목록 가져오기
	 * @param pagingVO
	 * @return
	 */
	public List<CmntyVO> noticeSelectList(PaginationInfoVO<CmntyVO> pagingVO);

	/**
	 * 그루베어 시스템 공지사항 디테일 가져오기
	 * @param cmntyNo
	 * @return
	 */
	public CmntyVO noticeSelectOne(int cmntyNo);

	/**
	 * 파일 디테일 불러오기 (다운로드)
	 * @param atchFileDetailCd
	 * @return
	 */
	public AtchFileDetailVO atchFileDetailOneSelect(String atchFileDetailCd);
	
	/**
	 * 파일 디테일 리스트 불러오기 (다운로드)
	 * @param atchFileCd
	 * @return
	 */
	public List<AtchFileDetailVO> atchFileDetailListSelect(String atchFileCd);

	/**
	 * Q&A 게시판 리스트의 수 가져오기
	 * @param pagingVO
	 * @return
	 */
	public int qstnSelectListCount(PaginationInfoVO<CmntyVO> pagingVO);

	/**
	 * Q&A 게시판 리스트 가져오기
	 * @param pagingVO
	 * @return
	 */
	public List<CmntyVO> qstnSelectList(PaginationInfoVO<CmntyVO> pagingVO);

	/**
	 * Q&A 디테일 가져오기
	 * @param cmntyNo
	 * @return
	 */
	public CmntyVO qstnSelectOne(int cmntyNo);

	/**
	 * Q&A 등록하기
	 * @param cmntyVO
	 * @return
	 */
	public ServiceResult cmntyQstnInsert(CmntyVO cmntyVO);

	/**
	 * Q&A 수정하기
	 * @param cmntyVO
	 * @return
	 */
	public ServiceResult cmntyQstnModify(CmntyVO cmntyVO);

	/**
	 * Q&A 삭제하기
	 * @param cmntyNo
	 * @return
	 */
	public ServiceResult cmntyQstnDelete(int cmntyNo);

}

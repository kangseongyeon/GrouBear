package kr.or.ddit.groubear.cmnty.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.cmnty.vo.CmntyVO;
import kr.or.ddit.comm.cmnty.vo.CmtVO;
import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;

public interface IGroCmntyService {

	/**
	 * 그루베어 시스템 공지사항 목록 갯수 가져오기
	 * @param pagingVO
	 * @return
	 */
	public int groNoticeSelectListCount(PaginationInfoVO<CmntyVO> pagingVO);

	/**
	 * 그루베어 시스템 공지사항 목록 가져오기
	 * @param pagingVO
	 * @return
	 */
	public List<CmntyVO> groNoticeSelectList(PaginationInfoVO<CmntyVO> pagingVO);

	/**
	 * 그루베어 시스템 공지사항 디테일 가져오기
	 * @param cmntyNo
	 * @return
	 */
	public CmntyVO groNoticeSelectOne(int cmntyNo);

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
	 * 공지사항 등록하기
	 * @param cmntyVO
	 * @return
	 */
	public ServiceResult cmntyNoticeInsert(CmntyVO cmntyVO);

	/**
	 * 공지사항 수정하기
	 * @param cmntyVO
	 * @return
	 */
	public ServiceResult cmntyNoticeModify(CmntyVO cmntyVO);

	/**
	 * 공지사항 삭제 처리
	 * @param cmntyVO
	 * @return
	 */
	public ServiceResult cmntyNoticeDelete(CmntyVO cmntyVO);

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
	 * Q&A에 답변 등록하기
	 * @param cmtVO
	 * @return
	 */
	public ServiceResult cmntyReplyInsert(CmtVO cmtVO);

	/**
	 * Q&A에 등록한 답변 삭제하기
	 * @param cmtVO
	 * @return
	 */
	public ServiceResult cmntyReplyDelete(CmtVO cmtVO);

	/**
	 * Q&A에 등록한 답변 수정하기
	 * @param cmtVO
	 * @return
	 */
	public ServiceResult cmntyReplyModify(CmtVO cmtVO);

	/**
	 * Q&A 카테고리별 전체 게시물과 Q&A 미답변 게시물 카운트하기
	 * @return
	 */
	public List<CmntyVO> qstnSttsAndListCount();

	/**
	 * Q&A 홈피드용 공지사항 리스트 가져오기
	 * @return
	 */
	public List<CmntyVO> groNoticeSelectListWidjet();

	
}

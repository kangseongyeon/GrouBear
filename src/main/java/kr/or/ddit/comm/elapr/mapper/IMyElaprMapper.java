package kr.or.ddit.comm.elapr.mapper;

import java.util.List;

import kr.or.ddit.comm.elapr.vo.ElaprVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;

public interface IMyElaprMapper {

	// //////////////////// 기안 문서함 //////////////////// 
	/**
	 *  기안 문서함 페이지수
	 * @param pagingVO
	 * @return
	 */
	public int selectDraftCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 *  개인 - 기안 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectMyElaprDraftList(PaginationInfoVO<ElaprVO> pagingVO);

	
	// //////////////////// 전체 문서함 //////////////////// 
	/**
	 * 전체 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectAllCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 전체 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectAllList(PaginationInfoVO<ElaprVO> pagingVO);
	
	/**
	 * 결재 긴급 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectEmrgCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 결재 긴급 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectEmrgList(PaginationInfoVO<ElaprVO> pagingVO);
	
	/**
	 * 결재 진행 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectProgressCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 결재 진행 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectProgressList(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 결재 완료 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectCompleteCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 결재 완료 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectCompleteList(PaginationInfoVO<ElaprVO> pagingVO);

	
	/**
	 * 결재 반려 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectRjctCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 결재 반려 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectRjctList(PaginationInfoVO<ElaprVO> pagingVO);

	
	// //////////////////// 참조/열람 문서함 ////////////////////
	/**
	 * 참조 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectRerncCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 참조 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectRerncList(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 열람 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectPrslCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 열람 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectPrslList(PaginationInfoVO<ElaprVO> pagingVO);
	
	
	// //////////////////// 개인 결재 문서함 ////////////////////
	/**
	 * 개인 전체 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectMyAllCount(PaginationInfoVO<ElaprVO> pagingVO);
	
	/**
	 * 개인 전체 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectMyAllList(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 개인 긴급 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectMyEmrgCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 개인 긴급 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectMyEmrgList(PaginationInfoVO<ElaprVO> pagingVO);

	
	/**
	 * 개인 진행 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectMyProgressCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 개인 진행 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectMyProgressList(PaginationInfoVO<ElaprVO> pagingVO);

	
	/**
	 * 개인 완료 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectMyCompleteCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 개인 완료 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectMyCompleteList(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 개인 반려 문서함 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectMyRjctCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 개인 반려 문서함 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectMyRjctList(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 전자결재 캘린더 연동
	 * @param empId
	 * @return
	 */
	public List<ElaprVO> selectAllCalList(String empId);

	
	// 메인페이지용 리스트 출력
	/**
	 * 메인페이지용 긴급문서함 리스트 출력
	 * @param empId
	 * @return
	 */
	public List<ElaprVO> selectEmrgHomeList(String empId);
	
	/**
	 * 메인페이지용 전체문서함 리스트 출력
	 * @param empId
	 * @return
	 */
	public List<ElaprVO> selectAllHomeList(String empId);

	/**
	 * 메인페이지용 참조 문서함 리스트 출력
	 * @param empId
	 * @return
	 */
	public List<ElaprVO> selectRerncHomeList(String empId);
	
	/**
	 * 메인페이지용 열람 문서함 리스트 출력
	 * @param empId
	 * @return
	 */
	public List<ElaprVO> selectPrslHomeList(String empId);




}

package kr.or.ddit.comm.elapr.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.elapr.service.IMyElaprService;
import kr.or.ddit.comm.elapr.vo.ElaprVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.elapr.mapper.IMyElaprMapper;

@Service
public class MyElaprServiceImpl implements IMyElaprService {

	@Inject
	private IMyElaprMapper myElaprMapper;
	
	// //////////////////// 기안 문서함 //////////////////// 
	/**
	 *  기안 문서함 페이지수
	 */
	@Override
	public int selectDraftCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectDraftCount(pagingVO);
	}
	
	/**
	 *  개인 - 기안 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectMyElaprDraftList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectMyElaprDraftList(pagingVO);
	}

	
	// //////////////////// 전체 문서함 //////////////////// 
	/**
	 * 전체 문서함 페이징
	 */
	@Override
	public int selectAllCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectAllCount(pagingVO);
	}

	/**
	 * 전체 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectAllList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectAllList(pagingVO);
	}
	
	/**
	 * 결재 긴급 문서함 페이징
	 */
	@Override
	public int selectEmrgCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectEmrgCount(pagingVO);
	}

	/**
	 * 결재 긴급 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectEmrgList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectEmrgList(pagingVO);
	}

	
	/**
	 * 진행 문서함 페이징
	 */
	@Override
	public int selectProgressCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectProgressCount(pagingVO);
	}

	/**
	 * 진행 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectProgressList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectProgressList(pagingVO);
	}

	/**
	 * 결재 완료 문서함 페이징
	 */
	@Override
	public int selectCompleteCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectCompleteCount(pagingVO);
	}

	/**
	 * 결재 완료 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectCompleteList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectCompleteList(pagingVO);
	}

	/**
	 * 결재 반려 문서함 페이징
	 */
	@Override
	public int selectRjctCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectRjctCount(pagingVO);
	}

	/**
	 * 결재 반려 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectRjctList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectRjctList(pagingVO);
	}


	// //////////////////// 참조/열람 완료문서함 ////////////////////
	/**
	 * 참조 문서함 페이징
	 */
	@Override
	public int selectRerncCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectRerncCount(pagingVO);
	}

	/**
	 * 참조 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectRerncList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectRerncList(pagingVO);
	}
	
	/**
	 * 열람 문서함 페이징
	 */
	@Override
	public int selectPrslCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectPrslCount(pagingVO);
	}

	/**
	 * 열람 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectPrslList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectPrslList(pagingVO);
	}
	
	
	// //////////////////// 개인 결재 문서함 ////////////////////
	
	/**
	 * 개인 전체 문서함 페이징
	 */
	@Override
	public int selectMyAllCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectMyAllCount(pagingVO);
	}

	/**
	 * 개인 전체 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectMyAllList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectMyAllList(pagingVO);
	}

	/**
	 * 개인 긴급 문서함 페이징
	 */
	@Override
	public int selectMyEmrgCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectMyEmrgCount(pagingVO);
	}

	/**
	 * 개인 긴급 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectMyEmrgList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectMyEmrgList(pagingVO);
	}

	
	/**
	 * 개인 진행 문서함 페이징
	 */
	@Override
	public int selectMyProgressCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectMyProgressCount(pagingVO);
	}

	/**
	 * 개인 진행 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectMyProgressList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectMyProgressList(pagingVO);
	}
	
	/**
	 * 개인 완료 문서함 페이징
	 */
	@Override
	public int selectMyCompleteCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectMyCompleteCount(pagingVO);
	}

	/**
	 * 개인 완료 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectMyCompleteList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectMyCompleteList(pagingVO);
	}

	/**
	 * 개인 반려 문서함 페이징
	 */
	@Override
	public int selectMyRjctCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectMyRjctCount(pagingVO);
	}

	/**
	 * 개인 반려 문서함 리스트
	 */
	@Override
	public List<ElaprVO> selectMyRjctList(PaginationInfoVO<ElaprVO> pagingVO) {
		return myElaprMapper.selectMyRjctList(pagingVO);
	}

	/**
	 * 전자결재 캘린더 연동
	 */
	@Override
	public List<ElaprVO> selectAllCalList(String empId) {
		return myElaprMapper.selectAllCalList(empId);
	}

	
	// 메인페이지용 리스트 출력
	/**
	 * 메인페이지용 긴급문서함 리스트 출력
	 */
	@Override
	public List<ElaprVO> selectEmrgHomeList(String empId) {
		return myElaprMapper.selectEmrgHomeList(empId);
	}
	
	/**
	 * 메인페이지용 전체문서함 리스트 출력
	 */
	@Override
	public List<ElaprVO> selectAllHomeList(String empId) {
		return myElaprMapper.selectAllHomeList(empId);
	}

	/**
	 * 메인페이지용 참조 문서함 리스트 출력
	 */
	@Override
	public List<ElaprVO> selectRerncHomeList(String empId) {
		return myElaprMapper.selectRerncHomeList(empId);
	}
	
	/**
	 * 메인페이지용 열람 문서함 리스트 출력
	 */
	@Override
	public List<ElaprVO> selectPrslHomeList(String empId) {
		return myElaprMapper.selectPrslHomeList(empId);
	}


}

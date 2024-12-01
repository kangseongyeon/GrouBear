package kr.or.ddit.comm.elapr.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.comm.elapr.vo.AplnVO;
import kr.or.ddit.comm.elapr.vo.ElaprPrslVO;
import kr.or.ddit.comm.elapr.vo.ElaprVO;
import kr.or.ddit.comm.elapr.vo.RerncVO;
import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;

public interface IElaprService {

	/**
	 *  메인 홈 카드 상단 3개
	 * @param empId 
	 * @return
	 */
	public List<ElaprVO> selectElaprCardList(String empId);
	
	/**
	 *  메인 홈 테이블
	 * @param empId 
	 * @return
	 */
	public List<ElaprVO> selectElaprTableList(String empId);

	/**
	 *  전자결재 양식 목록 출력 (Jstree)
	 * @param coCd
	 * @return
	 */
	public List<FormVO> selectFormListJstree(String coCd);

	/**
	 *  전자결재 상세보기
	 * @param elaprVO
	 * @return
	 */
	public ElaprVO elaprDetail(ElaprVO elaprVO);

	/**
	 * 프로젝트 수정폼
	 * @param elaprNo
	 * @return
	 */
	public ElaprVO selectElapr(int elaprNo);
	
	/**
	 *  전자결재 수정
	 * @param request 
	 * @param elaprVO
	 * @return
	 */
	public ServiceResult elaprUpdate(HttpServletRequest request, ElaprVO elaprVO);

	/**
	 * 전자결재 삭제
	 * @param request
	 * @param elaprNo
	 * @return
	 */
	public ServiceResult elaprDelete(HttpServletRequest request, int elaprNo);

	/**
	 * 전자결재 신청
	 * @param req
	 * @param elaprVO
	 * @return
	 */
	ServiceResult elaprInsert(HttpServletRequest req, ElaprVO elaprVO);


	/**
	 *  전자결재 데이터 가져오기
	 * @param empVO
	 * @return
	 */
	public EmployeeAllVO elaprSelectImpl(EmployeeVO empVO);

	public ElaprVO getElaprByNo(int elaprNo);

	/**
	 * 결재자 리스트
	 * @param param
	 * @return
	 */
	public List<AplnVO> selectAplnList(ElaprVO param);
	
	/**
	 * 참조자 리스트
	 * @param param
	 * @return
	 */
	public List<RerncVO> selectRerncList(ElaprVO param);

	/**
	 * 열람자 리스트
	 * @param param
	 * @return
	 */
	public List<ElaprPrslVO> selectPrslList(ElaprVO param);

	/**
	 * 결재대기문서 페이징
	 * @param pagingVO
	 * @return
	 */
	public int selectWatingCount(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 결재대기문서 리스트 
	 * @param pagingVO
	 * @return
	 */
	public List<ElaprVO> selectWatingList(PaginationInfoVO<ElaprVO> pagingVO);

	/**
	 * 결재대기문서 결재진행
	 * @param request
	 * @param aplnVO
	 * @return
	 */
	public ServiceResult elaprWatingUpdate(HttpServletRequest request, AplnVO aplnVO);

	/**
	 * 결재 상태가 모두 완료되었는지 확인
	 * @param elaprNo
	 * @return
	 */
	public int countPendingApprovals(int elaprNo);

	/**
	 * 모든 결재가 완료된 경우 전자결재 상태를 업데이트
	 * @param elaprNo
	 * @param status
	 */
	public void updateApprovalStatus(int elaprNo, String status);

	/**
	 * 결재대기문서 반려진행
	 * @param request
	 * @param aplnVO
	 * @return
	 */
	public ServiceResult elaprRjctUpdate(HttpServletRequest request, AplnVO aplnVO);

	/**
	 * 결재대기문서 반려 상태코드 업데이트
	 * @param elaprNo
	 * @return
	 */
	public int rjctElaprUpdate(int elaprNo);

	/**
	 * 완료일 업데이트
	 * @param elaprNo
	 * @return
	 */
	public int updateElaprEndDt(int elaprNo);

	/**
	 * 상신취소 유무
	 * @param elaprNo
	 * @return
	 */
	public int getApprovalCount(int elaprNo);

	/**
	 * 파일 디테일 불러오기
	 * @param atchFileDetailCd
	 * @return
	 */
	public AtchFileDetailVO atchFileDetailOneSelect(String atchFileDetailCd);

	/**
	 * 파일 디테일 리스트 불러오기
	 * @param atchFileCd
	 * @return
	 */
	public List<AtchFileDetailVO> atchFileDetailListSelect(String atchFileCd);


	
}

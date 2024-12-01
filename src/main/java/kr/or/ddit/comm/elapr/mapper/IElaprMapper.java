package kr.or.ddit.comm.elapr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.comm.elapr.vo.AplnVO;
import kr.or.ddit.comm.elapr.vo.ElaprPrslVO;
import kr.or.ddit.comm.elapr.vo.ElaprVO;
import kr.or.ddit.comm.elapr.vo.RerncVO;
import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;

public interface IElaprMapper {

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
	 * 전자결재 수정폼
	 * @param elaprNo
	 * @return
	 */
	public ElaprVO selectElapr(int elaprNo);
	
	/**
	 *  전자결재 수정하기
	 * @param elaprVO
	 * @return
	 */
	public int elaprUpdate(ElaprVO elaprVO);
	
	/**
	 * 결재선 삭제
	 * @param elaprNo
	 */
	public void deleteAlaprByElaprNo(int elaprNo);
	
	/**
	 * 참조자 삭제
	 * @param elaprNo
	 */
	public void deleteRerncByElaprNo(int elaprNo);

	/**
	 * 열람자 삭제
	 * @param elaprNo
	 */
	public void deletePrslByElaprNo(int elaprNo);

	

	/**
	 * 전자결재 삭제
	 * @param elaprNo
	 * @return
	 */
	public int deleteElapr(int elaprNo);


	/**
	 *  전자결재 신청
	 * @param elaprVO
	 * @return
	 */
	public int elaprInsert(ElaprVO elaprVO);

	/**
	 *  전자결재 데이터 가져오기
	 * @param empVO
	 * @return
	 */
	public EmployeeAllVO elaprSelectImpl(EmployeeVO empVO);

	/**
	 * 
	 * @param elaprNo
	 * @return
	 */
	public ElaprVO getElaprByNo(int elaprNo);

	/**
	 * 결재선 등록
	 * @param aplnVO
	 */
	public void insertApln(AplnVO aplnVO);

	/**
	 * 참조자 등록
	 * @param rerncVO
	 */
	public void insertRernc(RerncVO rerncVO);

	/**
	 * 열람자 등록
	 * @param prslVO
	 */
	public void insertPrsl(ElaprPrslVO prslVO);

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

	
	
	/////////////////////////////////////////////////////////////
	
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
	 * @param aplnVO
	 * @return
	 */
	public int elaprWatingUpdate(AplnVO aplnVO);


	 /**
	  * 결재 상태가 모두 완료되었는지 확인
	  * @param elaprNo
	  * @return
	  */
    public int countPendingApprovals(@Param("elaprNo") int elaprNo);

    /**
     * 모든 결재가 완료된 경우 전자결재 상태를 업데이트
     * @param elaprNo
     * @param status
     */
    public void updateApprovalStatus(@Param("elaprNo") int elaprNo, @Param("status") String status);

    /**
     * 결재대기문서 반려진행
     * @param aplnVO
     * @return
     */
	public int elaprRjctUpdate(AplnVO aplnVO);

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
	public int getApprovalCount(@Param("elaprNo") int elaprNo);

	public int atchFileInsert(ElaprVO elaprVO);

	public void fileDetailInsert(AtchFileDetailVO atchFileDetailVO);

	public AtchFileDetailVO atchFileDetailOneSelect(String atchFileDetailCd);

	public List<AtchFileDetailVO> atchFileDetailListSelect(String atchFileCd);


}

package kr.or.ddit.comm.elapr.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.elapr.mapper.IElaprMapper;
import kr.or.ddit.comm.elapr.service.IElaprService;
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

@Service
public class ElaprServiceImpl implements IElaprService {
	
	@Resource(name = "localPath")
	private String localPath;
	
	@Inject 
	private IElaprMapper elaprMapper;
	
	/**
	 *  메인 홈 카드 상단 3개
	 */
	@Override
	public List<ElaprVO> selectElaprCardList(String empId) {
		return elaprMapper.selectElaprCardList(empId);
	}

	/**
	 *  메인 홈 테이블
	 */
	@Override
	public List<ElaprVO> selectElaprTableList(String empId) {
		return elaprMapper.selectElaprTableList(empId);
	}

	/**
	 *  전자결재 양식 목록 출력 (Jstree)
	 */
	@Override
	public List<FormVO> selectFormListJstree(String coCd) {
		return elaprMapper.selectFormListJstree(coCd);
	}

	/**
	 *  전자결재 상세보기
	 */
	@Override
	public ElaprVO elaprDetail(ElaprVO elaprVO) {
		return elaprMapper.elaprDetail(elaprVO);
	}
	
	
	
	/**
	 * 프로젝트 수정폼
	 */
	@Override
	public ElaprVO selectElapr(int elaprNo) {
		return elaprMapper.selectElapr(elaprNo);
	}


	/**
	 * 전자결재 수정
	 */
	@Override
	public ServiceResult elaprUpdate(HttpServletRequest request, ElaprVO elaprVO) {
		ServiceResult result = null;
		int status = elaprMapper.elaprUpdate(elaprVO);
		
		if (status > 0) {
			List<AplnVO> aplnList = elaprVO.getAplnList();
			
			try {
				eplnUpdate(aplnList, elaprVO.getElaprNo(), request);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	private void eplnUpdate(List<AplnVO> aplnList, int elaprNo, HttpServletRequest request) {
		
		if (aplnList != null && aplnList.size() > 0) {
			
			for (AplnVO aplnVO : aplnList) {
				aplnVO.setElaprNo(elaprNo);
				elaprMapper.insertApln(aplnVO);
				
			}
		}
	}
	
	
	/**
	 * 전자결재 삭제
	 */
	@Override
	public ServiceResult elaprDelete(HttpServletRequest request, int elaprNo) {
		ServiceResult result = null;
		
		ElaprVO elaprVO = elaprMapper.selectElapr(elaprNo);
		elaprMapper.deleteAlaprByElaprNo(elaprNo);		// 결재자 삭제
		elaprMapper.deleteRerncByElaprNo(elaprNo);		// 참조자 삭제
		elaprMapper.deletePrslByElaprNo(elaprNo);		// 열람자 삭제
		
		int status = elaprMapper.deleteElapr(elaprNo);
		if (status > 0) {
			List<AplnVO> aplnList = elaprVO.getAplnList();
			List<RerncVO> rerncList = elaprVO.getRerncList();
			List<ElaprPrslVO> prslList = elaprVO.getPrslList();
			
			try {
				if (aplnList != null || rerncList != null || prslList != null) {
						result = ServiceResult.OK;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			result= ServiceResult.FAILED;
		}
		return result;
	}


	/**
	 * 전자결재 신청
	 */
	/*
	@Override
	public ServiceResult elaprInsert(HttpServletRequest req, ElaprVO elaprVO) {
		ServiceResult result;
		
		int status = elaprMapper.elaprInsert(elaprVO);

		if (status > 0) {
			List<AplnVO> aplnList = elaprVO.getAplnList();			// 결재선
			List<RerncVO> rerncList = elaprVO.getRerncList();		// 참조
			List<ElaprPrslVO> prslList = elaprVO.getPrslList();		// 열람
			
			
			aplnInsert(aplnList, elaprVO.getElaprNo(), req);			// 결재선
			rerncInsert(rerncList, elaprVO.getElaprNo(), req);			// 참조
			prslInsert(prslList, elaprVO.getElaprNo(), req);			// 열람
			
			
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
	*/
	
	@Override
	public ServiceResult elaprInsert(HttpServletRequest req, ElaprVO elaprVO) {
		ServiceResult result;
		
//		int status = elaprMapper.elaprInsert(elaprVO);
		int status = 0;

		if (elaprVO.getAtchFileDetailList() != null && elaprVO.getAtchFileDetailList().size() > 0) {
			status += elaprMapper.atchFileInsert(elaprVO);
			status += elaprMapper.elaprInsert(elaprVO);
			
			
//			if (status > 0) {
			if (status > 1) {
				List<AplnVO> aplnList = elaprVO.getAplnList();			// 결재선
				List<RerncVO> rerncList = elaprVO.getRerncList();		// 참조
				List<ElaprPrslVO> prslList = elaprVO.getPrslList();		// 열람
				
				
				aplnInsert(aplnList, elaprVO.getElaprNo(), req);			// 결재선
				rerncInsert(rerncList, elaprVO.getElaprNo(), req);			// 참조
				prslInsert(prslList, elaprVO.getElaprNo(), req);			// 열람
				
				List<AtchFileDetailVO>  elaprFileList = elaprVO.getAtchFileDetailList();
				fileUpload(elaprFileList, elaprVO.getElaprNo(), elaprVO.getAtchFileCd(), elaprVO.getEmpId());
				
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} else {
			status += elaprMapper.elaprInsert(elaprVO);
			
			if (status > 0) {
				List<AplnVO> aplnList = elaprVO.getAplnList();			// 결재선
				List<RerncVO> rerncList = elaprVO.getRerncList();		// 참조
				List<ElaprPrslVO> prslList = elaprVO.getPrslList();		// 열람
				
				
				aplnInsert(aplnList, elaprVO.getElaprNo(), req);			// 결재선
				rerncInsert(rerncList, elaprVO.getElaprNo(), req);			// 참조
				prslInsert(prslList, elaprVO.getElaprNo(), req);			// 열람
				
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		}
		return result;
		
	}
	
	private void fileUpload(List<AtchFileDetailVO> elaprFileList, int elaprNo, String atchFileCd, String empId) {
		String savePath = localPath + File.separator + "elapr" + File.separator + elaprNo;
		
		if (elaprFileList != null && elaprFileList.size() > 0) {
			for (AtchFileDetailVO atchFileDetailVO : elaprFileList) {
				String strgNm = UUID.randomUUID().toString()  + "_" + atchFileDetailVO.getAtchFileDetailOrgnlNm();
				atchFileDetailVO.setAtchFileDetailStrgNm(strgNm);
				
				String pathNm = savePath + File.separator + strgNm;
				atchFileDetailVO.setAtchFileDetailPathNm(pathNm);
				
				File file = new File(savePath);
				if (!file.exists()) {
					file.mkdirs();
				}
				
				atchFileDetailVO.setAtchFileCd(atchFileCd);
				atchFileDetailVO.setEmpId(empId);
				elaprMapper.fileDetailInsert(atchFileDetailVO);
				
				File saveFile = new File(pathNm);
				try {
					atchFileDetailVO.getMultiFile().transferTo(saveFile);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * 결재선 등록
	 * @param aplnList
	 * @param elaprNo
	 * @param req
	 */
	private void aplnInsert(List<AplnVO> aplnList, int elaprNo, HttpServletRequest req) {
		if (aplnList != null && aplnList.size() > 0) {
			for (AplnVO aplnVO : aplnList) {
				aplnVO.setElaprNo(elaprNo);
				// aplnVO.setAplnNo(aplnNo);
				elaprMapper.insertApln(aplnVO);
			}
		}
 	}
	
	
	/**
	 * 참조자 등록
	 * @param rerncList
	 * @param elaprNo
	 * @param req
	 */
	private void rerncInsert(List<RerncVO> rerncList, int elaprNo, HttpServletRequest req) {
		if (rerncList != null && rerncList.size() > 0) {
			for (RerncVO rerncVO : rerncList) {
				rerncVO.setElaprNo(elaprNo);
				elaprMapper.insertRernc(rerncVO);
			}
		}
	}

	/**
	 * 열람자 등록
	 * @param prslList
	 * @param elaprNo
	 * @param req
	 */
	private void prslInsert(List<ElaprPrslVO> prslList, int elaprNo, HttpServletRequest req) {
		if (prslList != null && prslList.size() > 0) {
			for (ElaprPrslVO prslVO : prslList) {
				prslVO.setElaprNo(elaprNo);
				elaprMapper.insertPrsl(prslVO);
			}
		}
	}
	

	/**
	 *  전자결재 데이터 가져오기
	 */
	@Override
	public EmployeeAllVO elaprSelectImpl(EmployeeVO empVO) {
		return elaprMapper.elaprSelectImpl(empVO);
	}

	@Override
	public ElaprVO getElaprByNo(int elaprNo) {
		return elaprMapper.getElaprByNo(elaprNo);
	}

	/**
	 * 결재자 리스트
	 */
	@Override
	public List<AplnVO> selectAplnList(ElaprVO param) {
		return elaprMapper.selectAplnList(param);
	}

	/**
	 * 참조자 리스트
	 */
	@Override
	public List<RerncVO> selectRerncList(ElaprVO param) {
		return elaprMapper.selectRerncList(param);
	}

	/**
	 * 열람자 리스트
	 */
	@Override
	public List<ElaprPrslVO> selectPrslList(ElaprVO param) {
 		return elaprMapper.selectPrslList(param);
	}

	
	/////////////////////////////////////////////////////////////
	
	/**
	 * 결재대기문서 페이징
	 */
	@Override
	public int selectWatingCount(PaginationInfoVO<ElaprVO> pagingVO) {
		return elaprMapper.selectWatingCount(pagingVO);
	}

	/**
	 * 결재대기문서 리스트
	 */
	@Override
	public List<ElaprVO> selectWatingList(PaginationInfoVO<ElaprVO> pagingVO) {
		return elaprMapper.selectWatingList(pagingVO);
	}

	/**
	 * 결재대기문서 결재진행
	 */
	@Override
	public ServiceResult elaprWatingUpdate(HttpServletRequest request, AplnVO aplnVO) {
	    ServiceResult result = null;
	    int status = elaprMapper.elaprWatingUpdate(aplnVO);

	    if (status > 0) {
	        result = ServiceResult.OK;
	    } else {
	        result = ServiceResult.FAILED;
	    }
	    return result;
	}
	
	@Override
	public int updateElaprEndDt(int elaprNo) {
		return elaprMapper.updateElaprEndDt(elaprNo);
	}

	/**
	 * 결재 상태가 모두 완료되었는지 확인
	 */
	@Override
	public int countPendingApprovals(int elaprNo) {
		return elaprMapper.countPendingApprovals(elaprNo);
	}

	/**
	 * 모든 결재가 완료된 경우 전자결재 상태를 업데이트
	 */
	@Override
	public void updateApprovalStatus(int elaprNo, String status) {
		elaprMapper.updateApprovalStatus(elaprNo, status);
	}

	/**
	 * 결재대기문서 반려진행
	 */
	@Override
	public ServiceResult elaprRjctUpdate(HttpServletRequest request, AplnVO aplnVO) {
		ServiceResult result = null;
	    int status = elaprMapper.elaprRjctUpdate(aplnVO);

	    if (status > 0) {
	        result = ServiceResult.OK;
	    } else {
	        result = ServiceResult.FAILED;
	    }
	    return result;
	}

	/**
	 * 결재대기문서 반려 상태코드 업데이트
	 */
	@Override
	public int rjctElaprUpdate(int elaprNo) {
		return elaprMapper.rjctElaprUpdate(elaprNo);
	}

	/**
	 * 상신취소 유무
	 */
	@Override
	public int getApprovalCount(int elaprNo) {
		return elaprMapper.getApprovalCount(elaprNo);
	}

	@Override
	public AtchFileDetailVO atchFileDetailOneSelect(String atchFileDetailCd) {
		return elaprMapper.atchFileDetailOneSelect(atchFileDetailCd);
	}

	@Override
	public List<AtchFileDetailVO> atchFileDetailListSelect(String atchFileCd) {
		return elaprMapper.atchFileDetailListSelect(atchFileCd);
	}
	

}

package kr.or.ddit.employee.vacation.service;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.employee.vacation.vo.VacationApplyApprovalVO;
import kr.or.ddit.employee.vacation.vo.VacationApplyVO;
import kr.or.ddit.employee.vacation.vo.VacationCreateDetailVO;

public interface IEmpVacationService {

	public List<VacationApplyVO> getAppDetail(PaginationInfoVO<VacationApplyVO> pagingVO);

	public List<VacationCreateDetailVO> getvctcrtDetailList(PaginationInfoVO<VacationCreateDetailVO> pagingVO);

	public int getvctcrtDetailListCount(PaginationInfoVO<VacationCreateDetailVO> pagingVO);
	
	public int getvctAppDetailListCount(PaginationInfoVO<VacationApplyVO> pagingVO);

	public int getVctCnt(String empId);

	public String getVaSeq();

	public int insertVacationApply(VacationApplyVO vaVO);

	public int insertVacationApplyApproval(VacationApplyApprovalVO vaaVO);

	public int getVctApplyCnt(String empId);

	public int getvctAppAprListCount(PaginationInfoVO<VacationApplyVO> pagingVO);

	public List<VacationApplyVO> getAppAprList(PaginationInfoVO<VacationApplyVO> pagingVO);

	public VacationApplyVO getApprovalInfo(String vctAplyCd);

	public int aplyapr(VacationApplyApprovalVO getVaaVO);

	public String getRsn(String code);


}

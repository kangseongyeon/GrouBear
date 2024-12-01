package kr.or.ddit.employee.vacation.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.employee.vacation.mapper.IEmpVacationMapper;
import kr.or.ddit.employee.vacation.service.IEmpVacationService;
import kr.or.ddit.employee.vacation.vo.VacationApplyApprovalVO;
import kr.or.ddit.employee.vacation.vo.VacationApplyVO;
import kr.or.ddit.employee.vacation.vo.VacationCreateDetailVO;

@Service
public class EmpVacationServiceImpl implements IEmpVacationService{

	@Inject
	 private IEmpVacationMapper mapper;
	
	@Override
	public List<VacationApplyVO> getAppDetail(PaginationInfoVO<VacationApplyVO> pagingVO) {
		return mapper.getAppDetail(pagingVO);
	}

	@Override
	public List<VacationCreateDetailVO> getvctcrtDetailList(PaginationInfoVO<VacationCreateDetailVO> pagingVO){
		return mapper.getVctCrtDetailList(pagingVO);
	}

	@Override
	public int getvctcrtDetailListCount(PaginationInfoVO<VacationCreateDetailVO> pagingVO) {
		return mapper.getvctcrtDetailListCount(pagingVO);
	}

	@Override
	public int getvctAppDetailListCount(PaginationInfoVO<VacationApplyVO> pagingVO) {
		return mapper.getvctAppDetailListCount(pagingVO);
	}

	@Override
	public int getVctCnt(String empId) {
		return mapper.getVctCnt(empId);
	}

	@Override
	public String getVaSeq() {
		return mapper.getVaSeq();
	}

	@Override
	public int insertVacationApply(VacationApplyVO vaVO) {
		return mapper.insertVacationApply(vaVO);
	}

	@Override
	public int insertVacationApplyApproval(VacationApplyApprovalVO vaaVO) {
		return mapper.insertVacationApplyApproval(vaaVO);
	}

	@Override
	public int getVctApplyCnt(String empId) {
		return mapper.getVctApplyCnt(empId);
	}

	@Override
	public int getvctAppAprListCount(PaginationInfoVO<VacationApplyVO> pagingVO) {
		return mapper.getvctAppAprListCount(pagingVO);
	}

	@Override
	public List<VacationApplyVO> getAppAprList(PaginationInfoVO<VacationApplyVO> pagingVO) {
		return mapper.getAppAprList(pagingVO);
	}

	@Override
	public VacationApplyVO getApprovalInfo(String vctAplyCd) {
		return mapper.getApprovalInfo(vctAplyCd);
	}

	@Override
	public int aplyapr(VacationApplyApprovalVO getVaaVO) {
		return mapper.aplyapr(getVaaVO);
	}

	@Override
	public String getRsn(String code) {
		return mapper.getRsn(code);
	}

}

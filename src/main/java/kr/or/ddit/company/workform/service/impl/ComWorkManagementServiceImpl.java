package kr.or.ddit.company.workform.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.workform.mapper.IComWorkManagementMapper;
import kr.or.ddit.company.workform.service.IComWorkManagementService;
import kr.or.ddit.company.workform.vo.CompanyWorkFormVO;
import kr.or.ddit.company.workform.vo.WorkFormVO;
import kr.or.ddit.employee.workStatus.vo.EmpWorkStatusVO;

@Service
public class ComWorkManagementServiceImpl implements IComWorkManagementService{

	@Inject
	private IComWorkManagementMapper workManagementMapper;
	
	@Override
	public int insertBaseWorkForm(WorkFormVO wfVO) {
		return workManagementMapper.insertBaseWorkForm(wfVO);
	}

	@Override
	public WorkFormVO getBaseWorkForm(EmployeeVO empVO) {
		return workManagementMapper.getBaseWorkForm(empVO);
	}

	@Override
	public int udtBaseWorkForm(WorkFormVO getwfVO) {
		return workManagementMapper.udtBaseWorkForm(getwfVO);
	}

	@Override
	public int insertDeptWorkForm(WorkFormVO wfVO) {
		return workManagementMapper.insertDeptWorkForm(wfVO);
	}

	@Override
	public WorkFormVO getDeptWorkForm(String deptCd) {
		return workManagementMapper.getDeptWorkForm(deptCd);
	}

	@Override
	public int udtDeptWorkForm(WorkFormVO wfVO) {
		return workManagementMapper.udtDeptWorkForm(wfVO);
	}

	@Override
	public List<CompanyWorkFormVO> getWorkFormList(EmployeeVO empVO) {
		return workManagementMapper.getWorkFormList(empVO);
	}

	@Override
	public List<EmpWorkStatusVO> getTodayWorkStatus(PaginationInfoVO<EmpWorkStatusVO> pagingVO) {
		return workManagementMapper.getTodayWorkStatus(pagingVO);
	}

	@Override
	public int getTodayWorkStatustCount(PaginationInfoVO<EmpWorkStatusVO> pagingVO) {
		return workManagementMapper.getTodayWorkStatustCount(pagingVO);
	}

	@Override
	public EmpWorkStatusVO getEmpTodayWorkStts(String empId) {
		return workManagementMapper.getEmpTodayWorkStts(empId);
	}

	@Override
	public int updateEmpTodayWorkStts(EmpWorkStatusVO empWorkSttsVO) {
		return workManagementMapper.updateEmpTodayWorkStts(empWorkSttsVO);
	}

	@Override
	public int delEmpTodayWorkStts(String wscd) {
		return workManagementMapper.delEmpTodayWorkStts(wscd);
	}


		

	@Override
	public void setBasicworkForm(WorkFormVO setCoCd) {
		workManagementMapper.setBasicworkForm(setCoCd);
		
	}


}

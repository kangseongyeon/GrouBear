package kr.or.ddit.company.jobgrade.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.company.jobgrade.mapper.IJobgradeMapper;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;

@Service
public class JobgradeServiceImpl implements IJobgradeService {

	@Inject
	private IJobgradeMapper jobgradeMapper;
	
	@Override
	public List<JobGradeVO> selectJbgd(String coCd) {
		return jobgradeMapper.selectJbgd(coCd);
	}

	@Override
	public JobGradeVO getJbgdVO(String jbgdCd) {
		return jobgradeMapper.getJbgdVO(jbgdCd);
	}

	@Override
	public ServiceResult jbgdModify(HttpServletRequest req, JobGradeVO jobGradeVO) {
		ServiceResult result = null;
		int status = jobgradeMapper.jbgdModify(jobGradeVO);
		
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult jbgdInsert(HttpServletRequest req, JobGradeVO jobGradeVO) {
		ServiceResult result = null;
		int status = jobgradeMapper.jbgdInsert(jobGradeVO);
		
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}


	@Override
	public ServiceResult deleteJbgd(JobGradeVO jobGradeVO) {
		ServiceResult result = null;
		int status = jobgradeMapper.deleteJbgd(jobGradeVO);
		
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

}

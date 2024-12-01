package kr.or.ddit.company.jobgrade.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;

public interface IJobgradeService {

	public List<JobGradeVO> selectJbgd(String coCd);

	public JobGradeVO getJbgdVO(String jbgdCd);

	public ServiceResult jbgdModify(HttpServletRequest req, JobGradeVO jobGradeVO);

	public ServiceResult jbgdInsert(HttpServletRequest req, JobGradeVO jobGradeVO);

	public ServiceResult deleteJbgd(JobGradeVO jobGradeVO);


}

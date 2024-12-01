package kr.or.ddit.company.jobgrade.mapper;

import java.util.List;

import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;

public interface IJobgradeMapper {

	public List<JobGradeVO> selectJbgd(String coCd);

	public JobGradeVO getJbgdVO(String jbgdCd);

	public int jbgdModify(JobGradeVO jobGradeVO);

	public int jbgdInsert(JobGradeVO jobGradeVO);

	public int deleteJbgd(JobGradeVO jobGradeVO);


}

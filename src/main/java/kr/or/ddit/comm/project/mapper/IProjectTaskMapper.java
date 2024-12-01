package kr.or.ddit.comm.project.mapper;

import java.util.List;

import kr.or.ddit.comm.project.vo.ProjectParticipantVO;
import kr.or.ddit.comm.project.vo.ProjectTaskVO;
import kr.or.ddit.comm.project.vo.ProjectVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;

public interface IProjectTaskMapper {

	/**
	 *  일감 추가
	 * @param projectTaskVO
	 * @return
	 */
	public int insertProTask(ProjectTaskVO projectTaskVO);

	/**
	 *  내 일감 리스트
	 * @param proNo
	 * @return
	 */
	public List<ProjectParticipantVO> selectProTaskList(int proNo);

	/**
	 *  일감 수정폼
	 * @param proNo
	 * @return
	 */
	public ProjectTaskVO selectProTask(int proNo);

	/**
	 *  일감 수정
	 * @param projectTaskVO
	 * @return
	 */
	public int updateProTask(ProjectTaskVO projectTaskVO);

	/**
	 *  일감 삭제
	 * @param proTaskNo
	 * @return
	 */
	public int deleteProTask(int proTaskNo);

	/**
	 *  프로젝트 - 일감 연결
	 * @param proTaskNo
	 * @return
	 */
	public int selectProNoByTaskNo(int proTaskNo);

	/**
	 *  일감 상태코드 변경
	 * @param ptVO
	 * @return
	 */
	public int updateProTaskStts(ProjectTaskVO ptVO);

	/**
	 *  간트 차트 리스트
	 * @param proNo
	 * @return
	 */
	public List<ProjectTaskVO> selectGanttList(int proNo);

	public EmployeeVO getEmpByID(String empId);

	
}

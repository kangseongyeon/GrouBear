package kr.or.ddit.comm.project.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.comm.project.vo.ProjectParticipantVO;
import kr.or.ddit.comm.project.vo.ProjectVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;

public interface IProjectMapper {
	

	/**
	 *  프로젝트 진행 / 완료 상태 변경
	 * @param empId
	 * @return
	 */
	public void updateProjectStts();

	/**
	 *  프로젝트 메인 홈 카드 리스트
	 * @param empId
	 * @return
	 */
	public List<ProjectVO> selectProCardList(String empId);

	/**
	 *  프로젝트 메인 홈 테이블 리스트
	 * @param empId
	 * @return
	 */
	public List<ProjectVO> selectProTableList(String empId);

	/**
	 *  칸반보드 리스트
	 * @param proNo
	 * @return
	 */
	public ProjectVO selectCanbanList(int proNo);

	/**
	 *  프로젝트 추가
	 * @param projectVO
	 * @return
	 */
	public int insertProForm(ProjectVO projectVO);
	
	/**
	 *  프로젝트 참가자 추가
	 * @param projectParticipantVO
	 */
	public void projectParticipantInsert(ProjectParticipantVO projectParticipantVO);

	/**
	 *  프로젝트 수정폼
	 * @param proNo
	 * @return
	 */
	public ProjectVO selectProject(int proNo);

	/**
	 *  프로젝트 수정
	 * @param projectVO
	 * @return
	 */
	public int updateProject(ProjectVO projectVO);

	/**
	 *  프로젝트 참가자 정보
	 * @param integer
	 * @return
	 */
	public ProjectParticipantVO selectProjectParticipant(Integer integer);

	/**
	 *  참가자 삭제
	 * @param integer
	 */
	public void deleteProjectParticipant(Integer integer);

	public void deleteProjectParticipantByProNo(int proNo);

	/**
	 * 프로젝트 삭제
	 * @param proNo
	 * @return
	 */
	public int deleteProject(int proNo);

	/**
	 * 날짜 유효성 검사
	 * @param proNo
	 * @return
	 */
	public ProjectVO getProjectByNo(int proNo);

	/**
	 * 참여자 리스트 출력
	 * @param proNo
	 * @return
	 */
	public List<EmployeeVO> getParticipantList(int proNo);
	
	/**
	 *  프로젝트 진행 / 완료 상태 변경
	 * @param coCd
	 * @return
	 */
	public List<ProjectVO> selectComProCardList(String coCd);

}

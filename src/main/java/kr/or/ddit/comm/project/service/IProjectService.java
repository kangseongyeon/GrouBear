package kr.or.ddit.comm.project.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.comm.project.vo.ProjectVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;

public interface IProjectService {
	

	/**
	 *  프로젝트 진행 / 완료 상태 변경
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
	 * @param req
	 * @param projectVO
	 * @return
	 */
	public ServiceResult insertProForm(HttpServletRequest req, ProjectVO projectVO);

	/**
	 *  프로젝트 수정폼
	 * @param proNo
	 * @return
	 */
	public ProjectVO selectProject(int proNo);
	
	/**
	 *  프로젝트 수정
	 * @param req
	 * @param projectVO
	 * @return
	 */
	public ServiceResult updateProject(HttpServletRequest req, ProjectVO projectVO);

	/**
	 *  프로젝트 삭제
	 * @param req
	 * @param proNo
	 * @return
	 */
	public ServiceResult deleteProject(HttpServletRequest req, int proNo);

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
	 * 프로젝트 기업 리스트 출력
	 * @param coCd
	 * @return
	 */
	public List<ProjectVO> selectComProCardList(String coCd);


}

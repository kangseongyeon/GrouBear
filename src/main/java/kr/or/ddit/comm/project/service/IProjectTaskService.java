package kr.or.ddit.comm.project.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.comm.project.vo.ProjectParticipantVO;
import kr.or.ddit.comm.project.vo.ProjectTaskVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;

public interface IProjectTaskService {

	/** 일감 추가
	 * 
	 * @param req
	 * @param projectTaskVO
	 * @return
	 */
	public ServiceResult insertProTask(HttpServletRequest req, ProjectTaskVO projectTaskVO);

	/**
	 *  내 일감 리스트
	 * @param proNo
	 * @return
	 */
	public List<ProjectParticipantVO> selectProTaskList(int proNo);

	/**
	 *  일감 수정폼
	 * @param proTaskNo
	 * @return
	 */
	public ProjectTaskVO selectProTask(int proTaskNo);

	/**
	 *  일감 수정
	 * @param req
	 * @param projectTaskVO
	 * @return
	 */
	public ServiceResult updateProTask(HttpServletRequest req, ProjectTaskVO projectTaskVO);
	
	/**
	 *  일감 삭제
	 * @param req
	 * @param proTaskNo
	 * @return
	 */
	public ServiceResult deleteProTask(HttpServletRequest req, int proTaskNo);

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
	 *  간트차트 리스트
	 * @param proNo
	 * @return
	 */
	public List<ProjectTaskVO> selectGanttList(int proNo);



}

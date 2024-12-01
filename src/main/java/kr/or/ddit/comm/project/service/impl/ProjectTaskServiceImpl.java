package kr.or.ddit.comm.project.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.project.mapper.IProjectTaskMapper;
import kr.or.ddit.comm.project.service.IProjectTaskService;
import kr.or.ddit.comm.project.vo.ProjectParticipantVO;
import kr.or.ddit.comm.project.vo.ProjectTaskVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;

@Service
public class ProjectTaskServiceImpl implements IProjectTaskService {

	@Inject
	private IProjectTaskMapper projectTaskMapper;
	
	/**
	 *  일감 추가
	 */
	@Override
	public ServiceResult insertProTask(HttpServletRequest req, ProjectTaskVO projectTaskVO) {
		ServiceResult result = null;
		int status = projectTaskMapper.insertProTask(projectTaskVO);
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	/**
	 *  내 일감 리스트
	 */
	@Override
	public List<ProjectParticipantVO> selectProTaskList(int proNo) {
		return projectTaskMapper.selectProTaskList(proNo);
	}

	/**
	 *  일감 수정폼
	 */
	@Override
	public ProjectTaskVO selectProTask(int proTaskNo) {
		return projectTaskMapper.selectProTask(proTaskNo);
	}

	/**
	 *  일감 수정
	 */
	@Override
	public ServiceResult updateProTask(HttpServletRequest req, ProjectTaskVO projectTaskVO) {
		ServiceResult result = null;
		int status = projectTaskMapper.updateProTask(projectTaskVO);
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}


	/**
	 *  일감 삭제
	 */
	@Override
	public ServiceResult deleteProTask(HttpServletRequest req, int proTaskNo) {
		ServiceResult result = null;
		
		int status = projectTaskMapper.deleteProTask(proTaskNo);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	/**
	 *  프로젝트 - 일감 연결
	 */
	@Override
	public int selectProNoByTaskNo(int proTaskNo) {
		return projectTaskMapper.selectProNoByTaskNo(proTaskNo);
	}

	/**
	 *  일감 상태코드 변경
	 */
	@Override
	public int updateProTaskStts(ProjectTaskVO ptVO) {
		return projectTaskMapper.updateProTaskStts(ptVO);
	}

	/**
	 *  간트차트 리스트
	 */
	@Override
	public List<ProjectTaskVO> selectGanttList(int proNo) {
		return projectTaskMapper.selectGanttList(proNo);
	}
}

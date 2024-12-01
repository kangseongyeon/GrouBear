package kr.or.ddit.comm.project.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.project.mapper.IProjectMapper;
import kr.or.ddit.comm.project.service.IProjectService;
import kr.or.ddit.comm.project.vo.ProjectParticipantVO;
import kr.or.ddit.comm.project.vo.ProjectVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;

@Service
public class ProjectServiceImpl implements IProjectService {

	@Inject
	private IProjectMapper projectMapper;
	

	/**
	 *  프로젝트 진행 / 완료 상태 변경
	 */
	@Override
	public void updateProjectStts() {
		projectMapper.updateProjectStts();
	}
	
	
	/**
	 *  프로젝트 메인 홈 카드 리스트
	 */
	@Override
	public List<ProjectVO> selectProCardList(String empId) {
		return projectMapper.selectProCardList(empId);
	}

	/**
	 *  프로젝트 메인 홈 테이블 리스트
	 */
	@Override
	public List<ProjectVO> selectProTableList(String empId) {
		return projectMapper.selectProTableList(empId);
	}

	/**
	 *  칸반보드 리스트
	 */
	@Override
	public ProjectVO selectCanbanList(int proNo) {
		return projectMapper.selectCanbanList(proNo);
	}

	/**
	 *  프로젝트 추가
	 */
	@Override
	public ServiceResult insertProForm(HttpServletRequest req, ProjectVO projectVO) {
		ServiceResult result = null;
		int status = projectMapper.insertProForm(projectVO);
		if (status > 0) {
			List<ProjectParticipantVO> participantList = projectVO.getParticipantList();
			projectParticipantInsert(participantList, projectVO.getProNo(), req);
			
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	/**
	 *  프로젝트 참가자 추가
	 * @param participantList
	 * @param proNo
	 * @param req
	 */
	private void projectParticipantInsert(List<ProjectParticipantVO> participantList, int proNo,
			HttpServletRequest req) {
		
		if (participantList != null && participantList.size() > 0) {
			for (ProjectParticipantVO projectParticipantVO : participantList) {
				projectParticipantVO.setProNo(proNo);
				projectMapper.projectParticipantInsert(projectParticipantVO);
			}
		}
	}

	/**
	 *  프로젝트 수정폼
	 */
	@Override
	public ProjectVO selectProject(int proNo) {
		return projectMapper.selectProject(proNo);
	}

	/**
	 *  프로젝트 수정
	 */
	@Override
	public ServiceResult updateProject(HttpServletRequest req, ProjectVO projectVO) {
		ServiceResult result = null;
		int status = projectMapper.updateProject(projectVO);
		if (status > 0) {
			List<ProjectParticipantVO> participantList = projectVO.getParticipantList();
			
			try {
				projectParticipantInsert(participantList, projectVO.getProNo(), req);
				
				Integer[] delProjectNo = projectVO.getDelProjectNo();
				if (delProjectNo != null) {
					for (int i=0; i<delProjectNo.length; i++) {
						ProjectParticipantVO projectParticipantVO = projectMapper.selectProjectParticipant(delProjectNo[i]);
						projectMapper.deleteProjectParticipant(delProjectNo[i]);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	/**
	 *  프로젝트 삭제
	 */
	@Override
	public ServiceResult deleteProject(HttpServletRequest req, int proNo) {
		ServiceResult result = null;
		
		ProjectVO projectVO = projectMapper.selectProject(proNo);
		projectMapper.deleteProjectParticipantByProNo(proNo);
		
		int status = projectMapper.deleteProject(proNo);
		if (status > 0) {
			List<ProjectParticipantVO> participantList = projectVO.getParticipantList();
			
			try {
				if (participantList != null) {
					result = ServiceResult.OK;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}

	/**
	 * 날짜 유효성 검사
	 */
	@Override
	public ProjectVO getProjectByNo(int proNo) {
		return projectMapper.getProjectByNo(proNo);
	}

	/**
	 * 참여자 리스트 출력
	 */
	@Override
	public List<EmployeeVO> getParticipantList(int proNo) {
		return projectMapper.getParticipantList(proNo);
	}

	/**
	 * 프로젝트 기업 리스트 출력
	 */
	
	@Override
	public List<ProjectVO> selectComProCardList(String coCd) {
		return projectMapper.selectComProCardList(coCd);
	}

}

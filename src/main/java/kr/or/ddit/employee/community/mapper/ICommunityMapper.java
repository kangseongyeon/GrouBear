package kr.or.ddit.employee.community.mapper;

import java.util.List;

import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.file.vo.AtchFileVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.employee.comment.vo.CommentVO;
import kr.or.ddit.employee.community.vo.CommunityVO;

public interface ICommunityMapper {
	
	public List<CommunityVO> communityFree(EmployeeVO employeeVO);

	public List<CommunityVO> communityCompany(EmployeeVO employeeVO);

	public List<CommunityVO> communityInfo(EmployeeVO employeeVO);

	public void insertCommunity(CommunityVO communityVO);

	public void incrementHit(int cmntyNo);

	public void communityModify(CommunityVO communityVO);

	public CommunityVO communityDetail(int cmntyNo);

	public int removeCommunity(int cmntyNo);

	public void atchFileinsert(AtchFileVO afVO);

	public void atchFileDetailInsert(AtchFileDetailVO atchFileDetailVO);

	public void deleteAtchFile(AtchFileDetailVO atchFileDetailVO);

	public void updateAtchFile(AtchFileDetailVO atchFileDetailVO);

	public int deleteYAtchFile(String atchFileCd);

	public int deleteNAtchFile(String string);

	public void addAtchFile(AtchFileDetailVO i);

	public int selectCmntyCount(PaginationInfoVO<CommunityVO> pagingVO);

	public List<CommunityVO> selectCmntyList(PaginationInfoVO<CommunityVO> pagingVO);

	public void downloadFile(AtchFileDetailVO atchFileDetailVO);

	public List<CommunityVO> communityMain(CommunityVO communityVO);

//	public CommentVO showComment(int cmtNo);



}

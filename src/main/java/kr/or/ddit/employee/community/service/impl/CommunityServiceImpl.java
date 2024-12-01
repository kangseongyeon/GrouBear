package kr.or.ddit.employee.community.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.file.vo.AtchFileVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.employee.community.mapper.ICommunityMapper;
import kr.or.ddit.employee.community.service.ICommunityService;
import kr.or.ddit.employee.community.vo.CommunityVO;

@Service
public class CommunityServiceImpl implements ICommunityService {

	@Inject
	private ICommunityMapper mapper;


	@Override
	public List<CommunityVO> communityFree(EmployeeVO employeeVO) {
		return mapper.communityFree(employeeVO);
	}

	@Override
	public List<CommunityVO> communityCompany(EmployeeVO employeeVO) {
		return mapper.communityCompany(employeeVO);
	}

	@Override
	public List<CommunityVO> communityInfo(EmployeeVO employeeVO) {
		return mapper.communityInfo(employeeVO);
	}

	@Override
	public void insertCommunity(CommunityVO communityVO) {
		mapper.insertCommunity(communityVO);
	}

	@Override
	public String atchFileInsert(AtchFileVO afVO) {
		mapper.atchFileinsert(afVO);

		List<AtchFileDetailVO> atchFileDetailList = afVO.getAtchFileDetailList();

		for (AtchFileDetailVO atchFileDetailVO : atchFileDetailList) {
			atchFileDetailVO.setAtchFileCd(afVO.getAtchFileCd());
			mapper.atchFileDetailInsert(atchFileDetailVO);
		}

		return afVO.getAtchFileCd();
	}

	@Override
	public CommunityVO communityDetail(int cmntyNo) throws Exception {
		mapper.incrementHit(cmntyNo);

		CommunityVO communityVO =  mapper.communityDetail(cmntyNo);
		
		return communityVO;
	}

	@Override
	public void deleteAtchFile(AtchFileDetailVO atchFileDetailVO) {
		mapper.deleteAtchFile(atchFileDetailVO);
	}

	@Override
	public void updateAtchFile(AtchFileDetailVO atchFileDetailVO) {
		AtchFileVO afVO = new AtchFileVO();
		atchFileDetailVO.setAtchFileCd(afVO.getAtchFileCd());
		atchFileInsert(afVO);
		mapper.updateAtchFile(atchFileDetailVO);
	}

	@Override
	public void communityModify(CommunityVO communityVO) {
		mapper.communityModify(communityVO);
	}

	@Override
	public int removeCommunity(int cmntyNo) {
		return mapper.removeCommunity(cmntyNo);
	}

	@Override
	public int deleteYAtchFile(String atchFileCd) {
		return mapper.deleteYAtchFile(atchFileCd);
	}

	@Override
	public int deleteNAtchFile(String string) {
		return mapper.deleteNAtchFile(string);
	}

	@Override
	public void addAtchFile(AtchFileDetailVO i) {
		mapper.addAtchFile(i);
	}

	@Override
	public int selectCmntyCount(PaginationInfoVO<CommunityVO> pagingVO) {
		return mapper.selectCmntyCount(pagingVO);
	}

	@Override
	public List<CommunityVO> selectCmntyList(PaginationInfoVO<CommunityVO> pagingVO) {
		return mapper.selectCmntyList(pagingVO);
	}

	@Override
	public void downloadFile(AtchFileDetailVO atchFileDetailVO) {
		mapper.downloadFile(atchFileDetailVO);
	}

	@Override
	public List<CommunityVO> communityMain(CommunityVO communityVO) {
		return mapper.communityMain(communityVO);
	}

//	@Override
//	public CommentVO showComment(int cmtNo) {
//		return mapper.showComment(cmtNo);
//	}


}

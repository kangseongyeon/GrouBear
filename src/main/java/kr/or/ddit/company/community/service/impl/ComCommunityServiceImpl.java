package kr.or.ddit.company.community.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.file.vo.AtchFileVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.community.mapper.IComCommunityMapper;
import kr.or.ddit.company.community.service.IComCommunityService;
import kr.or.ddit.company.community.vo.ComCommunityVO;

@Service
public class ComCommunityServiceImpl implements IComCommunityService {

	@Inject
	private IComCommunityMapper mapper;


	@Override
	public List<ComCommunityVO> communityFree(EmployeeVO employeeVO) {
		return mapper.communityFree(employeeVO);
	}

	@Override
	public List<ComCommunityVO> communityCompany(EmployeeVO employeeVO) {
		return mapper.communityCompany(employeeVO);
	}

	@Override
	public List<ComCommunityVO> communityInfo(EmployeeVO employeeVO) {
		return mapper.communityInfo(employeeVO);
	}

	@Override
	public void insertCommunity(ComCommunityVO ComCommunityVO) {
		mapper.insertCommunity(ComCommunityVO);
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
	public ComCommunityVO communityDetail(int cmntyNo) throws Exception {
		mapper.incrementHit(cmntyNo);

		ComCommunityVO ComCommunityVO =  mapper.communityDetail(cmntyNo);
		
		return ComCommunityVO;
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
	public void communityModify(ComCommunityVO ComCommunityVO) {
		mapper.communityModify(ComCommunityVO);
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
	public int selectCmntyCount(PaginationInfoVO<ComCommunityVO> pagingVO) {
		return mapper.selectCmntyCount(pagingVO);
	}

	@Override
	public List<ComCommunityVO> selectCmntyList(PaginationInfoVO<ComCommunityVO> pagingVO) {
		return mapper.selectCmntyList(pagingVO);
	}

	@Override
	public void downloadFile(AtchFileDetailVO atchFileDetailVO) {
		mapper.downloadFile(atchFileDetailVO);
	}

//	@Override
//	public CommentVO showComment(int cmtNo) {
//		return mapper.showComment(cmtNo);
//	}


}

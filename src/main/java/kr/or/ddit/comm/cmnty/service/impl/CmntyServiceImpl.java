package kr.or.ddit.comm.cmnty.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.cmnty.mapper.ICmntyMapper;
import kr.or.ddit.comm.cmnty.service.ICmntyService;
import kr.or.ddit.comm.cmnty.vo.CmntyVO;
import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;

@Service
public class CmntyServiceImpl implements ICmntyService {
	@Resource(name = "localPath")
	private String localPath;
	
	@Inject
	private ICmntyMapper cmntyMapper;
	
	@Override
	public int noticeSelectListCount(PaginationInfoVO<CmntyVO> pagingVO) {
		return cmntyMapper.noticeSelectListCount(pagingVO);
	}

	@Override
	public List<CmntyVO> noticeSelectList(PaginationInfoVO<CmntyVO> pagingVO) {
		return cmntyMapper.noticeSelectList(pagingVO);
	}

	@Override
	public CmntyVO noticeSelectOne(int cmntyNo) {
		// 조회수 증가하기
		cmntyMapper.incrementHit(cmntyNo);
		
		return cmntyMapper.noticeSelectOne(cmntyNo);
	}

	@Override
	public AtchFileDetailVO atchFileDetailOneSelect(String atchFileDetailCd) {
		return cmntyMapper.atchFileDetailOneSelect(atchFileDetailCd);
	}

	@Override
	public List<AtchFileDetailVO> atchFileDetailListSelect(String atchFileCd) {
		return cmntyMapper.atchFileDetailListSelect(atchFileCd);
	}

	@Override
	public int qstnSelectListCount(PaginationInfoVO<CmntyVO> pagingVO) {
		return cmntyMapper.qstnSelectListCount(pagingVO);
	}

	@Override
	public List<CmntyVO> qstnSelectList(PaginationInfoVO<CmntyVO> pagingVO) {
		return cmntyMapper.qstnSelectList(pagingVO);
	}

	@Override
	public CmntyVO qstnSelectOne(int cmntyNo) {
		return cmntyMapper.qstnSelectOne(cmntyNo);
	}

	@Override
	public ServiceResult cmntyQstnInsert(CmntyVO cmntyVO) {
		ServiceResult result = null;
		
		int status = cmntyMapper.cmntyQstnInsert(cmntyVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult cmntyQstnDelete(int cmntyNo) {
		ServiceResult result = null;
		
		int status = cmntyMapper.cmntyQstnDelete(cmntyNo);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult cmntyQstnModify(CmntyVO cmntyVO) {
		ServiceResult result = null;
		
		int status = cmntyMapper.cmntyQstnModify(cmntyVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
}

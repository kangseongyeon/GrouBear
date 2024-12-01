package kr.or.ddit.groubear.cmnty.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.cmnty.vo.CmntyVO;
import kr.or.ddit.comm.cmnty.vo.CmtVO;
import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.groubear.cmnty.mapper.IGroCmntyMapper;
import kr.or.ddit.groubear.cmnty.service.IGroCmntyService;

@Service
public class GroCmntyServiceImpl implements IGroCmntyService {
	@Resource(name = "localPath")
	private String localPath;
	
	@Inject
	IGroCmntyMapper cmntyMapper;
	
	@Override
	public int groNoticeSelectListCount(PaginationInfoVO<CmntyVO> pagingVO) {
		return cmntyMapper.groNoticeSelectListCount(pagingVO);
	}

	@Override
	public List<CmntyVO> groNoticeSelectList(PaginationInfoVO<CmntyVO> pagingVO) {
		return cmntyMapper.groNoticeSelectList(pagingVO);
	}

	@Override
	public CmntyVO groNoticeSelectOne(int cmntyNo) {
		// 조회수 증가하기
		cmntyMapper.incrementHit(cmntyNo);
		
		return cmntyMapper.groNoticeSelectOne(cmntyNo);
	}

	@Override
	public AtchFileDetailVO atchFileDetailOneSelect(String atchFileDetailCd) {
		return cmntyMapper.atchFileDetailOneSelect(atchFileDetailCd);
	}

	@Override
	public ServiceResult cmntyNoticeInsert(CmntyVO cmntyVO) {
		ServiceResult result = null;
		int status = 0;
		
		// 파일 데이터가 있을 때
		if (cmntyVO.getAtchFileDetailList() != null && cmntyVO.getAtchFileDetailList().size() > 0) {
			status += cmntyMapper.atchFileInsert(cmntyVO);
			status += cmntyMapper.cmntyNoticeInsert(cmntyVO);
			
			// 두개의 등록이 모두 성공이라면
			if (status > 1) {
				List<AtchFileDetailVO> noticeFileList = cmntyVO.getAtchFileDetailList();
				fileUpload(noticeFileList, cmntyVO.getCmntyNo(), cmntyVO.getAtchFileCd(), cmntyVO.getEmpId());
				
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
			
		} else {	// 파일 데이터가 없을 때 
			status += cmntyMapper.cmntyNoticeInsert(cmntyVO);
			
			if (status > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		}
		return result;
	}

	private void fileUpload(List<AtchFileDetailVO> noticeFileList, 
							int cmntyNo, String atchFileCd, String empId) {
		String savePath = localPath + File.separator + "GroCommunity" + File.separator + cmntyNo;
		
		if (noticeFileList != null && noticeFileList.size() > 0) {
			for (AtchFileDetailVO atchFileDetailVO : noticeFileList) {
				// 저장 이름 세팅하기
				String strgNm = UUID.randomUUID().toString() + "_" +  atchFileDetailVO.getAtchFileDetailOrgnlNm();
				atchFileDetailVO.setAtchFileDetailStrgNm(strgNm);
				
				// 저장 경로명 세팅하기
				String pathNm = savePath + File.separator + strgNm;
				atchFileDetailVO.setAtchFileDetailPathNm(pathNm);
				
				// 파일을 저장할 최종 경로 -> C:/GrouBear/upload/GroCommunity/131
				File file = new File(savePath);
				// 폴더 만들기
				if (!file.exists()) {
					file.mkdirs();
				}
				
				// 파일 DB 인서트하기
				atchFileDetailVO.setAtchFileCd(atchFileCd);
				atchFileDetailVO.setEmpId(empId);
				cmntyMapper.fileDetailInsert(atchFileDetailVO);
				
				// 파일 복사하기
				File saveFile = new File(pathNm);
				try {
					atchFileDetailVO.getMultiFile().transferTo(saveFile);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public ServiceResult cmntyNoticeModify(CmntyVO cmntyVO) {
		ServiceResult result = null;
		int status = 0;
		
		status += cmntyMapper.cmntyNoticeModify(cmntyVO);
		
		if (status > 0) {
			// 삭제할 파일 숨김처리하기
			if (cmntyVO.getAtchFileUpdateList() != null) {
				cmntyMapper.cmntyNoticeFileDetailModify(cmntyVO);
				
				result = ServiceResult.OK;
			}
			
			// 새롭게 추가한 파일이 있다면 등록하기
			if (cmntyVO.getAtchFileDetailList() != null && cmntyVO.getAtchFileDetailList().size() > 0) {
				int fileStatus = 0;
				
				// 기존에 파일이 하나도 없었던 게시물에서 파일을 새롭게 추가한다면
				if (cmntyVO.getAtchFileCd() == null || cmntyVO.getAtchFileCd().equals("")) {
					fileStatus += cmntyMapper.atchFileInsert(cmntyVO);
				}
				// 새롭게 파일을 추가했다면, 기존에 첨부파일 코드가 없으므로 첨부파일 코드 추가
				fileStatus = cmntyMapper.cmntyNoticeModify(cmntyVO);
				
				if (fileStatus > 0) {
					List<AtchFileDetailVO> noticeFileList = cmntyVO.getAtchFileDetailList();
					fileUpload(noticeFileList, cmntyVO.getCmntyNo(), cmntyVO.getAtchFileCd(), cmntyVO.getEmpId());
					
					result = ServiceResult.OK;
				} else {
					result = ServiceResult.FAILED;
				}
			}
			
		} else {
			result = ServiceResult.FAILED;
		}
			
			
		return result;
	}

	@Override
	public List<AtchFileDetailVO> atchFileDetailListSelect(String atchFileCd) {
		return cmntyMapper.atchFileDetailListSelect(atchFileCd);
	}

	@Override
	public ServiceResult cmntyNoticeDelete(CmntyVO cmntyVO) {
		int status = 0;
		ServiceResult result = null;
		
		status += cmntyMapper.cmntyNoticeDelete(cmntyVO.getCmntyNo());
		status += cmntyMapper.fileDetailDelete(cmntyVO.getAtchFileCd());
		
		if (status > 1) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
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
	public ServiceResult cmntyReplyInsert(CmtVO cmtVO) {
		ServiceResult result = null;
		Map<String, String> map = new HashMap<String, String>();
		map.put("cmntyNo", String.valueOf(cmtVO.getCmntyNo()));
		map.put("cmntyQstnSttsYn", "Y");
		
		int status = cmntyMapper.cmntyReplyInsert(cmtVO);
		
		if (status > 0) {
			status = cmntyMapper.cmntyQstnSttsUpdate(map);
			if (status > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult cmntyReplyDelete(CmtVO cmtVO) {
		ServiceResult result = null;
		int status = 0;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("cmntyNo", String.valueOf(cmtVO.getCmntyNo()));
		map.put("cmntyQstnSttsYn", "N");
		
		status += cmntyMapper.cmntyQstnSttsUpdate(map);
		status += cmntyMapper.cmntyReplyDelYnDelete(cmtVO.getCommentNo());
		
		if (status > 1) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult cmntyReplyModify(CmtVO cmtVO) {
		ServiceResult result = null;
		
		int status = cmntyMapper.cmntyReplyModify(cmtVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<CmntyVO> qstnSttsAndListCount() {
		return cmntyMapper.qstnSttsAndListCount();
	}

	@Override
	public List<CmntyVO> groNoticeSelectListWidjet() {
		return cmntyMapper.groNoticeSelectListWidjet();
	}
	
}

package kr.or.ddit.comm.file.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.file.mapper.IFileMapper;
import kr.or.ddit.comm.file.service.IFileService;
import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.file.vo.AtchFileVO;

@Service
public class FileServiceImpl implements IFileService{
	
	@Inject
	private IFileMapper fileMapper;
	
	@Override
	public void register(AtchFileVO atchFileVO) {
		fileMapper.register(atchFileVO);
		
	}

	@Override
	public String setatchCd() {
		return fileMapper.setatchCd();
	}

	@Override
	public int insertAtchFile(AtchFileVO atchVO) {
		return fileMapper.insertAtchFile(atchVO);
	}

	@Override
	public void insertAtchFileDetail(AtchFileDetailVO afdVO) {
		fileMapper.insertAtchFileDetail(afdVO);
	}

}

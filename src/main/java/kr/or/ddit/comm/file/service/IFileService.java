package kr.or.ddit.comm.file.service;

import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.file.vo.AtchFileVO;

public interface IFileService {

	public void register(AtchFileVO atchFileVO);

	public String setatchCd();

	public int insertAtchFile(AtchFileVO atchVO);

	public void insertAtchFileDetail(AtchFileDetailVO afdVO);

}

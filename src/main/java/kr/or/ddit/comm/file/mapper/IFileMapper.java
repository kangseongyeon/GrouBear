package kr.or.ddit.comm.file.mapper;

import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.file.vo.AtchFileVO;

public interface IFileMapper {

	public void register(AtchFileVO atchFileVO);

	public String setatchCd();

	public int insertAtchFile(AtchFileVO atchVO);

	public void insertAtchFileDetail(AtchFileDetailVO afdVO);

	
}

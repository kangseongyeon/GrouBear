package kr.or.ddit.employee.videoChatting.service;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.employee.videoChatting.vo.VideoChattingVO;

public interface IVideoChattingService {

	/**
	 * 화상채팅방 추가
	 * @param vcVO
	 */
	public void vcInsert(VideoChattingVO vcVO);

	/**
	 * 화상채팅방 삭제
	 * @param id
	 */
	public void vcDelete(String id);

	/**
	 * 페이징처리를 위한 화상채팅 방개수 가져오기
	 * @param pagingVO
	 * @return
	 */
	public int selectVcRoom(PaginationInfoVO<VideoChattingVO> pagingVO);

	/**
	 * 페이징처리한 화상채팅 방리스트
	 * @param pagingVO
	 * @return
	 */
	public List<VideoChattingVO> selectVcList(PaginationInfoVO<VideoChattingVO> pagingVO);

	public List<VideoChattingVO> getAllRooms();


}

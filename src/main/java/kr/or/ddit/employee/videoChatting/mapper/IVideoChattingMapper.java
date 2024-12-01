package kr.or.ddit.employee.videoChatting.mapper;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.employee.videoChatting.vo.VideoChattingVO;

public interface IVideoChattingMapper {

	public void vcInsert(VideoChattingVO vcVO);

	public void vcDelete(String id);

	public int selectVcRoom(PaginationInfoVO<VideoChattingVO> pagingVO);

	public List<VideoChattingVO> selectVcList(PaginationInfoVO<VideoChattingVO> pagingVO);

	public List<VideoChattingVO> getAllRooms();


	
}

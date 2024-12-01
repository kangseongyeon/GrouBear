package kr.or.ddit.employee.videoChatting.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.employee.videoChatting.mapper.IVideoChattingMapper;
import kr.or.ddit.employee.videoChatting.service.IVideoChattingService;
import kr.or.ddit.employee.videoChatting.vo.VideoChattingVO;

@Service
public class VideoChattingServiceImpl implements IVideoChattingService{

	@Inject
	private IVideoChattingMapper mapper;

	@Override
	public void vcInsert(VideoChattingVO vcVO) {
		vcVO.setVideoChatDate(getCurrentTime());
		mapper.vcInsert(vcVO);
	}
	
	@Override
	public void vcDelete(String id) {
		mapper.vcDelete(id);
	}
	
	private String getCurrentTime() {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(System.currentTimeMillis());
		return formatter.format(calendar.getTime());
	}


	@Override
	public int selectVcRoom(PaginationInfoVO<VideoChattingVO> pagingVO) {
		return mapper.selectVcRoom(pagingVO);
	}


	@Override
	public List<VideoChattingVO> selectVcList(PaginationInfoVO<VideoChattingVO> pagingVO) {
		return mapper.selectVcList(pagingVO);
	}

	@Override
	public List<VideoChattingVO> getAllRooms() {
		return mapper.getAllRooms();
	}


}

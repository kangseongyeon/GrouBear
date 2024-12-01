package kr.or.ddit.groubear.log.service.impl;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.groubear.log.mapper.ILogMapper;
import kr.or.ddit.groubear.log.service.ILogService;
import kr.or.ddit.groubear.log.vo.LogVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LogServiceImpl implements ILogService{

	@Inject
	private ILogMapper mapper;

	@Override
	public void insert(LogVO logVO) {
		logVO.setLogCrtDt(getCurrentTime());
		mapper.insert(logVO);
	}
	

	@Override
	public void loginInsert(HttpServletRequest request) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		LogVO logVO = new LogVO();
		logVO.setEmpNm(empVO.getEmpNm());
		logVO.setJbgdCd(empVO.getJbgdCd());
		logVO.setLogIp(request.getRemoteAddr());
		logVO.setLogCrtDt(getCurrentTime());
		logVO.setEmpId(empVO.getEmpId());
		logVO.setLogDetail("로그인");
		mapper.insert(logVO);
		
	}

	// 작업시간 불러옴
	private String getCurrentTime() {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(System.currentTimeMillis());
		return formatter.format(calendar.getTime());
	}

	@Override
	public int selectLog(PaginationInfoVO<LogVO> pagingVO) {
	    log.info("Start Date for count: {}", pagingVO.getStartDate());
	    log.info("End Date for count: {}", pagingVO.getEndDate());
	    
	    if (pagingVO.getStartDate() != null && pagingVO.getEndDate() != null) {
	        return mapper.selectLogCountByDateRange(pagingVO);
	    }
	    return mapper.selectLogCount(pagingVO);
	}

	@Override
	public List<LogVO> selectLogList(PaginationInfoVO<LogVO> pagingVO) {
	    log.info("Start Date for list: {}", pagingVO.getStartDate());
	    log.info("End Date for list: {}", pagingVO.getEndDate());
	    
	    if (pagingVO.getStartDate() != null && pagingVO.getEndDate() != null) {
	        return mapper.selectLogListByDateRange(pagingVO);
	    }
	    return mapper.selectLogList(pagingVO);
	}



}

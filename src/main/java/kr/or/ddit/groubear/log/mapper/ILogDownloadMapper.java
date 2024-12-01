package kr.or.ddit.groubear.log.mapper;

import java.util.List;

import kr.or.ddit.groubear.log.vo.LogVO;


public interface ILogDownloadMapper {

	List<LogVO> createExcelTemplate();
}

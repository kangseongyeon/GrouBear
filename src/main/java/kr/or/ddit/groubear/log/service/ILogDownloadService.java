package kr.or.ddit.groubear.log.service;

import java.io.ByteArrayInputStream;

public interface ILogDownloadService {

	ByteArrayInputStream createExcelTemplate() throws Exception;
}

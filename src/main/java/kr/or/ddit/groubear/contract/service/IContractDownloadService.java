package kr.or.ddit.groubear.contract.service;

import java.io.ByteArrayInputStream;

import org.springframework.stereotype.Service;

public interface IContractDownloadService {

	ByteArrayInputStream createExcelContract() throws Exception;

}

package kr.or.ddit.groubear.log.controller;

import java.io.ByteArrayInputStream;

import javax.inject.Inject;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.groubear.log.service.ILogDownloadService;



// 로그 엑셀저장
@Controller
@RequestMapping("/excel")
public class LogDownloadController {
	
	@Inject
	private ILogDownloadService service;
	
	@RequestMapping(value = "/download.do", method = RequestMethod.GET)
	public String downloadPage() {
		return "groubear/log/download"; // 다운로드 페이지로 이동
	}
	
	
	@PostMapping("/downExcel")
	public ResponseEntity<InputStreamResource> downloadExcel() throws Exception {
		ByteArrayInputStream excelFile = service.createExcelTemplate();
		String fileName = "groubear_log";		// 저장할 파일 명
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");	// 파일 형식
		
		// 파일 전송
		 return ResponseEntity.ok()
	                .headers(headers)
	                .contentType(MediaType.APPLICATION_OCTET_STREAM)
	                .body(new InputStreamResource(excelFile));
		
	}
}

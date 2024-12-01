package kr.or.ddit.groubear.contract.controller;

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

import kr.or.ddit.groubear.contract.service.IContractDownloadService;
import kr.or.ddit.groubear.contract.service.IContractService;

@Controller
@RequestMapping("/excel")
public class ContractDownloadController {
	
	@Inject
	private IContractDownloadService service;

	@RequestMapping(value = "/contractdownload.do", method = RequestMethod.GET)
	public String downloadPage() {
		return "groubear/contract/download"; // 다운로드 페이지로 이동
	}
	
	
	@PostMapping("/contractdownExcel")
	public ResponseEntity<InputStreamResource> downloadExcel() throws Exception {
		ByteArrayInputStream excelFile = service.createExcelContract();
		String fileName = "groubear_contract";		// 저장할 파일 명
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");	// 파일 형식
		
		// 파일 전송
		 return ResponseEntity.ok()
	                .headers(headers)
	                .contentType(MediaType.APPLICATION_OCTET_STREAM)
	                .body(new InputStreamResource(excelFile));
		
	}
	
	
}

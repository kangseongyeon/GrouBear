package kr.or.ddit.groubear.log.service.impl;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.Comparator;
import java.util.List;

import javax.inject.Inject;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import kr.or.ddit.groubear.log.mapper.ILogDownloadMapper;
import kr.or.ddit.groubear.log.service.ILogDownloadService;
import kr.or.ddit.groubear.log.vo.LogVO;

@Service
public class LogDownloadServiceImpl implements ILogDownloadService{

	@Inject
	private ILogDownloadMapper mapper;

	@Override
	public ByteArrayInputStream createExcelTemplate() throws Exception {
		// 엑셀 파일 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		XSSFSheet sheet = workbook.createSheet("로그리스트");
		
		// 셀 스타일 생성
		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setAlignment(HorizontalAlignment.CENTER);	// 가운데 정렬
		
		// 테두리 스타일 설정
		CellStyle borderStyle = workbook.createCellStyle();
		borderStyle.cloneStyleFrom(cellStyle);	// 기존 스타일 복사
		borderStyle.setBorderTop(BorderStyle.THIN);
		borderStyle.setBorderBottom(BorderStyle.THIN);
		borderStyle.setBorderLeft(BorderStyle.THIN);
		borderStyle.setBorderRight(BorderStyle.THIN);
		
		// 첫 번째 행에 설정
		Row header = sheet.createRow(0);
		
		// setCellValue는 type에 맞춰 import해야 함
		header.createCell(0).setCellValue("순번");
		header.createCell(1).setCellValue("이름");
		header.createCell(2).setCellValue("기업명");
		header.createCell(3).setCellValue("DATE");
		header.createCell(4).setCellValue("IP");
		header.createCell(5).setCellValue("LOG");
		header.createCell(6).setCellValue("ID");
		
		// 헤더 셀 스타일 적용
	    for (int i = 0; i < header.getPhysicalNumberOfCells(); i++) {
	        header.getCell(i).setCellStyle(borderStyle); // 테두리 스타일 적용
	    }
		
		List<LogVO> list = mapper.createExcelTemplate();
		
		// 원하는 정렬 기준에 따라 리스트 정렬 (예: 이름 기준)
	    list.sort(Comparator.comparing(LogVO::getLogCoCd)); // 이름으로 정렬
		
		int rowIdx = 1;
		for(LogVO vo : list) {
			Row row = sheet.createRow(rowIdx++);
			row.createCell(0).setCellValue(vo.getLogCoCd());
			row.createCell(1).setCellValue(vo.getEmpNm());
			row.createCell(2).setCellValue(vo.getJbgdCd());
			row.createCell(3).setCellValue(vo.getLogCrtDt());
			row.createCell(4).setCellValue(vo.getLogIp());
			row.createCell(5).setCellValue(vo.getLogDetail());
			row.createCell(6).setCellValue(vo.getEmpId());
			

			 // 데이터 셀 스타일 적용
	        for (int i = 0; i < row.getPhysicalNumberOfCells(); i++) {
	            row.getCell(i).setCellStyle(borderStyle); // 테두리 스타일 적용
	        }
		}
		
		sheet.setColumnWidth(0, 256 * 5); 
	    sheet.setColumnWidth(1, 256 * 25);
	    sheet.setColumnWidth(2, 256 * 25);
	    sheet.setColumnWidth(3, 256 * 25);
	    sheet.setColumnWidth(4, 256 * 20);
	    sheet.setColumnWidth(5, 256 * 20);
	    sheet.setColumnWidth(6, 256 * 20);
		
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		workbook.write(out);
		workbook.close();
		
		return new ByteArrayInputStream(out.toByteArray());
	}
	
	
}

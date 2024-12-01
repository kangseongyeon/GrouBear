package kr.or.ddit.groubear.contract.service.impl;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
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

import kr.or.ddit.groubear.contract.mapper.IContractDownloadMapper;
import kr.or.ddit.groubear.contract.service.IContractDownloadService;
import kr.or.ddit.groubear.contract.vo.ContractVO;
import kr.or.ddit.groubear.log.vo.LogVO;

@Service
public class ContractDownloadServiceImpl implements IContractDownloadService{

	@Inject
	private IContractDownloadMapper mapper;

	@Override
	public ByteArrayInputStream createExcelContract() throws Exception {
		// 엑셀 파일 생성
				XSSFWorkbook workbook = new XSSFWorkbook();
				XSSFSheet sheet = workbook.createSheet("계약리스트");
				
				 // 셀 스타일 생성
			    CellStyle cellStyle = workbook.createCellStyle();
			    cellStyle.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
				
			    // 테두리 스타일 설정
			    CellStyle borderStyle = workbook.createCellStyle();
			    borderStyle.cloneStyleFrom(cellStyle); // 기존 스타일 복사
			    borderStyle.setBorderTop(BorderStyle.THIN);
			    borderStyle.setBorderBottom(BorderStyle.THIN);
			    borderStyle.setBorderLeft(BorderStyle.THIN);
			    borderStyle.setBorderRight(BorderStyle.THIN);
			    
				// 첫 번째 행에 설정
				Row header = sheet.createRow(0);
				
				// setCellValue는 type에 맞춰 import해야 함
				header.createCell(0).setCellValue("순번");
				header.createCell(1).setCellValue("기업명");
				header.createCell(2).setCellValue("계약시작일");
				header.createCell(3).setCellValue("계약종료일");
				header.createCell(4).setCellValue("계약기간(월)");
				header.createCell(5).setCellValue("계약일");
				header.createCell(6).setCellValue("계약금액");
				header.createCell(7).setCellValue("계약자");
				header.createCell(8).setCellValue("사업자등록번호");
				header.createCell(9).setCellValue("프리미엄사용여부");
				
				// 헤더 셀 스타일 적용
			    for (int i = 0; i < header.getPhysicalNumberOfCells(); i++) {
			        header.getCell(i).setCellStyle(borderStyle); // 테두리 스타일 적용
			    }
				
				List<ContractVO> list = mapper.createExcelContract();
				
				// 원하는 정렬 기준에 따라 리스트 정렬 (예: 이름 기준)
			    list.sort(Comparator.comparing(ContractVO::getCtrtNo)); // 이름으로 정렬
				
				int rowIdx = 1;
				for(ContractVO vo : list) {
					Row row = sheet.createRow(rowIdx++);
					row.createCell(0).setCellValue(vo.getCtrtNo());
					row.createCell(1).setCellValue(vo.getCoNm());
					row.createCell(2).setCellValue(vo.getCtrtBgngDt());
					row.createCell(3).setCellValue(vo.getCtrtExpryDt());
					row.createCell(4).setCellValue(vo.getCtrtPre());
					row.createCell(5).setCellValue(vo.getCtrtDt());
					row.createCell(6).setCellValue(vo.getCtrtAmt());
					row.createCell(7).setCellValue(vo.getCtrtNm());
					row.createCell(8).setCellValue(vo.getCtrtBrno());
					row.createCell(9).setCellValue(vo.getPremiumYn());

					 // 데이터 셀 스타일 적용
			        for (int i = 0; i < row.getPhysicalNumberOfCells(); i++) {
			            row.getCell(i).setCellStyle(borderStyle); // 테두리 스타일 적용
			        }
			    }
				
				 // 열 너비 설정
			    sheet.setColumnWidth(0, 256 * 5); // 순번
			    sheet.setColumnWidth(1, 256 * 25); // 기업명
			    sheet.setColumnWidth(2, 256 * 25); // 계약시작일
			    sheet.setColumnWidth(3, 256 * 25); // 계약종료일
			    sheet.setColumnWidth(4, 256 * 15); // 계약기간(월)
			    sheet.setColumnWidth(5, 256 * 15); // 계약일
			    sheet.setColumnWidth(6, 256 * 15); // 계약금액
			    sheet.setColumnWidth(7, 256 * 15); // 계약자
			    sheet.setColumnWidth(8, 256 * 20); // 사업자등록번호
			    sheet.setColumnWidth(9, 256 * 15); // 프리미엄사용여부
					
				
				ByteArrayOutputStream out = new ByteArrayOutputStream();
				workbook.write(out);
				workbook.close();
				
				return new ByteArrayInputStream(out.toByteArray());
			}
}

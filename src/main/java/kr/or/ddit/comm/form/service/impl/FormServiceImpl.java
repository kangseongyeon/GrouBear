package kr.or.ddit.comm.form.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.form.mapper.IFormMapper;
import kr.or.ddit.comm.form.service.IFormService;
import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;

/**
 * 양식 관리 업무로직
 * @author LeeEunJae
 * 
 */
@Service
public class FormServiceImpl implements IFormService {

	@Inject
	private IFormMapper formMapper;
	
	// 양식 등록
	@Override
	public ServiceResult formInsert(FormVO formVO) {
		ServiceResult result;
		
		int status = formMapper.formInsert(formVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	/**
	 *양식 전체 게시물 수 조회 (그룹웨어 관리자)
	 */
	@Override
	public int groubearSelectFormCount(PaginationInfoVO<FormVO> pagingVO) {
		return formMapper.groubearSelectFormCount(pagingVO);
	}

	// 양식 리스트 조회 (그룹웨어 관리자)
	@Override
	public List<FormVO> groubearSelectFormList(PaginationInfoVO<FormVO> pagingVO) {
		return formMapper.groubearSelectFormList(pagingVO);
	}
	
	// 양식 전체 게시물 수 조회 (기업 관리자)
	@Override
	public int companySelectFormCount(PaginationInfoVO<FormVO> pagingVO) {
		return formMapper.companySelectFormCount(pagingVO);
	}
	
	// 양식 리스트 조회 (기업 관리자)
	@Override
	public List<FormVO> companySelectFormList(PaginationInfoVO<FormVO> pagingVO) {
		return formMapper.companySelectFormList(pagingVO);
	}

	// 양식 상세 조회
	@Override
	public FormVO selectForm(int docFormNo) {
		return formMapper.selectForm(docFormNo);
	}

	// 양식 수정
	@Override
	public ServiceResult formUpdate(FormVO formVO) {
		ServiceResult result;
		
		int status = formMapper.formUpdate(formVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	// 양식 삭제 (1개일 때)
	@Override
	public ServiceResult formDelete(int docFormNo) {
		ServiceResult result;
		
		int status = formMapper.formDelete(docFormNo);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	// Jstree에 출력할 form 계층형 데이터 (그룹웨어 관리자)
	@Override
	public List<FormVO> groubearSelectFormListJstree(String coCd) {
		return formMapper.groubearSelectFormListJstree(coCd);
	}
	
	// Jstree에 출력할 form 계층형 데이터 (기업 관리자)
	@Override
	public List<FormVO> companySelectFormListJstree(String coCd) {
		return formMapper.companySelectFormListJstree(coCd);
	}

	// 양식 종류 추가
	@Override
	public ServiceResult docFormKndNmAdd(FormVO formVO) {
		ServiceResult result;
		
		int status = formMapper.docFormKndNmAdd(formVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	// 양식 종류 가져오기 (그룹웨어 관리자)
	@Override
	public List<FormVO> groubearSelectDocFormKndNm(FormVO formVO) {
		return formMapper.groubearSelectDocFormKndNm(formVO);
	}
	
	// 양식 종류 가져오기 (기업 관리자)
	@Override
	public List<FormVO> companySelectDocFormKndNm(FormVO formVO) {
		return formMapper.companySelectDocFormKndNm(formVO);
	}

	// 양식 종류 삭제하기
	@Override
	public ServiceResult docFormKndNmDel(FormVO formVO) {
		ServiceResult result;
		
		int status = formMapper.docFormKndNmDel(formVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	// 양식 종류 삭제 전, 하위 글 유무 확인하기
	@Override
	public int docFormKndWriteCheck(int docFormNo) {
		return formMapper.docFormKndWriteCheck(docFormNo);
	}

	// 선텍힌 글 삭제하기 (1 또는 n)
	@Override
	public ServiceResult selectWriteListDelete(List<Integer> selectWriteList) {
		ServiceResult result;
		int status = 0;
		
		for (int i = 0; i < selectWriteList.size(); i++) {
			int docFormNo = selectWriteList.get(i);		// 게시물 번호 넘기기
			status += formMapper.formDelete(docFormNo);
		}
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	
}

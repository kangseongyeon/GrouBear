package kr.or.ddit.company.facilities.service.Impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.file.vo.AtchFileDetailVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.facilities.mapper.IFacilititesMapper;
import kr.or.ddit.company.facilities.service.IFacilititesService;
import kr.or.ddit.company.facilities.vo.EquipmentVO;
import kr.or.ddit.company.facilities.vo.FacilityCategoryVO;
import kr.or.ddit.company.facilities.vo.FacilityVO;
import kr.or.ddit.company.facilities.vo.FaciltyEquipmentVO;
import kr.or.ddit.employee.facilities.vo.FacilityReservationDetailVO;
import kr.or.ddit.employee.vacation.vo.VacationCreateDetailVO;

/**
 * @author gihyeokkwon
 *
 */
@Service
public class FacilititesServiceImpl implements IFacilititesService {

	@Inject
	public IFacilititesMapper mapper;
	
	@Override
	public int insertFclt(FacilityVO fcltVO) {
		return mapper.insertFclt(fcltVO);
	}

	@Override
	public String setfcltCd() {
		return mapper.setfcltCd();
	}

	@Override
	public void setequipment(FaciltyEquipmentVO fcltEmVO) {
		mapper.setequipment(fcltEmVO);
	}

	@Override
	public List<FacilityVO> getFcltList(FacilityCategoryVO fcltCtgrVO) {
		return mapper.getFcltList(fcltCtgrVO);
	}

	@Override
	public FacilityVO getFcltInfo(FacilityVO fcltVO) {
		return mapper.getFcltInfo(fcltVO);
	}

	@Override
	public List<FaciltyEquipmentVO> getFcltEq(FacilityVO fcltVO) {
		return mapper.getFcltEq(fcltVO);
	}

	@Override
	public int deleteFclt(FacilityVO fcltVO) {
		return mapper.deleteFclt(fcltVO);
	}

	@Override
	public List<FacilityCategoryVO> getfcltCtgrList(EmployeeVO empVO) {
		return mapper.getfcltCtgrList(empVO);
	}

	@Override
	public FacilityCategoryVO getfcltCtgrInfo(FacilityCategoryVO fcltctgrVO) {
		return mapper.getfcltCtgrInfo(fcltctgrVO);
	}

	@Override
	public List<EquipmentVO> getEqList(FacilityVO fcltVO) {
		return mapper.getEqList(fcltVO);
	}

	@Override
	public List<AtchFileDetailVO> getFcltImg(FacilityVO fcltVO) {
		return mapper.getFcltImg(fcltVO);
	}

	
	//날짜로 예약 정보 LIST
	@Override
	public List<FacilityReservationDetailVO> getFRDList(String sdfNow) {
		return mapper.getFRDList(sdfNow);
	}
	
	// 검색 정보 다음 예약 정보 가져오기
	@Override
	public FacilityReservationDetailVO getNextfrsvd(FacilityReservationDetailVO rsvdVO) {
		return mapper.getNextfcrsvd(rsvdVO);
	}

	@Override
	public int rsvAvailable(FacilityReservationDetailVO rsvdVO) {
		return mapper.rsvAvailable(rsvdVO);
	}

	@Override
	public List<FacilityReservationDetailVO> getFcltReserveList(FacilityReservationDetailVO fcltreserveVO) {
		return mapper.getFcltReserveList(fcltreserveVO);
	}

	@Override
	public List<FacilityReservationDetailVO> getFcltrsvtList(EmployeeVO empVO) {
		return mapper.getFcltrsvtList(empVO);
	}

	@Override
	public int getflctreserveCount(PaginationInfoVO<FacilityReservationDetailVO> pagingVO) {
		return mapper.getflctreserveCount(pagingVO);
	}

	@Override
	public List<FacilityReservationDetailVO> getfcltreserveDetailList(
			PaginationInfoVO<FacilityReservationDetailVO> pagingVO) {
		return mapper.getfcltreserveDetailList(pagingVO);
	}

	@Override
	public List<FacilityReservationDetailVO> getMyFcltrsvtList(EmployeeVO empVO) {
		return mapper.getMyFcltrsvtList(empVO);
	}
	
}

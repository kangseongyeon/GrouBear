package kr.or.ddit.employee.vehicleReservation.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.company.vehicleManagement.vo.VHCLRSVTVO;
import kr.or.ddit.company.vehicleManagement.vo.VHCLVO;
import kr.or.ddit.employee.vehicleReservation.mapper.IVehicleMapper;
import kr.or.ddit.employee.vehicleReservation.service.IVehicleService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class VehicleServiceImpl implements IVehicleService{

	@Inject
	private IVehicleMapper vehicleMapper;
	
	@Override
	public ServiceResult insertReservation(HttpServletRequest req, VHCLRSVTVO vhcl_rsvtVO) {
		ServiceResult result = null;
		
		int status = vehicleMapper.insertReservation(vhcl_rsvtVO);
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<VHCLRSVTVO> selectRSVTHistory(String empId) {
		return vehicleMapper.selectRSVTHistory(empId);
	}

	@Override
	public ServiceResult insertVHCL(HttpServletRequest req, VHCLVO vhclVO) {
		ServiceResult result = null;
		
		int status = vehicleMapper.insertVHCL(vhclVO);
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<VHCLRSVTVO> selectAllRSVTHistory(String coCd) {
		log.info("가지고 들어온 coCd값 : " + coCd);
		return vehicleMapper.selectAllRSVTHistory(coCd);
	}

	@Override
	public List<VHCLVO> selectVhclList(String coCd) {
		return vehicleMapper.selectVhclList(coCd);
	}

	@Override
	public ServiceResult vhclInfoModify(HttpServletRequest req, VHCLVO vhclVO) {
		log.info("vhclInfoModify 호출됨: " + vhclVO);
		ServiceResult result = null;
		
		int status = vehicleMapper.vhclInfoModify(vhclVO);
		if (status > 0 ) {
			log.info("됨");
			result = ServiceResult.OK;
		}else {
			log.info("안 됨");
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public VHCLVO findVhclVO(String vhclNo) {
		return vehicleMapper.findVhclVO(vhclNo);
	}

	@Override
	public ServiceResult vhclDelte(String vhclNo) {
		
		ServiceResult result = null;
		
		int status = vehicleMapper.vhclDelte(vhclNo);
		
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public int selectRSVTPage(PaginationInfoVO<VHCLRSVTVO> pagingVO) {
		return vehicleMapper.selectRSVTPage(pagingVO);
	}

	@Override
	public List<VHCLRSVTVO> selectRSVTPaging(PaginationInfoVO<VHCLRSVTVO> pagingVO) {
		return vehicleMapper.selectRSVTPaging(pagingVO);
	}

	@Override
	public int selectMyRSVTPage(PaginationInfoVO<VHCLRSVTVO> pagingVO) {
		return vehicleMapper.selectMyRSVTPage(pagingVO);
	}

	@Override
	public List<VHCLRSVTVO> selectMyRSVTPaging(PaginationInfoVO<VHCLRSVTVO> pagingVO) {
		return vehicleMapper.selectMyRSVTPaging(pagingVO);
	}

	@Override
	public List<VHCLRSVTVO> selectMyRSVTHistory(String empId) {
		return vehicleMapper.selectMyRSVTHistory(empId);
	}

	@Override
	public VHCLRSVTVO getRsvtVO(String rsvtCd) {
		return vehicleMapper.getRsvtVO(rsvtCd);
	}

	@Override
	public ServiceResult rsvtModify(HttpServletRequest req, VHCLRSVTVO vhclrsvtVO) {
		ServiceResult result = null;
		
		int status = vehicleMapper.rsvtModify(vhclrsvtVO);
		
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<VHCLRSVTVO> selectRsvt(String teamCd) {
		return vehicleMapper.selectRsvt(teamCd);
	}

	@Override
	public ServiceResult rsvtDelete(VHCLRSVTVO vhclRsvtVO) {
		ServiceResult result = null;
		
		int status = vehicleMapper.rsvtDelete(vhclRsvtVO);
		if (status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

}

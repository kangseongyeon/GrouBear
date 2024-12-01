package kr.or.ddit.employee.vehicleReservation.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.company.vehicleManagement.vo.VHCLRSVTVO;
import kr.or.ddit.company.vehicleManagement.vo.VHCLVO;

public interface IVehicleService {

	ServiceResult insertReservation(HttpServletRequest req, VHCLRSVTVO vhcl_rsvtVO);

	List<VHCLRSVTVO> selectRSVTHistory(String empId);

	ServiceResult insertVHCL(HttpServletRequest req, VHCLVO vhclVO);

	List<VHCLRSVTVO> selectAllRSVTHistory(String coCd);

	List<VHCLVO> selectVhclList(String coCd);

	ServiceResult vhclInfoModify(HttpServletRequest req, VHCLVO vhclVO);

	VHCLVO findVhclVO(String vhclNo);

	ServiceResult vhclDelte(String vhclNo);

	int selectRSVTPage(PaginationInfoVO<VHCLRSVTVO> pagingVO);

	List<VHCLRSVTVO> selectRSVTPaging(PaginationInfoVO<VHCLRSVTVO> pagingVO);

	int selectMyRSVTPage(PaginationInfoVO<VHCLRSVTVO> pagingVO);

	List<VHCLRSVTVO> selectMyRSVTPaging(PaginationInfoVO<VHCLRSVTVO> pagingVO);

	List<VHCLRSVTVO> selectMyRSVTHistory(String empId);

	VHCLRSVTVO getRsvtVO(String rsvtCd);

	ServiceResult rsvtModify(HttpServletRequest req, VHCLRSVTVO vhclrsvtVO);

	List<VHCLRSVTVO> selectRsvt(String teamCd);

	ServiceResult rsvtDelete(VHCLRSVTVO vhclRsvtVO);

}

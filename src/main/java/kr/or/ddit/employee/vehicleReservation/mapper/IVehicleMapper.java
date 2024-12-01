package kr.or.ddit.employee.vehicleReservation.mapper;

import java.util.List;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.company.vehicleManagement.vo.VHCLRSVTVO;
import kr.or.ddit.company.vehicleManagement.vo.VHCLVO;

public interface IVehicleMapper { 


	public int insertReservation(VHCLRSVTVO vhcl_rsvtVO);

	public List<VHCLRSVTVO> selectRSVTHistory(String empId);

	public int insertVHCL(VHCLVO vhclVO);

	public List<VHCLRSVTVO> selectAllRSVTHistory(String coCd);

	public List<VHCLVO> selectVhclList(String coCd);

	public int vhclInfoModify(VHCLVO vhclVO);

	public VHCLVO findVhclVO(String vhclNo);

	public int vhclDelte(String vhclNo);

	public int selectRSVTPage(PaginationInfoVO<VHCLRSVTVO> pagingVO);

	public List<VHCLRSVTVO> selectRSVTPaging(PaginationInfoVO<VHCLRSVTVO> pagingVO);

	public int selectMyRSVTPage(PaginationInfoVO<VHCLRSVTVO> pagingVO);

	public List<VHCLRSVTVO> selectMyRSVTPaging(PaginationInfoVO<VHCLRSVTVO> pagingVO);

	public List<VHCLRSVTVO> selectMyRSVTHistory(String empId);

	public VHCLRSVTVO getRsvtVO(String rsvtCd);

	public int rsvtModify(VHCLRSVTVO vhclrsvtVO);

	public List<VHCLRSVTVO> selectRsvt(String teamCd);

	public int rsvtDelete(VHCLRSVTVO vhclRsvtVO);

}

package kr.or.ddit.comm.findempinfo.mapper;

import kr.or.ddit.comm.findempinfo.vo.MailAuthVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;

public interface IFindEmpInfoMapper {

	public String findId(EmployeeVO empVO);

	public String findemail(EmployeeVO empVO);

	public int insertAuthNum(MailAuthVO mailAuthVO);

	public int getAuthNum(MailAuthVO mailAuthVO);

	public int delAuthNum(MailAuthVO mailAuthVO);

	public int changepw(EmployeeVO empVO);



}

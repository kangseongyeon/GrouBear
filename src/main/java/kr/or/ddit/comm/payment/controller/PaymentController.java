package kr.or.ddit.comm.payment.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.comm.cloud.service.ICloudService;
import kr.or.ddit.comm.login.service.ILoginService;
import kr.or.ddit.comm.payment.service.IPaymentService;
import kr.or.ddit.comm.payment.vo.RegularSettlementVO;
import kr.or.ddit.comm.payment.vo.SettlementVO;
import kr.or.ddit.comm.security.vo.CompanyVO;
import kr.or.ddit.comm.security.vo.EmployeeAuthVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.company.vacation.service.IComVacationSettingSerivce;
import kr.or.ddit.company.vacation.vo.YearVctVO;
import kr.or.ddit.company.workform.service.IComWorkManagementService;
import kr.or.ddit.company.workform.vo.WorkFormVO;
import kr.or.ddit.groubear.contract.service.IContractService;
import kr.or.ddit.groubear.contract.vo.ContractVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PaymentController {
	
	@Inject
	private IPaymentService paymentService;

	@Inject
	private ILoginService loginService;

	@Inject
	private IContractService contractService;
	
	@Inject
	private PasswordEncoder pe;
	
	@Inject
	private IContractService ctrtService;
	
	@Inject
	private ICloudService cloudService;

	@Inject
	private IComVacationSettingSerivce vctService;
	
	@Inject
	private IComWorkManagementService workMgService;
	
	@ResponseBody
	@PostMapping("/paymentsuccess")
	public ResponseEntity<String> paymentsuccess(@RequestBody Map<String, String> paymentInfo){
		log.info("=======================");

		// 기업 정보 입력
		CompanyVO companyVO = new CompanyVO();
		companyVO.setCoNm(paymentInfo.get("coNm"));
		companyVO.setCeoId(paymentInfo.get("empId"));
		companyVO.setCoBrno(paymentInfo.get("coBrno"));
		companyVO.setCeoNm(paymentInfo.get("ceoNm"));
		companyVO.setCoZip(Integer.parseInt(paymentInfo.get("coZip")));
		companyVO.setCoAddr(paymentInfo.get("coAddr"));
		companyVO.setCoDaddr(paymentInfo.get("coDaddr"));
		companyVO.setCoTel(paymentInfo.get("coTel"));
		companyVO.setCoCnt(Integer.parseInt(paymentInfo.get("coCnt")));
		paymentService.insertCompany(companyVO);
		
		// 사원 정보 입력
		EmployeeVO empVO = new EmployeeVO();
		empVO.setEmpId(paymentInfo.get("empId"));
		empVO.setEmpPw(pe.encode(paymentInfo.get("empPw")));
		empVO.setEmpEmlAddr(paymentInfo.get("empEmlAddr"));
		empVO.setEmpNm(paymentInfo.get("ceoNm"));
		empVO.setEmpZip(Integer.parseInt(paymentInfo.get("coZip")));
		empVO.setEmpAddr(paymentInfo.get("coAddr"));
		empVO.setEmpDaddr(paymentInfo.get("coDaddr"));
		empVO.setEmpTelno(paymentInfo.get("coTel"));
		loginService.insertEmployee(empVO);
		
		// 권한 부여
		EmployeeAuthVO authVO = new EmployeeAuthVO();
		authVO.setAuthrityNm("ROLE_COMPANY");
		authVO.setEmpId(paymentInfo.get("empId"));
		loginService.insertAuth(authVO);
		
		//정기 결제 정보
		RegularSettlementVO rgstVO = new RegularSettlementVO();
		rgstVO.setGdsNm(paymentInfo.get("gdsNm"));	//상품명
		rgstVO.setEmpId(paymentInfo.get("empId"));	//구매자
		rgstVO.setRglStlmDt(paymentInfo.get("stlmdt"));	//정기결제일
		rgstVO.setRglStlmStplPrd(paymentInfo.get("rglstlmstplprd"));	//약정기간
		rgstVO.setRglStlmNope(paymentInfo.get("coCnt"));	//이용인원수
		rgstVO.setRglStlmPrc(paymentInfo.get("price"));	//결제금액
		
		paymentService.insertRgSt(rgstVO);

		//결제 내역
		SettlementVO stmVO = new SettlementVO();
		stmVO.setStlmPrc(Integer.parseInt(paymentInfo.get("price")));
		stmVO.setEmpId(paymentInfo.get("empId"));
		
		paymentService.insertStm(stmVO);

		// 클라우드 생성
		String getCocd = paymentService.getComCd(empVO);
		empVO.setCoCd(getCocd);
		cloudService.comCloudStrgCreate(empVO);
		
		// 기본 휴가 설정
		YearVctVO yvVO = new YearVctVO();
		yvVO.setCoCd(getCocd);
		yvVO.setYearVctCnt(0);
		
		for (int i = 0; i < 28; i++) {
			yvVO.setYearCnt(i);
			vctService.setBasicVct(yvVO);
		}
		
		// 기본 출퇴근 설정
		WorkFormVO wfVO = new WorkFormVO();
		wfVO.setCoCd(getCocd);		
		workMgService.setBasicworkForm(wfVO);
		
		
		//기업과의 계약
		ContractVO contractVO = new ContractVO();
		
		contractVO.setCoNm(paymentInfo.get("coNm"));
		contractVO.setCtrtNm(paymentInfo.get("ceoNm"));
		contractVO.setCtrtBrno(paymentInfo.get("coBrno"));
		contractVO.setCtrtPre(paymentInfo.get("rglstlmstplprd"));
		int amt = Integer.parseInt(paymentInfo.get("price")) * Integer.parseInt(paymentInfo.get("rglstlmstplprd")); 
		contractVO.setCtrtAmt(amt+"");
		
		if(paymentInfo.get("acc_value").equals("basic")) {
			contractVO.setPremiumYn("N");
		}else {
			contractVO.setPremiumYn("Y");
		}
		
		int ctrtResult = contractService.insertContract(contractVO);
			
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
}

package kr.or.ddit.comm.aop.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.groubear.log.service.ILogService;
import kr.or.ddit.groubear.log.vo.LogVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component("aopController")
@Aspect
public class AOPController {

	@Inject
	private ILogService logservice;

	
	/**
	 * @param pjp
	 * @return
	 * @throws Throwable
	 * 프로젝트 서비스 실행시 작동
	 */
	@Around("execution(* kr.or.ddit.comm.project.service.IProjectService.*(..))")
	public Object projectService(ProceedingJoinPoint pjp) throws Throwable {
		Object result = pjp.proceed();

		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();

		LogVO logVO = new LogVO();
		String signature = pjp.getSignature().toString();
		if (signature.contains("insert") || signature.contains("delete") || signature.contains("update")) {
			logVO.setEmpNm(empVO.getEmpNm());
			logVO.setJbgdCd(empVO.getJbgdCd());
			logVO.setLogIp(req.getRemoteAddr());
			logVO.setEmpId(empVO.getEmpId());

			// 프로젝트 메뉴
			if (signature.contains("insert")) {
				logVO.setLogDetail("프로젝트 추가");
			} else if (signature.contains("delete")) {
				logVO.setLogDetail("프로젝트 삭제");
			} else if (signature.contains("update")) {
				logVO.setLogDetail("프로젝트 수정");
			}
			logservice.insert(logVO);
		}
		return result;
	}

	/**
	 * @param pjp
	 * @return
	 * @throws Throwable
	 * 일감 서비스 실행시 작동
	 */
	@Around("execution(* kr.or.ddit.comm.project.service.IProjectTaskService.*(..))")
	public Object projectTaskService(ProceedingJoinPoint pjp) throws Throwable {
		Object result = pjp.proceed();

		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();

		LogVO logVO = new LogVO();
		String signature = pjp.getSignature().toString();
		if (signature.contains("insert") || signature.contains("delete") || signature.contains("update")) {
			logVO.setEmpNm(empVO.getEmpNm());
			logVO.setJbgdCd(empVO.getJbgdCd());
			logVO.setLogIp(req.getRemoteAddr());
			logVO.setEmpId(empVO.getEmpId());

			// 로그 상세 설정
			if (signature.contains("insert")) {
				logVO.setLogDetail("일감 추가");
			} else if (signature.contains("delete")) {
				logVO.setLogDetail("일감 삭제");
			} else if (signature.contains("update")) {
				logVO.setLogDetail("일감 수정");
			}
			logservice.insert(logVO);
		}
		return result;
	}

	/**
	 * @param pjp
	 * @return
	 * @throws Throwable
	 * 화상채팅방 서비스 작동
	 */
	@Around("execution(* kr.or.ddit.employee.videoChatting.service.IVideoChattingService.*(..))")
	public Object VideoChattingService(ProceedingJoinPoint pjp) throws Throwable {
		Object result = pjp.proceed();

		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();

		LogVO logVO = new LogVO();
		String signature = pjp.getSignature().toString();
		if (signature.contains("Insert") || signature.contains("Delete") || signature.contains("update")) {
			logVO.setEmpNm(empVO.getEmpNm());
			logVO.setJbgdCd(empVO.getJbgdCd());
			logVO.setLogIp(req.getRemoteAddr());
			logVO.setEmpId(empVO.getEmpId());

			// 로그 상세 설정
			if (signature.contains("Insert")) {
				logVO.setLogDetail("화상채팅방 개설");
			} else if (signature.contains("Delete")) {
				logVO.setLogDetail("화상채팅방 삭제");
			} 
			logservice.insert(logVO);
		}
		return result;
	}
	
	
	@Around("execution(* kr.or.ddit.employee.workStatus.service.IEmpWorkStatusService.*(..))")
	public Object workStatus(ProceedingJoinPoint pjp) throws Throwable {
		Object result = pjp.proceed();
		
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		LogVO logVO = new LogVO();
		String signature = pjp.getSignature().toString();
		if (signature.contains("startWork") || signature.contains("stopWork")) {
			logVO.setEmpNm(empVO.getEmpNm());
			logVO.setJbgdCd(empVO.getJbgdCd());
			logVO.setLogIp(req.getRemoteAddr());
			logVO.setEmpId(empVO.getEmpId());
			
			// 로그 상세 설정
			if (signature.contains("startWork")) {
				logVO.setLogDetail("출근 기록");
			} else if (signature.contains("stopWork")) {
				logVO.setLogDetail("퇴근 기록");
			} 
			logservice.insert(logVO);
		}
		return result;
	}
	
	@Around("execution(* kr.or.ddit.employee.comment.service.ICommentService.*(..))")
	public Object CommentService(ProceedingJoinPoint pjp) throws Throwable {
		Object result = pjp.proceed();
		
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		LogVO logVO = new LogVO();
		String signature = pjp.getSignature().toString();
		if (signature.contains("commentInsert") || signature.contains("replyInsert")) {
			logVO.setEmpNm(empVO.getEmpNm());
			logVO.setJbgdCd(empVO.getJbgdCd());
			logVO.setLogIp(req.getRemoteAddr());
			logVO.setEmpId(empVO.getEmpId());
			
			// 로그 상세 설정
			if (signature.contains("commentInsert")) {
				logVO.setLogDetail("댓글 작성");
			} else if (signature.contains("replyInsert")) {
				logVO.setLogDetail("대댓글 작성");
			} 
			logservice.insert(logVO);
		}
		return result;
	}
	
	@Around("execution(* kr.or.ddit.company.personnelInformation.service.IInformationService.*(..))")
	public Object InformationService(ProceedingJoinPoint pjp) throws Throwable {
		Object result = pjp.proceed();
		
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		LogVO logVO = new LogVO();
		String signature = pjp.getSignature().toString();
		if (signature.contains("insertEmployee") || signature.contains("insertDepartment")) {
			logVO.setEmpNm(empVO.getEmpNm());
			logVO.setJbgdCd(empVO.getJbgdCd());
			logVO.setLogIp(req.getRemoteAddr());
			logVO.setEmpId(empVO.getEmpId());
			
			// 로그 상세 설정
			if (signature.contains("insertEmployee")) {
				logVO.setLogDetail("사원 추가");
			} else if (signature.contains("insertDepartment")) {
				logVO.setLogDetail("부서 추가");
			} 
			logservice.insert(logVO);
		}
		return result;
	}

	
	@Around("execution(* kr.or.ddit.employee.vehicleReservation.service.IVehicleService.*(..))")
	public Object VehicleService(ProceedingJoinPoint pjp) throws Throwable {
		Object result = pjp.proceed();
		
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO empVO = user.getMember();
		
		LogVO logVO = new LogVO();
		String signature = pjp.getSignature().toString();
		if (signature.contains("insertReservation") || signature.contains("insertDepartment")) {
			logVO.setEmpNm(empVO.getEmpNm());
			logVO.setJbgdCd(empVO.getJbgdCd());
			logVO.setLogIp(req.getRemoteAddr());
			logVO.setEmpId(empVO.getEmpId());
			
			// 로그 상세 설정
			if (signature.contains("insertReservation")) {
				logVO.setLogDetail("차량 등록");
			} else if (signature.contains("insertDepartment")) {
				logVO.setLogDetail("부서 추가");
			} 
			logservice.insert(logVO);
		}
		return result;
	}

}

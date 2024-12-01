package kr.or.ddit.comm.alarm.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.comm.alarm.vo.AlarmVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SocketHandler extends TextWebSocketHandler {

	// 로그인 한 사용자를 담기위한 list
	private static List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();

	// 소켓 접속
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("## 누군가 접속");
		// 웹소켓 session에서 httpSession 정보를 활용할 수 있음
		// log.info("접속된 사람 ID는 {}",session.getPrincipal().getName());
		SecurityContext sc = (SecurityContext) session.getAttributes().get("SPRING_SECURITY_CONTEXT");
		CustomUser user = (CustomUser) sc.getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		String alarmTarget = employeeVO.getEmpId();
		log.info("접속된 사람  정보는 {}", employeeVO.getEmpId());

		if (employeeVO.getEmpId() != null) {
			log.info("if문 들어옴 {}", alarmTarget);
			users.put(alarmTarget, session);
		}

		sessionList.add(session);

	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("송수신 메시지 처리");
		// empId
		SecurityContext sc = (SecurityContext) session.getAttributes().get("SPRING_SECURITY_CONTEXT");
		CustomUser user = (CustomUser) sc.getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getMember();
		String alarmTarget = employeeVO.getEmpId();

		String msg = message.getPayload();
		log.info("송수신 메시지: {}", msg); // aOpen에서 오는 payload

		// 여기까진 들어와

		if (msg != null) {

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParser.parse(msg);

			String alarmCategory = (String) jsonObj.get("alarmCategory");
			alarmTarget = (String) jsonObj.get("alarmTarget");
			String alarmCn = (String) jsonObj.get("alarmCn");
			String alarmUrl = (String) jsonObj.get("alarmUrl");

			// 각 행동에 따라 알림 처리
			// type
			switch (alarmCategory) {
			case "elapr":
				sendMessageToalarmTargetUser("elapr", alarmTarget, alarmCn, alarmUrl);
				break;
			case "cmntyRe":
				sendMessageToalarmTargetUser("cmntyRe", alarmTarget, alarmCn, alarmUrl);
				break;
			case "calender":
				sendMessageToalarmTargetUser("calender", alarmTarget, alarmCn, alarmUrl);
				break;
			case "project":
				sendMessageToalarmTargetUser("project", alarmTarget, alarmCn, alarmUrl);
				break;
			case "community":
				sendMessageToalarmTargetUser("community", alarmTarget, alarmCn, alarmUrl);
				break;
			case "video":
				sendMessageToalarmTargetUser("video", alarmTarget, alarmCn, alarmUrl);
				break;
			case "car":
				sendMessageToalarmTargetUser("car", alarmTarget, alarmCn, alarmUrl);
				break;
			case "facilty":
				sendMessageToalarmTargetUser("facilty", alarmTarget, alarmCn, alarmUrl);
				break;
			case "vacation":
				sendMessageToalarmTargetUser("vacation", alarmTarget, alarmCn, alarmUrl);
				break;
			case "prove":
				sendMessageToalarmTargetUser("prove", alarmTarget, alarmCn, alarmUrl);
				break;
			case "QnA":
				sendMessageToalarmTargetUser("QnA", alarmTarget, alarmCn, alarmUrl);
				break;
			case "info":
				sendMessageToalarmTargetUser("info", alarmTarget, alarmCn, alarmUrl);
				break;
		}
		}

	}

	private void sendMessageToalarmTargetUser(String alarmCategory, String alarmTarget, String alarmCn, String alarmUrl)
			throws Exception {
		WebSocketSession alarmTargetSession = users.get(alarmTarget); // 메시지를 받을 세션 조회

		if (alarmTargetSession != null && alarmTargetSession.isOpen()) {
			if (alarmCategory == "community") {
				String cmntyFormatMessage = cmntyFormatMessage(alarmCategory, alarmCn, alarmUrl);
				TextMessage tmpMsg = new TextMessage(cmntyFormatMessage);
				alarmTargetSession.sendMessage(tmpMsg);
				log.info("메시지를 {}에게 이렇게 보냄: {}", alarmTarget, tmpMsg.getPayload());
			} else if (alarmCategory == "cmntyRe") {
				String replyFormatMessage = replyFormatMessage(alarmCategory, alarmCn, alarmUrl);
				TextMessage tmpMsg = new TextMessage(replyFormatMessage);
				alarmTargetSession.sendMessage(tmpMsg);
				log.info("메시지를 {}에게 이렇게 보냄: {}", alarmTarget, tmpMsg.getPayload());
			} else if (alarmCategory == "elapr") {
				String approFormatMessage = approFormatMessage(alarmCategory, alarmCn, alarmUrl);
				TextMessage tmpMsg = new TextMessage(approFormatMessage);
				alarmTargetSession.sendMessage(tmpMsg);
				log.info("메시지를 {}에게 이렇게 보냄: {}", alarmTarget, tmpMsg.getPayload());
			} else if (alarmCategory == "QnA") {
				String qnaFormatMessage = qnaFormatMessage(alarmCategory, alarmCn, alarmUrl);
				TextMessage tmpMsg = new TextMessage(qnaFormatMessage);
				alarmTargetSession.sendMessage(tmpMsg);
				log.info("메시지를 {}에게 이렇게 보냄: {}", alarmTarget, tmpMsg.getPayload());
			} else if (alarmCategory == "calender") {
				String schFormatMessage = schFormatMessage(alarmCategory, alarmCn, alarmUrl);
				TextMessage tmpMsg = new TextMessage(schFormatMessage);
				alarmTargetSession.sendMessage(tmpMsg);
				log.info("메시지를 {}에게 이렇게 보냄: {}", alarmTarget, tmpMsg.getPayload());
			} else if (alarmCategory == "project") {
				String projFormatMessage = projFormatMessage(alarmCategory, alarmCn, alarmUrl);
				TextMessage tmpMsg = new TextMessage(projFormatMessage);
				alarmTargetSession.sendMessage(tmpMsg);
				log.info("메시지를 {}에게 이렇게 보냄: {}", alarmTarget, tmpMsg.getPayload());
			} else if (alarmCategory == "car") {
				String carFormatMessage = carFormatMessage(alarmCategory, alarmCn, alarmUrl);
				TextMessage tmpMsg = new TextMessage(carFormatMessage);
				alarmTargetSession.sendMessage(tmpMsg);
				log.info("메시지를 {}에게 이렇게 보냄: {}", alarmTarget, tmpMsg.getPayload());
			} else if (alarmCategory == "facilty") {
				String facFormatMessage = facFormatMessage(alarmCategory, alarmCn, alarmUrl);
				TextMessage tmpMsg = new TextMessage(facFormatMessage);
				alarmTargetSession.sendMessage(tmpMsg);
				log.info("메시지를 {}에게 이렇게 보냄: {}", alarmTarget, tmpMsg.getPayload());
			} else if (alarmCategory == "vacation") {
				String vacFormatMessage = vacFormatMessage(alarmCategory, alarmCn, alarmUrl);
				TextMessage tmpMsg = new TextMessage(vacFormatMessage);
				alarmTargetSession.sendMessage(tmpMsg);
				log.info("메시지를 {}에게 이렇게 보냄: {}", alarmTarget, tmpMsg.getPayload());
			} else if (alarmCategory == "prove") {
				String provFormatMessage = provFormatMessage(alarmCategory, alarmCn, alarmUrl);
				TextMessage tmpMsg = new TextMessage(provFormatMessage);
				alarmTargetSession.sendMessage(tmpMsg);
				log.info("메시지를 {}에게 이렇게 보냄: {}", alarmTarget, tmpMsg.getPayload());
			} else if (alarmCategory == "info") {
				String infoFormatMessage = infoFormatMessage(alarmCategory, alarmCn, alarmUrl);
				TextMessage tmpMsg = new TextMessage(infoFormatMessage);
				alarmTargetSession.sendMessage(tmpMsg);
				log.info("메시지를 {}에게 이렇게 보냄: {}", alarmTarget, tmpMsg.getPayload());
			}
		} else {
			log.info("수신자 {}는 현재 접속 중이지 않음", alarmTarget);
		}
	}
	
	private String infoFormatMessage(String alarmCategory, String alarmCn, String alarmUrl) { // aMessage 커뮤니티
		return "	<div class=\"d-flex flex-stack py-4\">\r\n" + "<div class=\"d-flex align-items-center\">\r\n"
		+ "			<div class=\"symbol symbol-35px me-4\">\r\n"
		+ "				<span class=\"symbol-label bg-light-warning\"> <i\r\n"
		+ "					class=\"bi bi-info-circle\">"
		+ "						</i>\r\n" + "</span>\r\n" + "</div>\r\n"
		+ "				<div class=\"mb-0 me-2\">\r\n" + "<a href=" + alarmUrl + "\r\n"
		+ "						class=\"fs-6 text-gray-800 text-hover-primary fw-bold\">" + alarmCategory
		+ "</a>\r\n" + "<div class=\"text-gray-500 fs-7\">" + alarmCn + "</div>\r\n"
		+ "					</div>\r\n" + "				</div>\r\n"
//				+ "			<span class=\"badge badge-light fs-8\">${alarmVO.alarmCrtDt}</span>\r\n" 
+ "	</div>\r\n";
	}
	
	private String qnaFormatMessage(String alarmCategory, String alarmCn, String alarmUrl) { // aMessage 커뮤니티
		return "	<div class=\"d-flex flex-stack py-4\">\r\n" + "<div class=\"d-flex align-items-center\">\r\n"
		+ "			<div class=\"symbol symbol-35px me-4\">\r\n"
		+ "				<span class=\"symbol-label bg-light-warning\"> <i\r\n"
		+ "					class=\"bi bi-chat-right-dots\">"
		+ "						</i>\r\n" + "</span>\r\n" + "</div>\r\n"
		+ "				<div class=\"mb-0 me-2\">\r\n" + "<a href=" + alarmUrl + "\r\n"
		+ "						class=\"fs-6 text-gray-800 text-hover-primary fw-bold\">" + alarmCategory
		+ "</a>\r\n" + "<div class=\"text-gray-500 fs-7\">" + alarmCn + "</div>\r\n"
		+ "					</div>\r\n" + "				</div>\r\n"
//				+ "			<span class=\"badge badge-light fs-8\">${alarmVO.alarmCrtDt}</span>\r\n" 
+ "	</div>\r\n";
	}

	private String provFormatMessage(String alarmCategory, String alarmCn, String alarmUrl) { // aMessage 커뮤니티
		return "	<div class=\"d-flex flex-stack py-4\">\r\n" + "<div class=\"d-flex align-items-center\">\r\n"
				+ "			<div class=\"symbol symbol-35px me-4\">\r\n"
				+ "				<span class=\"symbol-label bg-light-warning\"> <i\r\n"
				+ "					class=\"bi bi-file-earmark\">"
				+ "						</i>\r\n" + "</span>\r\n" + "</div>\r\n"
				+ "				<div class=\"mb-0 me-2\">\r\n" + "<a href=" + alarmUrl + "\r\n"
				+ "						class=\"fs-6 text-gray-800 text-hover-primary fw-bold\">" + alarmCategory
				+ "</a>\r\n" + "<div class=\"text-gray-500 fs-7\">" + alarmCn + "</div>\r\n"
				+ "					</div>\r\n" + "				</div>\r\n"
//				+ "			<span class=\"badge badge-light fs-8\">${alarmVO.alarmCrtDt}</span>\r\n" 
				+ "	</div>\r\n";
	}

	private String vacFormatMessage(String alarmCategory, String alarmCn, String alarmUrl) { // aMessage 커뮤니티
		return "	<div class=\"d-flex flex-stack py-4\">\r\n" + "<div class=\"d-flex align-items-center\">\r\n"
				+ "			<div class=\"symbol symbol-35px me-4\">\r\n"
				+ "				<span class=\"symbol-label bg-light-danger\"> <i\r\n"
				+ "					class=\"bi bi-calendar-heart-fill\">"
				+ "						</i>\r\n" + "</span>\r\n" + "</div>\r\n"
				+ "				<div class=\"mb-0 me-2\">\r\n" + "<a href=" + alarmUrl + "\r\n"
				+ "						class=\"fs-6 text-gray-800 text-hover-primary fw-bold\">" + alarmCategory
				+ "</a>\r\n" + "<div class=\"text-gray-500 fs-7\">" + alarmCn + "</div>\r\n"
				+ "					</div>\r\n" + "				</div>\r\n"
//				+ "			<span class=\"badge badge-light fs-8\">${alarmVO.alarmCrtDt}</span>\r\n" 
				+ "	</div>\r\n";
	}

	private String facFormatMessage(String alarmCategory, String alarmCn, String alarmUrl) { // aMessage 커뮤니티
		return "	<div class=\"d-flex flex-stack py-4\">\r\n" + "<div class=\"d-flex align-items-center\">\r\n"
				+ "			<div class=\"symbol symbol-35px me-4\">\r\n"
				+ "				<span class=\"symbol-label bg-light-info\"> <i\r\n"
				+ "					class=\"bi bi-building-check\">"
				+ "						</i>\r\n" + "</span>\r\n" + "</div>\r\n"
				+ "				<div class=\"mb-0 me-2\">\r\n" + "<a href=" + alarmUrl + "\r\n"
				+ "						class=\"fs-6 text-gray-800 text-hover-primary fw-bold\">" + alarmCategory
				+ "</a>\r\n" + "<div class=\"text-gray-500 fs-7\">" + alarmCn + "</div>\r\n"
				+ "					</div>\r\n" + "				</div>\r\n"
//				+ "			<span class=\"badge badge-light fs-8\">${alarmVO.alarmCrtDt}</span>\r\n" 
				+ "	</div>\r\n";
	}

	private String cmntyFormatMessage(String alarmCategory, String alarmCn, String alarmUrl) { // aMessage 커뮤니티
		return "	<div class=\"d-flex flex-stack py-4\">\r\n" + "<div class=\"d-flex align-items-center\">\r\n"
				+ "			<div class=\"symbol symbol-35px me-4\">\r\n"
				+ "				<span class=\"symbol-label bg-light-primary\"> <i\r\n"
				+ "					class=\"ki-duotone ki-abstract-28 fs-2 text-primary\"><span\r\n"
				+ "						class=\"path1\"></span> <span class=\"path2\"></span>\r\n"
				+ "						</i>\r\n" + "</span>\r\n" + "</div>\r\n"
				+ "				<div class=\"mb-0 me-2\">\r\n" + "<a href=" + alarmUrl + "\r\n"
				+ "						class=\"fs-6 text-gray-800 text-hover-primary fw-bold\">" + alarmCategory
				+ "</a>\r\n" + "<div class=\"text-gray-500 fs-7\">" + alarmCn + "</div>\r\n"
				+ "					</div>\r\n" + "				</div>\r\n"
//				+ "			<span class=\"badge badge-light fs-8\">${alarmVO.alarmCrtDt}</span>\r\n" 
				+ "	</div>\r\n";
	}
	
	private String replyFormatMessage(String alarmCategory, String alarmCn, String alarmUrl) { // aMessage 커뮤니티
		return "	<div class=\"d-flex flex-stack py-4\">\r\n" + "<div class=\"d-flex align-items-center\">\r\n"
		+ "			<div class=\"symbol symbol-35px me-4\">\r\n"
		+ "				<span class=\"symbol-label bg-light-primary\"> <i\r\n"
		+ "					class=\"ki-duotone ki-abstract-28 fs-2 text-primary\"><span\r\n"
		+ "						class=\"path1\"></span> <span class=\"path2\"></span>\r\n"
		+ "						</i>\r\n" + "</span>\r\n" + "</div>\r\n"
		+ "				<div class=\"mb-0 me-2\">\r\n" + "<a href=" + alarmUrl + "\r\n"
		+ "						class=\"fs-6 text-gray-800 text-hover-primary fw-bold\">" + alarmCategory
		+ "</a>\r\n" + "<div class=\"text-gray-500 fs-7\">" + alarmCn + "</div>\r\n"
		+ "					</div>\r\n" + "				</div>\r\n"
//				+ "			<span class=\"badge badge-light fs-8\">${alarmVO.alarmCrtDt}</span>\r\n" 
+ "	</div>\r\n";
	}

	private String approFormatMessage(String alarmCategory, String alarmCn, String alarmUrl) { // aMessage 전자결재
		return "	<div class=\"d-flex flex-stack py-4\">\r\n" + "		<div class=\"d-flex align-items-center\">\r\n"
				+ "			<div class=\"symbol symbol-35px me-4\">\r\n"
				+ "				<span class=\"symbol-label bg-light-warning\"> <i\r\n"
				+ "					class=\"ki-duotone ki-briefcase fs-2 text-warning\"> <span\r\n"
				+ "					class=\"path1\"></span> <span class=\"path2\"></span>\r\n</i>\r\n"
				+ "				</span>\r\n" + "			</div>" + "			<div class=\"mb-0 me-2\">\r\n"
				+ "				<div class=\"mb-0 me-2\">\r\n" + "<a href=" + alarmUrl + "\r\n"
				+ "						class=\"fs-6 text-gray-800 text-hover-primary fw-bold\">" + alarmCategory
				+ "</a>\r\n" + "<div class=\"text-gray-500 fs-7\">" + alarmCn + "</div>\r\n"
				+ "					</div>\r\n" + "				</div>\r\n"
//				+ "			<span class=\"badge badge-light fs-8\">${alarmVO.alarmCrtDt}</span>\r\n" 
				+ "	</div>\r\n";
	}

	private String schFormatMessage(String alarmCategory, String alarmCn, String alarmUrl) { // aMessage 일정
		return "	<div class=\"d-flex flex-stack py-4\">\r\n" + "		<div class=\"d-flex align-items-center\">\r\n"
				+ "			<div class=\"symbol symbol-35px me-4\">\r\n"
				+ "				<span class=\"symbol-label bg-light-danger\"> <i class=\"bi bi-calendar-check\"></i>\r\n"
				+ "				</span>\r\n" + "			</div>\r\n" + "				<div class=\"mb-0 me-2\">\r\n"
				+ "<a href=" + alarmUrl + "\r\n"
				+ "						class=\"fs-6 text-gray-800 text-hover-primary fw-bold\">" + alarmCategory
				+ "</a>\r\n" + "<div class=\"text-gray-500 fs-7\">" + alarmCn + "</div>\r\n"
				+ "					</div>\r\n" + "				</div>\r\n"
//				+ "			<span class=\"badge badge-light fs-8\">${alarmVO.alarmCrtDt}</span>\r\n" 
				+ "	</div>\r\n";
	}

	private String projFormatMessage(String alarmCategory, String alarmCn, String alarmUrl) { // aMessage 프로젝트
		return "	<div class=\"d-flex flex-stack py-4\">\r\n" + "		<div class=\"d-flex align-items-center\">\r\n"
				+ "			<div class=\"symbol symbol-35px me-4\">\r\n"
				+ "				<span class=\"symbol-label bg-light-success\"> <i\r\n"
				+ "					class=\"ki-duotone ki-abstract-12 fs-2 text-success\"> <span\r\n"
				+ "						class=\"path1\"></span> <span class=\"path2\"></span>\r\n"
				+ "					</i>\r\n" + "				</span>\r\n" + "			</div>\r\n"
				+ "				<div class=\"mb-0 me-2\">\r\n" + "<a href=" + alarmUrl + "\r\n"
				+ "						class=\"fs-6 text-gray-800 text-hover-primary fw-bold\">" + alarmCategory
				+ "</a>\r\n" + "<div class=\"text-gray-500 fs-7\">" + alarmCn + "</div>\r\n"
				+ "					</div>\r\n" + "				</div>\r\n"
//				+ "			<span class=\"badge badge-light fs-8\">${alarmVO.alarmCrtDt}</span>\r\n" 
				+ "	</div>\r\n";
	}

	private String carFormatMessage(String alarmCategory, String alarmCn, String alarmUrl) { // aMessage 차량예약
		return "	<div class=\"d-flex flex-stack py-4\">\r\n" + "		<div class=\"d-flex align-items-center\">\r\n"
				+ "			<div class=\"symbol symbol-35px me-4\">\r\n"
				+ "				<span class=\"symbol-label bg-light-info\"> <i\r\n"
				+ "					class=\"ki-duotone ki-picture fs-2 text-info\"><span\r\n"
				+ "						class=\"material-symbols-outlined\" style=\"color: #B2A8D3;\">directions_car</span></i>\r\n"
				+ "				</span>\r\n" + "			</div>\r\n" + "				<div class=\"mb-0 me-2\">\r\n"
				+ "<a href=" + alarmUrl + "\r\n"
				+ "						class=\"fs-6 text-gray-800 text-hover-primary fw-bold\">" + alarmCategory
				+ "</a>\r\n" + "<div class=\"text-gray-500 fs-7\">" + alarmCn + "</div>\r\n"
				+ "					</div>\r\n" + "				</div>\r\n"
//				+ "			<span class=\"badge badge-light fs-8\">${alarmVO.alarmCrtDt}</span>\r\n" 
				+ "	</div>\r\n";
	}

	// 특정 사용자
	public void sendMessageToUser(String alarmTarget, String message) throws Exception {
		WebSocketSession targetSession = users.get(alarmTarget); // 사용자 세션 조회
		if (targetSession != null && targetSession.isOpen()) {
			TextMessage tmpMsg = new TextMessage(message);
			targetSession.sendMessage(tmpMsg);
		}
	}

	// 소켓 나감
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("## 누군가 떠남");
		sessionList.remove(session);
	}
}

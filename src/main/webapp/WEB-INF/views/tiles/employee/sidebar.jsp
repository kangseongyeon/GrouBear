<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<style>
.menu-link.active {
	background-color: #e0e0e0; /* 활성화된 메뉴의 배경색 */
	color: #000; /* 활성화된 메뉴의 글자색 */
}

.menu-link.active .menu-arrow {
	transform: rotate(90deg); /* 활성화된 메뉴의 화살표 회전 */
}
</style>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 현재 URL 가져오기
        const currentUrl = window.location.pathname;
/*         console.log('currentUrl : ' + currentUrl);  */
        
        // 모든 메뉴 링크를 선택
        const menuLinks = document.querySelectorAll('.menu-link');
/*         console.log('menuLinks : ');  
		console.log(menuLinks);  */
        menuLinks.forEach(link => { 
            // 링크의 href 속성과 현재 URL 비교
            const linkUrl = link.getAttribute('href');
            if (linkUrl == currentUrl) {  
/*             	console.log('linkUrl : ');
            	console.log(linkUrl);  */
                link.classList.add('active'); // 활성화된 클래스 추가
                const subMenu = link.closest('.menu-accordion'); 
/*                 console.log('subMenu : ');  
        		console.log(subMenu);  */
                if (subMenu) {
                    subMenu.classList.add('show'); // 서브 메뉴 펼치기
                }
            } 
        });
    });
</script>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=directions_car,notifications,play_circle,stop_circle" />
<link rel="stylesheet" href="" />

<c:set var="customUser"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />
<c:forEach items="${customUser.menuList}" var="mem">
	<input type="hidden" value="${mem.menuNo}"
		data-menu-list="${mem.menuNo}">
</c:forEach>


<div id="kt_app_sidebar" class="app-sidebar flex-column"
	data-kt-drawer="true" data-kt-drawer-name="app-sidebar"
	data-kt-drawer-activate="{default: true, lg: false}"
	data-kt-drawer-overlay="true" data-kt-drawer-width="250px"
	data-kt-drawer-direction="start"
	data-kt-drawer-toggle="#kt_app_sidebar_mobile_toggle">
	<div
		class="app-sidebar-logo d-none d-lg-flex flex-stack flex-shrink-0 px-13"
		id="kt_app_sidebar_logo">
		<a href="/employee/main.do"> <img alt="Logo"
			src="${pageContext.request.contextPath}/resources/design/media/logos/GrouBear.png"
			class="theme-light-show h-85px" /> <img alt="Logo"
			src="${pageContext.request.contextPath}/resources/design/media/logos/GrouBear.png"
			class="theme-dark-show h-25px" />
		</a>
	</div>
	<div class="separator d-none d-lg-block"></div>
	<div class="app-sidebar-toolbar d-flex flex-stack py-6 px-8">
		<div class="nav bg-light rounded-pill px-3  w-225px">
			<c:choose>
				<c:when test="${not empty sessionScope.startWork and sessionScope.startWork eq 'N' }">
					<!--  근무 시작 -->
					<button id="startWorkBtn"
						class="btn btn-outline btn-outline-dashed btn-outline-secondary btn-active-light-secondary"
						style="width: 100%; display: inline-flex; align-items: center; justify-content: center; text-align: center;">
						<span class="material-symbols-outlined" style="margin-right: 5px;">play_circle</span>
						출근
					</button>
				</c:when>
				<c:otherwise>
					<!--  근무 종료 -->
					<button id="stopWorkBtn"
						class="btn btn-outline"
				        style="width: 100%; display: inline-flex; align-items: center; justify-content: center; text-align: center; background-color: black; color: white; border: 1px solid white;">
						<span class="material-symbols-outlined" style="margin-right: 5px;">stop_circle</span>
						퇴근
					</button>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="separator"></div>
	<div class="app-sidebar-menu hover-scroll-y my-5 my-lg-5 mx-3"
		id="kt_app_sidebar_menu_wrapper" data-kt-scroll="true"
		data-kt-scroll-height="auto"
		data-kt-scroll-dependencies="#kt_app_sidebar_toolbar, #kt_app_sidebar_footer"
		data-kt-scroll-offset="0">
		<div
			class="menu menu-column menu-sub-indention menu-active-bg fw-semibold"
			id="#kt_sidebar_menu" data-kt-menu="true">
			<!-- 사원 사이드바 -->
			<!-- 			<div data-kt-menu-trigger="click" class="menu-item menu-accordion"> -->
			<!-- 				<span class="menu-link"> -->
			<!-- 					<span class="menu-icon"> -->
			<!-- 						<i class="bi bi-house"> -->
			<!-- 							<span class="path1"></span> -->
			<!-- 							<span class="path2"></span> -->
			<!-- 							<span class="path3"></span> -->
			<!-- 							<span class="path4"></span> -->
			<!-- 							<span class="path5"></span> -->
			<!-- 						</i> -->
			<!-- 					</span> -->
			<!-- 					<span class="menu-title">홈 피드</span> -->
			<!-- 					<span class="menu-arrow"></span> -->
			<!-- 				</span> -->
			<!-- 				<div class="menu-sub menu-sub-accordion"> -->
			<!-- 					<div class="menu-item"> -->
			<!-- 						<a class="menu-link" href="pages/about.html"> -->
			<!-- 							<span class="menu-bullet"> -->
			<!-- 								<span class="bullet bullet-dot"></span> -->
			<!-- 							</span> -->
			<!-- 							<span class="menu-title">홈피드</span> -->
			<!-- 						</a> -->
			<!-- 					</div> -->
			<!-- 				</div> -->
			<!-- 			</div> -->

			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion hiddenMenu" id="menu_001">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-people"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span>
					</i>
				</span> <span class="menu-title">인사·정보 관리</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/empinformation/allinfo.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">전체 사원 관리</span>
						</a>
					</div>
				</div>
			</div>

			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion ${workMenu }" id="menu_002">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-clock-history"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span> <span
							class="path6"></span>
					</i>
				</span> <span class="menu-title">근태 관리</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion menu-active-bg">
					<div class="menu-item">
						<a class="menu-link ${workCommute }" href="/employee/commute/management.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">출퇴근 관리</span>
						</a>
					</div>
					<div class="menu-item">
						<a class="menu-link ${vacationHistory }" href="/employee/vacation/history.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">휴가 생성</span>
						</a>
					</div>
					<div class="menu-item">
						<a class="menu-link ${vacationApplication }"
							href="/employee/vacation/applicationhistory.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">휴가 신청</span>
						</a>
					</div>
					<div class="menu-item">
						<a class="menu-link ${vacationApproval }" href="/employee/vacation/approval.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">휴가 승인</span>
						</a>
					</div>
				</div>
			</div>



			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion hiddenMenu" id="menu_005">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-folder"> <span class="path1"></span> <span
							class="path2"></span>
					</i>
				</span> <span class="menu-title">증명서</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/employee/provedocAplyList.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">증명서 발급</span>
						</a>
					</div>
				</div>
			</div>



			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion hiddenMenu" id="menu_008">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-person-video3"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span> <span
							class="path6"></span> <span class="path7"></span> <span
							class="path8"></span>
					</i>
				</span> <span class="menu-title">조직도</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/employee/organizationchart.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">조직도</span>
						</a>
					</div>
				</div>
			</div>

			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion ${elaprMenu}" id="menu_003">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-newspaper"></i>
				</span> <span class="menu-title">전자결재</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/employee/elaprMain.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">전자결재</span>
						</a>
					</div>
					<div class="menu-item">
						<a class="menu-link" href="/employee/elaprForm.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">새 결재 진행하기</span>
						</a>
					</div>
					<div class="menu-item">
						<a class="menu-link" href="/employee/empElaprWating.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">결재 대기 문서</span>
						</a>
					</div>
					<div class="menu-item">
						<a class="menu-link" href="/employee/empElaprAll.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">전체 문서함</span>
						</a>
					</div>
					<div data-kt-menu-trigger="click"
						class="menu-item menu-accordion ${elaprMyMenu}">
						<span class="menu-link"> <span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">개인 문서함</span> <span class="menu-arrow"></span>
						</span>
						<div class="menu-sub menu-sub-accordion">
							<div class="menu-item">
								<a class="menu-link ${empElaprDraft }"
									href="/employee/empElaprDraft.do"> <span
									class="menu-bullet"> <span class="bullet bullet-dot"></span>
								</span> <span class="menu-title">기안 문서함</span>
								</a>
							</div>
							<div class="menu-item">
								<a class="menu-link ${empElaprRernc }"
									href="/employee/empElaprRernc.do"> <span
									class="menu-bullet"> <span class="bullet bullet-dot"></span>
								</span> <span class="menu-title">참조/열람 문서함</span>
								</a>
							</div>

							<div class="menu-item">
								<a class="menu-link ${empMyElaprAll }"
									href="/employee/empMyElaprAll.do"> <span
									class="menu-bullet"> <span class="bullet bullet-dot"></span>
								</span> <span class="menu-title">개인 전체 문서함</span>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>




			<!-- employee 달성률 -> 프로젝트 변경 / 경로 변경 -->
			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion hiddenMenu" id="menu_006">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-check2-circle"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span> <span
							class="path6"></span> <span class="path7"></span> <span
							class="path8"></span>
					</i>
				</span> <span class="menu-title">프로젝트</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/employee/project.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">프로젝트</span>
						</a>
					</div>
				</div>
			</div>

			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion hiddenMenu" id="menu_007">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-calendar-date"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span> <span
							class="path6"></span> <span class="path7"></span> <span
							class="path8"></span>
					</i>
				</span> <span class="menu-title">일정관리</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/employee/calendar.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">일정 관리</span>
						</a>
					</div>
				</div>
			</div>



			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion hiddenMenu ${cloudMenu}" id="menu_013">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-cloud-download"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span> <span
							class="path6"></span> <span class="path7"></span> <span
							class="path8"></span>
					</i>
				</span> <span class="menu-title">클라우드</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link ${cloudInternal}" href="/employee/cloudList.do "> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">클라우드</span>
						</a>
					</div>
				</div>
			</div>



			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion hiddenMenu" id="menu_012">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-chat-left-text"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span> <span
							class="path6"></span> <span class="path7"></span> <span
							class="path8"></span>
					</i>
				</span> <span class="menu-title">커뮤니티</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/employee/communityCompany.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">커뮤니티</span>
						</a>
					</div>
				</div>
			</div>



			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion hiddenMenu" id="menu_014">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-car-front"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span> <span
							class="path6"></span> <span class="path7"></span> <span
							class="path8"></span>
					</i>
				</span> <span class="menu-title">차량 예약</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/empvehicle/vehicledashboard.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">차량 예약</span>
						</a>
					</div>
					<div class="menu-item">
						<a class="menu-link" href="/empvehicle/reservationhistory.do">
							<span class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">차량 예약 내역</span>
						</a>
					</div>
				</div>
			</div>


			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion ${facilitesMenu }" id="menu_015">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-shop"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span> <span
							class="path6"></span> <span class="path7"></span> <span
							class="path8"></span>
					</i>
				</span> <span class="menu-title">시설예약</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link ${facilitesStatus }" href="/employee/facilities/status.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">시설 현황</span>
						</a>
					</div>
					<div class="menu-item">
						<a class="menu-link ${facilitesReserveStatus }" href="/employee/facilities/reserve/status.do">
							<span class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">예약 현황</span>
						</a>
					</div>
				</div>
			</div>

			<!-- <div data-kt-menu-trigger="click" class="menu-item menu-accordion hiddenMenu" id="menu_009">
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-envelope-at">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
							<span class="path4"></span>
							<span class="path5"></span>
							<span class="path6"></span>
							<span class="path7"></span>
							<span class="path8"></span>
						</i>
					</span>
					<span class="menu-title">메일</span>
					<span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/employee/mailList.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">메일</span>
						</a>
					</div>
				</div>
			</div> -->

			<!-- <div data-kt-menu-trigger="click" class="menu-item menu-accordion hiddenMenu" id="menu_010">
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-messenger">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
							<span class="path4"></span>
							<span class="path5"></span>
							<span class="path6"></span>
							<span class="path7"></span>
							<span class="path8"></span>
						</i>
					</span>
					<span class="menu-title">메신저</span>
					<span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/employee/messenger.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">메신저</span>
						</a>
					</div>
				</div>
			</div> -->

			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion hiddenMenu" id="menu_011">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-webcam"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span> <span
							class="path6"></span> <span class="path7"></span> <span
							class="path8"></span>
					</i>
				</span> <span class="menu-title">화상채팅</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/employee/videochatting.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">화상 채팅</span>
						</a>
					</div>
				</div>
			</div>


			<!-- 			<div data-kt-menu-trigger="click" class="menu-item menu-accordion"> -->
			<!-- 				<span class="menu-link"> -->
			<!-- 					<span class="menu-icon"> -->
			<!-- 						<i class="bi bi-cash-coin"> -->
			<!-- 							<span class="path1"></span> -->
			<!-- 							<span class="path2"></span> -->
			<!-- 							<span class="path3"></span> -->
			<!-- 							<span class="path4"></span> -->
			<!-- 							<span class="path5"></span> -->
			<!-- 							<span class="path6"></span> -->
			<!-- 							<span class="path7"></span> -->
			<!-- 							<span class="path8"></span> -->
			<!-- 						</i> -->
			<!-- 					</span> -->
			<!-- 					<span class="menu-title">급여정산</span> -->
			<!-- 					<span class="menu-arrow"></span> -->
			<!-- 				</span> -->
			<!-- 				<div class="menu-sub menu-sub-accordion"> -->
			<!-- 					<div class="menu-item"> -->
			<!-- 						<a class="menu-link" href="pages/careers/list.html"> -->
			<!-- 							<span class="menu-bullet"> -->
			<!-- 								<span class="bullet bullet-dot"></span> -->
			<!-- 							</span> -->
			<!-- 							<span class="menu-title">Careers List</span> -->
			<!-- 						</a> -->
			<!-- 					</div> -->
			<!-- 					<div class="menu-item"> -->
			<!-- 						<a class="menu-link" href="pages/careers/apply.html"> -->
			<!-- 							<span class="menu-bullet"> -->
			<!-- 								<span class="bullet bullet-dot"></span> -->
			<!-- 							</span> -->
			<!-- 							<span class="menu-title">Careers Apply</span> -->
			<!-- 						</a> -->
			<!-- 					</div> -->
			<!-- 				</div> -->
			<!-- 			</div> -->

			<!-- 			<div data-kt-menu-trigger="click" class="menu-item menu-accordion"> -->
			<!-- 				<span class="menu-link"> -->
			<!-- 					<span class="menu-icon"> -->
			<!-- 						<i class="bi bi-pencil-square"> -->
			<!-- 							<span class="path1"></span> -->
			<!-- 							<span class="path2"></span> -->
			<!-- 							<span class="path3"></span> -->
			<!-- 							<span class="path4"></span> -->
			<!-- 							<span class="path5"></span> -->
			<!-- 							<span class="path6"></span> -->
			<!-- 							<span class="path7"></span> -->
			<!-- 							<span class="path8"></span> -->
			<!-- 						</i> -->
			<!-- 					</span> -->
			<!-- 					<span class="menu-title">전자계약</span> -->
			<!-- 					<span class="menu-arrow"></span> -->
			<!-- 				</span> -->
			<!-- 				<div class="menu-sub menu-sub-accordion"> -->
			<!-- 					<div class="menu-item"> -->
			<!-- 						<a class="menu-link" href="/employee/elaprContract.do"> -->
			<!-- 							<span class="menu-bullet"> -->
			<!-- 								<span class="bullet bullet-dot"></span> -->
			<!-- 							</span> -->
			<!-- 							<span class="menu-title">전자 계약</span> -->
			<!-- 						</a> -->
			<!-- 					</div> -->
			<!-- 				</div> -->
			<!-- 			</div> -->

			<!-- 			<div data-kt-menu-trigger="click" class="menu-item menu-accordion" id="menu_apply"> -->
			<!-- 				<span class="menu-link"> -->
			<!-- 					<span class="menu-icon"> -->
			<!-- 						<i class="bi bi-person-video3"> -->
			<!-- 							<span class="path1"></span> -->
			<!-- 							<span class="path2"></span> -->
			<!-- 							<span class="path3"></span> -->
			<!-- 							<span class="path4"></span> -->
			<!-- 							<span class="path5"></span> -->
			<!-- 							<span class="path6"></span> -->
			<!-- 							<span class="path7"></span> -->
			<!-- 							<span class="path8"></span> -->
			<!-- 						</i> -->
			<!-- 					</span> -->
			<!-- 					<a class="menu-link" href="pages/careers/apply.html"> -->
			<!-- 						<span class="menu-title">예방교육</span> -->
			<!-- 					</a> -->
			<!-- 					<span class="menu-arrow"></span> -->
			<!-- 				</span> -->
			<!-- 			</div> -->


			<div data-kt-menu-trigger="click"
				class="menu-item menu-accordion hiddenMenu ${eventMenu}" id="menu_016">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="bi bi-joystick"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span> <span
							class="path6"></span> <span class="path7"></span> <span
							class="path8"></span>
					</i>
				</span> <span class="menu-title">이벤트</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<!-- 					<div class="menu-item"> -->
					<!-- 						<a class="menu-link" href="/employee/event.do"> -->
					<!-- 							<span class="menu-bullet"> -->
					<!-- 								<span class="bullet bullet-dot"></span> -->
					<!-- 							</span> -->
					<!-- 							<span class="menu-title">설문/투표</span> -->
					<!-- 						</a> -->
					<!-- 					</div> -->
					<div class="menu-item">
						<a class="menu-link ${rcmdtnInternal}" href="/employee/menuRecommend.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">날씨·메뉴추천</span>
						</a>
					</div>
				</div>
			</div>


			<div class="separator d-none d-lg-block"></div>

			<div data-kt-menu-trigger="click" class="menu-item menu-accordion ${cmntyMenu}">
				<span class="menu-link"> <span class="menu-icon"> <i
						class="ki-duotone ki-setting-2"> <span class="path1"></span> <span
							class="path2"></span>
					</i>
				</span> <span class="menu-title">시스템 공지</span> <span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link ${cmntyNotice}" href="/employee/cmntyNoticeList.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">공지사항</span>
						</a>
					</div>
					<div class="menu-item">
						<a class="menu-link ${cmntyQstn}" href="/employee/cmntyQstnList.do"> <span
							class="menu-bullet"> <span class="bullet bullet-dot"></span>
						</span> <span class="menu-title">QnA</span>
						</a>
					</div>
				</div>
			</div>
			<!-- 사원 관리자 사이드바 END -->
		</div>
	</div>
	<!-- 맨 아래 유저 정보 -->
	<div class="app-sidebar-user d-flex flex-stack py-5 px-8">
		<div class="d-flex me-5">
			<div class="me-5">
				<div class="symbol symbol-40px cursor-pointer"
					data-kt-menu-trigger="{default: 'click', lg: 'hover'}"
					data-kt-menu-placement="bottom-start" data-kt-menu-overflow="true" style="overflow: hidden;">
					<img src="/upload/${customUser.member.imgFileUrl }" alt="" style="object-fit: cover;"/>
				</div>
				<div
					class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg menu-state-color fw-semibold py-4 fs-6 w-275px"
					data-kt-menu="true">
					<div class="menu-item px-3">
						<div class="menu-content d-flex align-items-center px-3">
							<div class="symbol symbol-50px me-5" style="overflow: hidden;">
								<img src="/upload/${customUser.member.imgFileUrl }" alt="" style="object-fit: cover;"/>
							</div>
							<div class="d-flex flex-column">
								<div class="fw-bold d-flex align-items-center fs-5">${customUser.member.empNm }
									<span
										class="badge badge-light-info fw-bold fs-8 px-2 py-1 ms-2">${customUser.member.empId }</span>
								</div>
								<a href="#"
									class="fw-semibold text-muted text-hover-primary fs-7">${customUser.member.empEmlAddr }</a>
							</div>
						</div>
					</div>
					<div class="separator my-2"></div>
					<div class="menu-item px-5">
						<a
							href="/empinformation/empdetail.do?empId=${customUser.member.empId }"
							class="menu-link px-5">내 정보</a>
					</div>
					<div class="menu-item px-5">
						<a href="/employee/project.do" class="menu-link px-5"> <span
							class="menu-text">내 프로젝트</span>
						</a>
					</div>
					<div class="menu-item px-5">
						<a href="/employee/calendar.do" class="menu-link px-5"> <span
							class="menu-text">내 일정</span>
						</a>
					</div>
					<div class="menu-item px-5"
						data-kt-menu-trigger="{default: 'click', lg: 'hover'}"
						data-kt-menu-placement="right-end" data-kt-menu-offset="-15px, 0">
						<a href="#" class="menu-link px-5"> <span class="menu-title">내
								예약 현황</span> <span class="menu-arrow"></span>
						</a>
						<div class="menu-sub menu-sub-dropdown w-175px py-4">
							<div class="menu-item px-3">
								<a href="/empvehicle/reservationhistory.do"
									class="menu-link px-5">차량 예약 현황</a>
							</div>
							<div class="menu-item px-3">
								<a href="/employee/facilities/reserve/status.do"
									class="menu-link px-5">시설 예약 현황</a>
							</div>
						</div>
					</div>
					<div class="separator my-2"></div>
					<div class="menu-item px-5 my-1">
						<a href="/employee/cloudList.do" class="menu-link px-5">내
							클라우드함</a>
					</div>
				</div>
			</div>
			<div class="me-2">
				<div class="d-flex">
					<a
						href="/empinformation/teamdetail.do?teamCd=${customUser.member.teamCd }"
						class="app-sidebar-username fw-bold text-gray-900 text-hover-primary fs-6 fw-semibold">${customUser.member.empNm }</a>
					<div class="badge badge-light-info fw-bold fs-7 mx-3">${customUser.member.jbgdNm }</div>
				</div>
				<span
					class="app-sidebar-deckription text-gray-700 fw-semibold d-block fs-7">
					<c:if test="${not empty customUser.member.deptNm }">
						<span class="bullet w-10px h-4px rounded-2 bg-danger mb-1"></span>
						<span>${customUser.member.deptNm }</span>
					</c:if><br /> <c:if test="${not empty customUser.member.teamNm }">
						<span class="bullet w-10px h-4px rounded-2 bg-primary mb-1"></span>
						<span>${customUser.member.teamNm }</span>
					</c:if>
				</span>
			</div>
		</div>
		<a href="/logout"
			class="btn btn-icon btn-active-color-primary btn-icon-custom-color me-n4"
			data-bs-toggle="tooltip" title="로그아웃"> <i
			class="ki-duotone ki-entrance-left fs-2 text-gray-500"> <span
				class="path1"></span> <span class="path2"></span>
		</i>
		</a>
	</div>
</div>






<script type="text/javascript">
$(function () {
	let startWorkBtn = $("#startWorkBtn");
	let stopWorkBtn = $("#stopWorkBtn");
	
    $(".hiddenMenu").hide();

    // 세션에서 불러온 menuNo를 가져옴
    $("input[type='hidden']").each(function() {
        let menuNo = $(this).data("menu-list"); // data-menu-list에서 menuNo를 가져옴
        
        // menuNo에 해당하는 메뉴를 보여줌
        if (menuNo) {
            $("#menu_" + menuNo).show(); // ID가 menu_ + menuNo인 요소를 보여줌
        }
    });
	
	startWorkBtn.on("click",function(){
		
		$.ajax({
			url: "/employee/workstatus/startWork.do",
			type : "post",
			success : function(res) {
				console.log(res);
				if(res === "already"){
					 Swal.fire({
					      icon: 'warning',
					      title: '오늘은 이미 출근했어요!',
					      confirmButtonColor: '#4FC9DA',
					    });
				   return;
				}
				location.reload(true);
			},
			error: function(error, status){
				console.log(error);
			}
		});		
	});
	
	stopWorkBtn.on("click", function () {
		$.ajax({
			url: "/employee/workstatus/stopWork.do",
			type : "post",
			success : function(res) {
				location.reload(true);				
			},
		});	
	});

});

</script>


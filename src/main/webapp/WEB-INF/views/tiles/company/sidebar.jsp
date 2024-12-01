<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=directions_car,notifications" />
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
<c:set var="customUser" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />

<div id="kt_app_sidebar" class="app-sidebar flex-column" data-kt-drawer="true" data-kt-drawer-name="app-sidebar" data-kt-drawer-activate="{default: true, lg: false}" data-kt-drawer-overlay="true" data-kt-drawer-width="250px" data-kt-drawer-direction="start" data-kt-drawer-toggle="#kt_app_sidebar_mobile_toggle">
	<!--begin::Logo-->
	<div class="app-sidebar-logo d-none d-lg-flex flex-stack flex-shrink-0 px-13" id="kt_app_sidebar_logo">
		<!--begin::Logo image-->
		<a href="/company/main.do">
			<img alt="Logo" src="${pageContext.request.contextPath}/resources/design/media/logos/GrouBear.png" class="theme-light-show h-85px" />
			<img alt="Logo" src="${pageContext.request.contextPath}/resources/design/media/logos/GrouBear.png" class="theme-dark-show h-25px" />
		</a>
		<!--end::Logo image-->
		
	</div>
	<!--end::Logo-->
	<div class="separator d-none d-lg-block"></div>
	<!--begin::Toolbar-->
	<!--end::Toolbar-->
	<div class="separator"></div>
	<!--begin::Sidebar menu-->
	<div class="app-sidebar-menu hover-scroll-y my-5 my-lg-5 mx-3" id="kt_app_sidebar_menu_wrapper" data-kt-scroll="true" data-kt-scroll-height="auto" data-kt-scroll-dependencies="#kt_app_sidebar_toolbar, #kt_app_sidebar_footer" data-kt-scroll-offset="0">
		<!--begin::Menu-->
		<div class="menu menu-column menu-sub-indention menu-active-bg fw-semibold" id="#kt_sidebar_menu" data-kt-menu="true">
			
			<!-- 기업 관리자 사이드바 -->
			<!--begin:Menu item-->
			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-people">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
						</i>
					</span>
					<span class="menu-title">인사·정보 관리</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="/information/allinfo.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">전체사원목록</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="/information/alldept.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">부서목록</span>
						</a>
						<!--end:Menu link-->
					</div>
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="/information/alljbgd.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">직급목록</span>
						</a>
						<!--end:Menu link-->
					</div>
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->
			

            <!--begin:Menu item-->
            <div data-kt-menu-trigger="click" class="menu-item menu-accordion ${workMenu }">
                <!--begin:Menu link-->
                <span class="menu-link">
                    <span class="menu-icon">
                        <i class="bi bi-clock-history">
                            <span class="path1"></span>
                            <span class="path2"></span>
                            <span class="path3"></span>
                            <span class="path4"></span>
                            <span class="path5"></span>
                            <span class="path6"></span>
                        </i>
                    </span>
                    <span class="menu-title">근태 관리</span>
                    <span class="menu-arrow"></span>
                </span>
                <!--end:Menu link-->
                <!--begin:Menu sub-->
                <div class="menu-sub menu-sub-accordion menu-active-bg ">
                    <!--begin:Menu item-->
                    <div class="menu-item">
                        <!--begin:Menu link-->
                        <a class="menu-link ${workSetting }" href="/company/worksetting.do">
                            <span class="menu-bullet">
                                <span class="bullet bullet-dot"></span>
                            </span>
                            <span class="menu-title">근무 관리</span>
                        </a>
                        <!--end:Menu link-->
                    </div>
                    <!--end:Menu item-->
                    <!--begin:Menu item-->
                    <div class="menu-item">
                        <!--begin:Menu link-->
                        <a class="menu-link ${todayWorkStatus }" href="/company/todayworkstatus.do">
                            <span class="menu-bullet">
                                <span class="bullet bullet-dot"></span>
                            </span>
                            <span class="menu-title">금일 근무 현황</span>
                        </a>
                        <!--end:Menu link-->
                    </div>
                    <!--end:Menu item-->
                    <!--begin:Menu item-->
                    <div class="menu-item">
                        <!--begin:Menu link-->
                        <a class="menu-link ${workStatus }" href="/company/workstatus.do">
                            <span class="menu-bullet">
                                <span class="bullet bullet-dot"></span>
                            </span>
                            <span class="menu-title">근무 현황</span>
                        </a>
                        <!--end:Menu link-->
                    </div>
                    <!--end:Menu item-->
                    <!--begin:Menu item-->
                    <div class="menu-item">
                        <!--begin:Menu link-->
                        <a class="menu-link ${vacationStatus }" href="/company/vacation/status.do">
                            <span class="menu-bullet">
                                <span class="bullet bullet-dot"></span>
                            </span>
                            <span class="menu-title">휴가 관리</span>
                        </a>
                        <!--end:Menu link-->
                    </div>
                    <!--end:Menu item-->
                    
                </div>
                <!--end:Menu sub-->
            </div>
            <!--end:Menu item-->



			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion ${formMenu}">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-chat-left-text">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
						</i>
					</span>
					<span class="menu-title">양식 관리</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link ${formInternal}" href="/company/formList.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">양식 관리</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->

			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion ${provedocMenu}">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-folder">
							<span class="path1"></span>
							<span class="path2"></span>
						</i>
					</span>
					<span class="menu-title">증명서 관리</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link ${provedocAply}" href="/company/provedocAplyList.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">증명서 요청관리</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link ${provedocIspr}" href="/company/provedocIsprList.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">증명서 발급</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->

			 
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion hiddenMenu" id="menu_008">
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-person-video3">
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
					<span class="menu-title">조직도</span>
					<span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/company/comorganizationchart.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">조직도</span>
						</a>
					</div>
				</div>
			</div>
			
			
            <!--begin:Menu item-->
            <div data-kt-menu-trigger="click" class="menu-item menu-accordion ${elaprMenu}">
                <!--begin:Menu link-->
                <span class="menu-link">
                    <span class="menu-icon">
                        <i class="bi bi-newspaper"></i>
                    </span>
                    <span class="menu-title">전자결재</span>
                    <span class="menu-arrow"></span>
                </span>
                <!--end:Menu link-->
                <!--begin:Menu sub-->
                <div class="menu-sub menu-sub-accordion">
                    <!--begin:Menu item-->
                    <div class="menu-item">
                        <!--begin:Menu link-->
                        <a class="menu-link" href="/company/elaprMain.do">
                            <span class="menu-bullet">
                                <span class="bullet bullet-dot"></span>
                            </span>
                            <span class="menu-title">전자결재</span>
                        </a>
                        <!--end:Menu link-->
                    </div>
                    <!--end:Menu item-->
                    <!--begin:Menu item-->
                    <div class="menu-item">
                        <!--begin:Menu link-->
                        <a class="menu-link" href="/company/comElaprWating.do">
                            <span class="menu-bullet">
                                <span class="bullet bullet-dot"></span>
                            </span>
                            <span class="menu-title">결재 대기 문서</span>
                        </a>
                        <!--end:Menu link-->
                    </div>
                    <!--end:Menu item-->
                    <!--begin:Menu item-->
                    <div data-kt-menu-trigger="click" class="menu-item menu-accordion ${elaprMyMenu}">
                        <!--begin:Menu link-->
                        <span class="menu-link">
                            <span class="menu-bullet">
                                <span class="bullet bullet-dot"></span>
                            </span>
                            <span class="menu-title">개인 문서함</span>
                            <span class="menu-arrow"></span>
                        </span>
                        <!--end:Menu link-->
                        <!--begin:Menu sub-->
                        <div class="menu-sub menu-sub-accordion">
                            <!--begin:Menu item-->
                            <div class="menu-item">
                                <!--begin:Menu link-->
                                <a class="menu-link ${comElaprRernc }" href="/company/comElaprRernc.do">
                                    <span class="menu-bullet">
                                        <span class="bullet bullet-dot"></span>
                                    </span>
                                    <span class="menu-title">참조/열람 문서함</span>
                                </a>
                                <!--end:Menu link-->
                            </div>
                            <!--end:Menu item-->
                            <!--begin:Menu item-->
                            <div class="menu-item">
                                <!--begin:Menu link-->
                                <a class="menu-link ${comElaprAll }" href="/company/comElaprAll.do">
                                    <span class="menu-bullet">
                                        <span class="bullet bullet-dot"></span>
                                    </span>
                                    <span class="menu-title">결재 전체 문서함</span>
                                </a>
                                <!--end:Menu link-->
                            </div>
                            <!--end:Menu item-->
                        </div>
                        <!--end:Menu sub-->
                    </div>
                    <!--end:Menu item-->
                </div>
                <!--end:Menu sub-->
            </div>
            <!--end:Menu item-->
			

			

         
			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
                <!--begin:Menu link-->
                <span class="menu-link">
                   <span class="menu-icon">
                      <i class="bi bi-check2-circle">
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
                   <span class="menu-title">프로젝트</span>
                   <span class="menu-arrow"></span>
                </span>
                <!--end:Menu link-->
                <!--begin:Menu sub-->
                <div class="menu-sub menu-sub-accordion">
                   <!--begin:Menu item-->
                   <div class="menu-item">
                      <!--begin:Menu link-->
                      <a class="menu-link" href="/company/project.do">
                         <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                         </span>
                         <span class="menu-title">프로젝트</span>
                      </a>
                      <!--end:Menu link-->
                   </div>
                   <!--end:Menu item-->
                </div>
                <!--end:Menu sub-->
             </div>
             <!--end:Menu item-->

             
			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-calendar-date">
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
					<span class="menu-title">일정관리</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="/company/calendar.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">일정 관리</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
				
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->

            
			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion ${cloudMenu}">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-cloud-download">
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
					<span class="menu-title">클라우드</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link ${cloudInternal}" href="/company/cloudList.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">클라우드</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->
            
            
         
			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-chat-left-text">
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
					<span class="menu-title">커뮤니티</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="/company/communityCompany.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">커뮤니티</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->

            
			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-car-front">
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
					<span class="menu-title">차량 관리</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="/comvehicle/vehicledashboard.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">차량 목록</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="/comvehicle/reservationhistory.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">차량 예약 내역</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->
			
			
			
			
			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion ${facilitesMenu }">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-chat-left-text">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
						</i>
					</span>
					<span class="menu-title">시설 예약</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link ${facilitesAdd }" href="/company/facilities/add.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">시설 등록</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
				</div>
				<!--end:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link ${facilitesReserveStatus }" href="/company/facilities/reserve/status.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">예약 현황</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->
			
			
			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
				<!--begin:Menu link-->
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
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="/company/messenger.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">메신저</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->
			
						
			<!--begin:Menu item-->
			<!-- <div data-kt-menu-trigger="click" class="menu-item menu-accordion">
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
						<a class="menu-link" href="/company/mailList.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">메일</span>
						</a>
					</div>
				</div>
			</div> -->
			
			
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion ${eventMenu}">
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-joystick">
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
					<span class="menu-title">이벤트</span>
					<span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
<!-- 					<div class="menu-item"> -->
<!-- 						<a class="menu-link" href="/company/event.do"> -->
<!-- 							<span class="menu-bullet"> -->
<!-- 								<span class="bullet bullet-dot"></span> -->
<!-- 							</span> -->
<!-- 							<span class="menu-title">설문/투표</span> -->
<!-- 						</a> -->
<!-- 					</div> -->
					<div class="menu-item">
						<a class="menu-link ${rcmdtnInternal}" href="/company/menuRecommend.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">날씨·메뉴추천</span>
						</a>
					</div>
				</div>
			</div>
						

			<div class="separator d-none d-lg-block"></div>

            
			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-lock">
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
					<span class="menu-title">보안</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="/company/companylog.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">보안 로그</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->
			
			
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion ${cmntyMenu}">
				<span class="menu-link">
					<span class="menu-icon">
						<i class="ki-duotone ki-setting-2">
						 <span class="path1"></span>
						 <span class="path2"></span>
						</i>
					</span>
					<span class="menu-title">시스템 공지</span>
					<span class="menu-arrow"></span>
				</span>
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link ${cmntyNotice}" href="/company/cmntyNoticeList.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">공지사항</span>
						</a>
					</div>
					<div class="menu-item">
						<a class="menu-link ${cmntyQstn}" href="/company/cmntyQstnList.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">Q&A</span>
						</a>
					</div>
				</div>
			</div>
			
			<!--end:Menu item-->
			<!-- 기업 관리자 사이드바 END -->

		</div>
		<!--end::Menu-->
	</div>
	<!--end::Sidebar menu-->
	<!-- 맨 아래 유저 정보 -->
	<!--begin::User-->
	<div class="app-sidebar-user d-flex flex-stack py-5 px-8">
		<!--begin::User avatar-->
		<div class="d-flex me-5">
			<!--begin::Menu wrapper-->
			<div class="me-5">
				<!--begin::Symbol-->
				<div class="symbol symbol-40px cursor-pointer" data-kt-menu-trigger="{default: 'click', lg: 'hover'}" data-kt-menu-placement="bottom-start" data-kt-menu-overflow="true">
					<img src="/upload/${customUser.member.imgFileUrl }" alt="" />
				</div>
				<!--end::Symbol-->
				<!--begin::User account menu-->
				<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg menu-state-color fw-semibold py-4 fs-6 w-275px" data-kt-menu="true">
					<!--begin::Menu item-->
					<div class="menu-item px-3">
						<div class="menu-content d-flex align-items-center px-3">
							<!--begin::Avatar-->
							<div class="symbol symbol-50px me-5">
								<img src="/upload/${customUser.member.imgFileUrl }" alt="" />
							</div>
							<!--end::Avatar-->
							<!--begin::Username-->
							<div class="d-flex flex-column">
								<div class="fw-bold d-flex align-items-center fs-5">${customUser.member.empNm }
								<span class="badge badge-light-success fw-bold fs-8 px-2 py-1 ms-2">${customUser.member.empId }</span></div>
								<a href="#" class="fw-semibold text-muted text-hover-primary fs-7">${customUser.member.empEmlAddr }</a>
							</div>
							<!--end::Username-->
						</div>
					</div>
					<!--end::Menu item-->
					<!--begin::Menu separator-->
					<div class="separator my-2"></div>
					<!--end::Menu separator-->
					<!--begin::Menu item-->
					<div class="menu-item px-5">
						<a href="/company/project.do" class="menu-link px-5">
							<span class="menu-text">기업 내 프로젝트</span>
							<span class="menu-badge">
								<span class="badge badge-light-danger badge-circle fw-bold fs-7">3</span>
							</span>
						</a>
					</div>
					<div class="menu-item px-5">
						<a href="account/overview.html" class="menu-link px-5">그룹웨어 계약 내역</a>
					</div>
					<div class="menu-item px-5">
						<a href="/company/Info.do" class="menu-link px-5">기업 정보</a>
					</div>
					<div class="separator my-2"></div>
					<div class="menu-item px-5 my-1">
						<a href="account/settings.html" class="menu-link px-5">환경설정</a>
					</div>
				</div>
			</div>
			<div class="me-2">
				<!--begin::Username-->
				<a href="#" class="app-sidebar-username text-gray-800 text-hover-primary fs-6 fw-semibold lh-0">${customUser.member.empNm }</a>
				<!--end::Username-->
				<!--begin::Description-->
				<span class="app-sidebar-deckription text-gray-500 fw-semibold d-block fs-8">
				${customUser.member.coNm }
				</span>
				<!--end::Description-->
			</div>
			<!--end::Info-->
		</div>
		<!--end::User avatar-->
		<!--begin::Action-->
		<a href="/logout" class="btn btn-icon btn-active-color-primary btn-icon-custom-color me-n4" data-bs-toggle="tooltip" title="로그아웃">
			<i class="ki-duotone ki-entrance-left fs-2 text-gray-500">
				<span class="path1"></span>
				<span class="path2"></span>
			</i>
		</a>
		<!--end::Action-->
	</div>
	<!--end::User-->
</div>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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

<div id="kt_app_sidebar" class="app-sidebar flex-column" data-kt-drawer="true" data-kt-drawer-name="app-sidebar" data-kt-drawer-activate="{default: true, lg: false}" data-kt-drawer-overlay="true" data-kt-drawer-width="250px" data-kt-drawer-direction="start" data-kt-drawer-toggle="#kt_app_sidebar_mobile_toggle">
	<!--begin::Logo-->
	<div class="app-sidebar-logo d-none d-lg-flex flex-stack flex-shrink-0 px-13" id="kt_app_sidebar_logo">
		<!--begin::Logo image-->
		<a href="/groubear/main.do">
			<img alt="Logo" src="${pageContext.request.contextPath}/resources/design/media/logos/GrouBear.png" class="theme-light-show h-85px" />
			<img alt="Logo" src="${pageContext.request.contextPath}/resources/design/media/logos/GrouBear.png" class="theme-dark-show h-25px" />
		</a>
		<!--end::Logo image-->
	</div>
	<!--end::Logo-->
	<div class="separator d-none d-lg-block"></div>
	<div class="separator"></div>
	<!--begin::Sidebar menu-->
	<div class="app-sidebar-menu hover-scroll-y my-5 my-lg-5 mx-3" id="kt_app_sidebar_menu_wrapper" data-kt-scroll="true" data-kt-scroll-height="auto" data-kt-scroll-dependencies="#kt_app_sidebar_toolbar, #kt_app_sidebar_footer" data-kt-scroll-offset="0">
		<!--begin::Menu-->
		<div class="menu menu-column menu-sub-indention menu-active-bg fw-semibold" id="#kt_sidebar_menu" data-kt-menu="true">
			<!-- 그룹웨어 관리자 사이드바 -->
			
			
			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="ki-duotone ki-badge fs-2">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
							<span class="path4"></span>
							<span class="path5"></span>
						</i>
					</span>
					<span class="menu-title">기업과의 계약</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="/groubear/contract.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">계약리스트</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->
			
			
			<!--begin:Menu item-->
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion ${cmntyMenu}">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-chat-left-text">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
						</i>
					</span>
					<span class="menu-title">커뮤니티 관리</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link ${cmntyNotice}" href="/groubear/cmntyNoticeList.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">공지사항</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link--> 
						<a class="menu-link ${cmntyQstn}" href="/groubear/cmntyQstnList.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">Q&A</span>
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
						<a class="menu-link ${formInternal}" href="/groubear/formList.do">
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
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion ${statusMenu}">
				<!--begin:Menu link-->
				<span class="menu-link">
					<span class="menu-icon">
						<i class="bi bi-bar-chart">
							<span class="path1"></span>
							<span class="path2"></span>
						</i>
					</span>
					<span class="menu-title">통계</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion">
					<!--begin:Menu item-->
<!-- 					<div class="menu-item"> -->
<!-- 						begin:Menu link -->
<!-- 						<a class="menu-link" href="/groubear/salesmanagementYear.do"> -->
<!-- 							<span class="menu-bullet"> -->
<!-- 								<span class="bullet bullet-dot"></span> -->
<!-- 							</span> -->
<!-- 							<span class="menu-title">매출관리</span> -->
<!-- 						</a> -->
<!-- 						end:Menu link -->
<!-- 					</div> -->
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link ${statusSalesAndUser}" href="/groubear/usermanagementYear.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">매출/유저관리</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link ${companyStatus}" href="/groubear/companydetailnumofmem.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">기업통계</span>
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
						<i class="bi bi-geo-alt">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
							<span class="path4"></span>
							<span class="path5"></span>
							<span class="path6"></span>
						</i>
					</span>
					<span class="menu-title">기업현황</span>
					<span class="menu-arrow"></span>
				</span>
				<!--end:Menu link-->
				<!--begin:Menu sub-->
				<div class="menu-sub menu-sub-accordion menu-active-bg">
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="/groubear/map.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">지도</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					
				</div>
				<!--end:Menu sub-->
			</div>
			<!--end:Menu item-->
			
			<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
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
				<div class="menu-sub menu-sub-accordion">
					<div class="menu-item">
						<a class="menu-link" href="/groubear/log.do">
							<span class="menu-bullet">
								<span class="bullet bullet-dot"></span>
							</span>
							<span class="menu-title">로그</span>
						</a>
					</div>
				</div>
			</div>
			
			<div class="menu-item">
				<a class="menu-link" href="/groubear/videochatting.do">
					<span class="menu-icon"> 
						<i class="bi bi-webcam">
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
					<span class="menu-title">화상채팅 현황</span>
				</a>
			</div>
			
			<div class="menu-item">
				<a class="menu-link" href="#">
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
					<span class="menu-title">근태관리 편집</span>
				</a>
			</div>
			
			<div class="menu-item">
				<a class="menu-link" href="#">
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
					<span class="menu-title">조직도 편집</span>
				</a>
			</div>
			
			<div class="menu-item">
				<a class="menu-link" href="#">
					<span class="menu-icon"> 
						<i class="bi bi-newspaper"></i>
					</span>
					<span class="menu-title">전자결재 편집</span>
				</a>
			</div>
			
			<div class="menu-item">
				<a class="menu-link" href="#">
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
					<span class="menu-title">프로젝트 현황</span>
				</a>
			</div>
			
			<div class="menu-item">
				<a class="menu-link" href="#">
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
					<span class="menu-title">클라우드 현황</span>
				</a>
			</div>
			
			<div class="menu-item">
				<a class="menu-link" href="#">
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
					<span class="menu-title">차량예약 편집</span>
				</a>
			</div>
			
			<div class="menu-item">
				<a class="menu-link" href="#">
					<span class="menu-icon"> 
						<i class="bi bi-shop">
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
					<span class="menu-title">시설예약 편집</span>
				</a>
			</div>
			
			<div class="menu-item">
				<a class="menu-link" href="#">
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
					<span class="menu-title">이벤트 관리</span>
				</a>
			</div>
			
			<!-- 그룹웨어 관리자 사이드바 END -->
	
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
				 
				<!--end::Symbol-->
				<!--begin::User account menu-->
				<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg menu-state-color fw-semibold py-4 fs-6 w-275px" data-kt-menu="true">
					
				</div>
				<!--end::User account menu-->
			</div>
			<!--end::Menu wrapper-->
			<!--begin::Info-->
			<div class="me-2">
				<!--begin::Username-->
				<!--end::Username-->
				<!--begin::Description-->
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>GrouBear</title>
		<meta charset="utf-8" />
		<meta name="description" content="Good admin dashboard live demo. Check out all the features of the admin panel. A large number of settings, additional services and widgets." />
		<meta name="keywords" content="Good, bootstrap, bootstrap 5, admin themes, Asp.Net Core & Django starter kits, admin themes, bootstrap admin, bootstrap dashboard, bootstrap dark mode" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta property="og:locale" content="en_US" />
		<meta property="og:type" content="article" />
		<meta property="og:title" content="GrouBear" />
		<meta property="og:url" content="https://themes.getbootstrap.com/product/good-bootstrap-5-admin-dashboard-template" />
		<meta property="og:site_name" content="Good by Keenthemes" />
		<link rel="canonical" href="http://preview.keenthemes.comlanding.html" />
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/design/media/logos/favicon.ico" />
		<!--begin::Fonts(mandatory for all pages)-->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
		<!--end::Fonts-->
		<!--begin::Global Stylesheets Bundle(mandatory for all pages)-->
		<link href="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/resources/design/css/style.bundle.css" rel="stylesheet" type="text/css" />
		<!--end::Global Stylesheets Bundle-->
		<script>// Frame-busting to prevent site from being loaded within a frame without permission (click-jacking) if (window.top != window.self) { window.top.location.replace(window.self.location.href); }</script>
	</head>
	<!--end::Head-->
	<!--begin::Body-->
	<body id="kt_app_body" data-bs-spy="scroll" data-bs-target="#kt_landing_menu" data-bs-offset="200" data-kt-app-layout="light-sidebar" class="body-bg position-relative app-blank">
		<!--begin::Theme mode setup on page load-->
		<script>var defaultThemeMode = "light"; var themeMode; if ( document.documentElement ) { if ( document.documentElement.hasAttribute("data-bs-theme-mode")) { themeMode = document.documentElement.getAttribute("data-bs-theme-mode"); } else { if ( localStorage.getItem("data-bs-theme") !== null ) { themeMode = localStorage.getItem("data-bs-theme"); } else { themeMode = defaultThemeMode; } } if (themeMode === "system") { themeMode = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light"; } document.documentElement.setAttribute("data-bs-theme", themeMode); }</script>
		<!--end::Theme mode setup on page load-->
		<!--begin::Root-->
		<div class="d-flex flex-column flex-root" id="kt_app_root">
			<!--begin::Header Section-->
			<div class="m-0">
				<!--begin::Header-->
				<div class="landing-header mb-13" data-kt-sticky="true" data-kt-sticky-name="landing-header" data-kt-sticky-offset="{default: '200px', lg: '300px'}">
					<!--begin::Container-->
					<div class="container-xxl">
						<!--begin::Wrapper-->
						<div class="d-flex align-items-center">
							<!--begin::Logo-->
							<div class="d-flex align-items-center me-8">
								<!--begin::Mobile menu toggle-->
								<button class="btn btn-icon btn-active-color-primary me-3 d-flex d-lg-none ms-n2" id="kt_landing_menu_toggle">
									<i class="ki-duotone ki-abstract-14 fs-1">
										<span class="path1"></span>
										<span class="path2"></span>
									</i>
								</button>
								<!--end::Mobile menu toggle-->
								<!--begin::Logo image-->
								<a href="landing.html">
								</a>
								<!--end::Logo image-->
							</div>
							<!--end::Logo-->
							<!--begin::Menu wrapper-->
							<div class="d-lg-block" id="kt_header_nav_wrapper">
								<div class="d-lg-block p-5 p-lg-0" data-kt-drawer="true" data-kt-drawer-name="landing-menu" data-kt-drawer-activate="{default: true, lg: false}" data-kt-drawer-overlay="true" data-kt-drawer-width="200px" data-kt-drawer-direction="start" data-kt-drawer-toggle="#kt_landing_menu_toggle" data-kt-swapper="true" data-kt-swapper-mode="prepend" data-kt-swapper-parent="{default: '#kt_body', lg: '#kt_header_nav_wrapper'}">
								</div>
							</div>
							<!--end::Menu wrapper-->
							<!--begin::Toolbar-->
							<div class="flex-equal text-end ms-1 position-relative z-index-2">
								<a href="/signup.do" class="btn btn-danger">회원 가입</a>
								&nbsp;
								<a href="/login.do" class="btn btn-primary">로그인</a>
							</div>
							<!--end::Toolbar-->
						</div>
						<!--end::Wrapper-->
					</div>
					<!--end::Container-->
				</div>
				<!--end::Header-->
				<!--begin::Landing hero-->
				<div class="mb-lg-20">
					<!--begin::Container-->
	                    <img src="${pageContext.request.contextPath }/resources/file/image/main1.png" style="width: 100%;">
					<!--begin::Image-->
					<div class="position-absolute top-0 end-0 overflow-hidden w-150px h-450px h-lg-auto w-lg-auto">
						<img src="assets/media/svg/layout/1.svg" class="" alt="" />
					</div>
					<!--end::Image-->
				</div>
				<!--end::Landing hero-->
			</div>
		</div>
		<!--end::Root-->
		<!--begin::Scrolltop-->
		<div id="kt_scrolltop" class="scrolltop" data-kt-scrolltop="true">
			<i class="ki-duotone ki-arrow-up">
				<span class="path1"></span>
				<span class="path2"></span>
			</i>
		</div>
		<!--end::Scrolltop-->
		<!--begin::Javascript-->
		<script>var hostUrl = "assets/";</script>
		<!--begin::Global Javascript Bundle(mandatory for all pages)-->
		<script src="assets/plugins/global/plugins.bundle.js"></script>
		<script src="assets/js/scripts.bundle.js"></script>
		<!--end::Global Javascript Bundle-->
		<!--begin::Vendors Javascript(used for this page only)-->
		<script src="assets/plugins/custom/fslightbox/fslightbox.bundle.js"></script>
		<!--end::Vendors Javascript-->
		<!--begin::Custom Javascript(used for this page only)-->
		<script src="assets/js/custom/pages/pricing/general.js"></script>
		<script src="assets/js/widgets.bundle.js"></script>
		<script src="assets/js/custom/widgets.js"></script>
		<script src="assets/js/custom/apps/chat/chat.js"></script>
		<!--end::Custom Javascript-->
		<!--end::Javascript-->
	</body>
	<!--end::Body-->
</html>
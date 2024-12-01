<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
	<!--begin::Head-->
	<head>
		<title>Good – Bootstrap 5 HTML Asp.Net Core, Blazor, Django & Flask Admin Dashboard Template by KeenThemes</title>
		<meta charset="utf-8" />
		<meta name="description" content="Good admin dashboard live demo. Check out all the features of the admin panel. A large number of settings, additional services and widgets." />
		<meta name="keywords" content="Good, bootstrap, bootstrap 5, admin themes, Asp.Net Core & Django starter kits, admin themes, bootstrap admin, bootstrap dashboard, bootstrap dark mode" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta property="og:locale" content="en_US" />
		<meta property="og:type" content="article" />
		<meta property="og:title" content="Good – Bootstrap 5 HTML Asp.Net Core, Blazor, Django & Flask Admin Dashboard Template by KeenThemes" />
		<meta property="og:url" content="https://themes.getbootstrap.com/product/good-bootstrap-5-admin-dashboard-template" />
		<meta property="og:site_name" content="Good by Keenthemes" />
		<link rel="canonical" href="http://preview.keenthemes.comindex.html" />
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/design/media/logos/favicon.ico" />
		<!--begin::Fonts(mandatory for all pages)-->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
		<!--end::Fonts-->
		<!--begin::Vendor Stylesheets(used for this page only)-->
		<link href="${pageContext.request.contextPath}/resources/design/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/resources/design/plugins/custom/vis-timeline/vis-timeline.bundle.css" rel="stylesheet" type="text/css" />
		<!--end::Vendor Stylesheets-->
		<!--begin::Global Stylesheets Bundle(mandatory for all pages)-->
		<link href="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/resources/design/css/style.bundle.css" rel="stylesheet" type="text/css" />
		<!--end::Global Stylesheets Bundle-->
		<script>// Frame-busting to prevent site from being loaded within a frame without permission (click-jacking) if (window.top != window.self) { window.top.location.replace(window.self.location.href); }</script>
        <!--begin::Javascript-->
		<!--begin::Global Javascript Bundle(mandatory for all pages)-->
		<script src="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/scripts.bundle.js"></script>
		<!--end::Global Javascript Bundle-->
		<!--begin::Vendors Javascript(used for this page only)-->
		<script src="${pageContext.request.contextPath}/resources/design/plugins/custom/datatables/datatables.bundle.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/plugins/custom/vis-timeline/vis-timeline.bundle.js"></script>
		<!--end::Vendors Javascript-->
		<!--begin::Custom Javascript(used for this page only)-->
		<script src="${pageContext.request.contextPath}/resources/design/js/widgets.bundle.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/widgets.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/apps/chat/chat.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/utilities/modals/upgrade-plan.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/utilities/modals/create-project/type.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/utilities/modals/create-project/budget.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/utilities/modals/create-project/settings.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/utilities/modals/create-project/team.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/utilities/modals/create-project/targets.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/utilities/modals/create-project/files.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/utilities/modals/create-project/complete.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/utilities/modals/create-project/main.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/utilities/modals/create-campaign.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/custom/utilities/modals/users-search.js"></script>
		
		<!-- 캘린더 -->
		<link href="${pageContext.request.contextPath}/resources/design/plugins/custom/fullcalendar/fullcalendar.bundle.css" rel="stylesheet" type="text/css" />
		<script src="${pageContext.request.contextPath}/resources/design/plugins/custom/fullcalendar/fullcalendar.bundle.js"></script>
		<!--end::Custom Javascript-->
		<!--end::Javascript-->
	</head>


	<!--end::Head-->
	<!--begin::Body-->
	<body id="kt_app_body" data-kt-app-layout="light-sidebar" data-kt-app-sidebar-enabled="true" data-kt-app-sidebar-fixed="true" data-kt-app-sidebar-push-header="true" data-kt-app-sidebar-push-toolbar="true" data-kt-app-sidebar-push-footer="true" class="app-default">
		<!--begin::Theme mode setup on page load-->
		<script>var defaultThemeMode = "light"; var themeMode; if ( document.documentElement ) { if ( document.documentElement.hasAttribute("data-bs-theme-mode")) { themeMode = document.documentElement.getAttribute("data-bs-theme-mode"); } else { if ( localStorage.getItem("data-bs-theme") !== null ) { themeMode = localStorage.getItem("data-bs-theme"); } else { themeMode = defaultThemeMode; } } if (themeMode === "system") { themeMode = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light"; } document.documentElement.setAttribute("data-bs-theme", themeMode); }</script>
		<!--end::Theme mode setup on page load-->
		<!--begin::App-->
		<div class="d-flex flex-column flex-root app-root" id="kt_app_root">
			<!--begin::Page-->
			<div class="app-page flex-column flex-column-fluid" id="kt_app_page">
				
			<!-- 헤더 추가 -->
			<tiles:insertAttribute name="header"/>	
		
			
			<div class="app-wrapper flex-column flex-row-fluid" id="kt_app_wrapper">
						
			<!-- 사이드바 추가 -->
			<tiles:insertAttribute name="sidebar"/>
			
			<!-- 메인 화면 추가 -->
			
			<tiles:insertAttribute name="content"/>
						
			</div>
			<!--end::Wrapper-->
		</div>
		<!--end::Page-->
	</div>
<!--end::App-->
				
				
				
</body>
</html>
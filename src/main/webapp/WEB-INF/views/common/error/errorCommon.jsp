<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
<base href="../../" />
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
		<link rel="canonical" href="http://preview.keenthemes.comindex.html" />
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/design/media/logos/favicon.ico" />
		<!--end::Fonts-->
		<!--begin::Global Stylesheets Bundle(mandatory for all pages)-->
		<link href="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/resources/design/css/style.bundle.css" rel="stylesheet" type="text/css" />
		<!--end::Global Stylesheets Bundle-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>	
		<script>// Frame-busting to prevent site from being loaded within a frame without permission (click-jacking) if (window.top != window.self) { window.top.location.replace(window.self.location.href); }</script>
	</head>
	<!--end::Head-->
	<!--begin::Body-->
	<body id="kt_body" class="app-blank">
		<!--begin::Theme mode setup on page load-->
		<script>var defaultThemeMode = "light"; var themeMode; if ( document.documentElement ) { if ( document.documentElement.hasAttribute("data-bs-theme-mode")) { themeMode = document.documentElement.getAttribute("data-bs-theme-mode"); } else { if ( localStorage.getItem("data-bs-theme") !== null ) { themeMode = localStorage.getItem("data-bs-theme"); } else { themeMode = defaultThemeMode; } } if (themeMode === "system") { themeMode = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light"; } document.documentElement.setAttribute("data-bs-theme", themeMode); }</script>
		<div class="d-flex flex-column flex-root" id="kt_app_root">
			<!--begin::Authentication - Signup Welcome Message -->
			<div class="d-flex flex-column flex-column-fluid">
				<!--begin::Content-->
				<div class="d-flex flex-row-fluid flex-column flex-column-fluid text-center p-10 py-lg-20">
					<!--begin::Logo-->
					<a class="pt-lg-20 mb-12">
									<img alt="Logo" src="${pageContext.request.contextPath}/resources/design/media/logos/GrouBear.png" class="h-200px" />
					</a>
					<!--end::Logo-->
					<!--begin::Logo-->
					<h1 class="fw-bold fs-2qx text-gray-800 mb-7">비정상적 접근입니다.</h1>
					<!--end::Logo-->
					<!--begin::Message-->
					<div class="fw-semibold fs-3 text-muted mb-15">존재하지 않는 주소를 입력하셨거나, 
					<br />요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.</div>
					<!--end::Message-->
					<!--begin::Action-->
					<div class="text-center">
						<button id="backBtn" class="btn btn-lg btn-primary fw-bold">뒤로가기</button>
					</div>
					<!--end::Action-->
				</div>
				<!--end::Content-->
			</div>
			<!--end::Authentication - Signup Welcome Message-->
		</div>
		<!--end::Root-->
		<!--begin::Javascript-->
		<script>var hostUrl = "assets/";</script>
		<script type="text/javascript">
		$("#backBtn").on("click",function(){
			window.history.back();
		});
		
		</script>
		<!--begin::Global Javascript Bundle(mandatory for all pages)-->
		<script src="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.js"></script>
		<script src="${pageContext.request.contextPath}/resources/design/js/scripts.bundle.js"></script>
		<!--end::Global Javascript Bundle-->
		<!--end::Javascript-->
	</body>
	<!--end::Body-->
</html>
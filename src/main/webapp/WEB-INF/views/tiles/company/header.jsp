<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#wheel-x::-webkit-scrollbar-track {
	border-radius: 10px;
	display: none;
	!
	important
}

#wheel-x::-webkit-scrollbar-thumb {
	border-radius: 10px;
	width: 10px;
	background-color: #1D909F;
	!
	important
}

#wheel-x::-webkit-scrollbar-button {
	display: none;
	!
	important
}
</style>
<div id="kt_app_header" class="app-header">
	<!--begin::Header container-->
	<div
		class="app-container container-fluid d-flex align-items-stretch justify-content-between"
		id="kt_app_header_container">
		<!--begin::Mobile menu toggle-->
		<div class="d-flex align-items-center d-lg-none ms-n2 me-2"
			title="Show sidebar menu">
			<div class="btn btn-icon btn-active-color-primary w-35px h-35px"
				id="kt_app_sidebar_mobile_toggle">
				<i class="ki-duotone ki-abstract-14 fs-1"> <span class="path1"></span>
					<span class="path2"></span>
				</i>
			</div>
		</div>
		<!--end::Mobile menu toggle-->
		<!--begin::Mobile logo-->
		<div class="d-flex align-items-center flex-grow-1 flex-lg-grow-0">
			<a href="index.html" class="d-lg-none"> <img alt="Logo"
				src="${pageContext.request.contextPath}/resources/design/media/logos/default.svg"
				class="h-25px" />
			</a>
		</div>
		<!--end::Mobile logo-->
		<!--begin::Header wrapper-->
		<div
			class="d-flex align-items-stretch justify-content-between flex-lg-grow-1"
			id="kt_app_header_wrapper">
			<!--begin::Page title-->
			<div data-kt-swapper="true"
				data-kt-swapper-mode="{default: 'prepend', lg: 'prepend'}"
				data-kt-swapper-parent="{default: '#kt_app_content_container', lg: '#kt_app_header_wrapper'}"
				class="page-title d-flex flex-column justify-content-center flex-wrap me-3 mb-5 mb-lg-0">

			</div>
			<!--end::Page title-->
			<!--begin::Navbar-->
			<div class="app-navbar align-items-center flex-shrink-0">
				<!--begin::Search-->
				<div class="app-navbar-item ms-2 ms-lg-4">
					<!--begin::Search-->
					<div id="kt_header_search"
						class="header-search d-flex align-items-center w-lg-250px"
						data-kt-search-keypress="true" data-kt-search-min-length="2"
						data-kt-search-enter="enter" data-kt-search-layout="menu"
						data-kt-search-responsive="lg" data-kt-menu-trigger="auto"
						data-kt-menu-permanent="true" data-kt-menu-placement="bottom-end"
						data-kt-menu-attach="parent">
						<!--begin::Tablet and mobile search toggle-->
						<div data-kt-search-element="toggle"
							class="search-toggle-mobile d-flex d-lg-none align-items-center">
							<div
								class="d-flex btn btn-custom btn-outline btn-icon btn-icon-gray-700 btn-active-icon-primary">
								<i class="ki-duotone ki-magnifier fs-1"> <span class="path1"></span>
									<span class="path2"></span>
								</i>
							</div>
						</div>
						<!--end::Tablet and mobile search toggle-->
						<!--begin::Form(use d-none d-lg-block classes for responsive search)-->
						<form data-kt-search-element="form"
							class="d-none d-lg-block w-100 position-relative mb-5 mb-lg-0"
							autocomplete="off">
							<!--begin::Hidden input(Added to disable form autocomplete)-->
							<input type="hidden" />
							<!--end::Hidden input-->
							<!--begin::Icon-->
							<span
								class="position-absolute top-50 end-0 translate-middle-y lh-0 d-none me-5"
								data-kt-search-element="spinner"> <span
								class="spinner-border h-15px w-15px align-middle text-gray-500"></span>
							</span>
							<!--end::Spinner-->
							<!--begin::Reset-->
							<span
								class="btn btn-flush btn-active-color-primary position-absolute top-50 end-0 translate-middle-y lh-0 d-none me-4"
								data-kt-search-element="clear"> <i
								class="ki-duotone ki-cross fs-2 fs-lg-1 me-0"> <span
									class="path1"></span> <span class="path2"></span>
							</i>
							</span>
							<!--end::Reset-->
						</form>
						<!--end::Form-->
						<!--begin::Menu-->
						<div data-kt-search-element="content"
							class="menu menu-sub menu-sub-dropdown py-7 px-7 overflow-hidden w-300px w-md-350px">
							<!--begin::Wrapper-->
							<div data-kt-search-element="wrapper">
								<!--begin::Recently viewed-->
								<div data-kt-search-element="results" class="d-none">
									<!--begin::Items-->
									<div class="scroll-y mh-200px mh-lg-350px">
										<!--begin::Category title-->
										<h3 class="fs-5 text-muted m-0 pb-5"
											data-kt-search-element="category-title">Users</h3>
										<!--end::Category title-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<img
													src="${pageContext.request.contextPath}/resources/design/media/avatars/300-6.jpg"
													alt="" />
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div
												class="d-flex flex-column justify-content-start fw-semibold">
												<span class="fs-6 fw-semibold">Karina Clark</span> <span
													class="fs-7 fw-semibold text-muted">Marketing
													Manager</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<img
													src="${pageContext.request.contextPath}/resources/design/media/avatars/300-2.jpg"
													alt="" />
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div
												class="d-flex flex-column justify-content-start fw-semibold">
												<span class="fs-6 fw-semibold">Olivia Bold</span> <span
													class="fs-7 fw-semibold text-muted">Software
													Engineer</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<img
													src="${pageContext.request.contextPath}/resources/design/media/avatars/300-9.jpg"
													alt="" />
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div
												class="d-flex flex-column justify-content-start fw-semibold">
												<span class="fs-6 fw-semibold">Ana Clark</span> <span
													class="fs-7 fw-semibold text-muted">UI/UX Designer</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<img
													src="${pageContext.request.contextPath}/resources/design/media/avatars/300-14.jpg"
													alt="" />
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div
												class="d-flex flex-column justify-content-start fw-semibold">
												<span class="fs-6 fw-semibold">Nick Pitola</span> <span
													class="fs-7 fw-semibold text-muted">Art Director</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<img
													src="${pageContext.request.contextPath}/resources/design/media/avatars/300-11.jpg"
													alt="" />
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div
												class="d-flex flex-column justify-content-start fw-semibold">
												<span class="fs-6 fw-semibold">Edward Kulnic</span> <span
													class="fs-7 fw-semibold text-muted">System
													Administrator</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Category title-->
										<h3 class="fs-5 text-muted m-0 pt-5 pb-5"
											data-kt-search-element="category-title">Customers</h3>
										<!--end::Category title-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <img
													class="w-20px h-20px"
													src="${pageContext.request.contextPath}/resources/design/media/svg/brand-logos/volicity-9.svg"
													alt="" />
												</span>
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div
												class="d-flex flex-column justify-content-start fw-semibold">
												<span class="fs-6 fw-semibold">Company Rbranding</span> <span
													class="fs-7 fw-semibold text-muted">UI Design</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <img
													class="w-20px h-20px"
													src="${pageContext.request.contextPath}/resources/design/media/svg/brand-logos/tvit.svg"
													alt="" />
												</span>
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div
												class="d-flex flex-column justify-content-start fw-semibold">
												<span class="fs-6 fw-semibold">Company Re-branding</span> <span
													class="fs-7 fw-semibold text-muted">Web Development</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <img
													class="w-20px h-20px"
													src="${pageContext.request.contextPath}/resources/design/media/svg/misc/infography.svg"
													alt="" />
												</span>
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div
												class="d-flex flex-column justify-content-start fw-semibold">
												<span class="fs-6 fw-semibold">Business Analytics App</span>
												<span class="fs-7 fw-semibold text-muted">Administration</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <img
													class="w-20px h-20px"
													src="${pageContext.request.contextPath}/resources/design/media/svg/brand-logos/leaf.svg"
													alt="" />
												</span>
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div
												class="d-flex flex-column justify-content-start fw-semibold">
												<span class="fs-6 fw-semibold">EcoLeaf App Launch</span> <span
													class="fs-7 fw-semibold text-muted">Marketing</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <img
													class="w-20px h-20px"
													src="${pageContext.request.contextPath}/resources/design/media/svg/brand-logos/tower.svg"
													alt="" />
												</span>
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div
												class="d-flex flex-column justify-content-start fw-semibold">
												<span class="fs-6 fw-semibold">Tower Group Website</span> <span
													class="fs-7 fw-semibold text-muted">Google Adwords</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Category title-->
										<h3 class="fs-5 text-muted m-0 pt-5 pb-5"
											data-kt-search-element="category-title">Projects</h3>
										<!--end::Category title-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <i
													class="ki-duotone ki-notepad fs-2 text-primary"> <span
														class="path1"></span> <span class="path2"></span> <span
														class="path3"></span> <span class="path4"></span> <span
														class="path5"></span>
												</i>
												</span>
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div class="d-flex flex-column">
												<span class="fs-6 fw-semibold">Si-Fi Project by AU
													Themes</span> <span class="fs-7 fw-semibold text-muted">#45670</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <i
													class="ki-duotone ki-frame fs-2 text-primary"> <span
														class="path1"></span> <span class="path2"></span> <span
														class="path3"></span> <span class="path4"></span>
												</i>
												</span>
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div class="d-flex flex-column">
												<span class="fs-6 fw-semibold">Shopix Mobile App
													Planning</span> <span class="fs-7 fw-semibold text-muted">#45690</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <i
													class="ki-duotone ki-message-text-2 fs-2 text-primary">
														<span class="path1"></span> <span class="path2"></span> <span
														class="path3"></span>
												</i>
												</span>
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div class="d-flex flex-column">
												<span class="fs-6 fw-semibold">Finance Monitoring
													SAAS Discussion</span> <span class="fs-7 fw-semibold text-muted">#21090</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
										<!--begin::Item-->
										<a href="#"
											class="d-flex text-gray-900 text-hover-primary align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <i
													class="ki-duotone ki-profile-circle fs-2 text-primary">
														<span class="path1"></span> <span class="path2"></span> <span
														class="path3"></span>
												</i>
												</span>
											</div> <!--end::Symbol--> <!--begin::Title-->
											<div class="d-flex flex-column">
												<span class="fs-6 fw-semibold">Dashboard Analitics
													Launch</span> <span class="fs-7 fw-semibold text-muted">#34560</span>
											</div> <!--end::Title-->
										</a>
										<!--end::Item-->
									</div>
									<!--end::Items-->
								</div>
								<!--end::Recently viewed-->
								<!--begin::Recently viewed-->
								<div class="" data-kt-search-element="main">
									<!--begin::Heading-->
									<div class="d-flex flex-stack fw-semibold mb-4">
										<!--begin::Label-->
										<span class="text-muted fs-6 me-2">Recently Searched:</span>
										<!--end::Label-->
										<!--begin::Toolbar-->
										<div class="d-flex" data-kt-search-element="toolbar">
											<!--begin::Preferences toggle-->
											<div data-kt-search-element="preferences-show"
												class="btn btn-icon w-20px btn-sm btn-active-color-primary me-2 data-bs-toggle="
												title="Show search preferences">
												<i class="ki-duotone ki-setting-2 fs-2"> <span
													class="path1"></span> <span class="path2"></span>
												</i>
											</div>
											<!--end::Preferences toggle-->
											<!--begin::Advanced search toggle-->
											<div data-kt-search-element="advanced-options-form-show"
												class="btn btn-icon w-20px btn-sm btn-active-color-primary me-n1"
												data-bs-toggle="tooltip" title="Show more search options">
												<i class="ki-duotone ki-down fs-2"></i>
											</div>
											<!--end::Advanced search toggle-->
										</div>
										<!--end::Toolbar-->
									</div>
									<!--end::Heading-->
									<!--begin::Items-->
									<div class="scroll-y mh-200px mh-lg-325px">
										<!--begin::Item-->
										<div class="d-flex align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <i
													class="ki-duotone ki-laptop fs-2 text-primary"> <span
														class="path1"></span> <span class="path2"></span>
												</i>
												</span>
											</div>
											<!--end::Symbol-->
											<!--begin::Title-->
											<div class="d-flex flex-column">
												<a href="#"
													class="fs-6 text-gray-800 text-hover-primary fw-semibold">BoomApp
													by Keenthemes</a> <span class="fs-7 text-muted fw-semibold">#45789</span>
											</div>
											<!--end::Title-->
										</div>
										<!--end::Item-->
										<!--begin::Item-->
										<div class="d-flex align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <i
													class="ki-duotone ki-chart-simple fs-2 text-primary"> <span
														class="path1"></span> <span class="path2"></span> <span
														class="path3"></span> <span class="path4"></span>
												</i>
												</span>
											</div>
											<!--end::Symbol-->
											<!--begin::Title-->
											<div class="d-flex flex-column">
												<a href="#"
													class="fs-6 text-gray-800 text-hover-primary fw-semibold">"Kept
													API Project Meeting</a> <span
													class="fs-7 text-muted fw-semibold">#84050</span>
											</div>
											<!--end::Title-->
										</div>
										<!--end::Item-->
										<!--begin::Item-->
										<div class="d-flex align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <i
													class="ki-duotone ki-chart fs-2 text-primary"> <span
														class="path1"></span> <span class="path2"></span>
												</i>
												</span>
											</div>
											<!--end::Symbol-->
											<!--begin::Title-->
											<div class="d-flex flex-column">
												<a href="#"
													class="fs-6 text-gray-800 text-hover-primary fw-semibold">"KPI
													Monitoring App Launch</a> <span
													class="fs-7 text-muted fw-semibold">#84250</span>
											</div>
											<!--end::Title-->
										</div>
										<!--end::Item-->
										<!--begin::Item-->
										<div class="d-flex align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <i
													class="ki-duotone ki-chart-line-down fs-2 text-primary">
														<span class="path1"></span> <span class="path2"></span>
												</i>
												</span>
											</div>
											<!--end::Symbol-->
											<!--begin::Title-->
											<div class="d-flex flex-column">
												<a href="#"
													class="fs-6 text-gray-800 text-hover-primary fw-semibold">Project
													Reference FAQ</a> <span class="fs-7 text-muted fw-semibold">#67945</span>
											</div>
											<!--end::Title-->
										</div>
										<!--end::Item-->
										<!--begin::Item-->
										<div class="d-flex align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <i
													class="ki-duotone ki-sms fs-2 text-primary"> <span
														class="path1"></span> <span class="path2"></span>
												</i>
												</span>
											</div>
											<!--end::Symbol-->
											<!--begin::Title-->
											<div class="d-flex flex-column">
												<a href="#"
													class="fs-6 text-gray-800 text-hover-primary fw-semibold">"FitPro
													App Development</a> <span class="fs-7 text-muted fw-semibold">#84250</span>
											</div>
											<!--end::Title-->
										</div>
										<!--end::Item-->
										<!--begin::Item-->
										<div class="d-flex align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <i
													class="ki-duotone ki-bank fs-2 text-primary"> <span
														class="path1"></span> <span class="path2"></span>
												</i>
												</span>
											</div>
											<!--end::Symbol-->
											<!--begin::Title-->
											<div class="d-flex flex-column">
												<a href="#"
													class="fs-6 text-gray-800 text-hover-primary fw-semibold">Shopix
													Mobile App</a> <span class="fs-7 text-muted fw-semibold">#45690</span>
											</div>
											<!--end::Title-->
										</div>
										<!--end::Item-->
										<!--begin::Item-->
										<div class="d-flex align-items-center mb-5">
											<!--begin::Symbol-->
											<div class="symbol symbol-40px me-4">
												<span class="symbol-label bg-light"> <i
													class="ki-duotone ki-chart-line-down fs-2 text-primary">
														<span class="path1"></span> <span class="path2"></span>
												</i>
												</span>
											</div>
											<!--end::Symbol-->
											<!--begin::Title-->
											<div class="d-flex flex-column">
												<a href="#"
													class="fs-6 text-gray-800 text-hover-primary fw-semibold">"Landing
													UI Design" Launch</a> <span class="fs-7 text-muted fw-semibold">#24005</span>
											</div>
											<!--end::Title-->
										</div>
										<!--end::Item-->
									</div>
									<!--end::Items-->
								</div>
								<!--end::Recently viewed-->
								<!--begin::Empty-->
								<div data-kt-search-element="empty" class="text-center d-none">
									<!--begin::Icon-->
									<div class="pt-10 pb-10">
										<i class="ki-duotone ki-search-list fs-4x opacity-50"> <span
											class="path1"></span> <span class="path2"></span> <span
											class="path3"></span>
										</i>
									</div>
									<!--end::Icon-->
									<!--begin::Message-->
									<div class="pb-15 fw-semibold">
										<h3 class="text-gray-600 fs-5 mb-2">No result found</h3>
										<div class="text-muted fs-7">Please try again with a
											different query</div>
									</div>
									<!--end::Message-->
								</div>
								<!--end::Empty-->
							</div>
							<!--end::Wrapper-->
							<!--begin::Preferences-->
							<form data-kt-search-element="advanced-options-form"
								class="pt-1 d-none">
								<!--begin::Heading-->
								<h3 class="fw-semibold text-gray-900 mb-7">Advanced Search</h3>
								<!--end::Heading-->
								<!--begin::Input group-->
								<div class="mb-5">
									<input type="text"
										class="form-control form-control-sm form-control-solid"
										placeholder="Contains the word" name="query" />
								</div>
								<!--end::Input group-->
								<!--begin::Input group-->
								<div class="mb-5">
									<!--begin::Radio group-->
									<div class="nav-group nav-group-fluid">
										<!--begin::Option-->
										<label> <input type="radio" class="btn-check"
											name="type" value="has" checked="checked" /> <span
											class="btn btn-sm btn-color-muted btn-active btn-active-primary">All</span>
										</label>
										<!--end::Option-->
										<!--begin::Option-->
										<label> <input type="radio" class="btn-check"
											name="type" value="users" /> <span
											class="btn btn-sm btn-color-muted btn-active btn-active-primary px-4">Users</span>
										</label>
										<!--end::Option-->
										<!--begin::Option-->
										<label> <input type="radio" class="btn-check"
											name="type" value="orders" /> <span
											class="btn btn-sm btn-color-muted btn-active btn-active-primary px-4">Orders</span>
										</label>
										<!--end::Option-->
										<!--begin::Option-->
										<label> <input type="radio" class="btn-check"
											name="type" value="projects" /> <span
											class="btn btn-sm btn-color-muted btn-active btn-active-primary px-4">Projects</span>
										</label>
										<!--end::Option-->
									</div>
									<!--end::Radio group-->
								</div>
								<!--end::Input group-->
								<!--begin::Input group-->
								<div class="mb-5">
									<input type="text" name="assignedto"
										class="form-control form-control-sm form-control-solid"
										placeholder="Assigned to" value="" />
								</div>
								<!--end::Input group-->
								<!--begin::Input group-->
								<div class="mb-5">
									<input type="text" name="collaborators"
										class="form-control form-control-sm form-control-solid"
										placeholder="Collaborators" value="" />
								</div>
								<!--end::Input group-->
								<!--begin::Input group-->
								<div class="mb-5">
									<!--begin::Radio group-->
									<div class="nav-group nav-group-fluid">
										<!--begin::Option-->
										<label> <input type="radio" class="btn-check"
											name="attachment" value="has" checked="checked" /> <span
											class="btn btn-sm btn-color-muted btn-active btn-active-primary">Has
												attachment</span>
										</label>
										<!--end::Option-->
										<!--begin::Option-->
										<label> <input type="radio" class="btn-check"
											name="attachment" value="any" /> <span
											class="btn btn-sm btn-color-muted btn-active btn-active-primary px-4">Any</span>
										</label>
										<!--end::Option-->
									</div>
									<!--end::Radio group-->
								</div>
								<!--end::Input group-->
								<!--begin::Input group-->
								<div class="mb-5">
									<select name="timezone" aria-label="Select a Timezone"
										data-control="select2"
										data-dropdown-parent="#kt_header_search"
										data-placeholder="date_period"
										class="form-select form-select-sm form-select-solid">
										<option value="next">Within the next</option>
										<option value="last">Within the last</option>
										<option value="between">Between</option>
										<option value="on">On</option>
									</select>
								</div>
								<!--end::Input group-->
								<!--begin::Input group-->
								<div class="row mb-8">
									<!--begin::Col-->
									<div class="col-6">
										<input type="number" name="date_number"
											class="form-control form-control-sm form-control-solid"
											placeholder="Lenght" value="" />
									</div>
									<!--end::Col-->
									<!--begin::Col-->
									<div class="col-6">
										<select name="date_typer" aria-label="Select a Timezone"
											data-control="select2"
											data-dropdown-parent="#kt_header_search"
											data-placeholder="Period"
											class="form-select form-select-sm form-select-solid">
											<option value="days">Days</option>
											<option value="weeks">Weeks</option>
											<option value="months">Months</option>
											<option value="years">Years</option>
										</select>
									</div>
									<!--end::Col-->
								</div>
								<!--end::Input group-->
								<!--begin::Actions-->
								<div class="d-flex justify-content-end">
									<button type="reset"
										class="btn btn-sm btn-light fw-bold btn-active-light-primary me-2"
										data-kt-search-element="advanced-options-form-cancel">Cancel</button>
									<a href="utilities/search/horizontal.html"
										class="btn btn-sm fw-bold btn-primary"
										data-kt-search-element="advanced-options-form-search">Search</a>
								</div>
								<!--end::Actions-->
							</form>
							<!--end::Preferences-->
							<!--begin::Preferences-->
							<form data-kt-search-element="preferences" class="pt-1 d-none">
								<!--begin::Heading-->
								<h3 class="fw-semibold text-gray-900 mb-7">Search
									Preferences</h3>
								<!--end::Heading-->
								<!--begin::Input group-->
								<div class="pb-4 border-bottom">
									<label
										class="form-check form-switch form-switch-sm form-check-custom form-check-solid flex-stack">
										<span
										class="form-check-label text-gray-700 fs-6 fw-semibold ms-0 me-2">Projects</span>
										<input class="form-check-input" type="checkbox" value="1"
										checked="checked" />
									</label>
								</div>
								<!--end::Input group-->
								<!--begin::Input group-->
								<div class="py-4 border-bottom">
									<label
										class="form-check form-switch form-switch-sm form-check-custom form-check-solid flex-stack">
										<span
										class="form-check-label text-gray-700 fs-6 fw-semibold ms-0 me-2">Targets</span>
										<input class="form-check-input" type="checkbox" value="1"
										checked="checked" />
									</label>
								</div>
								<!--end::Input group-->
								<!--begin::Input group-->
								<div class="py-4 border-bottom">
									<label
										class="form-check form-switch form-switch-sm form-check-custom form-check-solid flex-stack">
										<span
										class="form-check-label text-gray-700 fs-6 fw-semibold ms-0 me-2">Affiliate
											Programs</span> <input class="form-check-input" type="checkbox"
										value="1" />
									</label>
								</div>
								<!--end::Input group-->
								<!--begin::Input group-->
								<div class="py-4 border-bottom">
									<label
										class="form-check form-switch form-switch-sm form-check-custom form-check-solid flex-stack">
										<span
										class="form-check-label text-gray-700 fs-6 fw-semibold ms-0 me-2">Referrals</span>
										<input class="form-check-input" type="checkbox" value="1"
										checked="checked" />
									</label>
								</div>
								<!--end::Input group-->
								<!--begin::Input group-->
								<div class="py-4 border-bottom">
									<label
										class="form-check form-switch form-switch-sm form-check-custom form-check-solid flex-stack">
										<span
										class="form-check-label text-gray-700 fs-6 fw-semibold ms-0 me-2">Users</span>
										<input class="form-check-input" type="checkbox" value="1" />
									</label>
								</div>
								<!--end::Input group-->
								<!--begin::Actions-->
								<div class="d-flex justify-content-end pt-7">
									<button type="reset"
										class="btn btn-sm btn-light fw-bold btn-active-light-primary me-2"
										data-kt-search-element="preferences-dismiss">Cancel</button>
									<button type="submit" class="btn btn-sm fw-bold btn-primary">Save
										Changes</button>
								</div>
								<!--end::Actions-->
							</form>
							<!--end::Preferences-->
						</div>
						<!--end::Menu-->
					</div>
					<!--end::Search-->
				</div>
				<!--end::Search-->
				<!--begin::Notifications-->
				<div class="app-navbar-item ms-2 ms-lg-4">
					<!--begin::Menu- wrapper-->
					<a href="#"
						class="btn btn-custom btn-icon btn-outline btn-icon-gray-700 btn-active-icon-primary"
						data-kt-menu-trigger="click" data-kt-menu-attach="parent"
						data-kt-menu-placement="bottom-end" data-kt-menu-flip="bottom">
						<i class="ki-duotone ki-element-11 fs-1"> <span class="path1"></span>
							<span class="path2"></span> <span class="path3"></span> <span
							class="path4"></span>
					</i>
					</a>
					<!--begin::Menu-->
					<div
						class="menu menu-sub menu-sub-dropdown menu-column w-250px w-lg-325px"
						data-kt-menu="true">
						<!--begin::Heading-->
						<div
							class="d-flex flex-column flex-center bgi-no-repeat rounded-top px-9 py-10"
							style="background-image:url('${pageContext.request.contextPath}/resources/design/media/misc/menu-header-bg.jpg')">
							<!--begin::Title-->
							<h2 class="text-white fw-semibold mb-3">자주 쓰는 기능</h2>
							<!--end::Title-->
							<!--begin::Status-->
							<span class="badge bg-primary text-inverse-primary py-2 px-3">자주
								쓰는 기능을 편집해보세요!</span>
							<!--end::Status-->
						</div>
						<!--end::Heading-->
						<!--begin:Nav-->
						<div class="row g-0">
							<!--begin:Item-->
							<div class="col-6">
								<a href="/employee/organizationchart.do"
									class="d-flex flex-column flex-center h-100 p-6 bg-hover-light border-end border-bottom">
									<i class="ki-duotone ki-dollar fs-3x text-primary mb-2"> <span
										class="path1"></span> <span class="path2"></span> <span
										class="path3"></span>
								</i> <span class="fs-5 fw-semibold text-gray-800 mb-0">주소록</span> <span
									class="fs-7 text-gray-500">Address book</span>
								</a>
							</div>
							<!--end:Item-->
							<!--begin:Item-->
							<div class="col-6">
								<a href="/employee/cloudList.do"
									class="d-flex flex-column flex-center h-100 p-6 bg-hover-light border-bottom">
									<i class="ki-duotone ki-sms fs-3x text-primary mb-2"> <span
										class="path1"></span> <span class="path2"></span>
								</i> <span class="fs-5 fw-semibold text-gray-800 mb-0">클라우드</span> <span
									class="fs-7 text-gray-500">Cloud</span>
								</a>
							</div>
							<!--end:Item-->
							<!--begin:Item-->
							<div class="col-6">
								<a href="/empvehicle/vehicledashboard.do"
									class="d-flex flex-column flex-center h-100 p-6 bg-hover-light border-end">
									<i class="ki-duotone ki-abstract-41 fs-3x text-primary mb-2">
										<span class="path1"></span> <span class="path2"></span>
								</i> <span class="fs-5 fw-semibold text-gray-800 mb-0">차량예약</span> <span
									class="fs-7 text-gray-500">Vehicle</span>
								</a>
							</div>
							<!--end:Item-->
							<!--begin:Item-->
							<div class="col-6">
								<a href="/employee/facilities/status.do"
									class="d-flex flex-column flex-center h-100 p-6 bg-hover-light">
									<i class="ki-duotone ki-briefcase fs-3x text-primary mb-2">
										<span class="path1"></span> <span class="path2"></span>
								</i> <span class="fs-5 fw-semibold text-gray-800 mb-0">시설예약</span> <span
									class="fs-7 text-gray-500">Facility</span>
								</a>
							</div>
							<!--end:Item-->
						</div>
						<!--end:Nav-->
						<!--begin::View more-->
						<!--end::View more-->
					</div>
					<!--end::Menu-->
					<!--end::Menu wrapper-->
				</div>
				<!--end::Notifications-->
				<!--begin::Chat-->
				<!-- 				<div class="app-navbar-item ms-2 ms-lg-4"> -->
				<!-- 					<a href="#" id="kt_drawer_chat_toggle" -->
				<!-- 						class="btn btn-custom btn-outline btn-icon btn-icon-gray-700 btn-active-icon-primary" -->
				<!-- 						data-kt-menu-trigger="click" data-kt-menu-attach="parent" -->
				<!-- 						data-kt-menu-placement="bottom-end" data-kt-menu-flip="bottom"> -->
				<!-- 						<i class="ki-duotone ki-message-text-2 fs-1"> <span -->
				<!-- 							class="path1"></span> <span class="path2"></span> <span -->
				<!-- 							class="path3"></span> -->
				<!-- 					</i> -->
				<!-- 					</a> -->
				<!-- 				</div> -->
				<!--end::Chat-->

				<!-- 알람 -->
				<!-- 알람 -->
				<!-- 알람 -->
				<!-- 알람 -->
				<!-- 알람 -->
				<!--begin::Quick links-->
<div class="app-navbar-item ms-2 ms-lg-4">
    <a href="#" class="btn btn-icon btn-primary fw-bold" id="alarmBtn"
       data-kt-menu-trigger="click" data-kt-menu-attach="parent"
       style="position: relative;">
        <span class="fs-5">
            <span class="material-symbols-outlined">notifications</span>
 				  <span class="symbol-badge badge badge-circle bg-danger" id="alarmCountBadge"
                      style="position: absolute; top: -10px; right: -13px; z-index: 1; color:white; width: 25px; height: 25px; font-size: 13px; line-height: 20px;">
                </span>
        </span>
    </a>

					<div
						class="menu menu-sub menu-sub-dropdown menu-column w-350px w-lg-375px"
						data-kt-menu="true" id="kt_menu_notifications">
						<!--begin::Heading-->
						<div class="d-flex flex-column bgi-no-repeat rounded-top"
							style="background-image:url('${pageContext.request.contextPath}/resources/design/media/misc/menu-header-bg.jpg');">
							<!--begin::Title-->
							<h2 class="text-white fw-semibold px-5 mt-9 mb-4">알림</h2>
							<!--end::Title-->
							<!--begin::Tabs-->
							<div id="wheel-x"
								style="overflow-x: scroll; white-space: nowrap;">
								<ul class="itemss"
									style="display: inline-flex; padding: 0; margin: 2; list-style-type: none;">
									<li class="itemsss"
										style="padding-left: 10px; font-weight: 900;"><a
										class="clickTab nav-link text-white opacity-75 opacity-state-100 pb-4"
										data-bs-toggle="tab" href="#kttopbarnotifications_1">전체알림</a>
									</li>
									<li class="itemsss" style="font-weight: 900;"><a
										class="clickTab nav-link text-white opacity-75 opacity-state-100 pb-4"
										data-bs-toggle="tab" href="#kttopbarnotifications_2">전자결재
											<input type="hidden" id="approval" />
									</a></li>
									<li class="itemsss" style="font-weight: 900;"><a
										class="clickTab nav-link text-white opacity-75 opacity-state-100 pb-4"
										data-bs-toggle="tab" href="#kttopbarnotifications_3">증명서 <input
											type="hidden" id="approval" />
									</a></li>
									<li class="itemsss" style="font-weight: 900;"><a
										class="clickTab nav-link text-white opacity-75 opacity-state-100 pb-4"
										data-bs-toggle="tab" href="#kttopbarnotifications_4">일정 <input
											type="hidden" id="schedule" />
									</a></li>
									<li class="itemsss" style="font-weight: 900;"><a
										class="clickTab nav-link text-white opacity-75 opacity-state-100 pb-4"
										data-bs-toggle="tab" href="#kttopbarnotifications_5">프로젝트
											<input type="hidden" id="project" />
									</a></li>
									<li class="itemsss" style="font-weight: 900;"><a
										class="clickTab nav-link text-white opacity-75 opacity-state-100 pb-4"
										data-bs-toggle="tab" href="#kttopbarnotifications_6">휴가 <input
											type="hidden" id="schedule" />
									</a></li>
									<li class="itemsss" style="font-weight: 900;"><a
										class="clickTab nav-link text-white opacity-75 opacity-state-100 pb-4"
										data-bs-toggle="tab" href="#kttopbarnotifications_7">시설예약
											<input type="hidden" id="car" />
									</a></li>
									<li class="itemsss" style="font-weight: 900;"><a
										class="clickTab nav-link text-white opacity-75 opacity-state-100 pb-4"
										data-bs-toggle="tab" href="#kttopbarnotifications_8">차량예약
											<input type="hidden" id="car" />
									</a></li>
									<li class="itemsss" style="font-weight: 900;"><a
										class="clickTab nav-link text-white opacity-75 opacity-state-100 pb-4"
										data-bs-toggle="tab" href="#kttopbarnotifications_9">커뮤니티
											<input type="hidden" id="community" />
									</a></li>
									<li class="itemsss" style="font-weight: 900;"><a
										class="clickTab nav-link text-white opacity-75 opacity-state-100 pb-4"
										data-bs-toggle="tab" href="#kttopbarnotifications_9">인사 • 정보 관리
											<input type="hidden" id="info" />
									</a></li>
								</ul>
							</div>
							<!--end::Tabs-->
						</div>
						<!--end::Heading-->
						<!--begin::Tab content-->
						<div class="tab-content">
							<!--begin::Tab panel-->
							<div class="tab-pane fade active show" id="alarmDiv"
								role="tabpanel">
								<!--begin::Items-->
								<div class="scroll-y mh-325px my-5 px-8" id="alarmAppend">
								</div>
								<!--end::Items-->



								<!--begin::View more-->
								<div class="py-2 text-center border-top">
									<a href="/company/allAlarm.do"
										class="btn btn-color-gray-600 btn-active-color-primary">전체보기
										<i class="ki-duotone ki-arrow-right fs-5"> <span
											class="path1"></span> <span class="path2"></span>
									</i>
									</a>
								</div>
								<!--end::View more-->
							</div>
							<!--end::Tab panel-->
						</div>
						<!--end::Tab panel-->
					</div>
					<!--end::Menu-->
					<!--end::Menu wrapper-->
				</div>
				<!--end::Quick links-->
			</div>
			<!--end::Navbar-->
		</div>
		<!--end::Header wrapper-->
	</div>
	<!--end::Header container-->
	<!-- 	<div style="width: 1px; height: 60px"></div> -->

<!-- 	begin::Toast -->
	<div id="kt_docs_toast_stack_container"
		class="toast-container position-fixed top-0 end-0 p-3 z-index-3"style=" margin-top:100px;">
		<div class="toast" role="alert" aria-live="assertive"
			aria-atomic="true" data-kt-docs-toast="stack">
			<div class="toast-header">
				 <span class="material-symbols-outlined">notifications</span> <strong
					class="me-auto">알림 왔어요!</strong> <small>지금</small>
				<button type="button" class="btn-close" data-bs-dismiss="toast"
					aria-label="Close"></button>
			</div>
			<div class="toast-body">새로운 알람이 도착했습니다!</div>
		</div>
	</div>
<!-- 	end::Toast -->
</div>





<script type="text/javascript" defer="defer">

	//Select elements
	const button = document.getElementById('kt_docs_toast_stack_button');
	const toastAppend = document.getElementById('kt_docs_toast_stack_container');
	const targetElement = document.querySelector('[data-kt-docs-toast="stack"]'); // Use CSS class or HTML attr to avoid duplicating ids


	const alarmAppend = document.querySelector("#alarmAppend");
	let webSocket;
	connect();


	$(document).ready(function(){



		$(document).on("click", "#alarmBtn", function(){
			let alarmCategory = $('#alarmCategory').val(); // 알림 유형
			let alarmTarget = $('#alarmTarget').val(); // 대상 empId
			let alarmCn = $('#alarmCn').val(); // 알림 내용
			let alarmUrl = $('#alarmUrl').val(); // 알림 링크
//	 		let alarmNo = $('#alarmNo').val(); // 알림 링크

		    
			 $.ajax({
	             url : "/alarmList",
	             type : "get", 
	             success: function(alarmList){
	            	 console.log("alarm Data",alarmList);
	            	 
	                 
					 let alarmHTML ="";
					 let categoryNames = {
	                    elapr: "전자결재",
	                    calender: "일정",
	                    project: "프로젝트",
	                    car: "차량 예약",
	                    facilty: "시설 예약",
	                    vacation: "휴가",
	                    prove: "증명서",
	                    info: "인사 • 정보 관리",
	                    community: "커뮤니티",
	                    cmntyRe: "커뮤니티",
	                    QnA : "Q&A"
	                };
					 
			 if (alarmList.length == 0) {
                    // 알람이 없을 때 표시할 HTML
              alarmHTML += `
                        <div class="flex mh-325px my-5 px-8 align-content-center justify-content-center"
                             style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%;">
                            <img src="/resources/file/image/cloudEmpty.png" class="mw-250px">
                            <div class="fs-4 text-gray-700 fw-bold">알림이 없습니다.</div>
                        </div>
                    `;
                } else {
					 
					 for(let i=0; i<alarmList.length; i++){
					  
					  let alarm = alarmList[i];
					  
					  let spanClass ="symbol-label bg-light-primary";
					  let iconClass = "ki-duotone ki-abstract-28 fs-2 text-primary";
					  if(alarm.alarmCategory == "elapr"){
						 spanClass = "symbol-label bg-light-warning";
						 iconClass ="ki-duotone ki-briefcase fs-2 text-warning";
					  }else if(alarm.alarmCategory == "calender"){
						spanClass = "symbol-label bg-light-primary";
						 iconClass ="bi bi-calendar-check";
					  }else if(alarm.alarmCategory == "project"){
						spanClass = "symbol-label bg-light-success";
						 iconClass ="ki-duotone ki-abstract-12 fs-2 text-success";
					  }else if(alarm.alarmCategory == "car"){
						spanClass = "symbol-label bg-light-info";
						iconClass ="ki-duotone fs-2 text-info";
					  }else if(alarm.alarmCategory == "facilty"){
							spanClass = "symbol-label bg-light-info";
							iconClass ="bi bi-building-check";
					  }else if(alarm.alarmCategory == "vacation"){
							spanClass = "symbol-label bg-light-danger";
							iconClass ="bi bi-calendar-heart-fill";
					  }else if(alarm.alarmCategory == "prove"){
							spanClass = "symbol-label bg-light-warning";
							iconClass ="bi bi-file-earmark";
					  }else if(alarm.alarmCategory == "info"){
							spanClass = "symbol-label bg-light-warning";
							iconClass ="bi bi-info-circle";
					  }



				alarmHTML +=   `
		                <div class="d-flex mb-5 py-4" style="padding-bottom:0 !important;">
		                  <div class="d-flex align-items-center">
		                     <div class="symbol symbol-35px me-4">
		                        <span class="\${spanClass}">
		                           <i class="\${iconClass}">
		              `;
		              
		              if(alarmCategory != `car` || alarmCategory != `info` || alarmCategory != `calender` || alarmCategory != `prove` || alarmCategory != `facilty` || alarmCategory != `vacation`){
		                 alarmHTML += ` <span class="path1"></span> 
		                           <span class="path2"></span>`;
		              }


		              if(alarm.alarmCategory == `car`){
		                alarmHTML += `<span class="material-symbols-outlined" style="color: #B2A8D3;">directions_car</span>`;
		              }


		         alarmHTML +=`
		                           </i>
		                        </span>
		                      </div>
		                      <div class="me-2">
		                         <div class="d-flex justify-content-between">
		                           <a href="#" data-alarmurl="\${alarm.alarmUrl}" class="fs-6 text-gray-800 text-hover-primary fw-bold readAlarm">
				                      <input type="hidden" id="alarmNo" class="alarmNo" value="\${alarm.alarmNo }" />
		                              \${categoryNames[alarm.alarmCategory]}
		                               </a>
		                           <div>
		                              <span class="badge badge-light fs-8 mb-0" style="float:right;">\${alarm.alarmCrtDt}</span> 
		                           </div>
		                        </div>
		                        <div class="text-gray-500 mt-1 fs-7" style="width: 255px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">\${alarm.alarmCn}</div>
		                      </div>
		                      
		                      
		                      <a href="#" class="deleteAlarm">
		                      <input type="hidden" id="alarmNo" class="alarmNo" value="\${alarm.alarmNo }" />
		                        <i class="ki-duotone ki-cross-circle">
		                         <span class="path1"></span>
		                         <span class="path2"></span>
		                        </i>
		                      </a>
		                     
		                  </div>
		                </div>
		                  `;
		             }
	             }
		             alarmAppend.innerHTML = alarmHTML;
		                
		             },
		             error: function(xhr, status, error) {
		                 console.error("Error inserting alarm:", error);
		             }
		         });
		   });
		      

		
		/**
		* 알림 확인 버튼
		*/
		$(document).on("click", ".readAlarm", function(evt){
			evt.preventDefault();
			console.log("evt ", evt);
			console.log("evt ", this);
			
			// 셀력션에서 선택된 객체의 현재 값을 변수에 담아둔다.
			let readAlarmObj = this;			
			
			// 셀랙션에서 선택된 알림 번호를 추출
			let alarmNo = $(this).find(".alarmNo").val();
			
			let alarmUrl = $(this).data("alarmurl");
			
			console.log("readAlarmObj :: ", readAlarmObj);
			console.log("alarmNo :: ", alarmNo);
			console.log("alarmUrl :: ", alarmUrl);
			
			// data 속성은 모두 소문자
			
			// Json 형식으로 데이터 프로토콜 생성
			let data = {alarmNo : alarmNo}
			
			console.log("data ::: ",data)
			
			$.ajax({
				url:"/alarmRead",
				type:"post",
				data: JSON.stringify(data),
				contentType : "application/json; charset=utf-8",
		        success: function(res) {
		        	console.log("res ::: " , res);

					$(readAlarmObj).parent().remove();
					
					console.log("data ::: ", $("#alarmCountBadge").text());
		 
					window.location.href = alarmUrl;
					
		        },
	            error: function(xhr, status, error) {
	                console.error("Error deleting alarm:", error);
	            }
			});
		});
	

	
			
		/**
		* 알림 버튼 삭제 
		*/
		$(document).on("click", ".deleteAlarm", function(evt){
			evt.preventDefault();
			console.log("evt ", evt);
			console.log("evt ", this);
			
			// 셀력션에서 선택된 객체의 현재 값을 변수에 담아둔다.
			let deleteAlarmObj = this;			
			
			// 셀랙션에서 선택된 알림 번호를 추출
			let alarmNo = $(this).find(".alarmNo").val(); 
			
			// Json 형식으로 데이터 프로토콜 생성
			let data = {alarmNo : alarmNo};
			
			console.log("data ::: ",data);
			
			$.ajax({
				url:"/alarmRemove",
				type:"post",
				data: JSON.stringify(data),
				contentType : "application/json; charset=utf-8",
		        success: function(res) {     
		        	console.log("res ::: " , res);

					$(deleteAlarmObj).parent().parent().remove();
					
					console.log("data ::: ", $("#alarmCountBadge").text());
					
					// $("#alarmCountBadge").text() 값에서 -1 을 한값을 
					// $("#alarmCountBadge").text("요기.");
					
					  // 현재 배지 값 가져오기
		            let currentCount = parseInt($("#alarmCountBadge").text()) || 0; // 현재 알람 개수 가져오기
		            let newCount = currentCount - 1; // 개수에서 1을 뺀 값
		            
		            // 새로운 개수로 배지 업데이트
		            if (newCount > 0) {
		                $("#alarmCountBadge").text(newCount).show(); // 0보다 큰 경우 표시
		            } else {
		                $("#alarmCountBadge").hide(); // 0이면 숨김
		            }
					
		        },
	            error: function(xhr, status, error) {
	                console.error("Error deleting alarm:", error);
	            }
			});
		});
	});
	

	
	$(function(){
		// 딱 갯수만 가져오는 아작스, 맨 처음에
		$.ajax({
			url:"/alarmCnt",
			type:"get",
			success:function(pCnt){
// 				 alert("체킁:" +   pCnt);
// 				webSocket.send(pCnt);
				
				if(pCnt > 0){
					$("#alarmCountBadge").text(pCnt).show();
				}else{
					$("#alarmCountBadge").hide();
				}
			}
		});
	});


	function connect() {
		// http://localhost/...
		// http://192.168.36.23/...

		let dabinHost = location.href.split("/")[2];
		//alert("체킁" + dabinHost);

		webSocket = new WebSocket(`ws://\${dabinHost}/alarm`);
		webSocket.onopen = aOpen; // 접속하면 자동 실행
		webSocket.onmessage = aMessage; // 서버에서 메세지오면 자동 실행
	}

	// 메세지 보내줌
	function aOpen() {
		console.log("웹소켓 접속 성공");
	}

	// 서버에서 온거 띄움
	function aMessage(e) {
		console.log("서버로부터 메세지 : ", e.data);
		
		 //Select elements
     	const toastAppend = document.getElementById('kt_docs_toast_stack_container');
      	const container = document.getElementById('kt_docs_toast_stack_container');
     	const targetElement = document.querySelector('[data-kt-docs-toast="stack"]'); // Use CSS class or HTML attr to avoid duplicating ids
     	
     	if (event.data.length > 0) {
		    // Create new toast element
		    const newToast = targetElement.cloneNode(true);
		    toastAppend.append(newToast);
		
		    // Create new toast instance --- more info: https://getbootstrap.com/docs/5.1/components/toasts/#getorcreateinstance
		    const toast = bootstrap.Toast.getOrCreateInstance(newToast);
			toast.show();
     	}

		if (event.data.length > 0) {
			let newAlarm = '';
			newAlarm += '<li>' + event.data + "</li>" // scope="col"
			$('#alarmAppend').append(newAlarm);
		}
		
	}
	     
	function send() {
		let msg = c_message.value;
		webSocket.send(msg);
		c_message.value = "";
		console.log("전송한 메시지: ", msg);
	}
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>설문/투표</h3>
		<h6>이벤트</h6>
	</div>
</div>
<!--begin::Col-->

<!--begin::Main-->
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<!--begin::Content wrapper-->
	<div class="d-flex flex-column flex-column-fluid">
		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<!--begin::Content container-->
			<div id="kt_app_content_container" class="app-container container-fluid">
				<!--begin::row-->
				<div class="row">
					<!--begin::Card-->
					<div class="col-xxl-6">
						<!--begin::Security recent alerts-->
						<div class="card card-xxl-stretch-50 mb-5 mb-xl-10">
							<!--begin::Body-->
							<div class="card-body pt-5">
								<!--begin::Carousel-->
								<div id="kt_security_recent_alerts" class="carousel carousel-custom carousel-stretch slide" data-bs-ride="carousel" data-bs-interval="8000">
									<!--begin::Heading-->
									<div class="d-flex flex-stack align-items-center flex-wrap">
										<h4 class="text-gray-500 fw-semibold mb-0 pe-2"><span class="badge text-bg-primary mb-2">설문</span></h4>
										<!--begin::Carousel Indicators-->
										<ol class="p-0 m-0 carousel-indicators carousel-indicators-dots">
											<li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="0" class="ms-1 active"></li>
											<li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="1" class="ms-1"></li>
											<li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="2" class="ms-1"></li>
										</ol>
										<!--end::Carousel Indicators-->
									</div>
									<!--end::Heading-->
									<!--begin::Carousel inner-->
									<div class="carousel-inner pt-6">
										<!--begin::Item-->
										<div class="carousel-item active">
											<!--begin::Wrapper-->
											<div class="carousel-wrapper">
												<!--begin::Description-->
												<div class="d-flex flex-column flex-grow-1">
													<a href="#" class="fs-5 fw-bold text-gray-900 text-hover-primary">{eventVO.eventNm }</a>
													<p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">{eventVO.eventCn }</p>
												</div>
												<!--end::Description-->
												<!--begin::Summary-->
												<div class="d-flex flex-stack pt-8">
													<span class="badge badge-light-primary fs-7 fw-bold me-2">{eventVO.eventBgngDt }</span>
													<a href="#" class="btn btn-sm btn-light">자세히 보기</a>
												</div>
												<!--end::Summary-->
											</div>
											<!--end::Wrapper-->
										</div>
										<!--end::Item-->
										<!--begin::Item-->
										<div class="carousel-item">
											<!--begin::Wrapper-->
											<div class="carousel-wrapper">
												<!--begin::Description-->
												<div class="d-flex flex-column flex-grow-1">
													<a href="#" class="fw-bold text-gray-900 text-hover-primary">설문명 추가 예정</a>
													<p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">설문 내용 추가 예정</p>
												</div>
												<!--end::Description-->
												<!--begin::Summary-->
												<div class="d-flex flex-stack pt-8">
													<span class="badge badge-light-primary fs-7 fw-bold me-2">설문 시작일</span>
													<a href="#" class="btn btn-light btn-sm btn-color-muted fs-7 fw-bold px-5">자세히 보기</a>
												</div>
												<!--end::Summary-->
											</div>
											<!--end::Wrapper-->
										</div>
										<!--end::Item-->
										<!--begin::Item-->
										<div class="carousel-item">
											<!--begin::Wrapper-->
											<div class="carousel-wrapper">
												<!--begin::Description-->
												<div class="d-flex flex-column flex-grow-1">
													<a href="#" class="fw-bold text-gray-900 text-hover-primary">설문명 추가 예정22</a>
													<p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">설문 내용 추가 예정</p>
												</div>
												<!--end::Description-->
												<!--begin::Summary-->
												<div class="d-flex flex-stack pt-8">
													<span class="badge badge-light-primary fs-7 fw-bold me-2">설문 시작일</span>
													<a href="#" class="btn btn-light btn-sm btn-color-muted fs-7 fw-bold px-5">자세히 보기</a>
												</div>
												<!--end::Summary-->
											</div>
											<!--end::Wrapper-->
										</div>
										<!--end::Item-->
									</div>
									<!--end::Carousel inner-->
								</div>
								<!--end::Carousel-->
							</div>
							<!--end::Body-->
						</div>
						<!--end::Security recent alerts-->
					</div>
					<!--end::Col-->
					<!--begin::Card-->
					<div class="col-xxl-6">
						<!--begin::Security recent alerts-->
						<div class="card card-xxl-stretch-50 mb-5 mb-xl-10">
							<!--begin::Body-->
							<div class="card-body pt-5">
								<!--begin::Carousel-->
								<div id="kt_security_recent_alerts" class="carousel carousel-custom carousel-stretch slide" data-bs-ride="carousel" data-bs-interval="8000">
									<!--begin::Heading-->
									<div class="d-flex flex-stack align-items-center flex-wrap">
										<h4 class="text-gray-500 fw-semibold mb-0 pe-2"><span class="badge text-bg-warning mb-2">투표</span></h4>
										<!--begin::Carousel Indicators-->
										<ol class="p-0 m-0 carousel-indicators carousel-indicators-dots">
											<li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="0" class="ms-1 active"></li>
											<li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="1" class="ms-1"></li>
											<li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="2" class="ms-1"></li>
										</ol>
										<!--end::Carousel Indicators-->
									</div>
									<!--end::Heading-->
									<!--begin::Carousel inner-->
									<div class="carousel-inner pt-6">
										<!--begin::Item-->
										<div class="carousel-item active">
											<!--begin::Wrapper-->
											<div class="carousel-wrapper">
												<!--begin::Description-->
												<div class="d-flex flex-column flex-grow-1">
													<a href="#" class="fs-5 fw-bold text-gray-900 text-hover-primary">{eventVO.eventNm }</a>
													<p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">{eventVO.eventCn }</p>
												</div>
												<!--end::Description-->
												<!--begin::Summary-->
												<div class="d-flex flex-stack pt-8">
													<span class="badge badge-light-warning fs-7 fw-bold me-2">{eventVO.eventBgngDt }</span>
													<a href="#" class="btn btn-sm btn-light">자세히 보기</a>
												</div>
												<!--end::Summary-->
											</div>
											<!--end::Wrapper-->
										</div>
										<!--end::Item-->
										<!--begin::Item-->
										<div class="carousel-item">
											<!--begin::Wrapper-->
											<div class="carousel-wrapper">
												<!--begin::Description-->
												<div class="d-flex flex-column flex-grow-1">
													<a href="#" class="fw-bold text-gray-900 text-hover-primary">투표명 추가 예정</a>
													<p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">투표 내용 추가 예정</p>
												</div>
												<!--end::Description-->
												<!--begin::Summary-->
												<div class="d-flex flex-stack pt-8">
													<span class="badge badge-light-primary fs-7 fw-bold me-2">투표 시작일</span>
													<a href="#" class="btn btn-light btn-sm btn-color-muted fs-7 fw-bold px-5">자세히 보기</a>
												</div>
												<!--end::Summary-->
											</div>
											<!--end::Wrapper-->
										</div>
										<!--end::Item-->
										<!--begin::Item-->
										<div class="carousel-item">
											<!--begin::Wrapper-->
											<div class="carousel-wrapper">
												<!--begin::Description-->
												<div class="d-flex flex-column flex-grow-1">
													<a href="#" class="fw-bold text-gray-900 text-hover-primary">설문명 추가 예정22</a>
													<p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">설문 내용 추가 예정</p>
												</div>
												<!--end::Description-->
												<!--begin::Summary-->
												<div class="d-flex flex-stack pt-8">
													<span class="badge badge-light-primary fs-7 fw-bold me-2">설문 시작일</span>
													<a href="#" class="btn btn-light btn-sm btn-color-muted fs-7 fw-bold px-5">자세히 보기</a>
												</div>
												<!--end::Summary-->
											</div>
											<!--end::Wrapper-->
										</div>
										<!--end::Item-->
									</div>
									<!--end::Carousel inner-->
								</div>
								<!--end::Carousel-->
							</div>
							<!--end::Body-->
						</div>
						<!--end::Security recent alerts-->
					</div>
					<!--end::Col-->
				</div>
				<!--begin::row-->
				<!--begin::설문-->
				<div class="card mb-5 mb-xl-10">
					<!--begin::Card header-->
					<div class="card-header">
						<!--begin::Heading-->
						<div class="card-title">
							<h3>설문</h3>
						</div>
						<!--end::Heading-->
						<!--begin::Toolbar-->
						<div class="card-toolbar">
							<a href="#" class="btn btn-sm btn-light-success my-1">자세히 보기</a>
						</div>
						<!--end::Toolbar-->
					</div>
					<!--end::Card header-->
					<!--begin::Card body-->
					<div class="card-body p-0">
						<!--begin::Table wrapper-->
						<div class="table-responsive">
							<!--begin::Table-->
							<table class="table align-middle table-row-bordered table-row-solid gy-4 gs-9">
								<!--begin::Thead-->
								<thead class="border-gray-200 fs-5 fw-semibold bg-lighten">
									<tr>
										<th class="min-w-250px">설문명</th>
										<th class="min-w-100px">상태</th>
										<th class="min-w-150px">설문기간</th>
										<th class="min-w-150px">작성자</th>
									</tr>
								</thead>
								<!--end::Thead-->
								<!--begin::Tbody-->
								<tbody class="fw-6 fw-semibold text-gray-600">
									<tr>
										<td>
											<a href="#" class="text-hover-primary text-gray-600">{eventVO.eventNm}</a>
										</td>
										<td>
											<span class="badge badge-light-success fs-7 fw-bold">{eventVO.eventSttsCd }</span>
										</td>
										<td>{eventVO.eventBgngDt} - {eventVO.eventEndDt}</td>
										<td>{eventVO.empId}</td>
									</tr>
									<tr>
										<td>
											<a href="#" class="text-hover-primary text-gray-600">설문명 하드코딩</a>
										</td>
										<td>
											<span class="badge badge-light-success fs-7 fw-bold">설문 상태코드 하드코딩</span>
										</td>
										<td>설문 시작일 하드코딩 - 설문 종료일 하드코딩</td>
										<td>작성자 하드코딩</td>
									</tr>
								</tbody>
								<!--end::Tbody-->
							</table>
							<!--end::Table-->
						</div>
						<!--end::Table wrapper-->
					</div>
					<!--end::Card body-->
				</div>
				<!--end::설문-->
				<!--begin::투표-->
				<div class="card mb-5 mb-xl-10">
					<!--begin::Card header-->
					<div class="card-header">
						<!--begin::Heading-->
						<div class="card-title">
							<h3>투표</h3>
						</div>
						<!--end::Heading-->
						<!--begin::Toolbar-->
						<div class="card-toolbar">
							<div class="card-toolbar">
								<a href="#" class="btn btn-sm btn-light-success my-1">자세히 보기</a>
							</div>
						</div>
						<!--end::Toolbar-->
					</div>
					<!--end::Card header-->
					<!--begin::Card body-->
					<div class="card-body p-0">
						<!--begin::Table wrapper-->
						<div class="table-responsive">
							<!--begin::Table-->
							<table class="table align-middle table-row-bordered table-row-solid gy-4 gs-9">
								<!--begin::Thead-->
								<thead class="border-gray-200 fs-5 fw-semibold bg-lighten">
									<tr>
										<th class="min-w-250px">투표명</th>
										<th class="min-w-100px">상태</th>
										<th class="min-w-150px">투표기간</th>
										<th class="min-w-150px">작성자</th>
									</tr>
								</thead>
								<!--end::Thead-->
								<!--begin::Tbody-->
								<tbody class="fw-6 fw-semibold text-gray-600">
									<tr>
										<td>
											<a href="#" class="text-hover-primary text-gray-600">{eventVO.eventNm}</a>
										</td>
										<td>
											<span class="badge badge-light-success fs-7 fw-bold">{eventVO.eventSttsCd }</span>
										</td>
										<td>{eventVO.eventBgngDt} - {eventVO.eventEndDt}</td>
										<td>{eventVO.empId}</td>
									</tr>
									<tr>
										<td>
											<a href="#" class="text-hover-primary text-gray-600">투표명 하드코딩</a>
										</td>
										<td>
											<span class="badge badge-light-success fs-7 fw-bold">투표상태코드 하드코딩</span>
										</td>
										<td>투표 시작일 하드코딩 - 투표 종료일 하드코딩</td>
										<td>작성자 하드코딩</td>
									</tr>
									
								</tbody>
								<!--end::Tbody-->
							</table>
							<!--end::Table-->
						</div>
						<!--end::Table wrapper-->
					</div>
					<!--end::Card body-->
				</div>
				<!--end::투표-->
			</div>
		</div>
	</div>
</div>

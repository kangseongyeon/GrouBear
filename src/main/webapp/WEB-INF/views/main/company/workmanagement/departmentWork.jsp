<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="${pageContext.request.contextPath }/resources/design/plugins/custom/fullcalendar/fullcalendar.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/design/plugins/custom/fullcalendar/fullcalendar.bundle.js"></script>
<script src="${pageContext.request.contextPath }/resources/design/js/custom/apps/calendar/calendar.js"></script>

<style>
/* 일반 캘린더 일정: 하늘색 */
.fc-event.calendar-event,
.fc-event.calendar-event * {
    background-color: #BFECFF !important;
    border-color: #BFECFF !important;
    color: #000000 !important;
}

/* 프로젝트 일정: 노란색 */
.fc-event.project-event, 
.fc-event.project-event * { 
    background-color: #F6EFBD !important;
    border-color: #F6EFBD !important;
    color: #000000 !important;
}

/* 전자결재 일정: 핑크색 */
.fc-event.elapr-event, 
.fc-event.elapr-event * { 
    background-color: #D0E8C5 !important;
    border-color: #D0E8C5 !important;
    color: #000000 !important;
}


</style>

<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>일정관리</h3>
		<h6>일정관리</h6>
	</div>
</div>

<!--begin::Main-->
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<!--begin::Content wrapper-->
	<div class="d-flex flex-column flex-column-fluid">
		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<!--begin::Content container-->
			<div id="kt_app_content_container" class="app-container container-fluid">
				 <div class="card card-flush mb-2" style="height: 70px;">
 	<div class="card-body d-flex" style="padding: 1em; align-items: center;">
 		<div class="menu-item">
 			<div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('All')">
				<span class="menu-icon">
					<i class="ki-duotone ki-abstract-8 me-3"><span class="path1"></span><span class="path2"></span></i>
				</span>
				<span class="menu-title">전체</span>
			</div>
		</div>
		<div class="start-0 top-0 w-3px rounded-2 ms-13" style="background-color: #acaaaa; height: 1.8em;"></div>
		
		<div class="menu-item">
			<div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('QSTNKND001')">
				<span class="menu-icon">
					<i class="ki-duotone ki-abstract-8 text-primary me-3"><span class="path1"></span><span class="path2"></span></i>
				</span>
				<span class="menu-title">개인 일정</span>
			</div>
		</div>
	
		<div class="menu-item">
			<div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('QSTNKND002')">
				<span class="menu-icon">
					<i class="ki-duotone ki-abstract-8 text-warning me-3"><span class="path1"></span><span class="path2"></span></i>
				</span>
				<span class="menu-title">프로젝트</span>
			</div>
		</div>
		
		<div class="menu-item">
			<div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('QSTNKND003')">
				<span class="menu-icon">
					<i class="ki-duotone ki-abstract-8 text-success me-3"><span class="path1"></span><span class="path2"></span></i>
				</span>
				<span class="menu-title">전자결재</span>
			</div>
		</div>
    </div>
</div>
<!-- Q&A 메뉴 시작 -->	
				<!--begin::Card-->
				<div class="card">
					<!--begin::Card header-->
					<div class="card-header">
						<h2 class="card-title fw-bold">캘린더</h2>
						<div class="card-toolbar" >
							<button class="btn btn-flex btn-primary" data-kt-calendar="add">
							<i class="ki-duotone ki-plus fs-2"></i>일정 추가</button>
						</div>
					</div>
					<!--end::Card header-->
					<!--begin::Card body-->
					<div class="card-body">
						<!-- 캘린더 시작 -->
						<div id="kt_calendar_app"></div>
						<!-- 캘린더 종료 -->
					</div>
					<!--end::Card body-->
				</div>
				<!--end::Card-->
				<!--전체 모달 시작-->
				<!--일정 추가 모달 시작-->
				<div class="modal fade" id="kt_modal_add_event" tabindex-="1" aria-hidden="true" data-bs-focus="false">
					<!--begin::Modal dialog-->
					<div class="modal-dialog modal-dialog-centered mw-650px">
						<!--begin::Modal content-->
						<div class="modal-content">
							<!--begin::Form-->
							<form class="form" action="/employee/calInsert.do" method="post" id="kt_modal_add_event_form">
								<!--begin::Modal header-->
								<div class="modal-header">
									<!--begin::Modal title-->
									<h2 class="fw-bold" data-kt-calendar="title">일정 추가</h2>
									<!--end::Modal title-->
									<!--begin::Close-->
									<div class="btn btn-icon btn-sm btn-active-icon-primary" id="kt_modal_add_event_close">
										<i class="ki-duotone ki-cross fs-1">
											<span class="path1"></span>
											<span class="path2"></span>
										</i>
									</div>
									<!--end::Close-->
								</div>
								<!--end::Modal header-->
								<!--begin::Modal body-->
								<div class="modal-body py-10 px-lg-17">
									<!--begin::Input group-->
									<div class="fv-row mb-9">
										<!--begin::Label-->
										<label class="fs-6 fw-semibold required mb-2">일정명</label>
										<!--end::Label-->
										<!--begin::Input-->
										<input type="text" class="form-control form-control-solid" placeholder="일정명을 입력해주세요." name="calendarNm" id="calendarNm" value="${calendarVO.calendarNm }"/>
										<!--end::Input-->
									</div>
									<!--end::Input group-->
									<!--begin::Input group-->
									<div class="fv-row mb-9">
										<!--begin::Label-->
										<label class="fs-6 fw-semibold mb-2">일정 설명</label>
										<!--end::Label-->
										<!--begin::Input-->
										<input type="text" class="form-control form-control-solid" placeholder="일정 설명을 입력해주세요." name="calendarCn" id="calendarCn" value="${calendarVO.calendarCn }"/>
										<!--end::Input-->
									</div>
									<!--end::Input group-->
									<!--begin::Input group-->
									<div class="fv-row mb-9">
										<!--begin::Label-->
										<label class="fs-6 fw-semibold mb-2">일정 장소</label>
										<!--end::Label-->
										<!--begin::Input-->
										<input type="text" class="form-control form-control-solid" placeholder="일정 장소를 입력해주세요." name="calendarDaddr" id="calendarDaddr" value="${calendarVO.calendarDaddr }"/>
										<!--end::Input-->
									</div>
									<!--end::Input group-->
									<!--begin::Input group-->
									<div class="fv-row mb-9">
										<!--begin::Checkbox-->
										<label class="form-check form-check-custom form-check-solid">
											<input class="form-check-input" type="checkbox" value="" id="kt_calendar_datepicker_allday" />
											<span class="form-check-label fw-semibold" for="kt_calendar_datepicker_allday">종일</span>
										</label>
										<!--end::Checkbox-->
									</div>
									<!--end::Input group-->
									<!--begin::Input group-->
									<div class="row row-cols-lg-2 g-10">
										<div class="col">
											<div class="fv-row mb-9">
												<!--begin::Label-->
												<label class="fs-6 fw-semibold mb-2 required">시작일</label>
												<!--end::Label-->
												<!--begin::Input-->
												<input class="form-control form-control-solid" name="calendarDt" placeholder="일정 시작일을 입력해주세요." id="kt_calendar_datepicker_start_date" value="${calendarVO.calendarDt }" />
												<%-- <input class="form-control form-control-solid" name="calendar_event_start_date" placeholder="Pick a start date" id="calendar_dt" value="${calendarVO.calendarDt }" /> --%>
												<!--end::Input-->
											</div>
										</div>
										<div class="col" data-kt-calendar="datepicker">
											<div class="fv-row mb-9">
												<!--begin::Label-->
												<label class="fs-6 fw-semibold mb-2">시작 시간</label>
												<!--end::Label-->
												<!--begin::Input-->
												<input class="form-control form-control-solid" name="calendarStartTime" placeholder="일정 시작 시간을 입력해주세요." id="kt_calendar_datepicker_start_time" value="${calendarVO.calendarStartTime }"/>
												<!--end::Input-->
											</div>
										</div>
									</div>
									<!--end::Input group-->
									<!--begin::Input group-->
									<div class="row row-cols-lg-2 g-10">
										<div class="col">
											<div class="fv-row mb-9">
												<!--begin::Label-->
												<label class="fs-6 fw-semibold mb-2 required">종료일</label>
												<!--end::Label-->
												<!--begin::Input-->
												<input class="form-control form-control-solid" name="calendarEndDt" placeholder="일정 종료일을 입력해주세요." id="kt_calendar_datepicker_end_date" value="${calendarVO.calendarEndDt }" />
												<!-- <input class="form-control form-control-solid" name="calendar_event_end_date" placeholder="Pick a end date" id="kt_calendar_datepicker_end_date" /> -->
												<%-- <input class="form-control form-control-solid" name="calendar_event_end_date" placeholder="Pick a end date" id="calendar_end_dt" value="${calendarVO.calendarEndDt }" /> --%>
												<!--end::Input-->
											</div>
										</div>
										<div class="col" data-kt-calendar="datepicker">
											<div class="fv-row mb-9">
												<!--begin::Label-->
												<label class="fs-6 fw-semibold mb-2">종료 시간</label>
												<!--end::Label-->
												<!--begin::Input-->
												<input class="form-control form-control-solid" name="calendarEndTime" placeholder="일정 종료 시간을 입력해주세요." id="kt_calendar_datepicker_end_time" value="${calendarVO.calendarEndTime }"/>
												<!--end::Input-->
											</div>
										</div>
									</div>
									<!--end::Input group-->
								</div>
								<!--end::Modal body-->
								<!--begin::Modal footer-->
								<div class="modal-footer flex-center">
									<!--begin::Button-->
									<button type="reset" id="kt_modal_add_event_cancel" class="btn btn-light me-3">취소</button>
									<!--end::Button-->
									<!--begin::Button-->
									<button type="submit" id="kt_modal_add_event_submit" class="btn btn-primary">
										<span class="indicator-label">저장</span>
										<span class="indicator-progress">저장 중
										<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
									</button>
									<!--end::Button-->
								</div>
								<!--end::Modal footer-->
							</form>
							<!--end::Form-->
						</div>
					</div>
				</div>
				<!-- 일정 추가 모달 종료-->
				<!-- 일정 상세보기 모달 시작 -->
				<div class="modal fade" id="kt_modal_view_event" tabindex="-1" data-bs-focus="false" aria-hidden="true">
					<!--begin::Modal dialog-->
					<div class="modal-dialog modal-dialog-centered mw-650px">
						<!--begin::Modal content-->
						<div class="modal-content">
							<!--begin::Modal header-->
							<div class="modal-header border-0 justify-content-end">
								<!--begin::Edit-->
								<div class="btn btn-icon btn-sm btn-color-gray-500 btn-active-icon-primary me-2" data-bs-toggle="tooltip" data-bs-dismiss="click" title="일정 수정" id="kt_modal_view_event_edit">
									<i class="ki-duotone ki-pencil fs-2">
										<span class="path1"></span>
										<span class="path2"></span>
									</i>
								</div>
								<!--end::Edit-->
								<!--begin::Edit-->
								<div class="btn btn-icon btn-sm btn-color-gray-500 btn-active-icon-danger me-2" data-bs-toggle="tooltip" data-bs-dismiss="click" title="일정 삭제" id="kt_modal_view_event_delete">
									<i class="ki-duotone ki-trash fs-2">
										<span class="path1"></span>
										<span class="path2"></span>
										<span class="path3"></span>
										<span class="path4"></span>
										<span class="path5"></span>
									</i>
								</div>
								<!--end::Edit-->
								<!--begin::Close-->
								<div class="btn btn-icon btn-sm btn-color-gray-500 btn-active-icon-primary" data-bs-toggle="tooltip" title="취소" data-bs-dismiss="modal">
									<i class="ki-duotone ki-cross fs-2x">
										<span class="path1"></span>
										<span class="path2"></span>
									</i>
								</div>
								<!--end::Close-->
							</div>
							<!--end::Modal header-->
							<!--begin::Modal body-->
							<div class="modal-body pt-0 pb-20 px-lg-17">
								<!--begin::Row-->
								<div class="d-flex">
									<!--begin::Icon-->
									<i class="ki-duotone ki-calendar-8 fs-1 text-muted me-5">
										<span class="path1"></span>
										<span class="path2"></span>
										<span class="path3"></span>
										<span class="path4"></span>
										<span class="path5"></span>
										<span class="path6"></span>
									</i>
									<!--end::Icon-->
									<div class="mb-9">
										<!--begin::Event name-->
										<div class="d-flex align-items-center mb-2">
											<span class="fs-3 fw-bold me-3" data-kt-calendar="event_name"></span>
											<span class="badge badge-light-success" data-kt-calendar="all_day"></span>
										</div>
										<!--end::Event name-->
										<!--begin::Event description-->
										<div class="fs-6" data-kt-calendar="event_description"></div>
										<!--end::Event description-->
									</div>
								</div>
								<!--end::Row-->
								<!--begin::Row-->
								<div class="d-flex align-items-center mb-2">
									<!--begin::Bullet-->
									<span class="bullet bullet-dot h-10px w-10px bg-success ms-2 me-7"></span>
									<!--end::Bullet-->
									<!--begin::Event start date/time-->
									<div class="fs-6">
										<span class="fw-bold">시작</span>
										<span data-kt-calendar="event_start_date"></span>
									</div>
									<!--end::Event start date/time-->
								</div>
								<!--end::Row-->
								<!--begin::Row-->
								<div class="d-flex align-items-center mb-9">
									<!--begin::Bullet-->
									<span class="bullet bullet-dot h-10px w-10px bg-danger ms-2 me-7"></span>
									<!--end::Bullet-->
									<!--begin::Event end date/time-->
									<div class="fs-6">
										<span class="fw-bold">종료</span>
										<span data-kt-calendar="event_end_date"></span>
									</div>
									<!--end::Event end date/time-->
								</div>
								<!--end::Row-->
								<!--begin::Row-->
								<div class="d-flex align-items-center">
									<!--begin::Icon-->
									<i class="ki-duotone ki-geolocation fs-1 text-muted me-5">
										<span class="path1"></span>
										<span class="path2"></span>
									</i>
									<!--end::Icon-->
									<!--begin::Event location-->
									<div class="fs-6" data-kt-calendar="event_location"></div>
									<!--end::Event location-->
								</div>
								<!--end::Row-->
							</div>
							<!--end::Modal body-->
						</div>
					</div>
				</div>
				<!-- 일정 상세보기 모달 종료 -->
				<!--전체 모달 종료-->
			</div>
			<!--end::Content container-->
		</div>
		<!--end::Content-->
	</div>
	<!--end::Content wrapper-->
	<!--begin::Footer-->
	<div id="kt_app_footer" class="app-footer">
		<!--begin::Footer container-->
		<div class="app-container container-fluid d-flex flex-column flex-md-row flex-center flex-md-stack py-3">
		</div>
		<!--end::Footer container-->
	</div>
	<!--end::Footer-->
</div>
<!--end:::Main-->

<script type="text/javascript">
$(function () {
	
	
	$(".fc-daygrid-day-frame").on("click", function () {
		console.log("!!");
	});
	
});
</script>

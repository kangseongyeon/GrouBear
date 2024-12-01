<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


<style>
a {
  color: rgb(21 21 21);
  text-decoration: none;
}
a:hover { 
  color: rgb(57 196 215); 
  text-decoration: none;
}
.txt_line {
   width:22em;
   padding:0 5px;
   overflow:hidden;
   text-overflow:ellipsis;
   white-space:nowrap;
}
.numShadow {
	margin-left: -30px;
    width: 40px;
    height: 5px;
    background-color: gray;
    border-radius: 50%;
    opacity: 60%;
    position: absolute;
    margin-top: 25%;
}
</style>


<!-- 달력 관련 -->
<style>
/* 일반 캘린더 일정: 하늘색 */
.fc-event.calendar-event, .fc-event.calendar-event * {
	background-color: #BFECFF !important;
	border-color: #BFECFF !important;
	color: #000000 !important;
}

/* 프로젝트 일정: 노란색 */
.fc-event.project-event, .fc-event.project-event * {
	background-color: #F6EFBD !important;
	border-color: #F6EFBD !important;
	color: #000000 !important;
}

/* 전자결재 일정: 핑크색 */
.fc-event.elapr-event, .fc-event.elapr-event * {
	background-color: #FFE1FF !important;
	border-color: #FFE1FF !important;
	color: #000000 !important;
}
</style>
<link
	href="${pageContext.request.contextPath }/resources/design/plugins/custom/fullcalendar/fullcalendar.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath }/resources/design/plugins/custom/fullcalendar/fullcalendar.bundle.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/design/js/custom/apps/calendar/comCalendar.js"></script>



<div style="margin-bottom: 20px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h1>홈피드</h1>
		<!-- <h6></h6> -->
	</div>
</div>

<!-- div 중에 row가 있는 곳이 한 줄이고, row 내부에 card가 하나의 영역이며,
	 row는 kt_app_content_container 클래스가 있는 div 내부에 넣어야 합니다. 참고해주세용.
-->

<!-- 참고 예시 : (아래는 2개의 카드가 들어가있는 1개의 꽉찬 row임) (그리드 영역은 6:6)
	<div class="row gx-5 gx-xl-10 mb-xl-10">
	
		<div class="col-md-6 col-lg-6 col-xl-6 col-xxl-3 mb-10">
			<div class="card card-flush h-md-50 mb-5 mb-xl-10">
				<div class="card-header pt-5">
				</div>
				<div class="card-body pt-2 pb-4 d-flex align-items-center">
				</div>
			</div>
		</div>
		
		<div class="col-md-6 col-lg-6 col-xl-6 col-xxl-3 mb-10">
			<div class="card card-flush h-md-50 mb-5 mb-xl-10">
				<div class="card-header pt-5">
				</div>
				<div class="card-body pt-2 pb-4 d-flex align-items-center">
				</div>
			</div>
		</div>
		
	</div>
-->

<div class="app-main flex-column flex-row-fluid mb-10" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content  flex-column-fluid ">
			<div id="kt_app_content_container" class="app-container  container-fluid ">

				<!-- 이 안부터 row넣기 시작 -->

				<!--프로젝트 시작-->
				<div class="row gx-5 gx-xl-10 mb-xl-10">
					<div class="col-xxl-6">
						<div class="card card-flush h-md-100">


							<div class="card-header pt-7">
								<h3 class="card-title align-items-start flex-column">
									<span class="card-label fw-bold text-gray-800"> <font
										style="vertical-align: inherit;"> <font
											style="vertical-align: inherit;">프로젝트</font>
									</font>
									</span>
								</h3>
							</div>



							<div class="card-body pt-6">
								<div class="table-responsive">
									<table
										class="table table-row-dashed align-middle gs-0 gy-3 my-0">
										<thead>
											<tr class="fs-7 fw-bold text-gray-500 border-bottom-0">
												<th class="p-0 pb-3 min-w-150px text-center"
													style="width: 150px;"><font
													style="vertical-align: inherit;"> <font
														style="vertical-align: inherit;">제목</font>
												</font></th>
												<th class="p-0 pb-3 min-w-90px text-center"><font
													style="vertical-align: inherit;"> <font
														style="vertical-align: inherit;">담당</font>
												</font></th>
												<th class="p-0 pb-3 min-w-130px text-center pe-10"><font
													style="vertical-align: inherit;"> <font
														style="vertical-align: inherit;">참가자</font>
												</font></th>
												<th class="p-0 pb-3 w-130px text-center"><font
													style="vertical-align: inherit;"> <font
														style="vertical-align: inherit;">자세히</font>
												</font></th>
											</tr>
										</thead>
										<tbody>
										<tbody class="fs-6">
											<c:set value="${proCardList }" var="proCardList" />
											<c:choose>
												<c:when test="${empty proCardList }">
													<tr>
														<td colspan="4" class="text-center"><a
															href="/employee/project.do"> <img
																src="/resources/file/image/cloudEmpty.png" class="w-50" />
																<h3 class=" fw-bolder text-dark">프로젝트가 존재하지 않습니다.</h3>
														</a></td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach items="${proCardList }" var="projectVO" begin="0" end="4" step="1">
														<tr>
															<td class="d-flex"><span data-kt-element="bullet"
																class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-4 bg-warning mt-3">
															</span>
																<div class="align-items-center">
																	<div class="d-flex justify-content-start flex-column">
																		<a
																			href="/employee/canbanList.do?proNo=${projectVO.proNo }"
																			class="text-gray-800 text-hover-primary"
																			style="display: block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px;">
																			<font style="vertical-align: inherit;"> <font
																				style="vertical-align: inherit;"><h4>${projectVO.proNm }</h4></font>
																		</font>
																		</a>
																	</div>
																	<span
																		class="badge badge-light-secondary mb-2 py-2 px-4 fs-7">
																		<font style="vertical-align: inherit;"> <font
																			style="vertical-align: inherit;">${projectVO.proStartDt }<br />
																				${projectVO.proEndDt }
																		</font>
																	</font>
																	</span>
																</div></td>
															<td class="text-center pe-0"><span
																class="badge badge-light-info mb-2 fw-bold fs-6">
																	<font style="vertical-align: inherit;"> <font
																		style="vertical-align: inherit;">${projectVO.empNm }</font>
																</font>
															</span></td>
															<td class="text-center pe-12">
																<div class="d-flex flex-stack flex-wrap mb-2">
																	<div class="symbol-group symbol-hover my-1">
																		<c:forEach
																			items="${projectVO.participantImgFileUrlsList}"
																			var="participantImgFileUrl" varStatus="status">
																			<c:choose>
																				<c:when
																					test="${status.index lt projectVO.participantEmpNamesList.size()}">
																					<div class="symbol symbol-30px symbol-circle"
																						data-bs-toggle="tooltip"
																						title="${projectVO.participantEmpNamesList[status.index] }"
																						style="overflow: hidden;">
																						<img
																							alt="${projectVO.participantEmpNamesList[status.index] }"
																							src="/upload/${participantImgFileUrl.trim() }"
																							style="object-fit: cover;">
																					</div>
																				</c:when>
																			</c:choose>
																		</c:forEach>
																	</div>
																</div>
															</td>
															<td><a href="#"
																class="btn btn-sm btn-light-success btn-flex btn-center btn-active-light-primary"
																data-kt-menu-trigger="click"
																data-kt-menu-placement="bottom-end">자세히 보기 <i
																	class="ki-duotone ki-down fs-5 ms-1"></i></a>
																<div
																	class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4"
																	data-kt-menu="true">
																	<div class="menu-item px-3">
																		<a
																			href="/employee/canbanList.do?proNo=${projectVO.proNo }"
																			class="menu-link px-3">칸반보드</a>
																	</div>
																	<div class="menu-item px-3">
																		<a
																			href="/employee/ganttList.do?proNo=${projectVO.proNo }"
																			class="menu-link px-3">간트차트</a>
																	</div>
																</div></td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
	
					<!--캘린더 시작-->
					<div class="col-lg-12 col-xl-12 col-xxl-6 mb-5 mb-xl-0">
						<div class="card card-flush overflow-hidden h-md-100">
	
							<div
								class="card-body d-flex justify-content-between flex-column pb-1 px-5"
								style="height: 600px;">
								<!-- 캘린더 시작 -->
								<div id="kt_calendar_app"></div>
								<!-- 캘린더 종료 -->
							</div>
						</div>
	
						<!--전체 모달 시작-->
						<!--일정 추가 모달 시작-->
						<div class="modal fade" id="kt_modal_add_event" tabindex-="1"
							aria-hidden="true" data-bs-focus="false">
							<!--begin::Modal dialog-->
							<div class="modal-dialog modal-dialog-centered mw-650px">
								<!--begin::Modal content-->
								<div class="modal-content">
									<!--begin::Form-->
									<form class="form" action="/employee/calInsert.do" method="post"
										id="kt_modal_add_event_form">
										<!--begin::Modal header-->
										<div class="modal-header">
											<!--begin::Modal title-->
											<h2 class="fw-bold" data-kt-calendar="title">일정 추가</h2>
											<!--end::Modal title-->
											<!--begin::Close-->
											<div class="btn btn-icon btn-sm btn-active-icon-primary"
												id="kt_modal_add_event_close">
												<i class="ki-duotone ki-cross fs-1" data-bs-dismiss="modal"> <span class="path1"></span>
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
												<input type="text" class="form-control form-control-solid"
													placeholder="일정명을 입력해주세요." name="calendarNm" id="calendarNm"
													value="${calendarVO.calendarNm }" />
												<!--end::Input-->
											</div>
											<!--end::Input group-->
											<!--begin::Input group-->
											<div class="fv-row mb-9">
												<!--begin::Label-->
												<label class="fs-6 fw-semibold mb-2">일정 설명</label>
												<!--end::Label-->
												<!--begin::Input-->
												<input type="text" class="form-control form-control-solid"
													placeholder="일정 설명을 입력해주세요." name="calendarCn"
													id="calendarCn" value="${calendarVO.calendarCn }" />
												<!--end::Input-->
											</div>
											<!--end::Input group-->
											<!--begin::Input group-->
											<div class="fv-row mb-9">
												<!--begin::Label-->
												<label class="fs-6 fw-semibold mb-2">일정 장소</label>
												<!--end::Label-->
												<!--begin::Input-->
												<input type="text" class="form-control form-control-solid"
													placeholder="일정 장소를 입력해주세요." name="calendarDaddr"
													id="calendarDaddr" value="${calendarVO.calendarDaddr }" />
												<!--end::Input-->
											</div>
											<!--end::Input group-->
											<!--begin::Input group-->
											<div class="fv-row mb-9">
												<!--begin::Checkbox-->
												<label class="form-check form-check-custom form-check-solid">
													<input class="form-check-input" type="checkbox" value=""
													id="kt_calendar_datepicker_allday" /> <span
													class="form-check-label fw-semibold"
													for="kt_calendar_datepicker_allday">종일</span>
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
														<input class="form-control form-control-solid"
															name="calendarDt" placeholder="일정 시작일을 입력해주세요."
															id="kt_calendar_datepicker_start_date"
															value="${calendarVO.calendarDt }" />
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
														<input class="form-control form-control-solid"
															name="calendarStartTime" placeholder="일정 시작 시간을 입력해주세요."
															id="kt_calendar_datepicker_start_time"
															value="${calendarVO.calendarStartTime }" />
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
														<input class="form-control form-control-solid"
															name="calendarEndDt" placeholder="일정 종료일을 입력해주세요."
															id="kt_calendar_datepicker_end_date"
															value="${calendarVO.calendarEndDt }" />
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
														<input class="form-control form-control-solid"
															name="calendarEndTime" placeholder="일정 종료 시간을 입력해주세요."
															id="kt_calendar_datepicker_end_time"
															value="${calendarVO.calendarEndTime }" />
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
											<button type="submit" id="kt_modal_add_event_submit"
												class="btn btn-primary">
												<span class="indicator-label">저장</span> <span
													class="indicator-progress">저장 중 <span
													class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
											</button>
											<button type="reset" id="kt_modal_add_event_cancel"
												class="btn btn-light me-3">취소</button>
											<!--end::Button-->
											<!--begin::Button-->
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
						<div class="modal fade" id="kt_modal_view_event" tabindex="-1"
							data-bs-focus="false" aria-hidden="true">
							<!--begin::Modal dialog-->
							<div class="modal-dialog modal-dialog-centered mw-650px">
								<!--begin::Modal content-->
								<div class="modal-content">
									<!--begin::Modal header-->
									<div class="modal-header border-0 justify-content-end">
										<!--begin::Edit-->
										<div
											class="btn btn-icon btn-sm btn-color-gray-500 btn-active-icon-primary me-2"
											data-bs-toggle="tooltip" data-bs-dismiss="click" title="일정 수정"
											id="kt_modal_view_event_edit">
											<i class="ki-duotone ki-pencil fs-2"> <span class="path1"></span>
												<span class="path2"></span>
											</i>
										</div>
										<!--end::Edit-->
										<!--begin::Edit-->
										<div
											class="btn btn-icon btn-sm btn-color-gray-500 btn-active-icon-danger me-2"
											data-bs-toggle="tooltip" data-bs-dismiss="click" title="일정 삭제"
											id="kt_modal_view_event_delete">
											<i class="ki-duotone ki-trash fs-2"> <span class="path1"></span>
												<span class="path2"></span> <span class="path3"></span> <span
												class="path4"></span> <span class="path5"></span>
											</i>
										</div>
										<!--end::Edit-->
										<!--begin::Close-->
										<div
											class="btn btn-icon btn-sm btn-color-gray-500 btn-active-icon-primary"
											data-bs-toggle="tooltip" title="취소" data-bs-dismiss="modal">
											<i class="ki-duotone ki-cross fs-2x"> <span class="path1"></span>
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
												<span class="path1"></span> <span class="path2"></span> <span
												class="path3"></span> <span class="path4"></span> <span
												class="path5"></span> <span class="path6"></span>
											</i>
											<!--end::Icon-->
											<div class="mb-9">
												<!--begin::Event name-->
												<div class="d-flex align-items-center mb-2">
													<span class="fs-3 fw-bold me-3"
														data-kt-calendar="event_name"></span> <span
														class="badge badge-light-success"
														data-kt-calendar="all_day"></span>
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
											<span
												class="bullet bullet-dot h-10px w-10px bg-success ms-2 me-7"></span>
											<!--end::Bullet-->
											<!--begin::Event start date/time-->
											<div class="fs-6">
												<span class="fw-bold">시작</span> <span
													data-kt-calendar="event_start_date"></span>
											</div>
											<!--end::Event start date/time-->
										</div>
										<!--end::Row-->
										<!--begin::Row-->
										<div class="d-flex align-items-center mb-9">
											<!--begin::Bullet-->
											<span
												class="bullet bullet-dot h-10px w-10px bg-danger ms-2 me-7"></span>
											<!--end::Bullet-->
											<!--begin::Event end date/time-->
											<div class="fs-6">
												<span class="fw-bold">종료</span> <span
													data-kt-calendar="event_end_date"></span>
											</div>
											<!--end::Event end date/time-->
										</div>
										<!--end::Row-->
										<!--begin::Row-->
										<div class="d-flex align-items-center">
											<!--begin::Icon-->
											<i class="ki-duotone ki-geolocation fs-1 text-muted me-5">
												<span class="path1"></span> <span class="path2"></span>
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
					<!--캘린더 종료-->
				</div>


				<div class="row g-5 g-xxl-10">

					<div class="col-md-5 col-lg-5 col-xl-5 col-xxl-3 mb-10">
						
						<!-- 증명서 위젯 시작 -->
						<div class="card card-flush h-lg-100 mb-5 mb-xl-10">
						
							<div class="card-header pt-9 ps-12">
								<div class="card-title d-flex flex-column">
									<div class="d-flex align-items-center ms-2">
										<span class="fs-4 fw-semibold text-gray-500 me-5 align-self-start">
											<i class="ki-duotone ki-tablet-text-up fs-2tx mt-1">
											 <span class="path1"></span>  
											 <span class="path2"></span>
											</i>
										</span>
										<span class="fs-2x fw-bold text-gray-900 me-2 lh-1 ls-n2">
											<a href="/company/provedocAplyList.do">증명서 요청관리</a>
										</span>
									</div> 
								</div>  
							</div> 

							<div class="card-body pt-2 pb-0">
								
								<div class="fs-3 fw-semibold ms-5">
									<div class="d-flex justify-content-center py-3">
										<div class="bullet w-15px h-8px rounded-2 bg-danger me-3 mt-3"></div>
										<div class="text-gray-700 ms-2 me-10 fs-2">미처리 발급요청</div>
									</div>
									<div class="fw-bolder text-gray-700 fs-1 me-4 d-flex justify-content-center"> 
										<span class="fs-5hx">
											<a href="/company/provedocAplyList.do">
												${provedocCount.prdocAprvN }
											</a>	
										</span>
										<span class="text-gray-800 ms-3 mt-13">건</span>
										<span class="numShadow"></span>
									</div>
								</div>
								
							</div>
						
						</div>
						<!-- 증명서 위젯 끝 -->
						 
					</div>
	

					<div class="col-xl-9 mb-5 mb-xxl-10">

						<div class="card card-flush h-xl-80">
							<div class="card-body pt-3">
								<div class="d-flex flex-column gap-10">
									<div class="table-responsive">
										<table class="table align-middle table-row-dashed fs-6 gy-5">
											<thead>
												<tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-3">
													<td><h4 class="text-gray-700">추가된 인사정보</h4></td>
												</tr>
											</thead>
											<tbody class="text-gray-600 fw-semibold">
											<c:choose>
												<c:when test="${empty empAllList }">
													<tr>
														<td colspan="7" class="text-center pt-5">
															사원이 존재하지 않습니다.
														</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach items="${empAllList }" var="empList" begin="0" step="1" end="2">
														<tr>
															<td class="d-flex align-items-center py-3">
																<div class="symbol symbol-circle symbol-50px overflow-hidden me-3">
																	<a href="apps/user-management/users/view.html">
																		<span class="symbol-label">
																			<img src="/upload/${empList.imgFileUrl }" alt="" class="w-100" />
																		</span>
																	</a>
																</div>
																<div class="d-flex flex-column">
																    <div class="text-gray-800 text-hover-primary mb-1" onclick="this.closest('form').submit();" style="cursor: pointer;">
																    	<a href="/information/empdetail.do?empId=${empList.empId }">
																        ${empList.empNm}
																        </a>
																    </div>
																</div>
															</td>
															<td>${empList.empNo }</td>
															<td>
																<div class="badge badge-light-success fw-bold">${empList.deptCd }</div>
															</td>
															<td>
																<div class="badge badge-light-primary fw-bold">${empList.jbgdCd }</div>
															</td>
															<td>${empList.empTelno }</td>
														</tr>
													</c:forEach>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

					</div>
					
				</div>
	
	
				<div class="row gx-5 gx-xl-10 mb-xl-10">
	
					<!-- 긴급 문서함 -->
					<div class="col-md-6 col-lg-6 col-xl-6 col-xxl-3 mb-10">
						<div class="card card-flush px-5 py-3 h-md-50 mb-5 mb-xl-10">
							<div id="kt_security_recent_alerts" class="carousel carousel-custom carousel-stretch slide" data-bs-ride="carousel" data-bs-interval="4000">
				                <div class="d-flex flex-stack align-items-center flex-wrap">
				                    <h4 class="text-gray-500 fw-semibold mb-0 pe-2"><span class="badge badge-light-danger mb-2">긴급 문서함</span></h4>
				                    <ol class="p-0 m-0 carousel-indicators carousel-indicators-dots">
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="0" class="ms-1 active"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="1" class="ms-1"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="2" class="ms-1"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="3" class="ms-1"></li>
				                    </ol>
				                </div>
				                <div class="carousel-inner">
				                	<c:set value="${emrgList }" var="elaprEmrgList"/>
									<c:choose>
										<c:when test="${empty elaprEmrgList }">
											<tr>
												<div class="d-flex flex-column flex-center ">
													<a href="/company/comElaprEmrg.do">
								                	    <img src="/resources/file/image/cloudEmpty.png" class="mw-150px"/>
								                    	<div class=" fw-bolder text-dark">긴급 문서가 존재하지 않습니다.</div>
								                    </a>
		              				 			</div>
											</tr>
										</c:when>
										<c:otherwise>
						                    <c:forEach items="${emrgList }" var="elaprVO" varStatus="status">
							                    <div class="carousel-item ${status.first ? 'active' : ''  }">
							                        <div class="carousel-wrapper">
							                            <div class="d-flex flex-column flex-grow-1">
							                                <a href="/company/elaprDetail.do?elaprNo=${elaprVO.elaprNo }" class="fs-5 fw-bold text-gray-900 text-hover-primary">${elaprVO.elaprNm }</a>
							                                <p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">기안자 | ${elaprVO.empNm }</p>
							                            </div>
							                            <div class="d-flex flex-stack pt-8">
							                                <div class="text-gray-700 fw-semibold fs-6 me-2">기안일 | ${elaprVO.elaprBgngDt }</div>
							                                <a href="/company/elaprDetail.do?elaprNo=${elaprVO.elaprNo }"  class="btn btn-sm btn-light">자세히 보기</a>
							                            </div>
							                        </div>
							                    </div>
						                    </c:forEach>
					                    </c:otherwise>
				                    </c:choose>
				                </div>
				            </div>
						</div>
						
						<!-- 참조 문서함 -->
						<div class="card card-flush px-5 py-3 h-md-50 mb-5 mb-xl-10">
							<div id="kt_security_recent_alerts" class="carousel carousel-custom carousel-stretch slide" data-bs-ride="carousel" data-bs-interval="4000">
				                <div class="d-flex flex-stack align-items-center flex-wrap">
				                    <h4 class="text-gray-500 fw-semibold mb-0 pe-2"><span class="badge badge-light-info mb-2">참조 문서함</span></h4>
				                    <ol class="p-0 m-0 carousel-indicators carousel-indicators-dots">
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="0" class="ms-1 active"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="1" class="ms-1"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="2" class="ms-1"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="3" class="ms-1"></li>
				                    </ol>
				                </div>
				                <div class="carousel-inner">
				                	<c:set value="${rerncList }" var="elaprRerncList"/>
									<c:choose>
										<c:when test="${empty elaprRerncList }">
											<tr>
												<div class="d-flex flex-column flex-center ">
													<a href="/company/comElaprRernc.do">
								                	    <img src="/resources/file/image/cloudEmpty.png" class="mw-150px"/>
								                    	<div class=" fw-bolder text-dark">참조 문서가 존재하지 않습니다.</div>
								                    </a>
		              				 			</div>
											</tr>
										</c:when>
										<c:otherwise>
						                    <c:forEach items="${rerncList }" var="elaprVO" varStatus="status">
							                    <div class="carousel-item ${status.first ? 'active' : ''  }">
							                        <div class="carousel-wrapper">
							                            <div class="d-flex flex-column flex-grow-1">
							                                <a href="/company/elaprDetail.do?elaprNo=${elaprVO.elaprNo }" class="fs-5 fw-bold text-gray-900 text-hover-primary">${elaprVO.elaprNm }</a>
							                                <p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">기안자 | ${elaprVO.empNm }</p>
							                            </div>
							                            <div class="d-flex flex-stack pt-8">
							                                <div class="text-gray-700 fw-semibold fs-6 me-2">기안일 | ${elaprVO.elaprBgngDt }</div>
							                                <a href="/company/elaprDetail.do?elaprNo=${elaprVO.elaprNo }"  class="btn btn-sm btn-light">자세히 보기</a>
							                            </div>
							                        </div>
							                    </div>
						                    </c:forEach>
					                    </c:otherwise>
				                    </c:choose>
				                </div>
				            </div>
						</div>
						<!-- 참조 문서함 -->
					</div>
	
	
					<div class="col-md-6 col-lg-6 col-xl-6 col-xxl-3 mb-10">
						<!-- 전체 문서함 -->
						<div class="card card-flush px-5 py-3 h-md-50 mb-5 mb-xl-10">
							<div id="kt_security_recent_alerts" class="carousel carousel-custom carousel-stretch slide" data-bs-ride="carousel" data-bs-interval="4000">
				                <div class="d-flex flex-stack align-items-center flex-wrap">
				                    <h4 class="text-gray-500 fw-semibold mb-0 pe-2"><span class="badge badge-light-warning mb-2">전체 문서함</span></h4>
				                    <ol class="p-0 m-0 carousel-indicators carousel-indicators-dots">
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="0" class="ms-1 active"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="1" class="ms-1"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="2" class="ms-1"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="3" class="ms-1"></li>
				                    </ol>
				                </div>
				                <div class="carousel-inner">
				                	<c:set value="${allList }" var="elaprAllList"/>
									<c:choose>
										<c:when test="${empty elaprAllList }">
											<tr>
												<div class="d-flex flex-column flex-center ">
													<a href="/company/comElaprAll.do">
								                	    <img src="/resources/file/image/cloudEmpty.png" class="mw-150px"/>
								                    	<div class=" fw-bolder text-dark">문서가 존재하지 않습니다.</div>
								                    </a>
		              				 			</div>
											</tr>
										</c:when>
										<c:otherwise>
						                    <c:forEach items="${allList }" var="elaprVO" varStatus="status">
							                    <div class="carousel-item ${status.first ? 'active' : ''  }">
							                        <div class="carousel-wrapper">
														<c:if test="${elaprVO.elaprSttsCd eq 'APRZ001' }">
								                        	<h4 class="text-gray-500 fw-semibold mb-0 pe-2">
																<span class="badge badge-light-warning">진행</span>
															</h4>
														</c:if>
														<c:if test="${elaprVO.elaprSttsCd eq 'APRZ002' }">
								                        	<h4 class="text-gray-500 fw-semibold mb-0 pe-2">
																<span class="badge badge-light-info">완료</span>
															</h4>
														</c:if>
														<c:if test="${elaprVO.elaprSttsCd eq 'APRZ003' }">
								                        	<h4 class="text-gray-500 fw-semibold mb-0 pe-2">
																<span class="badge badge-light-danger">반려</span>
															</h4>
														</c:if>
							                            <div class="d-flex flex-column flex-grow-1">
							                                <a href="/company/elaprDetail.do?elaprNo=${elaprVO.elaprNo }" class="fs-5 fw-bold text-gray-900 text-hover-primary">${elaprVO.elaprNm }</a>
							                                <p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">기안자 | ${elaprVO.empNm }</p>
							                            </div>
							                            <div class="d-flex flex-stack pt-8">
							                                <div class="text-gray-700 fw-semibold fs-6 me-2">기안일 | ${elaprVO.elaprBgngDt }</div>
							                                <a href="/company/elaprDetail.do?elaprNo=${elaprVO.elaprNo }"  class="btn btn-sm btn-light">자세히 보기</a>
							                            </div>
							                        </div>
							                    </div>
						                    </c:forEach>
				                   	 	</c:otherwise>
				                    </c:choose>
				                </div>
				            </div>
						</div>
						<!-- 전체 문서함 -->
						
						<!-- 열람 문서함 -->
						<div class="card card-flush px-5 py-3 h-md-50 mb-5 mb-xl-10">
							<div id="kt_security_recent_alerts" class="carousel carousel-custom carousel-stretch slide" data-bs-ride="carousel" data-bs-interval="4000">
				                <div class="d-flex flex-stack align-items-center flex-wrap">
				                    <h4 class="text-gray-500 fw-semibold mb-0 pe-2"><span class="badge badge-light-success mb-2">열람 문서함</span></h4>
				                    <ol class="p-0 m-0 carousel-indicators carousel-indicators-dots">
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="0" class="ms-1 active"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="1" class="ms-1"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="2" class="ms-1"></li>
				                        <li data-bs-target="#kt_security_recent_alerts" data-bs-slide-to="3" class="ms-1"></li>
				                    </ol>
				                </div>
				                <div class="carousel-inner">
				                	<c:set value="${prslList }" var="elaprPrslList"/>
									<c:choose>
										<c:when test="${empty elaprPrslList }">
											<tr>
												<div class="d-flex flex-column flex-center ">
													<a href="/company/comElaprPrsl.do">
								                	    <img src="/resources/file/image/cloudEmpty.png" class="mw-150px"/>
								                    	<div class=" fw-bolder text-dark">열람 문서가 존재하지 않습니다.</div>
								                    </a>
		              				 			</div>
											</tr>
										</c:when>
										<c:otherwise>
						                    <c:forEach items="${prslList }" var="elaprVO" varStatus="status">
							                    <div class="carousel-item ${status.first ? 'active' : ''  }">
							                        <div class="carousel-wrapper">
							                            <div class="d-flex flex-column flex-grow-1">
							                                <a href="/company/elaprDetail.do?elaprNo=${elaprVO.elaprNo }" class="fs-5 fw-bold text-gray-900 text-hover-primary">${elaprVO.elaprNm }</a>
							                                <p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">기안자 | ${elaprVO.empNm }</p>
							                            </div>
							                            <div class="d-flex flex-stack pt-8">
							                                <div class="text-gray-700 fw-semibold fs-6 me-2">기안일 | ${elaprVO.elaprBgngDt }</div>
							                                <a href="/company/elaprDetail.do?elaprNo=${elaprVO.elaprNo }"  class="btn btn-sm btn-light">자세히 보기</a>
							                            </div>
							                        </div>
							                    </div>
						                    </c:forEach>
				                    	</c:otherwise>
				                    </c:choose>
				                </div>
				            </div>
						</div>
						<!-- 열람 문서함 -->
					</div>
					<!--end::Col-->
	
					<!--begin::Col-->
					<div class="col-lg-12 col-xl-12 col-xxl-6 mb-5 mb-xl-0">
						<!--begin::Chart widget 3-->
						<div class="card card-flush overflow-hidden h-md-100">
							<!--begin::Header-->
							<div class="card-header py-5">
								<h3 class="card-title align-items-start flex-column">
									<a href="/company/communityCompany.do"> <span
										class="card-label fw-bold text-gray-900">커뮤니티<span
											class="text-gray-500 mt-1 fw-semibold fs-6"
											style="margin-left: 10px;">회사 공지사항</span></span>
									</a>
								</h3>
								<!--begin::Title-->
								<!--end::Title-->
							</div>
							<!--end::Header-->
							<div class="card-body py-4">
								<table class="table align-middle table-row-dashed fs-6 gy-5"
									id="communityTable">
									<thead>
										<tr
											class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
											<th class="min-w-50px"></th>
											<th class="min-w-200px">제목</th>
											<th class="min-w-145px">작성자</th>
											<th class="min-w-100px">작성일</th>
											<th class="min-w-50px">조회수</th>
										</tr>
									</thead>
									<tbody class="text-gray-600 fw-semibold">
										<c:choose>
											<c:when test="${empty comCmntyList }">
												<tr>
													<td colspan="5">게시물이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${comCmntyList}" var="freeBoardList">
													<c:if test="${freeBoardList.cmntyDelYn eq 'N' }">
														<c:choose>
															<c:when test="${freeBoardList.cmntyNoticeYn == 'Y'}">
																<tr data-id="${freeBoardList.cmntyNo}"
																	data-check-value="${freeBoardList.cmntyNoticeYn}">
																	<td class="CMlist"><p style="color: #F06445">[공지]</p></td>
																	<td class="CMlist"><a
																		href="/employee/communityDetail.do?cmntyNo=${freeBoardList.cmntyNo }">
																			<p>${freeBoardList.cmntyTtl}</p>
																	</a></td>
																	<td class="CMlist"><p>${freeBoardList.empNm}</p></td>
																	<td class="CMlist"><p>${freeBoardList.cmntyRegDt}</p>
																	</td>

																	<td class="CMlist"><p>${freeBoardList.cmntyInqCnt}</p></td>
																</tr>
															</c:when>
														</c:choose>
													</c:if>
												</c:forEach>
												<c:forEach items="${dataList}" var="freeBoardList">
													<c:if test="${freeBoardList.cmntyDelYn eq 'N' }">
														<c:choose>
															<c:when test="${freeBoardList.cmntyNoticeYn != 'Y'}">
																<tr data-id="${freeBoardList.cmntyNo}"
																	data-check-value="${freeBoardList.cmntyNoticeYn}">
																	<td class="CMlist"><p>&nbsp;</p></td>
																	<td class="CMlist"><a
																		href="/employee/communityDetail.do?cmntyNo=${freeBoardList.cmntyNo }">
																			<p>${freeBoardList.cmntyTtl}</p>
																	</a></td>
																	<td class="CMlist"><p>${freeBoardList.empNm}</p></td>
																	<td class="CMlist"><p>${freeBoardList.cmntyRegDt}</p></td>
																	<td class="CMlist"><p>${freeBoardList.cmntyInqCnt}</p></td>
																</tr>
															</c:when>
														</c:choose>
													</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
						<!--end::Chart widget 3-->
					</div>
					<!--end::Col-->
				</div>
				<!--end::Row-->
	
	
				<!-- 이 안부터 row넣기 끝 -->

			</div>
		</div>
	</div>
</div>


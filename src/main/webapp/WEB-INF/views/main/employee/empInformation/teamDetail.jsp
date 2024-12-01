<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link href="${pageContext.request.contextPath }/resources/design/plugins/custom/fullcalendar/fullcalendar.bundle.css" rel="stylesheet" type="text/css" />
<script	src="${pageContext.request.contextPath }/resources/design/plugins/custom/fullcalendar/fullcalendar.bundle.js"></script>
<script	src="${pageContext.request.contextPath }/resources/design/js/custom/apps/calendar/TeamCalendar.js"></script>
<div style="margin-bottom: 25px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>인사·정보 관리</h3>
		<h6>부서관리 - 팀 상세정보</h6>
	</div>
</div>
<style>
.numShadow {
	margin-left: -30px;
    width: 100px;
    height: 5px;
    background-color: gray;
    border-radius: 50%;
    opacity: 60%;
    position: absolute;
    margin-top: 36%;
}
</style>
<div id="kt_app_content_container" class="app-container container-fluid">
	<div class="row gx-5 gx-xl-10 mb-xl-10">
		<div class="col-md-6 col-lg-6 col-xl-6 col-xxl-3 mb-10">
			<div class="card card-flush bgi-no-repeat bgi-size-contain bgi-position-x-center border-0 h-md-50 mb-5 mb-xl-10" style="background: linear-gradient(112.14deg, #00D2FF 0%, #3A7BD5 100%)">
				<div class="card-header pt-5">
					<div class="card-title d-flex">
						<div class="fs-2hx fw-bold text-white me-2 lh-1 ls-n2">${teamVO.teamNm }</div>
						<div class="badge badge-light-success mt-2">${teamVO.deptNm }</div>
					</div>
				</div>
				<div class="card-body d-flex align-items-end pt-0">
					<div class="d-flex align-items-center flex-column mt-3 w-100">
						<div class="d-flex justify-content-between fw-bold fs-6 text-white w-100 mt-auto">
							<span>팀 생성일</span>
							<span>${teamVO.teamCrtDt }</span>
						</div>
					</div>
					<!--end::Progress-->
				</div>
				<!--end::Card body-->
			</div>
			<!--end::Card widget 16-->
			<!--begin::Card widget 7-->
			<div class="card card-flush h-md-50 mb-5 mb-xl-10">
				<!--begin::Header-->
				<div class="card-header pt-5">
					<!--begin::Title-->
					<div class="card-title d-flex flex-column">
						<!--begin::Amount-->
						<span class="fs-2 fw-bold text-gray-900 me-2 lh-1 ls-n2">팀원 휴가일정</span>
						<span class="text-gray-500 pt-1 fw-semibold fs-6"></span>
						<!--end::Subtitle-->
					</div>
					<!--end::Title-->
				</div>
				<!--end::Header-->
				<!--begin::Card body-->
				<div class="card-body d-flex flex-column justify-content-end pe-0">
					<!--begin::Title-->
					<span class="fs-6 fw-bolder text-gray-800 d-block mb-2">오늘 휴가자</span>
					<!--end::Title-->
					<!--begin::Users group-->
					<div class="symbol-group symbol-hover flex-nowrap">
					<!-- 포이치로 휴가자 추가 -->
						<c:forEach items="${todayVCT }" var="list">
							<div class="align-middle">
								<div class="symbol symbol-50px symbol-circle" data-bs-toggle="tooltip" aria-label="${list.empNm }" data-bs-original-title="${list.empNm }" style="overflow: hidden;" data-kt-initialized="1">
									<img src="/upload/${list.imgFileUrl }" style="object-fit: cover;">
								</div>
							</div>
							
						</c:forEach>
					</div>
					<!--end::Users group-->
				</div>
				<!--end::Card body-->
			</div>
			<!--end::Card widget 7-->
		</div>
		<!--end::Col-->
		<!--begin::Col-->
		<div class="col-md-6 col-lg-6 col-xl-6 col-xxl-3 mb-10">
			<!--begin::Card widget 17-->
			<div class="card card-flush h-md-50 mb-5 mb-xl-10">
				<!--begin::Header-->
				<div class="card-header pt-5">
					<!--begin::Title-->
					<div class="card-title flex-column">
						<!--begin::Info-->
						<div class="d-flex align-items-center">
							<span class="fs-2 fw-bold text-gray-900 me-2 lh-1 ls-n2">프로젝트 실적</span>
						</div>
						<!--end::Info-->
						<!--begin::Subtitle-->
						<span class="text-gray-500 pt-1 fw-semibold fs-6">완료한 프로젝트</span>
						<!--end::Subtitle-->
					</div>
					<!--end::Title-->
				</div>
				<!--end::Header-->
				<div class="card-body align-items-center justify-content-center">
					<div class="fw-bolder text-gray-900 fs-1 me-4 d-flex justify-content-center"> 
						<span class="fs-7hx">
							${completedCnt.endCnt }/${completedCnt.ingCnt }
						</span>
						<span class="text-gray-800 ms-3 mt-19">건</span>
						<span class="numShadow"></span>
					</div>
				</div>
			</div>
			<div class="card card-flush h-lg-50">
				<div class="card-header pt-5">
					<div class="card-title d-flex flex-column">
						<span class="fs-2 fw-bold text-gray-900 me-2 lh-1 ls-n2">출장일정</span>
						<span class="text-gray-500 pt-1 fw-semibold fs-6"></span>
					</div>
					<!--end::Title-->
				</div>
				<div class="separator"></div>
				<table class="table align-middle fs-6 mx-5">
					<thead>
						<tr>
							<td>사원</td>
							<td>출장지</td>
							<td>출장일시</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rsvtList }" var="rsvt">
							<tr>
								<td>${rsvt.empNm }</td>
								<td>${rsvt.vhclBtdst }</td>
								<td><span class="badge badge-light-info mt-2">${fn:replace(fn:substring(rsvt.vhclRntlDt, 5, 16), 'T', '일 ')} 분<br/>${fn:replace(fn:substring(rsvt.vhclRtnDt, 5, 16), 'T', '일 ')} 분</span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!--end::Body-->
			</div>
			<!--end::LIst widget 25-->
		</div>
		<div class="col-lg-12 col-xl-12 col-xxl-6 mb-5 mb-xl-0">
			<div class="card card-flush overflow-hidden h-md-100">

				<div
					class="card-body d-flex justify-content-between flex-column pb-1 px-5"
					style="height: 630px;">
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
		</div>
	</div>
</div>
<div class="d-flex flex-wrap flex-stack mb-6 px-10">
	<h1 class="text-gray-800 fw-bold my-2">팀원 목록
	<span class="fs-6 text-gray-500 fw-semibold ms-1">(${teamVO.empCnt })</span></h1>
</div>
<div class="row g-6 mb-6 g-xl-9 mb-xl-9 px-10">
	<c:choose>
		<c:when test="${empty empList }">
			<div class="d-flex flex-column flex-center mt-10">
			    <img src="/resources/file/image/cloudEmpty.png" class="mw-300px">
			    <div class="fs-1 fw-bolder text-dark">등록된 팀원이 없습니다.</div>
			</div>
		</c:when>
		<c:otherwise>
			<c:forEach items="${empList }" var="emp">
			<div class="col-xxl-4 image-input image-input-empty image-input-outline">
				
				<div class="card image-input-wrapper w-auto h-auto px-5"
				<c:if test="${emp.empGndr == 'GNDR01' }">style="background-color: #ddf8fc"</c:if>
				style="background-color: #f4fbdb"
				>
					<div class="card-body d-flex flex-center flex-column py-9 px-5">
						<div class="symbol symbol-200px symbol-circle overflow-hidden mb-5" style="overflow: hidden;">
							<img src="/upload/${emp.imgFileUrl }" data-emp-id="${emp.empId}" style="object-fit: cover; cursor: pointer;"/>
						</div>
						<div class="fs-2x text-gray-800 fw-bold mb-0">${emp.empNm }</div>
						<c:choose>
							<c:when test="${empty emp.empEmlAddr }">
								<div class="badge badge-light-primary fw-bold fs-7 mb-5">이메일이 없습니다</div>
							</c:when>
							<c:otherwise>
								<c:if test="${emp.empGndr == 'GNDR01' }">
								<div class="badge badge-info fw-bold fs-7 mb-5 py-2 px-4">${emp.empEmlAddr }</div>
								</c:if>
								<c:if test="${emp.empGndr == 'GNDR02' }">
								<div class="badge badge-warning fw-bold fs-7 mb-5 py-2 px-4">${emp.empEmlAddr }</div>
								</c:if>
							</c:otherwise>
						</c:choose>
						<div class="d-flex flex-center flex-wrap mb-5">
							<c:choose>
								<c:when test="${emp.empGndr == 'GNDR01'}">
									<span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-1 bg-info">
									</span>
								</c:when>
								<c:otherwise>
									<span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-50px mh-100 me-1 bg-warning">
									</span>
								</c:otherwise>
							</c:choose>
							<div class="border rounded min-w-90px py-2 px-3 mx-2"
							<c:if test="${emp.empGndr == 'GNDR01' }">style="background: linear-gradient(135deg, #8cd3db 50%, #b2e1e7 100%, #ddf8fc 50%)"</c:if> 
							style="background: linear-gradient(135deg, #c1e1a6 50%, #e2f0c4 100%, #f4fbdb 50%)">
								<div class="fs-1x fw-bold text-white">직급</div>
								<div class="fs-1x fw-semibold text-white">${emp.jbgdNm }</div>
							</div>
							<div class="border rounded min-w-90px py-2 px-3" 
							<c:if test="${emp.empGndr == 'GNDR01' }">style="background: linear-gradient(135deg, #8cd3db 50%, #b2e1e7 100%, #ddf8fc 50%)"</c:if> 
							style="background: linear-gradient(135deg, #c1e1a6 50%, #e2f0c4 100%, #f4fbdb 50%)">
								<div class="fs-1x fw-bold text-white">프로젝트</div>
								<div class="fs-1x fw-semibold text-white">진행중인 프로젝트</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>

	<div class="d-flex justify-content-end pb-10">
		<div class="align-items-center">
			<input type="button" id="listBtn" class="btn btn-info" value="목록">
		</div> 
	</div>
</div>
<script type="text/javascript">
	var listBtn = $("#listBtn");
	var delBtn = $("#delBtn");
	
	$("img").on("click", function() {
		var empId = $(this).data("emp-id"); // empId를 데이터 속성으로 저장
		window.location.href = "/information/empdetail.do?empId=" + empId;
    });
	
	listBtn.on("click", function () {
		location.href = '/empinformation/alldept.do';
	})
	delBtn.on("click", function () {
		 Swal.fire({
	            title: '팀을 삭제하시겠습니까?',
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonColor: '#F06445',
	            cancelButtonColor: '#4FC9DA',
	            confirmButtonText: '예',
	            cancelButtonText: '아니요',
	            reverseButtons: false,
	        }).then((result) => {
	            // 스피너와 문구 초기화
	            spinner.addClass('d-none');

	            if (result.isConfirmed) {
	                delForm.submit();
	            }
	        });
		
	})



$.ajax({
    url: '/empinformation/teamcanlendar.do', // 서버 엔드포인트
    type: 'GET',
    data: {
    	teamCd : "${teamVO.teamCd}"
    },
    contentType: 'application/json',
    success: function (response) {
    	response.map(function(v,i){
	    	calendar.addEvent({
	            id: v.id,
	            title: v.title,
	            description: v.description,
	            start: v.start,
	            end: v.end,
	            allDay: v.allDay,
	            classNames : v.classNames
	        });
    	});
        calendar.render();
    	console.log(response);
    },
    error: function () {
    }
});
</script>
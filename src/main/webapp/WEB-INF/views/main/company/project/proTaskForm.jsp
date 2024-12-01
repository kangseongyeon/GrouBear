<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set value="등록" var="stts"/>
<c:if test="${status eq 'u' }">
	<c:set value="수정" var="stts"/>
</c:if>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>일감 ${stts }</h3> 
		<h6>일감</h6>
	</div>
</div>

<section class="tab-content">
<form id="projectTaskForm" action="/company/canbanInsert.do" method="post">
<input type="hidden" id="proStartDt" value="${proStartDt }">
<input type="hidden" id="proEndDt" value="${proEndDt }">
<input type="hidden" name="empId" value="${employeeVO.empId }">
	<c:if test="${status ne 'u' }">	 
		<input type="hidden" name="proNo" value="${proNo}" />
	</c:if>
	<c:if test="${status eq 'u' }">
		<input type="hidden" name="proTaskNo" value="${projectTaskVO.proTaskNo}" />
	</c:if>
		<div id="kt_app_content" class="app-container container-fluid">
			<div class="d-flex flex-column gap-7 gap-lg-10">
			
				<!-- 일감 상태 등록 시작 (수정시) -->
				<c:if test="${status eq 'u' }">
					<div class="card card-flush py-4">
						<div class="card-header">
							<div class="card-title">
								<h2>진행상태</h2>
							</div>
							<div class="card-toolbar">
								<c:if test="${projectTaskVO.proTaskSttsCd == 'TASK001' }"><div class="rounded-circle bg-primary w-15px h-15px" id="kt_ecommerce_add_product_status"></div></c:if>
								<c:if test="${projectTaskVO.proTaskSttsCd == 'TASK002' }"><div class="rounded-circle bg-warning w-15px h-15px" id="kt_ecommerce_add_product_status"></div></c:if>
								<c:if test="${projectTaskVO.proTaskSttsCd == 'TASK003' }"><div class="rounded-circle bg-success w-15px h-15px" id="kt_ecommerce_add_product_status"></div></c:if>
							</div>
						</div>
						<div class="card-body pt-0">
						    <select class="form-select mb-2" data-control="select2" data-hide-search="true" data-placeholder="Select an option" id="kt_ecommerce_add_product_status_select" name="proTaskSttsCd">
						        <option value="TASK001" ${projectTaskVO.proTaskSttsCd == 'TASK001' ? 'selected' : ''}>대기</option>
						        <option value="TASK002" ${projectTaskVO.proTaskSttsCd == 'TASK002' ? 'selected' : ''}>진행</option>
						        <option value="TASK003" ${projectTaskVO.proTaskSttsCd == 'TASK003' ? 'selected' : ''}>완료</option>
						    </select>
						</div>
					</div>
				</c:if>
				<!-- 일감 상태 등록 종료 -->
			
				<!-- 일감 등록 시작 -->
				<div class="card card-flush py-4">
					<div class="card-header">
						<div class="card-title">
							<h2>일감 ${stts }</h2>
						</div>
					</div>
					<!-- 일감 내용 입력 시작 -->
					<div class="card-body pt-0">
						<!-- 일감명 등록 시작 -->
						<div class="mb-10 fv-row">
							<label class="required form-label">일감명</label>
							<input type="text" id="proTaskNm" name="proTaskNm" class="form-control mb-2" placeholder="일감명을 입력하세요" value="${projectTaskVO.proTaskNm }" />
						</div>
						<!-- 일감명 등록 종료 -->
						<!-- 일감 설명 등록 시작 -->
						<div class="mb-10 fv-row">
							<label class="required form-label">일감 내용</label>
							<input type="text" id="proTaskCn" name="proTaskCn" class="form-control mb-2" placeholder="일감 내용을 입력하세요" value="${projectTaskVO.proTaskCn }" />
						</div>
						<!-- 일감 설명 등록 종료 -->
						<!-- 일감 참여일 등록 시작 -->
						<c:if test="${status ne 'u' }">
							<div class="row g-9 mb-8">
								<div class="col-md-6 fv-row">
									<label class="fs-6 fw-semibold mb-2">프로젝트 시작일</label>
									<!-- <label class="required fs-6 fw-semibold mb-2">프로젝트 시작일</label> -->
									<div class="position-relative d-flex align-items-center">
										<i class="ki-duotone ki-calendar-8 fs-2 position-absolute mx-4">
											<span class="path1"></span>
											<span class="path2"></span>
											<span class="path3"></span>
											<span class="path4"></span>
											<span class="path5"></span>
											<span class="path6"></span>
										</i>
										<input class="form-control form-control-solid ps-12 flatpickr-input active" type="datetime-local" id="proStartDt" name="proStartDt" value="${proStartDt }" readonly />
									</div>
								</div>
								<div class="col-md-6 fv-row">
									<label class="fs-6 fw-semibold mb-2">프로젝트 마감일</label>
									<div class="position-relative d-flex align-items-center">
										<i class="ki-duotone ki-calendar-8 fs-2 position-absolute mx-4">
											<span class="path1"></span>
											<span class="path2"></span>
											<span class="path3"></span>
											<span class="path4"></span>
											<span class="path5"></span>
											<span class="path6"></span>
										</i>
										<input class="form-control form-control-solid ps-12 flatpickr-input active" type="datetime-local"  id="proEndDt" name="proEndDt" value="${proEndDt }" readonly/>
									</div>
								</div>
							</div>
						</c:if>
						<!-- 일감 참여일 등록 종료 -->
						<!-- 일감 참여일 등록 시작 -->
						<div class="row g-9 mb-8">
							<div class="col-md-6 fv-row">
								<label class="required fs-6 fw-semibold mb-2">일감 시작일</label>
								<div class="position-relative d-flex align-items-center">
									<i class="ki-duotone ki-calendar-8 fs-2 position-absolute mx-4">
										<span class="path1"></span>
										<span class="path2"></span>
										<span class="path3"></span>
										<span class="path4"></span>
										<span class="path5"></span>
										<span class="path6"></span>
									</i>
									<input class="form-control form-control-solid ps-12 flatpickr-input active" placeholder="시작일을 등록하세요" type="datetime-local" id="proTaskStartDt" name="proTaskStartDt" value="${projectTaskVO.proTaskStartDt }" />
								</div>
							</div>
							<div class="col-md-6 fv-row">
								<label class="required fs-6 fw-semibold mb-2">일감 마감일</label>
								<div class="position-relative d-flex align-items-center">
									<i class="ki-duotone ki-calendar-8 fs-2 position-absolute mx-4">
										<span class="path1"></span>
										<span class="path2"></span>
										<span class="path3"></span>
										<span class="path4"></span>
										<span class="path5"></span>
										<span class="path6"></span>
									</i>
									<input class="form-control form-control-solid ps-12" placeholder="마감일을 등록하세요" type="datetime-local"  id="proTaskEndDt" name="proTaskEndDt" value="${projectTaskVO.proTaskEndDt }" />
								</div>
							</div>
						</div>
						<!-- 일감 참여일 등록 종료 -->
					</div>
					<!-- 일감 내용 입력 종료 -->
				</div>
				<!-- 일감 등록 종료 -->
				<!-- 진행률 등록 시작 -->
				<c:if test="${status eq 'u' }">
					<div class="card card-flush py-4">
						<div class="card-header">
							<div class="card-title">
								<h2>진행률 ${stts }</h2>
							</div>
						</div>
						<!-- 진행률 수정 시작 -->
						<div class="card-body pt-0">
						    <div class="fv-row mb-10">
						        <div class="d-flex flex-column text-center">
						            <div class="d-flex align-items-start justify-content-center mb-7">
						                <span class="fw-bold fs-4 mt-1 me-2"></span>
						                <span class="fw-bold fs-3x" id="kt_modal_create_campaign_budget_label"></span>
						                <span class="fw-bold fs-3x">${projectTaskVO.proTaskPregrt}%</span>
						            </div>
						            <div id="kt_modal_create_campaign_budget_slider" class="noUi-sm"></div>
						            <span id="slider-value" class="fw-bold fs-4 mt-3">${projectTaskVO.proTaskPregrt}</span>
						            <input type="hidden" id="proTaskPregrt" name="proTaskPregrt">
						        </div>
						    </div>
						</div>
						<!-- 진행률 수정 종료 -->
					</div>
				</c:if>
				<!-- 진행률 등록 종료 -->
				
				<!-- 버튼 시작 -->
				<div class="d-flex justify-content-end pt-7">
					<input type="button" value="${stts }" id="addTasKBtn" class="btn btn-sm fw-bold btn-primary me-2">
					<c:if test="${status eq 'u' }">
						<input type="button" value="취소" id="cancelBtn" class="btn btn-sm btn-light fw-bold btn-active-light-primary me-2"> 
					</c:if>
					<c:if test="${status ne 'u' }">
						<input type="button" value="목록" id="listBtn" class="btn btn-sm btn-light fw-bold btn-active-light-primary me-2"> 
					</c:if>
				</div>
				<!-- 버튼 종료 -->
			</div>
		</div>
		<sec:csrfInput/>
	</form>
</section>
<div id="kt_app_footer" class="app-footer">
	<div class="app-container container-fluid d-flex flex-column flex-md-row flex-center flex-md-stack py-3"></div>
</div>

<script type="text/javascript">
$(function () {
	var listBtn = $("#listBtn");		// 목록 버튼
	var addTasKBtn = $("#addTasKBtn");	// 일감 추가 버튼
	var cancelBtn = $("#cancelBtn");	// 취소 버튼
	var projectTaskForm = $("#projectTaskForm");
	
	var proStartDt = new Date($("#proStartDt").val());	// 프로젝트 시작일
	var proEndDt = new Date($("#proEndDt").val());		// 프로젝트 종료일

	// 목록 버튼
	listBtn.on("click", function () {
		Swal.fire({
			title: '작성을 취소하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#4FC9DA',
			cancelButtonColor: '#F06445',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false,
	
		}).then((result) => {
			if (result.isConfirmed) {
				location.href = "/company/project.do";
			}
		});
	});
	
	// 취소 버튼
	cancelBtn.on('click', function() {
		Swal.fire({
			title: '편집을 취소하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#4FC9DA',
			cancelButtonColor: '#F06445',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false,
	
		}).then((result) => {
			if (result.isConfirmed) {
				location.href = "/company/canbanList.do?proNo=${projectTaskVO.proNo}";
			}
		})
	});
	
	// 시작일 유효성 검사
	$("#proTaskStartDt").on("change", function () {
		var currentTaskDt = new Date();
		var proTaskStartDt = $(this).val();
		var newTaskStartDt = new Date(proTaskStartDt);
		
		if (newTaskStartDt < currentTaskDt) {
			Swal.fire({
				title: '시작일은 현재일보다 과거일 수 없습니다.',
				icon: 'warning',
				confirmButtonColor: '#4FC9DA',
				confirmButtonText: '확인',
				reverseButtons: false,
			});
			$(this).val('');
			return;
		}
		
		if (newTaskStartDt < proStartDt || newTaskStartDt > proEndDt) {
			Swal.fire({
				title: '일감 시작일은 프로젝트 시작일과 종료일 사이로 입력해주세요.',
				icon: 'warning',
				confirmButtonColor: '#4FC9DA',
				confirmButtonText: '확인',
				reverseButtons: false,
			});
				$(this).val('');
			}
	});
	
	// 마감일 유효성 검사
	$("#proTaskEndDt").on("change", function () {
		var proTaskEndDt = $(this).val();
		var newTaskEndDt = new Date(proTaskEndDt);
		var proTaskStartDt = new Date($("#proTaskStartDt").val());
		
		if (proTaskStartDt && newTaskEndDt < proTaskStartDt) {
			Swal.fire({
				title: '마감일은 시작일보다 빠를 수 없습니다.',
				icon: 'warning',
				confirmButtonColor: '#4FC9DA',
				confirmButtonText: '확인',
				reverseButtons: false,
			});
			$(this).val('');
			return;
		}
		
		if (newTaskEndDt < proStartDt || newTaskEndDt > proEndDt ) {
			Swal.fire({
				title: '일감 마감일은 프로젝트 시작일과 종료일 사이로 입력해주세요.',
				icon: 'warning',
				confirmButtonColor: '#4FC9DA',
				confirmButtonText: '확인',
				reverseButtons: false,
			});
			$(this).val('');
		}
	});
	
	// 진행률 수정
	$(document).ready(function () {
	    var slider = document.getElementById('kt_modal_create_campaign_budget_slider');
	    var sliderValue = document.getElementById('slider-value');

	    // 슬라이더가 존재하는지 확인
	    if (slider) {
	        noUiSlider.create(slider, {
	            start: [${projectTaskVO.proTaskPregrt}],
	            range: {
	                'min': 0,
	                'max': 100
	            },
	            step: 1,
	            tooltips: true,
	            connect: [true, false]
	        });

	        slider.noUiSlider.on('update', function (values, handle) {
	            var value = values[handle];
	            sliderValue.innerHTML = value;
	        });
	    } else {
	        console.error('슬라이더 요소를 찾을 수 없습니다.');
	    }

	    // 일감 추가
	    addTasKBtn.on("click", function () {
	        var proTaskNm = $("#proTaskNm").val();
	        var proTaskCn = $("#proTaskCn").val();
	        var proTaskStartDt = $("#proTaskStartDt").val();
	        var proTaskEndDt = $("#proTaskEndDt").val();
	        var empId = $("#empId").val();
	        var proTaskPregrt = slider ? slider.noUiSlider.get() : null;
	        
	        if (proTaskNm == null || proTaskNm == "" ||
	            proTaskCn == null || proTaskCn == "" ||
	            proTaskStartDt == null || proTaskStartDt == "" ||
	            proTaskEndDt == null || proTaskEndDt == ""
	        ) {
	            Swal.fire({
	                icon: 'warning',
	                title: '필수 입력이 비어있습니다.',
	                text: '필수 입력 내용을 채워주세요.',
	                confirmButtonColor: '#4FC9DA',
	            });
	            return false;
	        }

	        // 진행률 값 추가하기
	        if ($(this).val() !== "등록") {
	            $("#proTaskPregrt").val(proTaskPregrt); 
	        }

	        if ($(this).val() == "수정") {
	            projectTaskForm.attr("action", "/company/canbanUpdate.do");
	        }

	        projectTaskForm.submit();
	    });
	});
});
</script>
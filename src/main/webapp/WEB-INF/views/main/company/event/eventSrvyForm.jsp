<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>설문 등록</h3> 
		<h6>이벤트</h6>
	</div>
</div>

<div id="kt_app_content" class="app-container container-fluid">
	<div class="d-flex flex-column gap-7 gap-lg-10">
		<!-- 설문 등록 시작 -->
		<div class="card card-flush py-4">
			<div class="card-header">
				<div class="card-title">
					<h2>설문 등록</h2>
				</div>
			</div>
			<!-- 설문명 입력 시작 -->
			<div class="card-body pt-0">
				<!-- 프로젝트명 등록 시작 -->
				<div class="mb-10 fv-row">
					<label class="required form-label">설문명</label>
					<input type="text" id="eventNm" name="eventNm" class="form-control mb-2" placeholder="설문명을 입력하세요" value="${eventVO.eventCn }" />
				</div>
				<!-- 설문명 등록 종료 -->
				<!-- 설문 설명 등록 시작 -->
				<div class="mb-10 fv-row">
					<label class="required form-label">설문 내용</label>
						<input type="text" id="eventCn" name="eventCn" class="form-control mb-2" placeholder="설문 설명을 입력하세요" value="${eventVO.eventCn }" />
				</div>
				<!-- 설문 설명 등록 종료 -->
				<!-- 설문 참여일 등록 시작 -->
				<div class="row g-9 mb-8">
					<div class="col-md-6 fv-row">
						<label class="required fs-6 fw-semibold mb-2">시작일</label>
						<div class="position-relative d-flex align-items-center">
							<i class="ki-duotone ki-calendar-8 fs-2 position-absolute mx-4">
								<span class="path1"></span>
								<span class="path2"></span>
								<span class="path3"></span>
								<span class="path4"></span>
								<span class="path5"></span>
								<span class="path6"></span>
							</i>
							<input class="form-control form-control-solid ps-12 flatpickr-input active" placeholder="시작일을 등록하세요" type="datetime-local" id="eventBgngDt" name="eventBgngDt" value="${eventVO.eventBgngDt }" />
						</div>
					</div>
					<div class="col-md-6 fv-row">
						<label class="required fs-6 fw-semibold mb-2">마감일</label>
						<div class="position-relative d-flex align-items-center">
							<i class="ki-duotone ki-calendar-8 fs-2 position-absolute mx-4">
								<span class="path1"></span>
								<span class="path2"></span>
								<span class="path3"></span>
								<span class="path4"></span>
								<span class="path5"></span>
								<span class="path6"></span>
							</i>
							<input class="form-control form-control-solid ps-12" placeholder="마감일을 등록하세요" type="datetime-local"  id="eventEndDt" name="eventEndDt" value="${eventVO.eventEndDt }" />
						</div>
					</div>
				</div>
				<!-- 설문 참여일 등록 종료 -->
			</div>
			<!-- 설문 내용 입력 종료 -->
		</div>
		<!-- 설문 등록 종료 -->
		<!-- 설문 문항 등록 시작 -->
		<div class="card card-flush py-4">
			<!--begin::Card header-->
			<div class="card-header">
				<div class="card-title">
					<h2>설문 문항</h2>
				</div>
			</div>
			<!--end::Card header-->
			<!--begin::Card body-->
			<div class="card-body pt-0">
				<!--begin::Input group-->
				<div class="" data-kt-ecommerce-catalog-add-product="auto-options">
					<label class="required form-label">설문 유형을 선택해주세요</label>
					<!--begin::Repeater-->
					<div id="kt_ecommerce_add_product_options">
						<!--begin::Form group-->
						<div class="form-group">
							<div data-repeater-list="kt_ecommerce_add_product_options" class="d-flex flex-column gap-3">
								<div data-repeater-item="" class="form-group d-flex flex-wrap align-items-center gap-5">
									<!--begin::Select2-->
									<div class="w-100 w-md-200px">
										<select class="form-select" name="product_option" data-placeholder="Select a variation" data-kt-ecommerce-catalog-add-product="product_option">
											<option>선택</option>
											<option value="SRVY001">객관식</option>
											<option value="SRVY002">주관식</option>
										</select>
									</div>
									<!--end::Select2-->
								</div>
							</div>
						</div>
						<!--end::Form group-->
					</div>
					<!--end::Repeater-->
				</div>
				<!--end::Input group-->
				<label class="required form-label">설문 항목을등록해주세요</label>
					<div id="kt_ecommerce_add_product_options">
						<div class="form-group">
							<div id="repeater-list" data-repeater-list="kt_ecommerce_add_product_options" class="d-flex flex-column gap-3">
								<div data-repeater-item="" class="form-group d-flex flex-wrap align-items-center gap-5">
									<input type="text" class="form-control mw-100 w-1000px" placeholder="항목" id="" name="" value=""/>
									<button type="button" data-repeater-delete="" class="btn btn-sm btn-icon btn-light-danger">
										<i class="ki-duotone ki-cross fs-1">
											<span class="path1"></span>
											<span class="path2"></span>
										</i>
									</button>
								</div>
							</div>
						</div>
						<div class="form-group mt-5">
							<button type="button" id="repeater-create" data-repeater-create="" class="btn btn-sm btn-light-primary">
							<i class="ki-duotone ki-plus fs-2"></i>문항 추가</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 참여자 등록 시작 -->
		</div>
		<!--end::Card header-->
	</div>
	<!-- 설문 문항 등록 시작 -->
	<!-- 버튼 시작 -->
	<div class="d-flex justify-content-end pt-7">
		<input type="button" value="등록" id="addBtn" class="btn btn-sm fw-bold btn-primary me-2">
		<input type="button" value="목록" id="listBtn" class="btn btn-sm btn-light fw-bold btn-active-light-primary me-2"> 
	</div>
	<!-- 버튼 종료 -->

<div id="kt_app_footer" class="app-footer">
	<div class="app-container container-fluid d-flex flex-column flex-md-row flex-center flex-md-stack py-3"></div>
</div>

<script type="text/javascript">
</script>
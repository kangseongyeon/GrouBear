<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>설문</h3>
		<h6>이벤트</h6>
	</div>
</div>
<div class="container">
	<!--begin::Main-->
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<!--begin::Content wrapper-->
		<div class="d-flex flex-column flex-column-fluid">
			<!--begin::Content-->
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<!--begin::Content container-->
				<div id="kt_app_content_container" class="app-container container-fluid">
					<!--begin::empElaprraft-->
					<div class="card card-flush">
						<!--begin::Card header-->
						<div class="card-header align-items-center py-5 gap-2 gap-md-5">
							<!--begin::Card title-->
							<div class="card-title">
								<!--begin::Search-->
								<div class="d-flex align-items-center position-relative my-1">
									<i class="ki-duotone ki-magnifier fs-3 position-absolute ms-4">
										<span class="path1"></span>
										<span class="path2"></span>
									</i>
									<form id="searchForm">
			                            <input type="hidden" name="page" id="page">
									    <input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-12" style="margin-top: 0.5em;" placeholder="설문 검색" value="${searchWord }"/>
		                            </form>
								</div>
								<!--end::Search-->
							</div>
							<!--end::Card title-->
							<!--begin::Card toolbar-->
							<div class="card-toolbar flex-row-fluid justify-content-end gap-5">
								<div class="w-100 mw-150px">
								</div>
								<!--begin::Add product-->
								<!-- <a href="apps/ecommerce/catalog/add-product.html" class="btn btn-primary">Add Product</a> -->
								<!--end::Add product-->
							</div>
							<!--end::Card toolbar-->
						</div>
						<!--end::Card header-->
						<!--begin::Card body-->
						<div class="card-body pt-0">
							<!--begin::Table-->
							<table class="table align-middle table-row-dashed fs-6 gy-5" id="kt_ecommerce_products_table">
								<thead>
									<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0">
										<th class="min-w-50px">No</th>
										<th class="min-w-250px">설문명</th>
										<th class="min-w-100px">상태</th>
										<th class="min-w-150px">설문기간</th>
										<th class="min-w-150px">작성자</th>
									</tr>
								</thead>
								<tbody class="fw-semibold text-gray-600">
									<tr>
										<td class="pe-0">
											<span class="fw-bold">1</span>
										</td>
										<td class="pe-0" data-order="34">
											<a href="#">
												<span class="fw-bold ms-3">설문명</span>
											</a>
										</td>
										<td class="pe-9">
											<!--begin::Badges-->
											<div class="badge badge-light-warning">참여완료</div>
											<!--end::Badges-->
										</td>
										<td class="pe-0">2024/10/17 - 2024/10/20</td>
										<td class="pe-0">
											<span class="fw-bold">강성연</span>
										</td>
									</tr>
								</tbody>
							</table>
							<!--end::Table-->
						</div>
						<!--end::Card body-->
						<div class="card-footer clearfix" id="pagingArea">
							${pagingVO.pagingHTML }
						</div>
					</div>
					<!--end::empElaprraft-->
				</div>
				<!--end::Content container-->
			</div>
			<!--end::Content-->
		</div>
		<!--end::Content wrapper-->
	</div>		
</div>
<script type="text/javascript">
$(function(){
	var searchForm = $("#searchForm");		// 검색 및 페이징 처리 위한 Form
	var pagingArea = $("#pagingArea");		// 페이징 처리 위한 div
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		$('#myInput').val("");
		searchForm.submit();
	});
});
</script>
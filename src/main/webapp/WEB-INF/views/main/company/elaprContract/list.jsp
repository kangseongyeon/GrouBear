<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<div class="kt_app_content_container mx-5 mb-5" style="height: 100%"> 
	<div class="card card-flush" style="height: 100%;">
                                
		<!--begin::Card header-->
		<div class="card-header align-items-center py-5 gap-2 gap-md-5">
			<!--begin::Card title-->
			<div class="card-title">
				<!--begin::Search-->
				<div class="d-flex align-items-center position-relative my-1">
													
	                			<form id="searchForm" style="display: contents;">
	                          <input type="hidden" name="page" id="page">
					    <input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-5" style="margin-top: 0.5em;" placeholder="전자계약 검색" value="">
	                     		<button id="searchBtn" type="button" class="btn btn-flex btn-light-success ms-1 py-3 px-3" style="margin-top: 0.5em;">
	                     			<i class="ki-duotone ki-magnifier fs-2x">
								 <span class="path1" style="height: 1.1em;"></span> 
								 <span class="path2"></span>
							</i>
						</button>
	                         </form>
	                         
				</div>
				<!--end::Search-->
			</div>
			<!--end::Card title-->
		</div>
		<!--end::Card header-->
	
		<!--begin::Card body-->
		<div class="card-body pt-0 pb-0">
			<!--begin::Table-->
			<table class="table align-middle table-row-dashed fs-6" id="kt_ecommerce_products_table">
				<thead>
					<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
						<th class="h4">관리번호</th>  
						<th class="h4">진행상태</th>
						<th class="h4">계약자</th>
						<th class="h4">계약담당자</th>
						<th class="h4">계약일시</th>
					</tr>
				</thead>
				<tbody class="fw-semibold text-gray-600">
					
					
						
							<tr>
								<td colspan="5" class="text-center pt-5">조회하신 계약이 존재하지 않습니다.</td>
							</tr>
						
						
					
				</tbody>
			</table>
			<!--end::Table-->
		</div>
		<!--end::Card body-->
	
		<div class="dt-paging paging_simple_numbers" id="pagingArea" style="margin-bottom: 10px;">
			<ul class="pagination"></ul>
		</div>

	</div>
</div>
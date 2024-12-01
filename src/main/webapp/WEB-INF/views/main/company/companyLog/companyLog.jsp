<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>보안</h3>
		<h6>로그</h6>
	</div>
</div>

<div> 
	<div class="d-flex flex-column flex-root app-root" id="kt_app_root">
		<div class="app-page flex-column flex-column-fluid" id="kt_app_page">
			<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
				<div class="d-flex flex-column flex-column-fluid">
					<div id="kt_app_content" class="app-content flex-column-fluid">
						<div id="kt_app_content_container" class="app-container container-fluid">
							<div class="card card-flush">
							<div style="display: flex; flex-direction: row; justify-content: space-between;">
							<form id="searchForm">
                                	<input type="hidden" name="page" id="page"> 
								<div class="card-header align-items-center py-5 gap-2 gap-md-5">
									<div class="card-title">
										<div class="d-flex align-items-center position-relative my-1">
											<i class="ki-duotone ki-magnifier fs-3 position-absolute ms-4">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>
											<input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-12" placeholder="검색" value="${searchWord }"/>
										</div>
									</div>
								</div>
								</form>
								<div style="display: flex;align-items: center; padding-right: 27px">
									<form id="excelDown" method="POST">
										<div class="card-toolbar flex-row-fluid justify-content-end gap-5">
											<div>
												<button type="button" id="excelBtn" class="btn btn-primary">Excel 저장하기</button>
											</div>
										</div>
									</form> 
								</div>
								</div>
								<div class="card-body pt-0">
									<table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered" id="kt_ecommerce_products_table">
										<thead>
											<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
<!-- 												<th class="w-10px pe-2"> -->
<!-- 													<DIV CLASS="FORM-CHECK FORM-CHECK-SM FORM-CHECK-CUSTOM FORM-CHECK-SOLID ME-3"> -->
<!-- 														<INPUT CLASS="FORM-CHECK-INPUT" TYPE="CHECKBOX" DATA-KT-CHECK="TRUE" DATA-KT-CHECK-TARGET="#KT_ECOMMERCE_PRODUCTS_TABLE .FORM-CHECK-INPUT" VALUE="1" /> -->
<!-- 													</DIV> -->
<!-- 												</th> -->
												<th class="min-w-150px h4">시간</th>
												<th class="min-w-100px h4">기업</th>
												<th class="min-w-100px h4">부서</th>
												<th class="min-w-100px h4">이름</th>
												<th class="min-w-100px h4">아이디</th> 
												<th class="min-w-100px h4">IP</th> 
												<th class="min-w-100px h4">작업내역</th> 
											</tr>
										</thead>
										<tbody class="fw-semibold text-gray-600">
											<c:set value="${companyLog}" var="logList" />
											<c:choose>
												<c:when test="${empty logList }">
													<tr>
														<td class="text-center" colspan="8">로그가 존재하지 않습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach items="${logList }" var="item">
														<tr>
<!-- 															<td> -->
<!-- 																<div -->
<!-- 																	class="form-check form-check-sm form-check-custom form-check-solid"> -->
<!-- 																	<input class="form-check-input" type="checkbox" -->
<!-- 																		value="1" /> -->
<!-- 																</div> -->
<!-- 															</td> -->
															<td>
																<div class="text-center">${item.logCrtDt}</div>
															</td>
															<td>
																<div class="text-center">${item.companyName }</div>
															</td>
															<td>
																<div class="text-center">${item.departmentName}</div>
															</td>
															<td>
																<div class="text-center">${item.empNm }</div>
															</td>
															<td>
																<div class="text-center">${item.empId }</div>
															</td>
															<td>
																<div class="text-center">${item.logIp }</div>
															</td>
															<td>
																<div class="text-center">${item.logDetail }</div>
															</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
								<div class="card-footer clearfix" id="pagingArea">${pagingVO.pagingHTML }
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	let searchForm = $('#searchForm');      // 검색 및 페이징 처리 위한 Form
	let pagingArea = $('#pagingArea');		// 페이징 처리 위한 div
	let excelDown = $('#excelDown');
	let excelBtn = $('#excelBtn');		
	
	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
	   pagingArea.on('click', 'a', function(event) {
	      event.preventDefault();
	      let pageNo = $(this).data('page');
	      searchForm.find('#page').val(pageNo);
	      searchForm.submit();
	   });
	
	   excelBtn.on("click", function () {
		   excelDown.attr("action","/excel/downExcel");
			excelDown.submit();
		});
});
</script>



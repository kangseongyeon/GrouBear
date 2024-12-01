<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>기안 문서함</h3>
		<h6>전자결재</h6>
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
				<!--begin::Row-->
				<div class="row gy-5 gx-xl-10" >
					<!--begin::Col-->
					<!-- <div class="col-xxl-6"> -->
					<div class="col-lg-4">
						<!--begin::Row-->
						<!-- <div class="row gx-5 gx-xl-10"> -->
					</div>
				</div>
				<!--end::Row-->
				<!--begin::결재리스트-->
				<div class="card mb-5 mb-xl-10">
					<!--begin::Card header-->
					<div class="card-header">
						<!--begin::Heading-->
						<div class="card-title">
							<!-- begin::paging -->
							<div class="d-flex align-items-center position-relative my-1">
                              <form id="searchForm" style="display: contents;">
                                 <input type="hidden" name="page" id="page"/>
                                 <input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-5" style="margin-top: 0.5em;" placeholder="검색" value="${searchWord }"/>
                                 <button id="searchBtn" type="button" class="btn btn-flex btn-light-success ms-1 py-3 px-3" style="margin-top: 0.5em;">
                                       <i class="ki-duotone ki-magnifier fs-2">
                                       <span class="path1" style="height: 1.1em;"></span> 
                                       <span class="path2"></span>
                                    </i>
                                 </button>
                              </form>
                           </div>
							<!-- end::paging -->
							<!-- <h3 class="card-title">
							</h3> -->
						</div>
						<!--end::Heading-->
					</div>
					<!--end::Card header-->
					<!--begin::Card body-->
					<div class="card-body p-0">
						<!--begin::Table wrapper-->
						<div class="table-responsive">
							<!--begin::Table-->
							<table class="table align-middle table-row-bordered table-hover table-row-solid gy-4 gs-9">
								<!--begin::Thead-->
								<thead class="border-gray-200 fs-5 fw-semibold bg-lighten">
									<tr>
										<th class="min-w-50px">No</th>
										<th class="min-w-150px">기안일</th>
										<th class="min-w-150px">완료일</th>
										<th class="min-w-200px">제목</th>
										<th class="min-w-100px">결재양식</th>
										<th class="min-w-100px">긴급</th>
										<th class="min-w-100px">첨부</th>
										<th class="min-w-70px">결재상태</th>
									</tr>
								</thead>
								<!--end::Thead-->
								<!--begin::Tbody-->
								<tbody class="fw-6 fw-semibold text-gray-600">
									<c:set value="${pagingVO.dataList }" var="draftList"/>
									<c:choose>
										<c:when test="${empty draftList }">
											<tr>
												<td colspan="8" class="text-center pt-5">기안 문서가 존재하지 않습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${draftList }" var="elaprVO">
												<tr>
													<td>${elaprVO.elaprNo }</td>
													<td class="pe-0">
														<span class="fw-bold">${elaprVO.elaprBgngDt }</span>
													</td>
													<td class="pe-0">
														<span class="fw-bold">${elaprVO.elaprEndDt }</span>
													</td>
													<td class="pe-0" data-order="34">
														<a href="/company/elaprDetail.do?elaprNo=${elaprVO.elaprNo }&status=${status}">
															<span class="fw-bold ms-3">${elaprVO.elaprNm }</span>
														</a>
													</td>
													<td class="pe-0">${elaprVO.docFormNm }</td>
													<td class="pe-0" data-order="rating-3">
														<!--begin::Badges-->
														<c:if test="${elaprVO.elaprEmrgYn eq 'Y' }">
															<div class="badge badge-light-danger">긴급</div>
														</c:if>
														<c:if test="${elaprVO.elaprEmrgYn eq 'N' }">
															<div class="badge badge-light-info"></div>
														</c:if>
														<!--end::Badges-->
													</td>
													<td class="pe-0" data-order="Inactive">
														<span class="fw-bold ms-3">${elaprVO.atchFileCode }</span>
													</td>
													<td class="pe-9">
														<!--begin::Badges-->
														<c:if test="${elaprVO.elaprSttsCd eq 'APRZ001' }">
															<div class="badge badge-light-warning">진행</div>
														</c:if>
														<c:if test="${elaprVO.elaprSttsCd eq 'APRZ002' }">
															<div class="badge badge-light-info">완료</div>
														</c:if>
														<c:if test="${elaprVO.elaprSttsCd eq 'APRZ003' }">
															<div class="badge badge-light-danger">반려</div>
														</c:if>
														<!--end::Badges-->
													</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
								<!--end::Tbody-->
							</table>
							<!--end::Table-->
						</div>
						<!--end::Table wrapper-->
					<div class="card-footer clearfix" id="pagingArea">
						${pagingVO.pagingHTML }
					</div>
					</div>
					<!--end::Card body-->
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function () {
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	
	pagingArea.on("click", "a", function (event) {
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
});


</script>

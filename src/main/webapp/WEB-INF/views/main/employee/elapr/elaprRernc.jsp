<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>참조/열람 문서함</h3>
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
				<div class="card mb-5 mb-xxl-8">
					<div class="card-body pt-0 pb-0">
						<!--begin::Navs-->
						<ul class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold">
							<li class="nav-item mt-2">
								<a href="/employee/empElaprRernc.do" class="nav-link text-active-primary ms-0 me-10 py-5 active" >
									참조 문서함
								</a>
							</li>
							<li class="nav-item mt-2">
								<a href="/employee/empElaprPrsl.do" class="nav-link text-active-primary ms-0 me-10 py-5">
									열람 문서함
								</a>
							</li>
						</ul>
						<!--begin::Navs-->
					</div>
				</div>
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
										<th class="min-w-100px">기안자</th>
										<th class="min-w-70px">결재상태</th>
									</tr>
								</thead>
								<!--end::Thead-->
								<!--begin::Tbody-->
								<tbody class="fw-6 fw-semibold text-gray-600">
									<c:set value="${pagingVO.dataList }" var="rerncList"/>
									<c:choose>
										<c:when test="${empty rerncList }">
											<tr>
												<td colspan="8" class="text-center">
							                	    <img src="/resources/file/image/cloudEmpty.png" class="w-50"/>
							                    	<h3 class=" fw-bolder text-dark">참조 문서가 존재하지 않습니다.</h3>
		              				 			</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${rerncList }" var="elaprVO">
												<tr>
													<td>${elaprVO.elaprNo }</td>
													<td class="pe-0">
														<span class="fw-bold">${elaprVO.elaprBgngDt }</span>
													</td>
													<td class="pe-0">
														<span class="fw-bold">${elaprVO.elaprEndDt }</span>
													</td>
													<td class="pe-0" data-order="34">
														<a href="/employee/elaprDetail.do?elaprNo=${elaprVO.elaprNo }&status=${status}">
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
													<td>
														${elaprVO.empNm }
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
					</div>
					<!--end::Card body-->
					<div class="card-footer clearfix" id="pagingArea">
						${pagingVO.pagingHTML }
					</div>
				</div>
				<!--end::설문-->
				<!--begin::투표-->
				<!--end::투표-->
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
	})
});


</script>

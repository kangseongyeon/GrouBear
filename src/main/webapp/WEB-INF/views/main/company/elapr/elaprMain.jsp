<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>전자결재</h3>
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
				<!-- <div class="row gy-5 gx-xl-10" > -->
				<div class="row" style="display: flex; flex-wrap: nowrap;">
					<!--begin::Col-->
					<!-- <div class="col-xxl-6"> -->
					<!-- <div class="col-lg-4"> -->
					<div class="col-lg-12">
						<!--begin::Row-->
						<!-- <div class="row gx-5 gx-xl-10"> -->
						<div class="row">
							<c:forEach items="${cardList }" var="elaprVO">
							<!--begin::Col-->
							<div class="col-sm-3 mb-5 mb-xl-10">
								<!--begin::List widget 1-->
								<div class="card card-flush h-lg-100">
									<!--begin::Header-->
									<div class="card-header pt-5">
										<!--begin::Title-->
										<h3 class="card-title align-items-start flex-column">
											<span class="card-label fw-bold text-gray-900">${elaprVO.elaprNm }</span>
											<span class="text-gray-500 mt-1 fw-semibold fs-6">기안자 : ${elaprVO.empNm }</span>
										</h3>
										<!--end::Title-->
									</div>
									<!--end::Header-->
									<!--begin::Body-->
									<div class="card-body pt-5">
										<!--begin::Item-->
										<div class="d-flex flex-stack">
											<!--begin::Section-->
											<div class="text-gray-700 fw-semibold fs-6 me-2">기안일 : ${elaprVO.elaprBgngDt }</div>
											<!--end::Section-->
										</div>
										<!--end::Item-->
										<!--begin::Separator-->
										<div class="separator separator-dashed my-3"></div>
										<!--end::Separator-->
										<!--begin::Item-->
										<div class="d-flex flex-stack">
											<!--begin::Section-->
											<div class="text-gray-700 fw-semibold fs-6 me-2">결재양식 : ${elaprVO.docFormNm }</div>
											<!--end::Section-->
										</div>
										<!--end::Item-->
										<!--begin::Separator-->
										<div class="separator separator-dashed my-3"></div>
										<!--end::Separator-->
										<!--begin::Item-->
										<!-- <div class="d-flex flex-stack"> -->
									</div>
									<!--end::Body-->
									<div class="card-footer">
										<!--begin::Section-->
										<!-- <div class="text-gray-700 fw-semibold fs-6 me-2"> -->
											<a href="/company/elaprDetail.do?elaprNo=${elaprVO.elaprNo }" class="btn btn-primary">결재하기</a>
										<!-- </div> -->
										<!--end::Section-->
									</div>
									<!--end::Item-->
								</div>
								<!--end::LIst widget 1-->
							</div>
							<!--end::Col-->
							</c:forEach>
						</div>
					</div>
				</div>
				<!--end::Row-->
				<!--begin::결재리스트-->
				<c:set var="statusList" value="${fn:split('APRZ002,APRZ003', ',')}" />
				<c:forEach var="status" items="${statusList }">
				<div class="card mb-5 mb-xl-10">
					<!--begin::Card header-->
					<div class="card-header">
						<!--begin::Heading-->
						<div class="card-title">
							<h3 class="card-title ">
							<c:choose>
								<c:when test="${status eq 'APRZ002' }">
									결재 완료 문서
								</c:when>
								<c:when test="${status eq 'APRZ003' }">
									결재 반려 문서
								</c:when>
							</c:choose>
						</h3>
						</div>
						<!--end::Heading-->
						<!--begin::Toolbar-->
						<div class="card-toolbar">
							<c:choose>
								<c:when test="${status eq 'APRZ002' }">
									<a href="/company/comElaprComplete.do" class="btn btn-sm btn-light-success my-1">더보기</a>
								</c:when>
								<c:when test="${status eq 'APRZ003' }">
									<a href="/company/comElaprRjct.do" class="btn btn-sm btn-light-success my-1">더보기</a>
								</c:when>
							</c:choose>
						</div>
						<!--end::Toolbar-->
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
										<th style="width: 6%">No</th>
										<th style="width: 15%">기안일</th>
										<th style="width: 15%">완료일</th>
										<th style="width: 10%">제목</th>
										<th style="width: 11%">결재양식</th>
										<th style="width: 8%">긴급</th>
										<th style="width: 10%">첨부</th>
										<th style="width: 10%">결재상태</th>
									</tr>
								</thead>
								<!--end::Thead-->
								<!--begin::Tbody-->
								<tbody class="fw-6 fw-semibold text-gray-600">
									<c:set value="${tableList }" var="elaprTableList"/>
									<c:choose>
										<c:when test="${empty elaprTableList }">
											<tr>
												<td colspan="8" >
													<c:choose>
														<c:when test="${status eq 'APRZ002' }">결재 완료 문서가 존재하지 않습니다.</c:when>
														<c:when test="${status eq 'APRZ003' }">결재 반려 문서가 존재하지 않습니다.</c:when>
													</c:choose>
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${elaprTableList }" var="elaprVO">
												<c:if test="${elaprVO.elaprSttsCd eq status }">
													<tr>
														<td>${elaprVO.elaprNo }</td>
														<td>${elaprVO.elaprBgngDt }</td>
														<td>${elaprVO.elaprEndDt }</td>
														<td>
															<a href="/company/elaprDetail.do?elaprNo=${elaprVO.elaprNo }" class="text-hover-primary text-gray-600">
																${elaprVO.elaprNm }
															</a>
														</td>
														<td>${elaprVO.docFormNm }</td>
														<td>
															<c:if test="${elaprVO.elaprEmrgYn eq 'Y'}">
																<span class="badge badge-light-danger fs-7 fw-bold">긴급</span>
															</c:if>
															<c:if test="${elaprVO.elaprEmrgYn eq 'N'}"/>
														</td>
														<td>${elaprVO.atchFileCode }</td>
														<td>
															<c:if test="${elaprVO.elaprSttsCd eq 'APRZ002'}">
																<span class="badge badge-light-primary fs-7 fw-bold">완료</span>
															</c:if>
															<c:if test="${elaprVO.elaprSttsCd eq 'APRZ003'}">
																<span class="badge badge-light-success fs-7 fw-bold">반려</span>
															</c:if>
														</td>
													</tr>
												</c:if>
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
				</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>


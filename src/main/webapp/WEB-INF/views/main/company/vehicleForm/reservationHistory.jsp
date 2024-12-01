<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div style="margin-bottom: 25px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>차량 관리</h3>
		<h6 class="text-muted min-w-100px">차량 예약 목록</h6>
	</div>
</div>

<div id="kt_app_content_container">
	<div class="app-main flex-column flex-row-fluid">
		<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
			<div class="d-flex flex-column flex-column-fluid">
				<div id="kt_app_content" class="app-content flex-column-fluid">
					<div id="kt_app_content_container" class="app-container container-fluid">
						<div class="card">
							<div class="card-header border-0 pt-6">
								<div class="card-title">
									<div class="d-flex align-items-center position-relative my-1">
										<form id="searchForm" style="display: contents;">
											<input type="hidden" name="page" id="page"/>
											<input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-5" style="margin-top: 0.5em;" placeholder="통합 검색" value="${searchWord }"/>
											<button id="searchBtn" type="button" class="btn btn-flex btn-light-success ms-1 py-3 px-3" style="margin-top: 0.5em;">
									            <i class="ki-duotone ki-magnifier fs-2">
													<span class="path1" style="height: 1.1em;"></span> 
													<span class="path2"></span>
												</i>
											</button>
										</form>
									</div>
								</div>
								<div class="card-toolbar">
									<div class="d-flex justify-content-end" data-kt-user-table-toolbar="base">
										<button type="button" class="btn btn-light-primary me-3" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
										<i class="ki-duotone ki-filter fs-2">
											<span class="path1"></span>
											<span class="path2"></span>
										</i>정렬</button>
										<div class="menu menu-sub menu-sub-dropdown w-300px w-md-325px" data-kt-menu="true">
											<div class="px-7 py-5">
												<div class="fs-5 text-gray-900 fw-bold">정렬 옵션</div>
											</div>
											<div class="separator border-gray-200"></div>
											<div class="px-7 py-5" data-kt-user-table-filter="form">
												<div class="mb-10">
													<label class="form-label fs-6 fw-semibold">정렬</label>
													<select class="form-select form-select-solid fw-bold" name="searchOrder" id="sortSelect" data-placeholder="정렬 기준 선택" data-allow-clear="true">
													    <option value="null" selected="selected">예약 순</option>
													    <option value="empNm">이름 순</option>
													    <option value="oldest">예약 역순</option>
													    <option value="rntlDt">대여일 순</option>
													    <option value="rtnDt">반납일 순</option>
													</select>
												</div>
												<div class="d-flex justify-content-end">
													<button type="submit" id="sortBtn" class="btn btn-primary fw-semibold px-6" data-kt-menu-dismiss="true" data-kt-user-table-filter="filter">정렬</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body py-4">
								<table class="table align-middle table-row-dashed fs-4" id="kt_table_users">
									<thead>
										<tr class="text-start text-muted fw-bold fs-4 text-uppercase gs-0">
											<th class="min-w-100px">예약번호</th>
											<th class="min-w-100px">차량 번호</th>
											<th class="min-w-100px">대여자</th>
											<th class="min-w-100px">예약일시</th>
											<th class="min-w-100px">이용 시간</th>
										</tr>
									</thead>
									<tbody class="text-gray-600 fw-semibold">
									<c:set value="${pagingVO.dataList }" var="vhclRsvtList"/>
									<c:choose>
										<c:when test="${empty vhclRsvtList }">
											<tr>
												<td colspan="7" class="text-center pt-5">
													예약 내역이 없습니다.
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${vhclRsvtList }" var="rsvtList">
												<tr>
													<td>${fn:replace(rsvtList.rsvtCd, "/", "")}</td>
													<td>${rsvtList.vhclNo}</td>
													<td>${rsvtList.empNm }</td>
													<td>${fn:replace(rsvtList.vhclRsvtDt, "/", "-")}일</td>
													<td>${fn:replace(rsvtList.vhclRntlDt, "T", "일 ") }시<br/>${fn:replace(rsvtList.vhclRtnDt, "T", "일 ") }시</td>
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
	</div>
	<div id="kt_app_footer" class="app-footer">
		<div class="app-container container-fluid d-flex align-items-center justify-content-center flex-column flex-md-row flex-center flex-md-stack py-3">
			<div class="card-footer clearfix" id="pagingArea">
				${pagingVO.pagingHTML }
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

$(document).ready(function() {
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	var searchBtn = $("#searchBtn");
	var searchOrderId = $("#searchOrderId");
	var sortBtn = $("#sortBtn");
	
	pagingArea.on("click", "a", function (event) {
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	searchBtn.on("click", function () {
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	sortBtn.on("click", function () {
		event.preventDefault();
		sortSelect = $("#sortSelect").val();
		console.log("선택된 벨류 : " + sortSelect);
		var pageNo = $(this).data("page");
		searchOrderId.val(sortSelect);
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
});
</script>			
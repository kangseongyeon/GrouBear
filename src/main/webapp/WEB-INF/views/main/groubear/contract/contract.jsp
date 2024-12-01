<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>

<%
	// 현재 날짜와 SimpleDateFormat 객체 초기화
// Date currentDate = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

<style>
.table-header {
	vertical-align: middle; /* 중앙 정렬 */
	text-align: center; /* 가운데 정렬 */
}
</style>



<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>기업과의 계약</h3>
		<h6>계약리스트</h6>
	</div>
</div>

<div>
	<div class="d-flex flex-column flex-root app-root" id="kt_app_root">
		<div class="app-page flex-column flex-column-fluid" id="kt_app_page">
			<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
				<div class="d-flex flex-column flex-column-fluid">
					<div id="kt_app_content" class="app-content flex-column-fluid">
						<div id="kt_app_content_container"
							class="app-container container-fluid">
							<div class="card card-flush">
								<div
									style="display: flex; flex-direction: row; justify-content: space-between;">
									<form id="searchForm">
										<input type="hidden" name="page" id="page">
										<div
											class="card-header align-items-center py-5 gap-2 gap-md-5">
											<div class="card-title">
												<div
													class="d-flex align-items-center position-relative my-1">
													<input id="myInput" name="searchWord" type="text"
														data-kt-ecommerce-product-filter="search"
														class="form-control form-control-solid w-250px ps-12"
														placeholder="검색" value="${searchWord }" />
													<button id="searchBtn" type="button"
														class="btn btn-flex btn-light-primary ms-1 py-3 px-3"
														style="margin-top: 0.5em;">
														<i class="ki-duotone ki-magnifier fs-2"> <span
															class="path1"></span> <span class="path2"></span>
														</i>
													</button>
												</div>
											</div>
										</div>
									</form>
									
									<div
										style="display: flex; align-items: center; padding-right: 27px">
										<!--begin::Toolbar-->
												<div class="d-flex justify-content-end" data-kt-user-table-toolbar="base">
													<!--begin::Filter-->
													<button type="button" class="btn btn-warning me-3" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
													<i class="ki-duotone ki-filter fs-2">
														<span class="path1"></span>
														<span class="path2"></span>
													</i>검색필터</button>
													<!--begin::Menu 1-->
													<div class="menu menu-sub menu-sub-dropdown w-300px w-md-325px" data-kt-menu="true">
														<!--begin::Header-->
														<div class="px-7 py-5">
															<div class="fs-5 text-gray-900 fw-bold">검색옵션</div>
														</div>
														<!--end::Header-->
														<!--begin::Separator-->
														<div class="separator border-gray-200"></div>
														<!--end::Separator-->
														<!--begin::Content-->
														<div class="px-7 py-5" data-kt-user-table-filter="form">
															<!--begin::Input group-->
															<div class="mb-10">
																<label class="form-label fs-6 fw-semibold">옵션:</label>
																<select class="form-select form-select-solid fw-bold" name="searchOrder" data-kt-select2="true" data-placeholder="선택" data-allow-clear="true" data-kt-user-table-filter="role" data-hide-search="true">
																	<option></option>
																	<option value="periodUp">남은기간 ↑</option>
																	<option value="periodDown">남은기간 ↓</option>
																	<option value="amtUp">계약금액 ↑</option>
																	<option value="amtDown">계약금액 ↓</option>
																	<option value="premiumYN">계약유형</option>
																</select>
															</div>
															<!--end::Input group-->
														
															<!--begin::Actions-->
															<div class="d-flex justify-content-end">
																<button type="submit" id="filterBtn" class="btn btn-primary fw-semibold px-6" data-kt-menu-dismiss="true" data-kt-user-table-filter="filter">확인</button>
																<button type="reset" class="btn btn-light btn-active-light-primary fw-semibold me-2 px-6" data-kt-menu-dismiss="true" data-kt-user-table-filter="reset">취소</button>
															</div>
															<!--end::Actions-->
														</div>
														<!--end::Content-->
													</div>
													<!--end::Menu 1-->
													<!--end::Filter-->
												</div>
												<!--end::Toolbar-->
										<form id="excelDown" method="POST">
											<div
												class="card-toolbar flex-row-fluid justify-content-end gap-5">
												<div>
													<button type="button" id="excelBtn" class="btn btn-primary">Excel
														저장하기</button>
												</div>
											</div>
										</form>
									</div>
								</div>
								<div class="card-body pt-0">
									<table
										class="table align-middle table-row-dashed fs-6 gy-5 table-bordered"
										id="kt_ecommerce_products_table">
										<thead>
											<tr
												class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
												<th class="min-w-100px h4">기업명<br />
												<span style="font-size: 0.8em;">(사업자번호)</span></th>
												<th class="min-w-100px h4 table-header">대표자명</th>
												<th class="min-w-100px h4 table-header">계약유형</th>
												<th class="min-w-100px h4 table-header">계약금액</th>
												<th class="min-w-100px h4 table-header">시작일<br />종료일
												</th>
												<th class="min-w-100px h4 table-header">계약기간</th>
												<th class="min-w-100px h4 table-header">남은기간</th>
												<th class="min-w-100px h4 table-header">상태</th>
												<!-- 												<th class="min-w-100px h4 table-header">내역</th>  -->
											</tr>
										</thead>
										<tbody class="fw-semibold text-gray-600">
											<c:set value="${pagingVO.dataList }" var="conList" />
											<c:choose>
												<c:when test="${empty conList }">
													<tr>
														<td class="text-center" colspan="8">계약내역이 존재하지 않습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach items="${conList }" var="item">
														<tr>
															<td>
<%-- 																<div class="text-center">${item.coNm }</div> --%>
																<div style="text-align: center;">
																<a href="#" class="menu-link px-3" data-bs-toggle="modal" data-bs-target="#company" onclick="f_company(${item.ctrtNo})">${item.coNm }</a>
																</div>
																<div class="text-center">
																	<span style="font-size: 0.8em;">${item.ctrtBrno }</span>
																</div>
															</td>
															<td>
																<div class="text-center">${item.ctrtNm }</div>
															</td>
															<td>
																<div class="text-center">
																	<c:choose>
																		<c:when test="${item.premiumYn == 'Y'}">
																			<span
																				class="badge fs-7 lh-1 py-5 px-2 d-flex flex-center"
																				style="background-color: #FBD288; color: black; height: 22px">프리미엄
																			</span>
																		</c:when>
																		<c:when test="${item.premiumYn == 'N'}">
																			<span
																				class="badge fs-7 lh-1 py-5 px-2 d-flex flex-center"
																				style="background-color: #F3F3E0; color: black; height: 22px">일반
																			</span>
																		</c:when>
																	</c:choose>
																</div>
															</td>
															<td>
																<div class="text-end">
																	<fmt:formatNumber value="${item.ctrtAmt}" type="number" pattern="#,##0" /> 원
																</div>
															</td>
															<td>
																<div class="text-center">${item.formattedCtrtBgngDt}</div>
																<div class="text-center">${item.formattedCtrtExpryDt}</div>
															</td>
															<td>
																<div class="text-center">${item.ctrtPre }개월</div>
															</td>
															<td>
																<div class="text-center">
																	<c:set var="expryDate" value="${item.ctrtExpryDt}" />
																	<%
																		Date expryDateObj = sdf.parse((String) pageContext.getAttribute("expryDate")); // 종료일을 Date로 변환
																	
																	    // 현재 날짜를 자정으로 설정
															            Calendar currentCalendar = Calendar.getInstance();
															            currentCalendar.set(Calendar.HOUR_OF_DAY, 0);
															            currentCalendar.set(Calendar.MINUTE, 0);
															            currentCalendar.set(Calendar.SECOND, 0);
															            currentCalendar.set(Calendar.MILLISECOND, 0);
															            Date currentDate = currentCalendar.getTime(); // 자정으로 설정된 현재 날짜

															            // 종료일도 자정으로 설정 (sdf로 포맷할 필요가 없으므로 직접 계산)
															            Calendar expryCalendar = Calendar.getInstance();
															            expryCalendar.setTime(expryDateObj);
															            expryCalendar.set(Calendar.HOUR_OF_DAY, 0);
															            expryCalendar.set(Calendar.MINUTE, 0);
															            expryCalendar.set(Calendar.SECOND, 0);
															            expryCalendar.set(Calendar.MILLISECOND, 0);
															            Date expryDateMidnight = expryCalendar.getTime(); // 자정으로 설정된 종료일
																		
																		long diff = expryDateObj.getTime() - currentDate.getTime(); // 밀리초로 차이 계산
																	long daysRemaining = diff / (1000 * 60 * 60 * 24); // 밀리초를 일로 변환

																	// 남은 일수가 0이면 "계약만료일", 음수이면 "종료" 출력
																	if (daysRemaining > 0) {
																		out.print(daysRemaining + "일");
																	} else if (daysRemaining == 0) {
																		out.print("계약만료일");
																	} else {
																		out.print("종료");
																	}
																	%>
																</div>
															</td>

															<td>
																<div class="text-center">
																	<c:choose>
																		<c:when test="${item.status == '계약중'}">
																			<span
																				class="badge fs-7 lh-1 py-5 px-2 d-flex flex-center"
																				style="background-color: #B1D690; color: black; height: 22px">
																				${item.status} </span>
																		</c:when>
																		<c:when test="${item.status == '계약만료'}">
																			<span
																				class="badge fs-7 lh-1 py-5 px-2 d-flex flex-center"
																				style="background-color: #F95454; color: black; height: 22px">
																				${item.status} </span>
																		</c:when>
																	</c:choose>
																</div>
															</td>
															<!-- 															<td class="text-end text-center"> -->
															<!-- 																	<a href="#" class="btn btn-sm btn-light btn-flex btn-center btn-active-primary" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">자세히 -->
															<!-- 																	<i class="ki-duotone ki-down fs-5 ms-1"></i></a> -->
															<!-- 																	<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true"> -->
															<!-- 																		<div class="menu-item px-3"> -->
															<%-- 																			<a href="#" class="menu-link px-3" data-bs-toggle="modal" data-bs-target="#ctrt" onclick="f_ctrt(${item.ctrtNo })">계약내역</a> --%>
															<!-- 																		</div> -->
															<!-- 																		<div class="menu-item px-3"> -->
															<%-- 																			<a href="#" class="menu-link px-3" data-bs-toggle="modal" data-bs-target="#company" onclick="f_company(${item.ctrtNo})">기업정보</a> --%>
															<!-- 																		</div> -->
															<!-- 																	</div> -->
															<!-- 																</td> -->
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

<!-- 모달 시작 -->
<div class="modal fade" tabindex="-1" id="ctrt">
	<div class="modal-dialog modal-dialog-scrollable"
		style="margin-left: 25%">
		<div class="modal-content" style="width: 800px;">

			<div class="modal-header">
				<h5 class="modal-title">계약내역</h5>
				<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
					data-bs-dismiss="modal">
					<i class="ki-duotone ki-cross fs-2x"> <span class="path1"></span>
						<span class="path2"></span>
					</i>
				</div>
			</div>

			<div class="modal-body" style="min-height: 250px;">
				<div class="card-toolbar">
					<div class="mb-3"
						style="display: flex; justify-content: end; align-items: center;">
						<div class="me-2" style="width: 100%;">
							<h3 id="ctrtList"></h3>
						</div>
					</div>
				</div>
				<div class="card card-flush" id="formKndList"
					style="min-height: 300px;">
					<div class="mt-5 mb-5">
						<div class="container-fluid">
							<div class="row" id="ctrtDetail"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer" style="height: 100px">
				<button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" tabindex="-1" id="company">
	<div class="modal-dialog modal-dialog-scrollable"
		style="margin-left: 25%">
		<div class="modal-content" style="width: 800px;">

			<div class="modal-header">
				<h5 class="modal-title">기업정보</h5>
				<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
					data-bs-dismiss="modal">
					<i class="ki-duotone ki-cross fs-2x"> <span class="path1"></span>
						<span class="path2"></span>
					</i>
				</div>
			</div>

			<div class="modal-body" style="min-height: 250px;">
				<div class="card-toolbar">
					<div class="mb-3"
						style="display: flex; justify-content: end; align-items: center;">
						<div class="me-2" style="width: 100%;">
							<h3 id="ctrtInfo"></h3>
						</div>
					</div>
				</div>
				<div class="card card-flush" id="formKndList"
					style="min-height: 300px;">
					<div class="mt-5 mb-5">
						<div class="container-fluid">
							<div class="row" id="comDetail"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer" style="height: 100px">
				<button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	let searchForm = $('#searchForm');      // 검색 및 페이징 처리 위한 Form
    let pagingArea = $('#pagingArea');		// 페이징 처리 위한 div
    let excelDown = $('#excelDown');
    let excelBtn = $('#excelBtn');
    let filterBtn = $("#filterBtn");
    
    filterBtn.on('click', function () {
        event.preventDefault();
        let filterSelect = $("#filterSelect").val(); // 선택된 정렬 옵션
        searchForm.find("input[name='searchOrder']").val(filterSelect); // 정렬 옵션 추가
        let pageNo = $(this).data("page");
        searchForm.find("#page").val(pageNo);
        searchForm.submit();
    });
    
    // 검색 버튼 눌렀을 때 키워드 검색
    $('#searchBtn').on('click', function() {
        searchForm.submit();
    });
    
    
    // pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
    pagingArea.on('click', 'a', function(event) {
        event.preventDefault();
        let pageNo = $(this).data('page');
        searchForm.find('#page').val(pageNo);
        searchForm.submit();
    });
    
    excelBtn.on("click", function () {
        Swal.fire({
            title: '엑셀 파일을 다운로드 하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#F06445',
            cancelButtonColor: '#4FC9DA',
            confirmButtonText: '예',
            cancelButtonText: '아니요',
            reverseButtons: false,
        }).then((result) => {
            if (result.isConfirmed) {
                // 사용자가 '예'를 클릭한 경우
                excelDown.attr("action", "/excel/contractdownExcel");
                excelDown.submit();
            }
        });
    });
});

function f_ctrt(ctrtNo){
	
	$.ajax({
		type: "get",
		url: "/groubear/detail.do?ctrtNo=" + ctrtNo,
		success: function(res){
		
			// 프리미엄 여부
			let premiumYn = res.premiumYn;
			if(premiumYn == 'Y'){
				type = '프리미엄';
			}else if(premiumYn == 'N'){
				type = '일반';
			}	
			
			// 남은기간
			let bgng = res.ctrtBgngDt;
			let expry = res.ctrtExpryDt;
			
			let startDate = new Date(bgng);
			let endDate = new Date(expry);

			let period = Math.round((endDate - startDate) / (1000 * 60 * 60 * 24));
			
			if(period < 0){
				period = '<span class="badge badge-danger fs-7 lh-1 py-5 px-2 d-flex flex-center" style="height: 22px">계약만료</span>';
            }
			
			$('#ctrtList').text(res.coNm);
			// 
			let html = "";
			
				html +=	`<table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered" id="kt_ecommerce_products_table">`;
				html += `<thead>`;
				html += `<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">`;
				html +=	`<div class="form-check form-check-sm form-check-custom form-check-solid me-3">`;
				html +=	`</div>`;
				html +=	`<th class="min-w-100px h4">계약유형</th>`;
				html +=	`<th class="min-w-100px h4">계약기간</th>`;
				html +=	`<th class="min-w-100px h4">계약금액</th>`;
				html +=	`<th class="min-w-100px h4">남은기간</th>`;
				html += `<tr>`;
				html += `<td><div class="text-center">\${type}</div></td>`;
				html += `<td><div class="text-center">\${res.ctrtPre}개월</div></td>`;
				html += `<td><div class="text-center">\${Number(res.ctrtAmt).toLocaleString()}원</div></td>`;
				html += `<td><div class="text-center">\${period}일</div></td>`;
				html += `</tr>`;
				html += `</tr>`;
				html += `</thead>`;
				html += `</table>`;
			
				
			$('#ctrtDetail').html(html);
			console.log(html);
		}
	});
}

function f_company(ctrtNo){
	
	$.ajax({
		type:"get",
		url:"/groubear/comDetail.do?ctrtNo=" + ctrtNo,
		success: function(res){
			
			$('#ctrtInfo').text(res.coNm);
			let html = "";
			
			html +=	`<table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered" id="kt_ecommerce_products_table">`;
			html += `<thead>`;
			html += `<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">`;
			html +=	`<div class="form-check form-check-sm form-check-custom form-check-solid me-3">`;
			html +=	`</div>`;
			html +=	`<th class="min-w-100px h4">기업주소</th>`;
			html +=	`<th class="min-w-100px h4">상세주소</th>`;
			html +=	`<th class="min-w-100px h4">전화번호</th>`;
			html +=	`<th class="min-w-100px h4">우편번호</th>`;
			html += `<tr>`;
			html += `<td><div class="text-center">\${res.coAddr}</div></td>`;
			html += `<td><div class="text-center">\${res.coDaddr}</div></td>`;
			html += `<td><div class="text-center">\${res.coTel}</div></td>`;
			html += `<td><div class="text-center">\${res.coZip}</div></td>`;
			html += `</tr>`;
			html += `</tr>`;
			html += `</thead>`;
			html += `</table>`;
			
			
			$('#comDetail').html(html);
			console.log(html);
		}
	});
}

</script>



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>시설 예약</h3>
		<h6>시설 에약 현황</h6>
	</div>
</div>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-fluid">
				<div class="card" id="workCard">
				
					<div class="card-header border-0 pt-6">
						<div class="card-title">
							<h2>시설 예약 현황</h2>
						</div>
						<div class="card-toolbar"> 
	                        <div class="d-flex justify-content-end" data-kt-filemanager-table-toolbar="base">
	                            <button type="button" class="btn btn-flex btn-light-info me-1 px-4 callJstree" id="searchModalBtn">
	                                <i class="ki-duotone ki-file-right fs-2"><span class="path1"></span><span class="path2"></span></i>
	                                	검색
	                            </button>
	                        </div>
	                        <div class="modal fade" id="searchModal" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered mw-650px">
									<div class="modal-content">
										<div class="modal-header" id="kt_modal_add_user_header">
											<h2 class="fw-bold">이용 내역 검색</h2>
											<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal" id="">
												<i class="ki-duotone ki-cross fs-1">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
											</div>
										</div>
										<div class="modal-body px-5 my-7">
											<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
												<div class="fv-row mb-7">
													<label class="required fw-semibold fs-6 mb-2">위치</label>
													<select class="col form-select form-select-solid fw-bold" id="select_ctgr" data-kt-select2="true"  data-allow-clear="true" data-kt-user-table-filter="role" data-hide-search="true">
														<option disabled="disabled" selected="selected">위치 선택</option>
														<c:forEach items="${fcltCtgrList }" var="list">
															<option value="${list.fcltCtgrCd }">${ list.fcltCtgrNm}</option>
														</c:forEach>
													</select>
													
												</div>
												<div class="fv-row mb-7">
													<label class="required fw-semibold fs-6 mb-2">시설</label>
													<select class="col form-select form-select-solid fw-bold" id="select_fclt" data-kt-select2="true"  data-allow-clear="true" data-kt-user-table-filter="role" data-hide-search="true">
														<option disabled="disabled" selected="selected">시설 선택</option>
													</select>		
													<span style="color: red;" id="fclt_null"></span>													
												</div>
												<div class="fv-row mb-7">
													<label class="required fw-semibold fs-6 mb-2">예약일</label>
													<input type="date" name="select_date" id="select_date"  class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
													<span style="color: red;" id="date_null"></span>
												</div>
											</div>
											<div class="text-center pt-10">
												<button type="button" class="btn btn-primary" id="searchBtn">
													<span class="indicator-label">검색</span>
													<span class="indicator-progress">Please wait... 
													<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
												</button>
											</div>
										</div>
									</div>
								</div>
							</div>						
						</div>
					</div>
					<div class="card-body py-4" id="workList">
						<table class="table align-middle table-row-dashed fs-6 gy-5" id="kt_table_users">
							<thead>
								<tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
									<th class="min-w-100px">번호</th>
									<th class="min-w-100px">예약자명</th>
									<th class="min-w-100px">예약일자</th>
									<th class="min-w-100px">예약시간</th>
									<th class="min-w-100px">위치</th>
									<th class="min-w-100px">시설명</th>
								</tr>
							</thead>
							<tbody class="text-gray-600 fw-semibold" id="reserveTable">
								<c:choose>
									<c:when test="${empty fcltreserveList }">
										<tr>
				                            <td colspan="6" class="dt-empty">
					                            <div class="d-flex flex-column flex-center mt-10">
								                    <img src="${pageContext.request.contextPath }/resources/file/image/cloudEmpty.png" class="mw-300px">
								                    <div class="fs-1 fw-bolder text-dark">예약 내역이 없습니다.</div>
			              				 		</div> 
		              						</td> 
	              						</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${fcltreserveList }" var="list">
											<tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
												<th class="min-w-100px">${list.fcltRsvtDsctnCd }</th>
												<th class="min-w-100px">${list.empNm }</th>
												<th class="min-w-100px">${list.rsvtYmd }</th>
												<th class="min-w-100px">${list.rsvtBgngTm} ~ ${list.rsvtEndTm }</th>
												<th class="min-w-100px">${list.fcltCtgrNm } </th>
												<th class="min-w-100px">${list.fcltNm } </th>
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
<script type="text/javascript">
$(function () {
	
	var searchModalBtn = $("#searchModalBtn");
	var searchModal = $("#searchModal");	
	var select_ctgr = $("#select_ctgr");
	var select_fclt = $("#select_fclt");
	var select_date = $("#select_date");
	var searchBtn = $("#searchBtn");
	searchModalBtn.on("click",function(){
		searchModal.modal("show");
	});
	
	select_ctgr.on("change",function(){
		var formData = {
			fcltCtgrCd : select_ctgr.val()
		};
		$.ajax({
			url : "/company/facilities/reserve/searchfclt.do",
			type : "post",
			contentType: "application/json; charset=utf-8",
	        data: JSON.stringify(formData) ,
	        success: function(res) {
	        	console.log(res);
				var fcltListHtml = "<option disabled='disabled' selected='selected'>시설 선택</option>";
				for (var i = 0; i < res.length; i++) {
					fcltListHtml += 
						"<option value='"+res[i].fcltCd+"'>"+res[i].fcltNm+"</option>"
					;
				}
				select_fclt.html(fcltListHtml);
	        },
	        error: function(res) {
	        	Swal.fire({
   	  				icon: 'warning',
   		  			title: '시설 조회를 실패했습니다. 다시 시도해주세요.',
   		  			confirmButtonColor: '#4FC9DA',
   				});	
	        }
		});	
		
	});
	
	searchBtn.on("click",function(){
		if($("#select_fclt option:selected").val() == null || $("#select_fclt option:selected").val() == '시설 선택'){
			$("#fclt_null").text("시설을 선택해주세요.");
			console.log("A");
			return false;
		}
		$("#fclt_null").text("");
		if(select_date.val() == null || select_date.val() == ""){
			$("#date_null").text("날짜를 선택해주세요.");
			console.log("B ");
			return false;
		}	
		$("#date_null").text("");
		var formData = {
			fcltCd : $("#select_fclt option:selected").val(),
			rsvtYmd : select_date.val()
		};
		$.ajax({
			url : "/company/facilities/reserve/searchfcltreserve.do",
			type : "post",
			contentType: "application/json; charset=utf-8",
	        data: JSON.stringify(formData) ,
	        success: function(res) {
	        	console.log("res.length::" + res.length);
				var reserveTable = $("#reserveTable");
				var ListHtml = "";
				if (res.length != 0) {
					for (var i = 0; i < res.length; i++) {
						ListHtml +="<tr class='text-start text-muted fw-bold fs-7 text-uppercase gs-0'>";
						ListHtml += 
							`
							<th class='min-w-100px'>\${res[i].fcltRsvtDsctnCd }</th>
							<th class='min-w-100px'>\${res[i].empNm }</th>
							<th class='min-w-100px'>\${res[i].rsvtYmd }</th>
							<th class='min-w-100px'>\${res[i].rsvtBgngTm } ~ \${res[i].rsvtEndTm}</th>
							<th class='min-w-100px'>\${res[i].fcltCtgrNm }</th>
							<th class='min-w-100px'>\${res[i].fcltNm }</th>
							`;
						ListHtml += "</tr>";	
					}	
				}else {
					ListHtml += `
						<tr>
                        <td colspan="6" class="dt-empty">
                            <div class="d-flex flex-column flex-center mt-10">
			                    <img src="${pageContext.request.contextPath }/resources/file/image/cloudEmpty.png" class="mw-300px">
			                    <div class="fs-1 fw-bolder text-dark">예약 내역이 없습니다.</div>
      				 		</div> 
  						</td> 
						</tr>
					`;
				}
				console.log("ListHtml::" , ListHtml);
				
				
				$("#reserveTable").html(ListHtml);
				searchModal.modal("hide");
	        },
	        error: function(res) {
	        	Swal.fire({
   	  				icon: 'warning',
   		  			title: '시설 조회를 실패했습니다. 다시 시도해주세요.',
   		  			confirmButtonColor: '#4FC9DA',
   				});	
	        }
		});	
	});
});
</script>			

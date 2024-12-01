<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>근태 관리</h3>
		<h6>금일 근무 현황</h6>
	</div>
</div>

<div> 
	<!--begin::App--> 
	<div class="d-flex flex-column flex-root app-root" id="kt_app_root">
		<!--begin::Page-->
		<div class="app-page flex-column flex-column-fluid" id="kt_app_page">
			<!--begin::Main-->
			<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
				<!--begin::Content wrapper-->
				<div class="d-flex flex-column flex-column-fluid">
					<!--begin::Content-->
					<div id="kt_app_content" class="app-content flex-column-fluid">
						<!--begin::Content container-->
						<div id="kt_app_content_container" class="app-container container-fluid">
							<!--begin::Products-->
							<div class="card card-flush" style="margin-bottom: 40px;">
                                
									<!--begin::Card header-->
									<div class="card-header align-items-center py-5 gap-2 gap-md-5">
										<!--begin::Card title-->
										<div class="card-title">
										</div>
										<!--end::Card title-->
										<div style="display: flex; justify-content: center;">
											<div class="card-toolbar flex-row-fluid justify-content-end gap-5">
												<div class="d-flex align-items-center position-relative my-1">
													<i class="ki-duotone ki-magnifier fs-3 position-absolute ms-4">
														<span class="path1"></span>
														<span class="path2"></span>
													</i>
												
					                            	<form id="searchForm">
							                            <input type="hidden" name="page" id="page">
													    <input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-12" style="margin-top: 0.5em;" placeholder="검색" value="${searchWord }"/>
						                            </form>
						                            <button id="searchBtn" type="button" class="btn btn-light-info mt-2" style="width: 100%;">
												    	검색
													</button>
												</div>
								        		 <div class="modal fade" id="searchDetailModal" tabindex="-1" aria-hidden="true">
													<div class="modal-dialog modal-dialog-centered mw-650px">
														<div class="modal-content">
															<div class="modal-header" id="kt_modal_add_user_header">
																<h2 class="fw-bold">상세 검색</h2>
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
																		<label class="required fw-semibold fs-6 mb-2">이름</label>
																		<input type="text" name="select_name" id="select_name"  class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
																		<span style="color: red;" id="name_null"></span>
																	</div>
																	<div class="fv-row mb-7">
																		<label class="required fw-semibold fs-6 mb-2">날짜</label>
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
									</div>
									<!--end::Card header-->
	
					        		
	
									<!--begin::Card body-->
									<div class="card-body pt-0 pb-0">
										<div align="center" id="dateDiv"> </div>
										<!--begin::Table-->
										<table class="table align-middle table-row-dashed fs-6 gy-5" id="kt_ecommerce_products_table">
											<thead>
												<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
													<th width="15%" class="h4">이름</th>  
													<th width="15%" class="h4">부서명</th>
													<th width="15%" class="h4">팀명</th>
													<th width="15%" class="h4">출근 시각</th>
													<th width="15%" class="h4">퇴근 시각</th>
													<th width="15%" class="h4">출근 상태</th>
													<th width="10%" class="h4"></th>
												</tr>
											</thead>
											<tbody class="fw-semibold text-gray-600">
												<c:set value="${pagingVO.dataList }" var="List"/>
												<c:choose>
													<c:when test="${empty List }">
														<tr>
															<td colspan="10" class="text-center pt-5">조회하신 인원이 존재하지 않습니다.</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${List }" var="item">
															<tr>
																<td>  
																	<div class="text-center">
																		<c:out value="${item.empNm}" />
																	</div>
																</td>
																<td>
																	<div class="text-center">
																		${item.deptNm }
																	</div>
																</td>
																<td>
																	<div class="text-center">
																		${item.teamNm }
																	</div>
																</td>
																<td>
																	<div class="text-center">
																			<c:if test="${fn:length(item.workBgngTm) eq '3' }">
																				0<c:out value="${fn:substring(item.workBgngTm,0,1) }"/>:<c:out value="${fn:substring(item.workBgngTm,1,3) }"/>
																			</c:if>
																			
																			<c:if test="${fn:length(item.workBgngTm) eq '4' }">
																				<c:out value="${fn:substring(item.workBgngTm,0,2) }"/>:<c:out value="${fn:substring(item.workBgngTm,2,4) }"/>
																			</c:if>
																	</div>
																</td>
																<td>
																	<div class="text-center">
																		<c:if test="${fn:length(item.workEndTm) eq '3' }">
																			0<c:out value="${fn:substring(item.workEndTm,0,1) }"/>:<c:out value="${fn:substring(item.workEndTm,1,3) }"/>
																		</c:if>
																		
																		<c:if test="${fn:length(item.workEndTm) eq '4' }">
																			<c:out value="${fn:substring(item.workEndTm,0,2) }"/>:<c:out value="${fn:substring(item.workEndTm,2,4) }"/>
																		</c:if>
																	</div>
																</td>
																<td>
																	<div class="text-center">
																		${item.workType }
																	</div>
																</td>
																<td>
																	<button type="button" id="sttsUdtBtn" name="sttsUdtBtn" class="btn btn-light-danger" onclick="sttsUdtBtn('${item.empId }')">
														                조회
														            </button> 
																</td>
															</tr>
														</c:forEach> 
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
										<!--end::Table-->
									</div>
									<!--end::Card body-->
	
									<div class="dt-paging paging_simple_numbers" id="pagingArea" style="margin-bottom: 10px;">
										${pagingVO.pagingHTML }
									</div>

							</div>
							<!--end::Products-->
						</div>
						<!--end::Content container-->
					</div>
					<!--end::Content-->
				</div>
				<!--end::Content wrapper-->
			</div>
			<!--end:::Main-->
		</div>
		<!--end::Page-->
	</div>
</div>


<!-- 기본 근무 설정 모달 -->
							<div class="modal fade" id="sttsModal" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered mw-650px">
									<div class="modal-content">
										<div class="modal-header" id="kt_modal_add_user_header">
											<h2 class="fw-bold">근무 설정</h2>
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
														<label class="fw-semibold fs-6 mb-2">출근 시간</label>
														<input type="time" name="start_tm" id="gtwk_tm" class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
													</div>
													<div class="fv-row mb-7">
														<label class="fw-semibold fs-6 mb-2">퇴근 시간</label>
														<input type="time" name="end_tm" id="lvrm_tm" class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
													</div>
													<div class="fv-row mb-7">
														<label class="fw-semibold fs-6 mb-2">출근 상태</label>
														<select class="form-select form-select-solid" id="modalselectVal" data-control="select2" data-dropdown-css-class="w-200px" data-placeholder="Select an option" data-hide-search="true">
														    <option selected >출근 상태</option>
														    <option value="WS001">출근</option>
														    <option value="WS002">지각</option>
														    <option value="WS003">결근</option>
														    <option value="WS005">휴가</option>	
														</select>
													</div>
													<div class="fv-row mb-7">
														<label class="fw-semibold fs-6 mb-2">수정 사유</label>
														<input type="text" name="mdfcnRsnInput" id="mdfcnRsnInput" class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
													</div>
												</div>
												<div class="text-center pt-10">
													<input type="hidden" id="empHidden" value=""/>
													<input type="hidden" id="wscd" value=""/>
													<button type="button" class="btn btn-primary" id="setSttsBtn">
														<span class="indicator-label">수정</span>
														<span class="indicator-progress">Please wait...</span> 
													</button>
													<button type="button" class="btn btn-warning" id="delSttsBtn">
														<span class="indicator-label">삭제</span>
														<span class="indicator-progress">Please wait...</span> 
													</button>
												</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 기본 근무 설정 모달 끝 -->


<script>
function sttsUdtBtn(empId) {
	console.log(empId)
	let startTm ="";
	let endTm = "";
	$("#empHidden").val(empId);
	$.ajax({
		url : "/company/getEmpTodayWorkStts.do",
		type : "post",
		contentType: "application/json; charset=utf-8",
           data: empId,
           success: function(res){
           	if (res.workBgngTm != null) {
           		if (res.workBgngTm.length != 4) {
   					startTm = "0"+res.workBgngTm.substr(0,1) + ":"+ res.workBgngTm.substr(1,3);
   				}else{
   					startTm = res.workBgngTm.substr(0,2) + ":"+ res.workBgngTm.substr(2,4);
   				}	
			}
           	if (res.workEndTm != null) {
           		if (res.workEndTm.length != 4) {
               		endTm = "0"+res.workEndTm.substr(0,1) + ":"+ res.workEndTm.substr(1,3);
   				}else{
   					endTm = res.workEndTm.substr(0,2) + ":"+ res.workEndTm.substr(2,4);
   				}	
			}
			$("#mdfcnRsnInput").val(res.workMdfcnRsn);				            	
     		 	$("#gtwk_tm").val(startTm);
     		 	$("#lvrm_tm").val(endTm);
     		 	$("#modalselectVal").val(res.workType).prop("selected",true);
     		 	$("#empHidden").val(empId);
     		 	$("#wscd").val(res.workSttsCd);
           }
	});
	
	$("#sttsModal").modal("show");
};

$(function() {
	let empId = "";
	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
	let searchForm = $("#searchForm");		
	let pagingArea = $("#pagingArea");		// 페이징 처리 위한 div
	
	// 검색 버튼
	let searchBtn = $("#searchBtn");
	
	// 출근상태 수정버튼
	var sttsUdtBtn = $("#sttsUdtBtn");
	
	// 출근상태 수정버튼
	let setSttsBtn = $("#setSttsBtn");

	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a 태그의 기본 기능 멈추기
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		
		let inputVal = $('#myInput').val();
		if (inputVal == "출근") {
			$('#myInput').val("WS001");
		}
		if (inputVal == "지각") {
			$('#myInput').val("WS002");
		}
		if (inputVal == "결근") {
			$('#myInput').val("WS003");
		}
		if (inputVal == "병가") {
			$('#myInput').val("WS004");
		}
		if (inputVal == "휴가") {
			$('#myInput').val("WS005");
		}
		
		$('#myInput').val("");
		$('#formatedDate').val();
		
		searchForm.submit();
	});
	

	
	setSttsBtn.on("click",function(){
		let mdfcnRsnInput = $("#mdfcnRsnInput").val();				            	
	 	let gtwkTm = $("#gtwk_tm").val();
	 	let lvrmTm = $("#lvrm_tm").val();
	 	let modalselectVal = $("#modalselectVal option:selected").val();
	 	let wscd = $("#wscd").val();
	 	let empId = $("#empHidden").val();
	 	console.log("!!!!!");
	 	console.log(empId);
	 	console.log(gtwkTm);
	 	console.log(lvrmTm);
	 	console.log(modalselectVal);
	 	console.log(mdfcnRsnInput);
	 	console.log(wscd);
		
	 	let formData = {
	 			workMdfcnRsn : mdfcnRsnInput,
	 			workBgngTm : gtwkTm.replace(":",""),
	 			workEndTm : lvrmTm.replace(":",""),
	 			workType : modalselectVal,
	 			empId : empId,
	 			workSttsCd : wscd
	 			
	 	}
	 	
	 	$.ajax({
	 		url : "/company/updateEmpTodayWorkStts.do" ,
	 		type : "post",
	 		contentType : "application/json; charset=utf-8",
	 		data: JSON.stringify(formData),
			success :  function(res){
				Swal.fire({
	  				icon: 'success',
		  			title: '수정 성공했습니다.',
		  			confirmButtonColor: '#4FC9DA',
				}).then(function () {
  					location.reload(true);
  					$("#sttsModal").modal('hide'); 
				})
	  			  
		    },
		    error: function(){
		      	Swal.fire({
						icon: 'warning',
			  			title: '수정 실패 다시 시도해주세요.',
			  			confirmButtonColor: '#4FC9DA',
					});
	      }
	 	}) 
	});		
	
	$("#delSttsBtn").on("click",function(){
		
		let wscd = $("#wscd").val();
		console.log(wscd);
		$.ajax({
	 		url : "/company/delEmpTodayWorkStts.do" ,
	 		type : "post",
	 		contentType : "application/json; charset=utf-8",
	 		data: wscd,
			success :  function(res){
				Swal.fire({
	  				icon: 'success',
		  			title: '삭제 성공했습니다.',
		  			confirmButtonColor: '#4FC9DA',
				}).then(function(){
					location.reload(true);
		  			$("#sttsModal").modal('hide');
				});
  			 
	  			  
		    },
		    error: function(){
		      	Swal.fire({
					icon: 'warning',
		  			title: '삭제 실패 다시 시도해주세요.',
		  			confirmButtonColor: '#4FC9DA',
				});
	      }
	 	});
		
	}); 
	$("#searchDetailBtn").on("click",function(){
		$("#searchDetailModal").modal("show");
	});
	
	$("#before_day_btn").on("click", function () {
		console.log("<");
	});
	$("#after_day_btn").on("click", function () {
		console.log(">");
	});
});


</script>
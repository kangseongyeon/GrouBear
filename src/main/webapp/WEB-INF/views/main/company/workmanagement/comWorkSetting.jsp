 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>근태 관리</h3>
		<h6>근무 관리</h6>
	</div>
</div>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-fluid">
				<div class="card" id="workCard">
				
					<div class="card-header border-0 pt-6">
						<div class="card-title">
							
						</div>
						
						<div class="card-toolbar">
							<div class="d-flex justify-content-end" data-kt-user-table-toolbar="base">
								<button type="button" class="btn btn-primary" id="baseworksettingbtn" >
								<i class="ki-duotone ki-plus fs-2"></i>기본 근무 설정</button>
								&nbsp;
								<button type="button" class="btn btn-primary" id="deptworksettingbtn">
								<i class="ki-duotone ki-plus fs-2"></i>부서별 근무 설정</button>
							</div>
							<!-- 기본 근무 설정 모달 -->
							<div class="modal fade" id="kt_modal_basic_work_setting" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered mw-650px">
									<div class="modal-content">
										<div class="modal-header" id="kt_modal_add_user_header">
											<h2 class="fw-bold">기본 근무 설정</h2>
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
														<label class="required fw-semibold fs-6 mb-2">출근 시간 설정</label>
														<input type="time" name="gtwk_tm" id="gtwk_tm" class="form-control form-control-solid mb-3 mb-lg-0"  value="${wfVO.workFormGtwkTm }" />
													</div>
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">퇴근 시간 설정</label>
														<input type="time" name="lvrm_tm" id="lvrm_tm" class="form-control form-control-solid mb-3 mb-lg-0"  value="${wfVO.workFormLvrmTm }" />
													</div>
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">휴게 시작 시간 설정</label>
														<input type="time" name="break_start" id="break_start" class="form-control form-control-solid mb-3 mb-lg-0"  value="${wfVO.workFormBreakBgngTm }" />
													</div>
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">휴게 종료 시간 설정</label>
														<input type="time" name="break_end" id="break_end" class="form-control form-control-solid mb-3 mb-lg-0"  value="${wfVO.workFormBreakEndTm }" />
													</div>

													<!--begin::Form group-->
													<div class="form-group d-flex flex-stack">            
														<!--begin::Heading-->     
														<div class="d-flex flex-column ">
															<label class="required fw-semibold fs-6 mb-2">근무 요일 설정</label>
														</div>
														<!--end::Heading-->
													
														<!--begin::Options-->
														<div class="d-flex gap-7">
														
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="sun" 
																		id="basic_setting_checkbox" 
																		name="checkbox_sun"
																		${wfVO.workFormSunYn }
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		일
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="mon" 
																		id="basic_setting_checkbox" 
																		name="checkbox_mon"
																		checked="checked"
																		${wfVO.workFormMonYn }
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		월
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="tue" 
																		id="basic_setting_checkbox" 
																		name="checkbox_tue"
																		checked="checked"
																		${wfVO.workFormTueYn }
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		화
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="web" 
																		id="basic_setting_checkbox" 
																		name="checkbox_web"
																		checked="checked"
																		${wfVO.workFormWebYn }
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		수
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="thu" 
																		id="basic_setting_checkbox" 
																		name="checkbox_thu"
																		checked="checked"
																		${wfVO.workFormThuYn }
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		목
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="fri" 
																		id="basic_setting_checkbox" 
																		name="checkbox_fri"
																		checked="checked"
																		${wfVO.workFormFriYn }
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		금
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="sat" 
																		id="basic_setting_checkbox" 
																		name="checkbox_sat"
																		${wfVO.workFormSatYn }
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		토
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																</div>
														<!--end::Options-->
													</div>
													<!--end::Form group-->
												</div>
												<div class="text-center pt-10">
													<button type="button" class="btn btn-primary" id="setBasicBtn">
														<span class="indicator-label">등록</span>
														<span class="indicator-progress">Please wait... 
														<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
													</button>
												</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 기본 근무 설정 모달 끝 -->

							<!-- 부서 근무 설정 모달 -->
							<div class="modal fade" id="dept_work_setting" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered mw-650px">
									<div class="modal-content">
										<div class="modal-header" id="kt_modal_add_user_header">
											<h2 class="fw-bold">부서 근무 설정</h2>
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
														<div style="float: right; margin-top: 3px; ">
															<input 
																class="form-check-input" type="checkbox" 
																value="fri" 
																id="get_base_work_from" 
																name="get_base_work_from_checkbox"
															/>
															<!--begin::Label-->
															<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																기본 근무 가져오기
															</label>
														</div>
													</div>
													<div class="fv-row mb-7">
														
														<!--end::Label-->
													    <label class="required fw-semibold fs-6 mb-2">부서명</label>
													    <select name="deptCd" id="deptSelect" class="form-control form-control-solid mb-3 mb-lg-0">
													       	<option value="" disabled selected>부서를 선택해주세요</option>
													        <c:forEach items="${deptList }" var="dept">
													        	<option value="${dept.deptCd }">${dept.deptNm }</option>
													        </c:forEach>
													    </select>
													    <div id="sel_null" style="color: red;"></div>
													</div>
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">출근 시간 설정</label>
														<input type="time" name="dept_gtwk_tm" id="dept_gtwk_tm" class="form-control form-control-solid mb-3 mb-lg-0"  value="${wfVO.workFormGtwkTm }" />
													</div>
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">퇴근 시간 설정</label>
														<input type="time" name="dept_lvrm_tm" id="dept_lvrm_tm" class="form-control form-control-solid mb-3 mb-lg-0"  value="${wfVO.workFormLvrmTm }" />
													</div>
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">휴게 시작 시간 설정</label>
														<input type="time" name="dept_break_start" id="dept_break_start" class="form-control form-control-solid mb-3 mb-lg-0"  value="${wfVO.workFormBreakBgngTm }" />
													</div>
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">휴게 종료 시간 설정</label>
														<input type="time" name="dept_break_end" id="dept_break_end" class="form-control form-control-solid mb-3 mb-lg-0"  value="${wfVO.workFormBreakEndTm }" />
													</div>

													<!--begin::Form group-->
													<div class="form-group d-flex flex-stack">            
														<!--begin::Heading-->     
														<div class="d-flex flex-column ">
															<label class="required fw-semibold fs-6 mb-2">근무 요일 설정</label>
														</div>
														<!--end::Heading-->
													
														<!--begin::Options-->
														<div class="d-flex gap-7">
														
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="sun" 
																		id="dept_setting_checkbox" 
																		name="dept_checkbox_sun"
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		일
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="mon" 
																		id="dept_setting_checkbox" 
																		name="dept_checkbox_mon"
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		월
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="tue" 
																		id="dept_setting_checkbox" 
																		name="dept_checkbox_tue"
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		화
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="web" 
																		id="dept_setting_checkbox" 
																		name="dept_checkbox_web"
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		수
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="thu" 
																		id="dept_setting_checkbox" 
																		name="dept_checkbox_thu"
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		목
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="fri" 
																		id="dept_setting_checkbox" 
																		name="dept_checkbox_fri"
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		금
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																<!--begin::Check-->
																<div class="form-check form-check-custom form-check-success form-check-solid form-check-sm" >
																	<input 
																		class="form-check-input" type="checkbox" 
																		value="sat" 
																		id="dept_setting_checkbox" 
																		name="dept_checkbox_sat"
																	/>
																	<!--begin::Label-->
																	<label class="form-check-label text-gray-700 fw-bold text-nowrap" for="kt_layout_builder_page_width_default">
																		토
																	</label>
																	<!--end::Label-->
																</div>
																<!--end::Check-->
																
																</div>
														<!--end::Options-->
													</div>
													<!--end::Form group-->
												</div>
												<div class="text-center pt-10">
													<button type="button" class="btn btn-primary" id="setDeptBtn">
														<span class="indicator-label">등록</span>
														<span class="indicator-progress">Please wait... 
														<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
													</button>
												</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 부서 근무 설정 모달 끝 -->
						</div>
						
					</div>
					
					<div class="card-body py-4" id="workList">
						<table class="table align-middle table-row-dashed fs-6 gy-5" id="kt_table_users">
							<thead>
								<tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
									<th class="min-w-100px">부서명</th>
									<th class="min-w-100px">출근시간</th>
									<th class="min-w-100px">휴게시간</th>
									<th class="min-w-100px">퇴근시간</th>
									<th class="min-w-100px">근무일</th>
								</tr>
							</thead>
							<tbody class="text-gray-600 fw-semibold">
							<c:forEach items="${wfList }" var="list">
								<tr>
									<td>
										<c:choose>
											<c:when test="${empty list.deptNm }">
												기본
											</c:when>
											<c:otherwise>
												${list.deptNm }		
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										${list.workFormGtwkTm }
									</td>
									<td>
										${list.workFormBreakBgngTm } ~ ${list.workFormBreakEndTm }
									</td>
									<td>${list.workFormLvrmTm }</td>
									<td>
										${list.workFormWeek }
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$(function() {
	// 기본
	var setBasicBtn = $("#setBasicBtn");
	var baseworksettingbtn = $("#baseworksettingbtn");
	var deptworksettingbtn = $("#deptworksettingbtn");
	
	var gtwk_tm = $("#gtwk_tm");			// 출근시간
	var lvrm_tm = $("#lvrm_tm");			// 퇴근시간
	var break_start = $("#break_start");	// 휴게시작시간
	var break_end = $("#break_end");		// 휴게종료시간	
	var checkbox_sun = $("input[name=checkbox_sun]");
	var checkbox_mon = $("input[name=checkbox_mon]");
	var checkbox_tue = $("input[name=checkbox_tue]");
	var checkbox_web = $("input[name=checkbox_web]");
	var checkbox_thu = $("input[name=checkbox_thu]");
	var checkbox_fri = $("input[name=checkbox_fri]");
	var checkbox_sat = $("input[name=checkbox_sat]");
	
	//부서별
	var setDeptBtn = $("#setDeptBtn");
	var dept_gtwk_tm = $("#dept_gtwk_tm");			// 출근시간
	var dept_lvrm_tm = $("#dept_lvrm_tm");			// 퇴근시간
	var dept_break_start = $("#dept_break_start");	// 휴게시작시간
	var dept_break_end = $("#dept_break_end");		// 휴게종료시간	
	var dept_setting_checkbox = $("#dept_setting_checkbox"); //체크 박스
	

	deptworksettingbtn.on("click",function(){
		$("#dept_work_setting").modal('show');
		
	});

	$("#get_base_work_from").on("change",function(){
		if ($("#get_base_work_from").prop("checked") == true) {
			console.log("!!!!");
			$.ajax({
				url : "/company/getbasesetting.do",
				type : "post",
				contentType: "application/json; charset=utf-8",
	            data: "",
	            success: function(res){
	            	console.log(res)
	            	dept_gtwk_tm.attr('value',res.workFormGtwkTm);
	            	dept_lvrm_tm.attr('value',res.workFormLvrmTm);
	            	dept_break_start.attr('value',res.workFormBreakBgngTm);
	            	dept_break_end.attr('value',res.workFormBreakEndTm);
	            	$("input[name=dept_checkbox_sun]").attr(res.workFormSunYn,true);
	            	$("input[name=dept_checkbox_mon]").attr(res.workFormMonYn,true);
	            	$("input[name=dept_checkbox_tue]").attr(res.workFormTueYn,true);
	            	$("input[name=dept_checkbox_web]").attr(res.workFormWebYn,true);
	            	$("input[name=dept_checkbox_thu]").attr(res.workFormThuYn,true);
	            	$("input[name=dept_checkbox_fri]").attr(res.workFormFriYn,true);
	            	$("input[name=dept_checkbox_sat]").attr(res.workFormSatYn,true);
	            }
			});
		}
	});
	
	
	$("#deptSelect").on("change", function () {
		console.log("change");
		var deptCd = $("#deptSelect").val();
		
		$.ajax({
			url : "/company/getdeptsetting.do",
			type : "post",
			contentType: "application/json; charset=utf-8",
            data: deptCd,
            success: function(res){
            	console.log(res)
            	dept_gtwk_tm.attr('value',res.workFormGtwkTm);
            	dept_lvrm_tm.attr('value',res.workFormLvrmTm);
            	dept_break_start.attr('value',res.workFormBreakBgngTm);
            	dept_break_end.attr('value',res.workFormBreakEndTm);
            	$("input[name=dept_checkbox_sun]").attr(res.workFormSunYn,true);
            	$("input[name=dept_checkbox_mon]").attr(res.workFormMonYn,true);
            	$("input[name=dept_checkbox_tue]").attr(res.workFormTueYn,true);
            	$("input[name=dept_checkbox_web]").attr(res.workFormWebYn,true);
            	$("input[name=dept_checkbox_thu]").attr(res.workFormThuYn,true);
            	$("input[name=dept_checkbox_fri]").attr(res.workFormFriYn,true);
            	$("input[name=dept_checkbox_sat]").attr(res.workFormSatYn,true);
            }
		});
	})

	setDeptBtn.on("click",function(){
		var deptSelect = $("#deptSelect").val();
		if (deptSelect == null || deptSelect == "") {
			$("#sel_null").text("부서를 선택해주세요.");
			return false;
		}
		$("#sel_null").text("");
		
		var gtwk_tm_val = dept_gtwk_tm.val();
		var lvrm_tm_val = dept_lvrm_tm.val();
		var break_start_val = dept_break_start.val();
		var break_end_val = dept_break_end.val();
		
		var sun = "N";
		var mon = "N";
		var tue = "N";
		var web = "N";
		var thu = "N";
		var fri = "N";
		var sat = "N";
		$("input[id='dept_setting_checkbox']:checked").each(function(e) {
			if ($(this).val() == 'sun') {
				sun = "CHECKED";
			}else if ($(this).val() == 'mon') {
				mon = "CHECKED";
			}else if ($(this).val() == 'tue') {
				tue = "CHECKED";
			}else if ($(this).val() == 'web') {
				web = "CHECKED";
			}else if ($(this).val() == 'thu') {
				thu = "CHECKED";
			}else if ($(this).val() == 'fri') {
				fri = "CHECKED";
			}else if ($(this).val() == 'sat') {
				sat = "CHECKED";
			}
		});
		
		var formData = {
				deptSelect : deptSelect,
				gtwk_tm_val : gtwk_tm_val,
				lvrm_tm_val : lvrm_tm_val,
				break_start_val : break_start_val,
				break_end_val : break_end_val,		
				sun : sun, 
				mon : mon,
				tue : tue,
				web : web,
				thu : thu,
				fri : fri,
				sat : sat
			}
			
			$.ajax({
				url : "/company/worksettingdept.do",
				type : "post",
				contentType: "application/json; charset=utf-8",
	            data: JSON.stringify(formData),
	            success: function(res){
	      		  Swal.fire({
			  				icon: 'success',
				  			title: '등록 성공했습니다.',
				  			confirmButtonColor: '#4FC9DA',
						}).then(function(){
				      		  location.reload(true);
			      			  $("#dept_work_setting").modal('hide'); 
			 			});
	      			  
			      },
			      error: function(){
			      	Swal.fire({
							icon: 'warning',
				  			title: '등록 실패 다시 시도해주세요.',
				  			confirmButtonColor: '#4FC9DA',
						});
			      }
			
			});
	});
	
	
	
	

	baseworksettingbtn.on("click",function(){
		$("#kt_modal_basic_work_setting").modal('show');
		
	});
	
	
	
	setBasicBtn.on("click", function () {
		
		var gtwk_tm_val = gtwk_tm.val();
		var lvrm_tm_val = lvrm_tm.val();
		var break_start_val = break_start.val();
		var break_end_val = break_end.val();		
		var sun = "N";
		var mon = "N";
		var tue = "N";
		var web = "N";
		var thu = "N";
		var fri = "N";
		var sat = "N";
		$("input[id='basic_setting_checkbox']:checked").each(function(e) {
			if ($(this).val() == 'sun') {
				sun = "CHECKED";
			}else if ($(this).val() == 'mon') {
				mon = "CHECKED";
			}else if ($(this).val() == 'tue') {
				tue = "CHECKED";
			}else if ($(this).val() == 'web') {
				web = "CHECKED";
			}else if ($(this).val() == 'thu') {
				thu = "CHECKED";
			}else if ($(this).val() == 'fri') {
				fri = "CHECKED";
			}else if ($(this).val() == 'sat') {
				sat = "CHECKED";
			}
		});
		
		
		var formData = {
			gtwk_tm_val : gtwk_tm_val,
			lvrm_tm_val : lvrm_tm_val,
			break_start_val : break_start_val,
			break_end_val : break_end_val,		
			sun : sun, 
			mon : mon,
			tue : tue,
			web : web,
			thu : thu,
			fri : fri,
			sat : sat
		}
		
		$.ajax({
			url : "/company/worksettingbasic.do",
			type : "post",
			contentType: "application/json; charset=utf-8",
            data: JSON.stringify(formData),
            success: function(res){
      		  Swal.fire({
  				icon: 'success',
	  			title: '등록 성공했습니다.',
	  			confirmButtonColor: '#4FC9DA',
			  }).then(function(){
	      		  location.reload(true);
 			});
      		  
      		  $("#kt_modal_basic_work_setting").modal('hide');  
		      },
		      error: function(){
		      	Swal.fire({
						icon: 'warning',
			  			title: '등록 실패 다시 시도해주세요.',
			  			confirmButtonColor: '#4FC9DA',
					});
		      }
		
		});
	});	
	
	
	

});

</script>					

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>근태 관리</h3>
		<h6>휴가 신청 내역</h6>
	</div>
</div>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-fluid">	
				<div class="card" id="workCard">
				
					<div class="card-header border-0 pt-6">
						<div class="card-title">
							<h1>휴가 신청 내역</h1>
						</div>
						
						<div class="card-toolbar">
							<div class="d-flex justify-content-end" data-kt-user-table-toolbar="base">
								<button type="button" class="btn btn-primary" id="vct_app_btn" name="vct_app_btn" >
								<i class="ki-duotone ki-plus fs-2"></i>휴가 신청</button>
							</div>
							<div class="modal-content modal-rounded">
								<div class="modal fade" id="modal_add_addrBook" tabindex="-1" aria-hidden="true">
									<div class="modal-dialog modal-fullscreen p-9">
										<div class="modal-content modal-rounded">
											<div class="row modal-body">
												<div class="col-12 col-xl-6">
													<div class="card card-flush h-xl-100 d-flex flex-column">
														<div class="card-header border-0 pt-7">
															<h1>${companyVO.coNm }</h1>
														</div>
														<div class="separator separator-dashed my-0"></div>
														<div class="row card-body pt-5">
															<div class="col-5">
																<div class="bg-gray-100 bg-opacity-70 rounded-2 px-6 pt-5 pb-5">
																	<div class="container mt-3 mb-max">
																		<h1>주소록</h1>
															            <div class="separator separator-dashed my-0 pt-3"></div>
																		<div class="scrollable-list pb-5" style="max-height: 355px; overflow-y: auto;">
																			<div class="d-flex align-items-center collapsible py-1 toggle mb-0" data-bs-toggle="collapse" data-bs-target="#kt_job_all">
																		        <div class="btn btn-sm btn-icon mw-20px btn-active-color-primary me-2">
																		            <i class="ki-duotone ki-plus-square toggle-off fs-1">
																		                <span class="path1"></span>
																		                <span class="path2"></span>
																		                <span class="path3"></span>
																		            </i>
																		            <i class="ki-duotone ki-minus-square toggle-on text-primary fs-1">
																		                <span class="path1"></span>
																		                <span class="path2"></span>
																		            </i>
																		        </div>
																		        <h4 class="text-gray-700 fw-bold cursor-pointer mt-2">전체 부서</h4>
																		    </div>
																		    <div class="container pl-max">
																			    <div id="kt_job_all" class="collapse fs-6">
																			        <c:forEach items="${deptTeamList}" var="dept">
																				    <div class="d-flex align-items-center collapsible py-1 toggle mb-0" data-bs-toggle="collapse" data-bs-target="#kt_job_${dept.deptCd}">
																				        <div class="btn btn-sm btn-icon mw-20px btn-active-color-primary me-2">
																				            <i class="ki-duotone ki-plus-square toggle-off fs-1">
																				                <span class="path1"></span>
																				                <span class="path2"></span>
																				                <span class="path3"></span>
																				            </i>
																				            <i class="ki-duotone ki-minus-square toggle-on text-primary fs-1">
																				                <span class="path1"></span>
																				                <span class="path2"></span>
																				            </i>
																				        </div>
																				        <h4 class="text-gray-700 fw-bold cursor-pointer mt-2">${dept.deptNm}</h4>
																				    </div>
																				    <div id="kt_job_${dept.deptCd}" class="collapse fs-6 ml-5">
																				        <c:forEach items="${dept.teamVO}" var="team">
																				            <div id="team_${team.teamCd }" class="nested-team-list mb-2 text-gray-600 fw-semibold fs-6 ps-10" style="flex-grow: 1; cursor: pointer;"> ㆍ ${team.teamNm}
																					        	<input type="hidden" id="teamCdVal" value="${team.teamCd }">
																				            </div>
																				        </c:forEach>
																				    </div>
																					</c:forEach>
																			    </div>
																		    </div>
																		</div>
																	</div>
																</div>
															</div>
															<div class="col-7">
															    <div class="bg-gray-100 bg-opacity-70 rounded-2 px-6 py-5" style="height: auto;">
															        <div class="container mt-3">
															            <div class="d-flex justify-content-between align-items-center">
							                                                <h1>사원 목록</h1>
							                                                <i class="ki-duotone ki-abstract-41 fs-5 text-gray-700" id="showAllEmployees" style="cursor: pointer;">
							   	                                                <span class="path1"></span>
							       	                                            <span class="path2"></span>
							           	                                    </i>
							                                            </div>
															            <table class="table">
															                <thead>
															                    <tr>
															                        <th style="width: 30px;">
															                            <div class="form-check form-check-sm form-check-custom form-check-solid">
															                                <input class="form-check-input" id="allChk" type="checkbox" value="1" style='cursor: pointer;'/>
															                            </div>
															                        </th>
															                        <th class="align-middle text-gray-600 fw-semibold fs-6" style="width: 180px;">아이디</th>
															                        <th class="align-middle text-gray-600 fw-semibold fs-6">이름</th>
															                    </tr>
															                </thead>
															            </table>
															            <div class="separator separator-dashed"></div>
															            <div class="scrollable-list" style="max-height: 300px; overflow-y: auto;">
															                <table class="table table-borderless" id="addrEmpList">
															                    <tbody>
															                        <c:forEach items="${empAllList}" var="emp">
															                            <tr>
															                                <td style="width: 30px;">
															                                    <div class="form-check form-check-sm form-check-custom form-check-solid">
															                                        <input class="form-check-input" name="chk" type="radio" value="${emp.empId }" style='cursor: pointer;'/>
															                                    </div>
															                                </td>
															                                <td class="align-middle">
															                                    <div class="fv-row mb-1 text-gray-600 fw-semibold fs-6" style="width: 150px;">${emp.empId}</div>
															                                </td>
															                                <td class="align-middle">
															                                    <div class="fv-row mb-1 text-gray-600 fw-semibold fs-6">${emp.empNm}</div>
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
												</div>
												<div class="col-12 col-xl-5">
													<div class="card card-flush h-xl-100 d-flex flex-column" id="empIdChk">
														<div class="row card-body" style="height: 500px;">
														    <div class="row col-12">  
														        <div style="display: flex"> 
														        	<h5 class="col-12" style="width: 82%;">휴가 신청서</h5> 
														        </div>
							                                    <div class="scrollable-list bg-opacity-70 rounded-2 px-6 py-1 ms-3" style="height: 100%; flex-grow: 1; cursor: pointer; border: 2px solid #aee2fc" id="card1">
																	<div class="fv-row mb-7">
																		<label class="required fw-semibold fs-6 mb-2">사용 가능 휴가 일수</label>
																		<input type="number" readonly="readonly" name="available_vct_cnt" id="available_vct_cnt" class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
																	</div>
																	<div class="fv-row mb-7">
																		<label class="required fw-semibold fs-6 mb-2">휴가 시작일</label>
																		<input type="date" name="start_dt" id="start_dt" class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
																	</div>
																	<div class="fv-row mb-7">
																		<label class="required fw-semibold fs-6 mb-2">휴가 종료일</label>
																		<input type="date" name="end_dt" id="end_dt" class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
																	</div>
																	<div class="fv-row mb-7">
																		<label class="required fw-semibold fs-6 mb-2">휴가 일수</label>
																		<input type="number" readonly="readonly" name="use_vct_cnt" id="use_vct_cnt" class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
																		<span style="color: red;" id="err_vct_cnt"></span>
																	</div>
																	<div class="fv-row mb-7">
																		<label class="required fw-semibold fs-6 mb-2">휴가 사유</label>
																		<textarea name="vct_rsn" id="vct_rsn" rows = "3" class="form-control form-control-solid mb-3 mb-lg-0" ></textarea>
																	</div>
							                                    </div>
							                                </div>
							                            </div>
							                            <div class="row card-body">
							                                <div class="col-12">
							                                    <h5>결재선</h5>
							                                    <div class="scrollable-list bg-gray-100 bg-opacity-70 rounded-2 px-6 py-1" style="flex-grow: 1; cursor: pointer;" id="card3" >
							                                        <div class="scrollable-list" style="height: 100px; max-height:100px; overflow-y: auto;  ">
							                                            <table class="table">
							                                                <tbody id="moveData3">
							                                                </tbody>
							                                            </table>
							                                        </div>
							                                    </div>
							                                    <br>
							                                    <div class="d-flex justify-content-end" data-kt-user-table-toolbar="base">
							                                    	<button type="button" class="btn btn-danger" id="insertBtn" name="vct_udt_btn"  >
																	<i class="ki-duotone ki-plus fs-2"></i>입력</button>
																	&nbsp; 
																	<button type="button" class="btn btn-primary" id="submitBtn" name="vct_udt_btn"  >
																	<i class="ki-duotone ki-plus fs-2"></i>휴가 신청</button>
																	&nbsp; 
																	<button type="button" class="btn btn-warning " onclick="$('#modal_add_addrBook').modal('hide');" >
																	<i class="ki-duotone ki-minus fs-2"></i>취소</button> 
																</div>
							                                </div>
							                            </div>
													</div>
													<div class="col-12 col-xl-2">
													<div class="col-12 col-xl-1 d-flex flex-column justify-content-between"> 
												    <div class="symbol-label d-flex justify-content-center" style="cursor: pointer;" onclick="$('#modal_add_addrBook').modal('hide');">
												        <!-- <img src="/upload/close_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png" class="w-25"> -->
												    </div>
												    <div class="symbol-label d-flex justify-content-center align-items-center" style="flex-grow: 1;">
												        <!-- <img src="/upload/arrow_forward_ios_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png" class="w-75" style="cursor: pointer;" id="submitBtn"> -->
												    </div>
												</div>
													</div>
												</div>
												
											</div>
										</div>
									</div>
								</div>
							</div>
							<input type="hidden" value="${companyVO.ceoId }" id="ceoIdVal">
							<input type="hidden" value="${companyVO.ceoNm }" id="ceoNmVal">
														
														
							<!-- 기본 근무 설정 모달 -->
						<div class="modal fade" id="chk_apr_modal" tabindex="-1" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered mw-650px">
								<div class="modal-content">
									<div class="modal-header" id="kt_modal_add_user_header">
										<h2 class="fw-bold">휴가 반려 사유</h2>
										<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal" id="">
											<i class="ki-duotone ki-cross fs-1">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>
										</div>
									</div>
									<div class="modal-body px-5 my-7">
										<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
											<input type="hidden" id="apr_cd" value="">
											<div class="fv-row mb-7" id="arp_rsn">
												<label class="fw-semibold fs-6 mb-2">사유</label>
												<textarea class="form-control form-control-solid mb-3 mb-lg-0" readonly="readonly" id="aprRsn" rows="5" cols="30" placeholder="사유를 입력해주세요." style="border: none; resize: none;"></textarea>
											</div>
										</div>
										<div class="text-center pt-10">
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 기본 근무 설정 모달 끝 -->							
														
						</div>
					</div>
					<div class="card-body py-4" id="workList">
						<table class="table align-middle table-row-dashed fs-6 gy-5" id="kt_table_users">
							<thead>
								<tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
									<th class="min-w" style="20%; text-align: center;">휴가 시작일</th>
									<th class="min-w" style="20%; text-align: center;">휴가 종료일</th>
									<th class="min-w" style="20%; text-align: center;">휴가일수</th>
									<th class="min-w" style="20%; text-align: center;">신청일</th>
									<th class="min-w" style="20%; text-align: center;">결제일</th>
									<th class="min-w" style="20%; text-align: center;">결제상태</th>
									<th class="min-w" style="20%; text-align: center;">반려 사유</th>
								</tr>
							</thead>
							<tbody class="text-gray-600 fw-semibold">
							
							<c:choose>
								<c:when test="${empty pagingVO.dataList }">
									<tr style="text-align: center;"> 
										<td colspan="7">휴가 신청 내역이 없습니다.</td>
									</tr>	
								</c:when>
							</c:choose>
							<c:forEach items="${pagingVO.dataList }" var="list">
								<tr>
									<td style="20%; text-align: center;">
										${list.vctBgngDt }
									</td>
									<td style="20%; text-align: center;">
										${list.vctBgngDt }
									</td>
									<td style="20%; text-align: center;">
										${list.vctUseDayCnt }
									</td>
									<td style="20%; text-align: center;">
										${list.vctRegDt }
									</td>
									<td style="20%; text-align: center;">
										${list.vctAplyAprYmd }
									</td>
									<td style="20%; text-align: center;">
										<c:choose>
											<c:when test="${list.vctAplyAprStts eq 'vaa001'}">
												대기
											</c:when>
											<c:when test="${list.vctAplyAprStts eq 'VAA002'}">
												승인
											</c:when>
											<c:when test="${list.vctAplyAprStts eq 'VAA003'}">
												반려
											</c:when>	
										</c:choose>
									
									</td>
									<td style="20%; text-align: center;">
										<!-- 상태가 반려일 경우 사유 버튼 생성 -->
										<c:if test="${list.vctAplyAprStts eq 'VAA003'}">
											<button class="btn btn-light-danger" onclick="chkAprRsn(${list.vctAplyCd})">사유 확인</button>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="dt-paging paging_simple_numbers" id="pagingArea" style="margin-bottom: 10px;">
						${pagingVO.pagingHTML }
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

function vat_ct_change() {
	var start_dt = $("#start_dt");
	var end_dt = $("#end_dt");
	
	if (start_dt.val() == '' && start_dt.val() == null) {
		return false;	
	}
	if (end_dt.val() == '' && end_dt.val() == null) {
		return false;	
	}
	
	var date_start_dt = new Date(start_dt.val());
	var date_end_dt = new Date(end_dt.val());
	
	if (date_start_dt > date_end_dt) {
		console.log("시작 날짜가  늦음");
		end_dt.val(start_dt.val());
		return false;
	}
	
    let diffTime = date_end_dt.getTime() - date_start_dt.getTime();
    
    // 밀리초를 일 단위로 변환합니다.
    let diffDays = (diffTime / (1000 * 60 * 60 * 24)) + 1;

    if (diffDays > $("#available_vct_cnt").val()) {
		$("#err_vct_cnt").text("사용 가능 휴가 일수보다 일수가 많습니다.");
		return false;
	}
    $("#use_vct_cnt").val(diffDays);
	
}

function chkAprRsn(code) {
	console.log("chk_apr_rsn");
	var formData = {
			vctAplyCd : code
	}
	$.ajax({
		url : "/employee/vacation/getRsn.do",
		type : "post", 
		contentType: 'application/json; charset=UTF-8',
		data : JSON.stringify(formData),
		success : function(res) {
			$("#aprRsn").val(res);
			$("#chk_apr_modal").modal("show");		
		}
		
	});
}


$(function() {
	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
	let searchForm = $("#searchForm");		
	let pagingArea = $("#pagingArea");		// 페이징 처리 위한 div
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a 태그의 기본 기능 멈추기
		var pageNo = $(this).data("page");
		$("#myInput").val('');
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	let vct_app_btn = $("#vct_app_btn");
	let vct_app = $("#vct_app");
	let modal_add_addrBook = $("#modal_add_addrBook");
	
	vct_app_btn.on("click", function() {
		console.log("111");
		$.ajax({
			url : "/employee/vacation/getVctCnt.do",
			type : "post",
			contentType: 'application/json; charset=UTF-8',
			success : function (res) {
				$("#available_vct_cnt").val(res);
			}
		});	
		modal_add_addrBook.modal("show");
	});
	
	
	// 시작일 종료일 수정시 휴가 일수 추가
	var start_dt = $("#start_dt");
	var end_dt = $("#end_dt");
	start_dt.on("change",function(){
		vat_ct_change();
	});
	end_dt.on("change",function(){
		vat_ct_change();
	});
	
	
	
	
	
	// 결재선
	var teamName = $(".nested-team-list");
    var moveData1 = $("#moveData1");
    var moveData2 = $("#moveData2");
    var moveData3 = $("#moveData3");
    var card3 = $("#card3");
    var nowCard = card3;
    var showAllEmployees = $("#showAllEmployees");
    var myArray = [];
    var submitBtn = $("#submitBtn");
    var sendToCeoCard1 = $("#sendToCeoCard1");
    nowCard = 'card3';
	console.log(nowCard);
	$("#card1").css("border", "none");
	$("#card2").css("border", "none");
	$("#card3").css("border", "2px solid #aee2fc");
	
	// 결재 버튼
    submitBtn.on("click", function () {
		let card3Data = "";
    	
	    moveData3.find('tr').each(function () {
	        let empId = $(this).data('emp-id');
	        let empNm = $(this).find('td:eq(1)').text(); // 이름 가져오기
	        card3Data += empId+",";
	       
	    });
	 	
		if($("#start_dt").val() == null && $("#start_dt").val() == "" &&
		   $("#end_dt").val() == null && $("#end_dt").val() == "" &&
		   card3Data == null && card3Data == ""){
			return false;
		}
		let formData = {
				aprList : card3Data,
				start_dt : $("#start_dt").val(),
				end_dt : $("#end_dt").val(),
				use_cnt : $("#use_vct_cnt").val(),
				vct_rsn : $("#vct_rsn").val()
		}	    
	    
		$.ajax({
			url : "/employee/vacation/vctapplication.do",
			type : "post",
			contentType: 'application/json; charset=UTF-8',
			data : JSON.stringify(formData),
			success : function (res) {
				Swal.fire({
	  				icon: 'success',
		  			title: '휴가 신청을 완료했습니다.',
		  			confirmButtonColor: '#4FC9DA',
				}).then(function(){
					$('#modal_add_addrBook').modal('hide');
					location.href = "/employee/vacation/applicationhistory.do";
				});
			},
			error : function () {
				Swal.fire({
   	  				icon: 'warning',
   		  			title: '휴가 신청 중 오류가 발생했습니다.',
   		  			confirmButtonColor: '#4FC9DA',
   				});	
			}
			
		});		

	   
	});
    
    
    
    showAllEmployees.on("click", function () {
        let addrEmpList = $("#addrEmpList");
        console.log("클릭이벤트실행 : ");
        updateAllChkState()
        $.ajax({
            url: "/addressbook/getaddrallemp.do",
            type: 'GET',
            contentType: 'application/json; charset=UTF-8',
            success: function (res) {
                let html = "";

                if (res && res.length > 0) {
                    res.forEach(emp => {
                        html += "<tbody>";
                        html += "<tr><td style='width: 30px;'><div class='form-check form-check-sm form-check-custom form-check-solid'><input class='form-check-input' type='checkbox' value='" + emp.empId + "' /></div></td>";
                        html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6' style='width: 150px;'>" + emp.empId + "</div></td>";
                        html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6'>" + emp.empNm + "</div></td></tr>";
                        html += "</tbody>";
                    });
                } else {
                    html += "<tr><td colspan='4' class='text-center text-gray-600 fw-semibold fs-6 pt-10'>사원 정보가 없습니다.</td></tr>";
                }

                addrEmpList.empty().append(html);

                // 팀 사원 목록을 불러온 후, 체크된 상태 유지
                $("#addrEmpList .form-check-input").each(function () {
                    let empId = $(this).val();
                    if ($("#moveData1 tr[data-emp-id='" + empId + "']").length > 0) {
                        $(this).prop('checked', true);
                    }
                    if ($("#moveData2 tr[data-emp-id='" + empId + "']").length > 0) {
                        $(this).prop('checked', true);
                    }
                    if ($("#moveData3 tr[data-emp-id='" + empId + "']").length > 0) {
                        $(this).prop('checked', true);
                    }
                });
            },
        });
	})
    
    card3.on("click", function () {
    	nowCard = 'card3';
    	console.log(nowCard);
    	$("#card1").css("border", "none");
    	$("#card2").css("border", "none");
    	$("#card3").css("border", "2px solid #aee2fc");
	});

    $(document).on("change", "#allChk", function () {
       	myArray = [];
        // 체크박스가 상위 체크박스일 경우
        if ($(this).is(':checked')) {
        	
        	
        	$("#empIdChk [data-emp-id]").each(function () {
                let firstEmpId = $(this).data('emp-id');
                if (!myArray.includes(firstEmpId)) {
                    myArray.push(firstEmpId);
                }
            });
        	
    		console.log("!!!"+myArray);
    		
            $("#addrEmpList .form-check-input").prop('checked', true); // 체크박스 체크
            $("#addrEmpList .form-check-input").each(function () {
                let empId = $(this).val();
                
                
                if (!myArray.includes(empId)) {
                    let empNm = $(this).closest('tr').find('td:eq(2)').text(); // 이름 가져오기
                    let html = "";
                 
                    html += "<tr data-emp-id='" + empId + "'><td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6' style='width: 150px;'>" + empId + "</div></td>";
                    html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6'>" + empNm + "</div></td>";
                    html += "<td class='align-middle'><i class='ki-duotone ki-trash fs-6 remove-emp' data-emp-id='" + empId + "' style='cursor: pointer; color: #gray;'><span class='path1'></span><span class='path2'></span><span class='path3'></span><span class='path4'></span><span class='path5'></span></i></td></tr>";
                    
                    if (nowCard === "card1") {
                        moveData1.append(html); 
    				}
                    if (nowCard === "card2") {
                        moveData2.append(html); 
    				}
                    if (nowCard === "card3") {
                        moveData3.append(html); 
    				}
                } else {
    				console.log("중복된 아이디 : " + empId);
    			}
            });
        } else {
        	//////////////////////////
        	$("#empIdChk [data-emp-id]").each(function () {
                let firstEmpId = $(this).data('emp-id');
                if (!myArray.includes(firstEmpId)) {
                    myArray.push(firstEmpId);
                }
            });
    		console.log(myArray);
    		console.log("이거 실행 안 되는 중");
    		$("#addrEmpList .form-check-input").prop('checked', false);
        	$("#addrEmpList .form-check-input").each(function () {
                let empId = $(this).val();
                console.log("중복된 아이디들  : " + empId);
                console.log("배열 안에 푸쉬된 값들  : " + myArray);
               
                if (myArray.includes(empId)) {
                	console.log("이거 실행 안 되는 중인가?");
                    $("#moveData1 tr[data-emp-id='" + empId + "']").remove();
                    $("#moveData2 tr[data-emp-id='" + empId + "']").remove();
                    $("#moveData3 tr[data-emp-id='" + empId + "']").remove();
                    
                    $(this).prop('checked', false);
                }
            });
	        myArray = [];
        }
    });


    $(document).on("change", ".form-check-input", function () {
        let empId = $(this).val();
        let empNm = $(this).closest('tr').find('td:eq(2)').text(); // 이름 가져오기
        console.log("moveDate CHK :::" , moveData3.html());
        
        if ($(this).is(':checked')) {
            // 체크된 경우: "옮긴 데이터"에 추가
	            $.ajax({
	                url: "/addressbook/getaddempid.do",
	                type: 'GET',
	                contentType: 'application/json; charset=UTF-8',
	                data: { empId: empId },
	                success: function (res) {
	                    let html = "";
	                    console.log("ajax 결과값 :", res);
	
	                    // res가 객체인지 확인
	                    if (!myArray.includes(empId)) {
		                    if (res && res.empId && res.empNm) {
		                        html += "<tr data-emp-id='" + res.empId + "'><td><div class='fv-row text-gray-600 fw-semibold fs-6' style='width: 150px;'>" + res.empId + "</div></td>";
		                        html += "<td><div class='fv-row text-gray-600 fw-semibold fs-6'>" + res.empNm + "</div></td>";
		                        html += "<td><i class='ki-duotone ki-trash fs-6 remove-emp' data-emp-id='" + res.empId + "' style='cursor: pointer; color: #gray;'><span class='path1'></span><span class='path2'></span><span class='path3'></span><span class='path4'></span><span class='path5'></span></i></td></tr>"; // 아이콘 추가
		
		                        if (nowCard === "card1") {
			                        moveData1.append(html); 
								}
		                        if (nowCard == "card2") {
			                        moveData2.append(html)
								}
		                        if (nowCard == "card3") {
			                        moveData3.html(html);
								}
		                    }
	                    }
	                    $("#empIdChk [data-emp-id]").each(function () {
	                        let firstEmpId = $(this).data('emp-id');
	                        if (!myArray.includes(firstEmpId)) {
	                            myArray.push(firstEmpId);
	                        }
	                    });
						console.log(myArray);
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    console.error("AJAX 호출 실패: " + textStatus, errorThrown);
	                }
	            });
        } else {
            // 체크 해제된 경우: "옮긴 데이터"에서 해당 사원 제거
            $("#moveData1 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 삭제
            $("#moveData2 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 삭제
            $("#moveData3 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 삭제
        }
        updateAllChkState();
        myArray = [];
    });

    // 아이콘 클릭 이벤트 추가
    $(document).on("click", ".remove-emp", function () {
        let empId = $(this).data('emp-id'); // 아이콘에 저장된 empId 가져오기
        $("#moveData1 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 해당 사원 제거
        $("#moveData2 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 해당 사원 제거
        $("#moveData3 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 해당 사원 제거
        $("#allChk").prop('checked', false);
        $("#addrEmpList .form-check-input[value='" + empId + "']").prop('checked', false); // 사원 목록에서 체크박스 해제
    });

    // 팀 클릭 이벤트
    teamName.on("click", function () {
        let teamCd = $(this).find("input[id='teamCdVal']").val(); 
        let addrEmpList = $("#addrEmpList");
        
        $.ajax({
            url: "/addressbook/getaddremp.do",
            type: 'GET',
            contentType: 'application/json; charset=UTF-8',
            data: { teamCd: teamCd },
            success: function (res) {
                let html = "";

                if (res && res.length > 0) {
                    res.forEach(emp => {
                        html += "<tbody>";
                        html += "<tr><td style='width: 30px;'><div class='form-check form-check-sm form-check-custom form-check-solid'><input class='form-check-input' style='cursor: pointer;' type='checkbox' value='" + emp.empId + "' /></div></td>";
                        html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6' style='width: 150px;'>" + emp.empId + "</div></td>";
                        html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6'>" + emp.empNm + "</div></td></tr>";
                        html += "</tbody>";
                    });
                } else {
                    html += "<tr><td colspan='4' class='text-center text-gray-600 fw-semibold fs-6 pt-10'>사원 정보가 없습니다.</td></tr>";
                }

                addrEmpList.empty().append(html);
				
                $("#addrEmpList .form-check-input").each(function () {
                    let empId = $(this).val();
                    if ($("#moveData1 tr[data-emp-id='" + empId + "']").length > 0) {
                        $(this).prop('checked', true);
                    }
                    if ($("#moveData2 tr[data-emp-id='" + empId + "']").length > 0) {
                        $(this).prop('checked', true);
                    }
                    if ($("#moveData3 tr[data-emp-id='" + empId + "']").length > 0) {
                        $(this).prop('checked', true);
                    }
                });
                updateAllChkState();
            },
        });
    });

    function updateAllChkState() {
        const allCheckboxes = $("#addrEmpList .form-check-input");
        const allChecked = allCheckboxes.length > 0 && allCheckboxes.length === allCheckboxes.filter(':checked').length;
        
        $("#allChk").prop('checked', allChecked);
    }

    $(document).on("change", "#addrEmpList .form-check-input", function () {
        updateAllChkState(); // individual checkbox 상태 변경 시 allChk 상태 업데이트
    });
	
    $("#insertBtn").on("click",function(){
    	$("#start_dt").val("2024-11-20");
    	$("#end_dt").val("2024-11-27");
    	$("#use_vct_cnt").val('8');
    	$("#vct_rsn").text("하와이 여행!!!");
    });
    
	
})
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>결재라인</h3>
		<h6>전자결재</h6>
	</div>
</div>
<div class="container">
	<!-- 사이드바 -->
		<!-- 결재 라인 List -->
		<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
			<!--begin::Content wrapper-->
			<div class="d-flex flex-column flex-column-fluid">
				<!--begin::Content-->
				<div id="kt_app_content" class="app-content flex-column-fluid">
					<!--begin::Content container-->
					<div id="kt_app_content_container" class="app-container container-fluid">
						<!--begin::Card-->
						<div class="card">
							<!--begin::Card header-->
							<div class="card-header border-0 pt-6">
								<!--begin::Card title-->
								<div class="card-title">
									<!--begin::Search-->
									<div class="d-flex align-items-center position-relative my-1">
										<i class="ki-duotone ki-magnifier fs-3 position-absolute ms-5">
											<span class="path1"></span>
											<span class="path2"></span>
										</i>
										<input type="text" data-kt-user-table-filter="search" class="form-control form-control-solid w-250px ps-13" placeholder="검색" />
									</div>
									<!--end::Search-->
									<!--begin::Add user-->
									<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#kt_modal_add_user">
									<i class="ki-duotone ki-plus fs-2 text-end"></i>Add User</button>
									<!--end::Add user-->
								</div>
								<!-- 결재요청 모달 시작 -->
								<div class="modal-content modal-rounded">
									<div class="modal fade" id="kt_modal_add_user" tabindex="-1" aria-hidden="true">
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
																                                        <input class="form-check-input" type="checkbox" value="${emp.empId }" style='cursor: pointer;'/>
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
															<div class="row card-body">
								                                <div class="col-12">
								                                    <h5>Card1</h5>
								                                    <div class="scrollable-list bg-gray-100 bg-opacity-70 rounded-2 px-6 py-1" style="height: 120px; flex-grow: 1; cursor: pointer; border: 2px solid #aee2fc" id="card1">
								                                        <div class="scrollable-list" style="max-height: 110px; overflow-y: auto;">
								                                            <table class="table">
								                                                <tbody id="moveData1">
								                                                </tbody>
								                                            </table>
								                                        </div>
								                                    </div>
								                                </div>
								                            </div>
								                            <div class="row card-body">
								                                <div class="col-12">
								                                    <h5>Card2</h5>
								                                    <div class="scrollable-list bg-gray-100 bg-opacity-70 rounded-2 px-6 py-1" style="height: 120px; flex-grow: 1; cursor: pointer;" id="card2">
								                                        <div class="scrollable-list" style="max-height: 110px; overflow-y: auto;">
								                                            <table class="table">
								                                                <tbody id="moveData2">
								                                                </tbody>
								                                            </table>
								                                        </div>
								                                    </div>
								                                </div>
								                            </div>
								                            <div class="row card-body">
								                                <div class="col-12">
								                                    <h5>Card3</h5>
								                                    <div class="scrollable-list bg-gray-100 bg-opacity-70 rounded-2 px-6 py-1" style="height: 120px; flex-grow: 1; cursor: pointer;" id="card3" >
								                                        <div class="scrollable-list" style="max-height: 110px; overflow-y: auto; ">
								                                            <table class="table">
								                                                <tbody id="moveData3">
								                                                </tbody>
								                                            </table>
								                                        </div>
								                                    </div>
								                                </div>
								                            </div>
														</div>
														<div class="col-12 col-xl-2">
														</div>
													</div>
													<div class="col-12 col-xl-1 d-flex flex-column justify-content-between"> 
													    <div class="symbol-label d-flex justify-content-center" style="cursor: pointer;" onclick="$('#modal_add_addrBook').modal('hide');">
													        <img src="/upload/close_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png" class="w-25">
													    </div>
													    <div class="symbol-label d-flex justify-content-center align-items-center" style="flex-grow: 1;">
													        <img src="/upload/arrow_forward_ios_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png" class="w-75" style="cursor: pointer;" id="submitBtn">
													    </div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--end::Modal - Add task-->
								<!--begin::Card title-->
								<!--begin::Card toolbar-->
								<div class="card-toolbar">
									<!--begin::Toolbar-->
									<div class="d-flex justify-content-end" data-kt-user-table-toolbar="base">
										
									</div>
									<!--end::Toolbar-->
									<!--begin::Group actions-->
									<div class="d-flex justify-content-end align-items-center d-none" data-kt-user-table-toolbar="selected">
										<div class="fw-bold me-5">
										<span class="me-2" data-kt-user-table-select="selected_count"></span>Selected</div>
										<button type="button" class="btn btn-danger" data-kt-user-table-select="delete_selected">Delete Selected</button>
									</div>
									
								</div>
								<!--end::Card toolbar-->
							</div>
							<!--end::Card header-->
							<!--begin::Card body-->
							<div class="card-body py-4">
								<!--begin::Table-->
								<table class="table align-middle table-row-dashed fs-6 gy-5" id="kt_table_users">
									<thead>
										<tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
											<th class="w-10px pe-2">
												<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
													<input class="form-check-input" type="checkbox" data-kt-check="true" data-kt-check-target="#kt_table_users .form-check-input" value="1" />
												</div>
											</th>
											<th class="min-w-50px">No</th>
											<th class="min-w-50px">결재순서</th>
											<th class="min-w-150px">결재자</th>
											<th class="min-w-100px">부서</th>
											<th class="min-w-100px">직급</th>
											<th class="min-w-100px">수정 / 삭제</th>
										</tr>
									</thead>
									<tbody class="text-gray-600 fw-semibold">
										<tr>
											<td>
												<div class="form-check form-check-sm form-check-custom form-check-solid">
													<input class="form-check-input" type="checkbox" value="1" />
												</div>
											</td>
											<td>1</td>
											<td>1</td>
											<td class="d-flex align-items-center">
												<!--begin:: Avatar -->
												<div class="symbol symbol-circle symbol-50px overflow-hidden me-3">
													<a href="#">
														<div class="symbol-label">
															<img src="#" alt="#" class="w-100" />
														</div>
													</a>
												</div>
												<!--end::Avatar-->
												<!--begin::User details-->
												<div class="d-flex flex-column">
													<a href="#" class="text-gray-800 text-hover-primary mb-1">사원명</a>
													<span>메일</span>
												</div>
												<!--begin::User details-->
											</td>
											<td>부서</td>
											<td>직급</td>
											<td>
												<a href="#" class="btn btn-light btn-active-light-primary btn-flex btn-center btn-sm" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">수정/삭제 
												<i class="ki-duotone ki-down fs-5 ms-1"></i></a>
												<!--begin::Menu-->
												<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">
													<!--begin::Menu item-->
													<div class="menu-item px-3">
														<a href="apps/user-management/users/view.html" class="menu-link px-3">수정</a>
													</div>
													<!--end::Menu item-->
													<!--begin::Menu item-->
													<div class="menu-item px-3">
														<a href="#" class="menu-link px-3" data-kt-users-table-filter="delete_row">삭제</a>
													</div>
													<!--end::Menu item-->
												</div>
												<!--end::Menu-->
											</td>
										</tr>
										
									</tbody>
								</table>
								<!--end::Table-->
							</div>
							<!--end::Card body-->
						</div>
						<!--end::Card-->
					</div>
					<!--end::Content container-->
				</div>
				<!--end::Content-->
			</div>
		</div>
	</div>

<script type="text/javascript">
$(function () {
    var teamName = $(".nested-team-list");
    var moveData1 = $("#moveData1");
    var moveData2 = $("#moveData2");
    var moveData3 = $("#moveData3");
    var card1 = $("#card1");
    var card2 = $("#card2");
    var card3 = $("#card3");
    var nowCard = "card1";
    var showAllEmployees = $("#showAllEmployees");
    var myArray = [];
    var submitBtn = $("#submitBtn");
    
    submitBtn.on("click", function () {
		let card1Data = [];
		let card2Data = [];
		let card3Data = [];
    	
		moveData1.find('tr').each(function () {
	        let empId = $(this).data('emp-id');
	        let empNm = $(this).find('td:eq(1)').text(); // 이름 가져오기
	        card1Data.push({ 
	        	empId: empId, 
	        	empNm: empNm 
	        });
	    });

	    moveData2.find('tr').each(function () {
	        let empId = $(this).data('emp-id');
	        let empNm = $(this).find('td:eq(1)').text(); // 이름 가져오기
	        card2Data.push({ 
	        	empId: empId, 
	        	empNm: empNm
	        });
	    });

	    moveData3.find('tr').each(function () {
	        let empId = $(this).data('emp-id');
	        let empNm = $(this).find('td:eq(1)').text(); // 이름 가져오기
	        card3Data.push({
	        	empId: empId,
	        	empNm: empNm 
	        });
	    });

	    console.log(card1Data);
	    console.log(card2Data);
	    console.log(card3Data);
	    
	    $("#card1List").val(JSON.stringify(card1Data));   // 받는 사람
	    $("#card2List").val(JSON.stringify(card2Data));          // 참조
	    $("#card3List").val(JSON.stringify(card3Data));         // 숨은 참조

	    $('#modal_add_addrBook').modal('hide');
	});
    
    
    
    showAllEmployees.on("click", function () {
        let addrEmpList = $("#addrEmpList");
        console.log("클릭이벤트실행 : ");

        $.ajax({
            url: "/company/getaddrallemp.do",
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
    
    card1.on("click", function () {
    	console.log("card1 클릭");
    	nowCard = 'card1';
    	console.log(nowCard);
    	
    	$("#card1").css("border", "2px solid #aee2fc");
    	$("#card2").css("border", "none");
    	$("#card3").css("border", "none");
    });    
    
    card2.on("click", function () {
    	console.log("card2 클릭");
    	nowCard = 'card2';
    	console.log(nowCard);
    	$("#card1").css("border", "none");
    	$("#card2").css("border", "2px solid #aee2fc");
    	$("#card3").css("border", "none");
	});
    
    card3.on("click", function () {
    	console.log("card3 클릭");
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
                if (firstEmpId) {
                    myArray.push(firstEmpId);
                }
            });
        	
			console.log(myArray);
			
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
            // 체크박스가 해제된 경우
            updateAllChkState();
            moveData1.empty(); // "옮긴 데이터"를 비우기
            moveData2.empty(); // "옮긴 데이터"를 비우기
            moveData3.empty(); // "옮긴 데이터"를 비우기
        }
        myArray = [];
    });

    $(document).on("change", ".form-check-input", function () {
        let empId = $(this).val();
        let empNm = $(this).closest('tr').find('td:eq(2)').text(); // 이름 가져오기
        
        myArray = [];
        
        $("#empIdChk [data-emp-id]").each(function () {
            let firstEmpId = $(this).data('emp-id');
            if (firstEmpId) {
                myArray.push(firstEmpId);
            }
        });
        
		console.log(myArray);
		
        if ($(this).is(':checked')) {
            // 체크된 경우: "옮긴 데이터"에 추가
            $.ajax({
                url: "/company/getaddempid.do",
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
		                        moveData3.append(html);
							}
	                    }
                    }
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
            url: "/company/getaddremp.do",
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

});

</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<div>
	<button type="button" class="btn btn-light-info ms-2" data-bs-toggle="modal" data-bs-target="#modal_add_addrBook">주소록 불러오기</button>
</div>
<p>체크박스 테스트12</p>

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
							    <div class="row col-12">  
							        <div style="display: flex"> 
							        	<h5 class="col-12" style="width: 82%;">Card1</h5> 
							        	<div>   
								            <span class="form-check-label me-2">대표 포함</span>
								            <input class="form-check-input" type="checkbox" id="sendToCeoCard1">
							        	</div>
							        </div>
                                    <div class="scrollable-list bg-gray-100 bg-opacity-70 rounded-2 px-6 py-1 ms-3" style="height: 120px; flex-grow: 1; cursor: pointer; border: 2px solid #aee2fc" id="card1">
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
<input type="hidden" value="${companyVO.ceoId }" id="ceoIdVal">
<input type="hidden" value="${companyVO.ceoNm }" id="ceoNmVal">

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
    var sendToCeoCard1 = $("#sendToCeoCard1");
    
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
	    
	    $("#card1List").val(JSON.stringify(card1Data));
	    $("#card2List").val(JSON.stringify(card2Data));
	    $("#card3List").val(JSON.stringify(card3Data));

	    $('#modal_add_addrBook').modal('hide');
	});
    
    sendToCeoCard1.on("change", function () {
    	console.log("바뀌긴 바뀜");
    	let ceoNm = $("#ceoNmVal").val();
    	let ceoId = $("#ceoIdVal").val();
    	
        if ($(this).is(':checked')) {
        	 let html = "<tr data-emp-id='" + ceoId + "'><td class='align-middle'><div class='fv-row mb-1 text-gray-900 fw-bold fs-6' style='width: 150px;'>" + ceoId + "</div></td>";
             html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-900 fw-bold fs-6'>" + ceoNm + "</div></td>";
             html += "<td class='align-middle text-gray-900 fw-bold fs-6'>대표</td></tr>";
            
            moveData1.append(html);
        } else {
        	$("#moveData1 tr[data-emp-id='" + ceoId + "']").remove();
        }
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
                if (!myArray.includes(firstEmpId)) {
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
		                        moveData3.append(html);
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

});

</script>
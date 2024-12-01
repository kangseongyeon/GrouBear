<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set value="등록" var="stts"/>
<c:if test="${status eq 'u' }">
	<c:set value="수정" var="stts"/>
</c:if>

<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>프로젝트 ${stts }</h3> 
		<h6>프로젝트</h6>
	</div>
</div>

<section class="tab-content">
<form id="projectForm" action="/employee/projectInsert.do" method="post">
	<input type="hidden" name="coCd" value="${employeeVO.coCd}"/>
	<c:if test="${status eq 'u' }">
		<input type="hidden" name="proNo" value="${projectVO.proNo }"/>
		<input type="hidden" name="proNo" value="${projectTaskVO.proNo}"/>
		<input type="hidden" name="coCd" value="${employeeVO.coCd}"/>
		
	</c:if>
		<div id="kt_app_content" class="app-container container-fluid">
			<div class="d-flex flex-column gap-7 gap-lg-10">
				<!-- 프로젝트 상태 등록 시작 (수정시) -->
				<%-- <c:if test="${status eq 'u' }">
					<div class="card card-flush py-4">
						<div class="card-header">
							<div class="card-title">
								<h2>진행상태</h2>
							</div>
							<div class="card-toolbar">
								<c:if test="${projectVO.proSttsCd == 'PRO001' }"><div class="rounded-circle bg-primary w-15px h-15px" id="kt_ecommerce_add_product_status"></div></c:if>
								<c:if test="${projectVO.proSttsCd == 'PRO002' }"><div class="rounded-circle bg-warning w-15px h-15px" id="kt_ecommerce_add_product_status"></div></c:if>
								<c:if test="${projectVO.proSttsCd == 'PRO003' }"><div class="rounded-circle bg-success w-15px h-15px" id="kt_ecommerce_add_product_status"></div></c:if>
							</div>
						</div>
						<div class="card-body pt-0">
						    <select class="form-select mb-2" data-control="select2" data-hide-search="true" data-placeholder="Select an option" id="kt_ecommerce_add_product_status_select" name="proSttsCd">
						        <option value="PRO001" ${projectVO.proSttsCd == 'PRO001' ? 'selected' : ''}>대기</option>
						        <option value="PRO002" ${projectVO.proSttsCd == 'PRO002' ? 'selected' : ''}>진행</option>
						        <option value="PRO003" ${projectVO.proSttsCd == 'PRO003' ? 'selected' : ''}>완료</option>
						    </select>
						</div>
					</div>
				</c:if> --%>
				<!-- 프로젝트 상태 등록 종료 -->
				<!-- 프로젝트 등록 시작 -->
				<div class="card card-flush py-4">
					<div class="card-header">
						<div class="card-title">
							<h2>프로젝트 ${stts }</h2>
						</div>
					</div>
					<!-- 프로젝트 내용 입력 시작 -->
					<div class="card-body pt-0">
						<!-- 프로젝트명 등록 시작 -->
						<div class="mb-10 fv-row">
							<label class="required form-label">프로젝트명</label>
							<input type="text" id="proNm" name="proNm" class="form-control mb-2" placeholder="프로젝트명을 입력하세요" value="${projectVO.proNm }" />
						</div>
						<!-- 프로젝트명 등록 종료 -->
						<!-- 프로젝트 설명 등록 시작 -->
						<div class="mb-10 fv-row">
							<label class="required form-label">프로젝트 내용</label>
								<input type="text" id="proCn" name="proCn" class="form-control mb-2" placeholder="프로젝트 설명을 입력하세요" value="${projectVO.proCn }" />
						</div>
						<!-- 프로젝트 설명 등록 종료 -->
						<!-- 프로젝트 참여일 등록 시작 -->
						<div class="row g-9 mb-8">
							<div class="col-md-6 fv-row">
								<label class="required fs-6 fw-semibold mb-2">시작일</label>
								<div class="position-relative d-flex align-items-center">
									<i class="ki-duotone ki-calendar-8 fs-2 position-absolute mx-4">
										<span class="path1"></span>
										<span class="path2"></span>
										<span class="path3"></span>
										<span class="path4"></span>
										<span class="path5"></span>
										<span class="path6"></span>
									</i>
									<input class="form-control form-control-solid ps-12 flatpickr-input active" placeholder="시작일을 등록하세요" type="datetime-local" id="proStartDt" name="proStartDt" value="${projectVO.proStartDt }" />
								</div>
							</div>
							<div class="col-md-6 fv-row">
								<label class="required fs-6 fw-semibold mb-2">마감일</label>
								<div class="position-relative d-flex align-items-center">
									<i class="ki-duotone ki-calendar-8 fs-2 position-absolute mx-4">
										<span class="path1"></span>
										<span class="path2"></span>
										<span class="path3"></span>
										<span class="path4"></span>
										<span class="path5"></span>
										<span class="path6"></span>
									</i>
									<input class="form-control form-control-solid ps-12" placeholder="마감일을 등록하세요" type="datetime-local"  id="proEndDt" name="proEndDt" value="${projectVO.proEndDt }" />
								</div>
							</div>
						</div>
						<!-- 프로젝트 참여일 등록 종료 -->
					</div>
					<!-- 프로젝트 내용 입력 종료 -->
				</div>
				<!-- 프로젝트 등록 종료 -->
				<!-- 프로젝트 참여자 등록 시작 -->
				<div class="card card-flush py-4">
					<div class="card-header">
						<div class="card-title">
							<h2>참여자 ${stts }</h2>
						</div>
					</div>
					<!-- 참여자 등록 시작 -->
					<div class="card-body pt-0">
						<div class="" data-kt-ecommerce-catalog-add-product="auto-options">
							<label class="required form-label">프로젝트 참여자를 ${stts }해주세요</label>
							<div id="kt_ecommerce_add_product_options">
							<div id="kt_ecommerce_add_product_options">
								<button type="button" class="btn btn-sm btn-light-primary" data-bs-toggle="modal" data-bs-target="#modal_add_addrBook"><i class="bi bi-person-check">참여자 등록</i></button>
								<c:if test="${status eq 'u' }">
									    <div id="participantList">
									        <c:forEach var="participant" items="${participantList}">
									            <div class="participant-info" style="margin-top: 5px;">
									                <span>${participant.empNm} (${participant.empId})</span>
									                <i class="ki-duotone ki-trash fs-6 remove-participant" data-emp-id="${participant.empId}" style="cursor: pointer;"></i>
									            </div>
									        </c:forEach>
									    </div>
								</c:if>
							</div>
						</div>
					</div>
					<!-- 참여자 등록 시작 -->
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
											        	<h1 class="col-12" style="width: 82%;">참여자</h1> 
											        </div>
											        <div class="separator separator-dashed my-0"></div>
				                                    <div class="scrollable-list bg-gray-100 bg-opacity-70 rounded-2 px-6 py-1 ms-3" style="height: 90%; flex-grow: 1; cursor: pointer; border: 2px solid #aee2fc" id="card1">
				                                        <div class="scrollable-list" style="max-height: 90%; overflow-y: auto;">
				                                            <table class="table">
				                                                <tbody id="moveData1">
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
				<input type="hidden" id="aplnList" name="card1List">
														
				<!-- 프로젝트 참여자 등록 시작 -->
				<!-- 버튼 시작 -->
				<div class="d-flex justify-content-end pt-7">
					<input type="button" value="${stts }" id="addBtn" class="btn btn-sm fw-bold btn-primary me-2">
					<c:if test="${status eq 'u' }">
						<input type="button" value="취소" id="cancelBtn" class="btn btn-sm btn-light fw-bold btn-active-light-primary me-2"> 
					</c:if>
					<c:if test="${status ne 'u' }">
						<input type="button" value="목록" id="listBtn" class="btn btn-sm btn-light fw-bold btn-active-light-primary me-2"> 
					</c:if>
				</div>
				<!-- 버튼 종료 -->
			</div>
		</div>
		<sec:csrfInput/>
	</form>
</section>
<div id="kt_app_footer" class="app-footer">
	<div class="app-container container-fluid d-flex flex-column flex-md-row flex-center flex-md-stack py-3"></div>
</div>
<script type="text/javascript">
$(function () {
	var listBtn = $("#listBtn");		// 목록 버튼
	var addBtn = $("#addBtn");			// 추가 버튼
	var cancelBtn = $("#cancelBtn");	// 취소 버튼
	
	
	var projectForm = $("#projectForm");
	
	
	// 목록 버튼
	listBtn.on("click", function () {
	  Swal.fire({
	    title: '작성을 취소하시겠습니까?',
	    icon: 'warning',
	    showCancelButton: true,
	    confirmButtonColor: '#4FC9DA',
	    cancelButtonColor: '#F06445',
	    confirmButtonText: '예',
	    cancelButtonText: '아니요',
	    reverseButtons: false,
	
	  }).then((result) => {
	    if (result.isConfirmed) {
	      location.href = "/employee/project.do";
	    }
	  });
	});

	// 취소 버튼
	cancelBtn.on('click', function () {
	  Swal.fire({
	    title: '편집을 취소하시겠습니까?',
	    icon: 'warning',
	    showCancelButton: true,
	    confirmButtonColor: '#4FC9DA',
	    cancelButtonColor: '#F06445',
	    confirmButtonText: '예',
	    cancelButtonText: '아니요',
	    reverseButtons: false,
	
	  }).then((result) => {
	    if (result.isConfirmed) {
	      location.href = "/employee/canbanList.do?proNo=${projectVO.proNo}";
	    }
	  })
	});
	
 	// 시작일 유효성 검사
	$("#proStartDt").on("change", function() {
		var proStartDt = $(this).val();
		var currentDt = new Date();
		var newStartDt = new Date(proStartDt);

		$("#kt_datepicker_3").flatpickr({
		    enableTime: true,
		    dateFormat: "Y-m-d H:i",
		});
		if (newStartDt < currentDt) {
			Swal.fire({
				title: '시작일은 현재일보다 과거일 수 없습니다.',
				icon: 'warning',
				confirmButtonColor: '#4FC9DA',
				confirmButtonText: '확인',
				reverseButtons: false,
				});
				$(this).val('');
			}
		});
	
	// 마감일 유효성 검사
	$("#proEndDt").on("change", function() {
		var proEndDt = $(this).val();
		var proStartDt = $("#proStartDt").val();
	
		if (proStartDt && new Date(proEndDt) < new Date(proStartDt)) {
			Swal.fire({
				title: '마감일은 시작일보다 빠를 수 없습니다.',
				icon: 'warning',
				confirmButtonColor: '#4FC9DA',
				confirmButtonText: '확인',
				reverseButtons: false,
		});
			$(this).val('');
		}
	});

	
	
	// 추가 버튼
	addBtn.on("click", function () {
	    var proNm = $("#proNm").val();
	    var proCn = $("#proCn").val();
	    var proStartDt = $("#proStartDt").val();
	    var proEndDt = $("#proEndDt").val();

	    // aplnList의 empId 값 확인
	    var empIds = $("input[name^='participantList']").map(function() {
	        return $(this).val();
	    }).get();

	    if (proNm == null || proNm == "" ||
	    	proCn == null || proCn == "" ||
	    	proStartDt == null || proStartDt == "" ||
	    	proEndDt == null || proEndDt == "") {
	        Swal.fire({
	            icon: 'warning',
	            title: '필수 입력이 비어있습니다.',
	            text: '필수 입력 내용을 채워주세요.',
	            confirmButtonColor: '#4FC9DA',
	        });
	        return false;
	    }

	    // 상태가 '수정'인 경우 액션 URL 변경
	    if ($(this).val() === "수정") {
	        projectForm.attr("action", "/employee/projectUpdate.do");
	    }

	    projectForm.submit();
	});

});


//jstree용 데이터 가공해서 추가하기
function f_createJstree(treeData) {
	// 트리 구조를 만들기 위한 객체
	const tree = {};

	// 데이터 구조를 트리 형태로 변환
	treeData.forEach(node => {
		tree[node.id] = { ...node, children: [] };
	});

	// 자식 노드를 연결
	Object.values(tree).forEach(node => {
		if (node.parent !== "#") {
			tree[node.parent].children.push(node);
		}
	});

	// 최상위 노드만 추출
	const rootNodes = Object.values(tree).filter(node => node.parent === "#");

	// 정해진 형식으로 HTML 생성하기
	const treeHTML = generateHTML(rootNodes);

	// 결과를 DOM에 삽입하기
	console.log(treeHTML);

	$('#treeUl').html(treeHTML); // treeUl에 jstree HTML을 삽입함

	// 삽입한 HTML을 jstree 형식과 매칭하기
	$('#formJstree').jstree({
		"core": {
			"themes": {
				"responsive": false
			}
		},
		"types": {
			"default": {
				"icon": "ki-outline ki-file text-warning"
			},
			"file": {
				"icon": "ki-outline ki-notification-status text-danger fs-7"
			}
		},
		"plugins": ["types", "dnd"]
	})

	// 양식을 선택하면 CKEDITOR에 양식 내용 삽입하기
	$("#formJstree").bind("select_node.jstree", function (event, data) {
		console.log(data.node.li_attr.value);
		let docFormNo = data.node.li_attr.value;
		
		docFormNoSelect = docFormNo;
	})

}

//HTML 생성 함수
function generateHTML(nodes) {
	let html = "";
	nodes.forEach(node => {
		const isRoot = node.parent === "#";
		html += `<li data-jstree='{"type" : "\${node.type}"` + (', "opened": true') + `}' value='\${node.id}'>\${node.text}`;

		// 자식 노드가 있는 경우 
		if (node.children && node.children.length > 0) {
			html += "<ul>" + generateHTML(node.children) + "</ul>"; // 자식 노드 재귀 호출
		}

		html += "</li>";
	});
	return html;
}

//결재 정보 모달
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
		        
		        console.log("empId : " + empId);
		        console.log("empNm : " + empNm);
		        
		        card1Data.push({ 
		        	empId: empId, 
		        	empNm: empNm
		        });
		    });


		    console.log(card1Data);
		    
		    
		    // 참여자 등록
		    let aplnHtml = '';
		    card1Data.forEach(function(emp, index) {
		    	console.log("index" + index);
		    	aplnHtml += `
		            <input type="hidden" name="participantList[\${index}].empId" value="\${emp.empId}">
		            <input type="hidden" name="participantList[\${index}].empNm" value="\${emp.empNm}">
		        `;
		    });
		    document.getElementById('aplnList').innerHTML = aplnHtml;
		    
		    console.log(aplnHtml);
		    
		    let participantHtml = '';
		    card1Data.forEach((emp, index) => {
		        participantHtml += `
		            <div class="participant-info" style="margin-top: 5px;">
		                <span>\${emp.empNm} (\${emp.empId})</span>
		            </div>`;
		    });
		    
		    // 참가자 정보를 id="kt_ecommerce_add_product_options" 아래에 추가
		    document.getElementById("kt_ecommerce_add_product_options").insertAdjacentHTML('beforeend', participantHtml);

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
	                });
	            },
	        });
		})
	    
	    card1.on("click", function () {
	    	console.log("card1 클릭");
	    	nowCard = 'card1';
	    	console.log(nowCard);
	    	
	    	$("#card1").css("border", "2px solid #aee2fc");
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
		
		                        let html = `
								    <tr data-emp-id='\${res.empId}'>
								        <td><div class='fv-row text-gray-600 fw-semibold fs-6' style='width: 150px;'>\${res.empId}</div></td>
								        <td><div class='fv-row text-gray-600 fw-semibold fs-6'>\${res.empNm}</div></td>
								        <td><div class='fv-row text-gray-600 fw-semibold fs-6'>\${res.deptCd}</div></td>
								        <td><div class='fv-row text-gray-600 fw-semibold fs-6'>\${res.jbgdCd}</div></td>
								        <td>
								            <i class='ki-duotone ki-trash fs-6 remove-emp' data-emp-id='\${res.empId}' style='cursor: pointer; color: #gray;'>
								                <span class='path1'></span>
								                <span class='path2'></span>
								                <span class='path3'></span>
								                <span class='path4'></span>
								                <span class='path5'></span>
								            </i>
								        </td>
								    </tr>
								`;

		                        
		                        if (nowCard === "card1") {
			                        moveData1.append(html); 
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
	        }
	        updateAllChkState();
	        myArray = [];
	    });

	    // 아이콘 클릭 이벤트 추가
	    $(document).on("click", ".remove-emp", function () {
	        let empId = $(this).data('emp-id'); // 아이콘에 저장된 empId 가져오기
	        $("#moveData1 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 해당 사원 제거
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- ckeditor API -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script> 

<!-- sweetalert2 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- jstree -->
<link href="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.js"></script>


<style>
	.expln {
	    margin-left: 0.5em;
	    color: white;
	    background-color: lightslategray;
	    width: 1.1em;
	    height: 1.1em;
	    line-height: 1.1em;
	}
	.fs-2x {
	    font-size: 1.5rem !important;
	}
	/* CKEDITOR 경고창 없애기 */
   .cke_notifications_area { display: none; }
</style>


<!-- 넘겨받은 메세지가 있을 때만 자바스크립트를 실행-->
<c:if test="${not empty message }">
	<script type="text/javascript">
		Swal.fire({ 
			icon: 'success',
			title: '${message}',
			confirmButtonColor: '#4FC9DA',
		});
	</script>
	<c:remove var="message" scope="request"/>
</c:if>

<div style="margin-bottom: 20px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>증명서 발급</h3>
		<h6>증명서 관리</h6>
	</div>
</div>


<div class="kt_app_content_container mx-5 mb-5" class="app-container container-fluid" style="height: 100%"> 
	<div class="card card-flush" style="height: 100%;">
                                
				<!--begin::Card header-->
				<div class="card-header align-items-center py-5 gap-2 gap-md-5">
					<!--begin::Card title-->
					<div class="card-title">
						<!--begin::Search-->
						<div class="d-flex align-items-center position-relative my-1">
															
                   			<form id="searchForm" style="display: contents;">
	                            <input type="hidden" name="page" id="page">
							    <input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-5" style="margin-top: 0.5em;" placeholder="증명서 검색" value="${searchWord }"/>
	                       		<button id="searchBtn" type="button" class="btn btn-flex btn-light-success ms-1 py-3 px-3" style="margin-top: 0.5em;">
	                       			<i class="ki-duotone ki-magnifier fs-2x">
										 <span class="path1" style="height: 1.1em;"></span> 
										 <span class="path2"></span>
									</i>
								</button>
                            </form>
                            
						</div>
						<!--end::Search-->
					</div>
					<!--end::Card title-->
					<div style="display: flex; justify-content: center;">
						<div class="card-toolbar flex-row-fluid justify-content-end gap-5">
			        		<button id="formCallJstree" type="button" class="btn btn-light-info mt-2" data-bs-toggle="modal" data-bs-target="#modal_add_addrBook" style="width: 100%;">
							   	증명서 발급하기 
							</button>
						</div>
					</div>
				</div>
				<!--end::Card header-->

				<!-- 주소록 모달 시작 -->
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
																<div class="d-flex align-items-center collapsible py-1 toggle mb-0  active" data-bs-toggle="collapse" data-bs-target="#kt_job_all" aria-expanded="true">
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
																	    <div class="d-flex align-items-center collapsible py-1 toggle mb-0  active" data-bs-toggle="collapse" data-bs-target="#kt_job_${dept.deptCd}">
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
											        	<h5 class="col-12" style="width: 80%;">사원선택</h5> 
											        	<div>   
												            <input class="form-check-input" type="checkbox" id="sendToCeoCard1">
												            <span class="form-check-label ms-2">대표 포함</span>
											        	</div>
											        </div>
				                                    <div class="scrollable-list bg-gray-100 bg-opacity-70 rounded-2 px-6 py-1 ms-3" style="height: 530px; flex-grow: 1; cursor: pointer; border: 2px solid #aee2fc" id="card1">
				                                        <div class="scrollable-list" style="max-height: 510px; overflow-y: auto;">
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
									        <img src="/upload/arrow_forward_ios_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png" class="w-75" style="cursor: pointer;" id="submitBtn" data-bs-toggle="modal" data-bs-stacked-modal="#proveCall1">
									    </div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<input type="hidden" value="${companyVO.ceoId }" id="ceoIdVal">
				<input type="hidden" value="${companyVO.ceoNm }" id="ceoNmVal">					
				<!-- 주소록 모달 끝 -->
									        
        		<!-- 증명서 신청 모달 시작 -->
				<div class="modal fade" tabindex="-1" id="proveCall1" style="background-color: #00000073">
				    <div class="modal-dialog modal-dialog-scrollable">
				        <div class="modal-content">
				            <div class="modal-header"> 
				                <h5 class="modal-title">증명서 선택</h5>
				                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
				                    <i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
				                </div>
				            </div>
                            <div class="modal-body" style="min-height: 200px">
                                <!-- jstree 시작 -->
                                <div class="card card-flush"> 
                                  
                                  <div class="card bg-light shadow-sm">
                                      <div class="card-header">
                                          <h3 class="card-title">증명서 목록</h3>
                                      </div>
                                      <div class="card-body">
                                      
                                        <div id="formJstree">
                                           <ul id="treeUl"></ul>
                                        </div>

                                      </div>
                                  </div>

                                </div>
                                <!-- jstree 끝 -->
                            	</div>
                              
							<div>
					            <button type="button" class="btn btn-primary preview" style="width: 100%">발급 미리보기</button>
							</div>
				        </div>
					</div>
				</div>
				
				<div class="modal fade" tabindex="-1" id="proveCall2">
				    <div class="modal-dialog modal-dialog-scrollable">
				        <div class="modal-content" style="width: 790px; min-height: 100%; margin-left: -100px;">
				            <div class="modal-header"> 
				                <h5 class="modal-title">발급 미리보기</h5>
				                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
				                    <i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
				                </div>
				            </div>
				
							<form id="empProvedocAplyInsert" action="/employee/empProvedocAplyInsert.do" method="post">
					            <input type="hidden" name="docFormNo" value="" id="docFormNo">
					            
					            
					            <div class="modal-body" style="min-height: 300px">
					            	<div style="height: 60px;">
						            	<span style="float: left;">
						            		<i class="ki-duotone ki-double-check text-warning fs-2">
												 <span class="path1"></span>
												 <span class="path2"></span>
											</i>
						            	</span>
						            	<span class="form-label ms-3">다중 선택시 가장 첫번째 사원의 정보가 반영됩니다.</span>
						            	<span>
								            <button type="button" class="btn btn-primary mb-5" id="proveCall3" style="float: right;">
								                	발급하기
								            </button>
								        </span>
					            	</div>
									<div class="mb-5">
									    <div class="container-fluid"> 
											<div class="row" id="provedocCn">
		 										<textarea id="provedocEditorCK" name="prdocCn" style="position: absolute;">
                                                </textarea> 
											</div>
 										</div>
									</div>
					            </div>
							</form>
				        </div>
					</div>
				</div>
				<!-- 증명서 신청 모달 끝 -->

				<!--begin::Card body-->
				<div class="card-body pt-0 pb-0">
					<!--begin::Table-->
					<table class="table align-middle table-row-dashed fs-4" id="kt_ecommerce_products_table">
						<thead>
							<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
								<th width="16%" class="h4">발급일</th>  
								<th width="11%" class="h4">부서</th>
								<th width="11%" class="h4">팀</th>
								<th width="11%" class="h4">사원명</th>
								<th width="11%" class="h4">사원아이디</th>
								<th width="32%" class="h4">증명서명</th>
								<th width="8%" class="h4">조회하기</th>  
							</tr>
						</thead>
						<tbody class="fw-semibold text-gray-600">
							<c:set value="${pagingVO.dataList }" var="provedocList"/>
							<c:choose>
								<c:when test="${empty provedocList }">
									<tr>
										<td colspan="7" class="text-center pt-10">
											<img src="${pageContext.request.contextPath }/resources/file/image/cloudEmpty.png" class="mw-600px">
											<div class="fs-1 fw-bold">발급한 증명서 내역이 없습니다</div> 
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${provedocList }" var="provedocVO">
										<tr>
											<td>  
												<div class="text-center">
													<c:out value="${fn:substring(provedocVO.prdocIsprDt, 0, 16)}" />
												</div>
											</td>
											<td>
												<div class="text-center">${provedocVO.deptNm }</div>
											</td>
											<td> 
												<div class="text-center">${provedocVO.teamNm }</div>
											</td>
											<td>
												<div class="text-center">${provedocVO.empNm }</div>
											</td>
											<td>
												<div class="text-center">${provedocVO.prdocInfoEmpId }</div>
											</td>
											<td>
												<div class="text-center"><a href="/company/provedocDetailIspr.do?prdocNo=${provedocVO.prdocNo }">${provedocVO.docFormNm }</a></div>
											</td> 
											<td>
												<button type="button" id="provedocIsprBtn" class="btn btn-light-danger" value="${provedocVO.prdocNo }" onclick="f_provedocIsprDetail('${provedocVO.prdocNo }')">
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
</div>

<script>
// jstree에서 선택한 양식의 번호
let docFormNoJstree = null;
var myArray = [];

$(function() {
	
	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
	let searchForm = $("#searchForm");		
	let pagingArea = $("#pagingArea");		// 페이징 처리 위한 div
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a 태그의 기본 기능 멈추기
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		
		$('#myInput').val("");
		
		searchForm.submit();
	});
	
	// 검색 버튼 눌렀을 때 키워드 검색
	$('#searchBtn').on('click', function() {
		searchForm.submit();
	});

	// 엔터키를 눌렀을 때 키워드 검색
	$('#searchForm').on('keydown', function(event) {
		if (event.keyCode == 13) {	// Enter 키를 눌렀을 때 (엔터키 == 13번)
			searchForm.submit();
	    }
	});
	
   /* CKEDITOR 자바스크립트 */
   CKEDITOR.replace( 'provedocEditorCK', {
      height: 700, 
      width: 740,
		// 사용하려는 툴바의 버튼을 문자열로 지정해서 포함시킴
		toolbar: [
		    { name: 'document', items: ['Source', 'ExportPdf', 'Print', 'Newpage'] },
		    { name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'Undo', 'Redo', 'Find', 'Replace', 'Selectall'] },
		    { name: 'alignment', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', 'BidirectionalLTR', 'BidirectionalRTL'] },
		    { name: 'styles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', 'Numberedlist', 'Bulletedlist', 'Outdent', 'Indent'] },
	        { name: 'insert', items: ['Image', 'Table', 'HorizontalRule', 'SpecialChar', 'PageBreak', 'CreateDiv', 'Insertdiv'] },
		    { name: 'custom', items: ['Styles', 'Font', 'FontSize', 'TextColor', 'BGColor', 'NumberedList', 'BulletedList', 'Maximize'] }
		]
   });
   
    // jstree 자바스크립트에서 사용할 계층형 데이터 가져오기
    $('#formCallJstree').on('click', function() {
    	$('#treeUl').html("");
       console.log("111");
       console.log("docFormNoJstree : " + docFormNoJstree);
        $.ajax({
            type: "get",
            url: "/company/provedocSelectJstree.do",
            success: function(data) {
                f_createJstree(data);
                console.log(data);
            }
        });
    });  
    
    // 발급 미리보기 버튼 눌렀을 때
	$('.preview').on('click', function() {
	    console.log("docFormNoJstree : " + docFormNoJstree);
		if (docFormNoJstree == null) {
	         Swal.fire({
	             icon: 'warning',
	             title: '양식을 선택해주세요!',
	             confirmButtonColor: '#4FC9DA',
	          });
	         return false;
		} else {
			 $('#proveCall2').modal('show');
		}
	});

    // 발급하기 버튼 누를 때
     $('#proveCall3').on('click', function() {
		console.log("발급하기 버튼");
		console.log(myArray)
		let content = CKEDITOR.instances.provedocEditorCK.getData();
		
		let data = {
			docFormNo : docFormNoJstree,
			empIdArr : myArray,
			prdocCn : content
		};
		
        $.ajax({
           url: "/company/comProvedocAplyAndIsprInsert.do",
           type: "post",
           data: JSON.stringify(data),
           contentType : "application/json; charset=utf-8",
           success: function(res) {
              CKEDITOR.instances.provedocEditorCK.setData(res.docFormCn);
              
              if (res == "OK") {
				  // Bootstrap 모달 숨기기
		          $('#proveCall1').modal('hide');
		          $('#proveCall2').modal('hide');
				
				 location.href= "/company/provedocIsprList.do";
              } else {
	      			Swal.fire({
	    				icon: 'warning',
	    				title: '서버에 오류가 발생했습니다!',
	    				text:  '다시 시도해주세요.',
	    				confirmButtonColor: '#4FC9DA',
	    			});
              }
              
          }
        }); 
	});  
    
	
	/* 주소록 시작 */
    var teamName = $(".nested-team-list");
    var moveData1 = $("#moveData1");

    var card1 = $("#card1");

    var nowCard = "card1";
    var showAllEmployees = $("#showAllEmployees");
    var submitBtn = $("#submitBtn");
    var sendToCeoCard1 = $("#sendToCeoCard1");
    
    submitBtn.on("click", function () {
		let card1Data = [];
    	
		moveData1.find('tr').each(function () {
	        let empId = $(this).data('emp-id');
	        let empNm = $(this).find('td:eq(1)').text(); // 이름 가져오기
	        card1Data.push({ 
	        	empId: empId, 
	        	empNm: empNm
	        });
	    });


	    console.log(card1Data);
	    
	    $("#card1List").val(JSON.stringify(card1Data)); 

/* 	    $('#modal_add_addrBook').modal('hide'); */
	});
    
    sendToCeoCard1.on("change", function () {
    	console.log("바뀌긴 바뀜");
    	let ceoNm = $("#ceoNmVal").val();
    	let ceoId = $("#ceoIdVal").val();
    	
        if ($(this).is(':checked')) { 
        	 let html = "<tr data-emp-id='" + ceoId + "'><td class='align-middle'><div class='fv-row mb-1 text-gray-900 fw-bold fs-6' style='width: 150px;'>" + ceoId + "</div></td>";
             html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-900 fw-bold fs-6'>" + ceoNm + "</div></td>";
             html += "<td class='align-middle text-gray-900 fw-bold'>대표</td></tr>";
            
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
	                        html += "<tr data-emp-id='" + res.empId + "'><td><div class='fv-row text-gray-600 fw-semibold fs-6' style='width: 150px;'>" + res.empId + "</div></td>";
	                        html += "<td><div class='fv-row text-gray-600 fw-semibold fs-6'>" + res.empNm + "</div></td>";
	                        html += "<td><i class='ki-duotone ki-trash fs-6 remove-emp' data-emp-id='" + res.empId + "' style='cursor: pointer; color: #gray;'><span class='path1'></span><span class='path2'></span><span class='path3'></span><span class='path4'></span><span class='path5'></span></i></td></tr>"; // 아이콘 추가
	
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
					console.log("myArray : ");
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
	/* 주소록 끝 */
});


// 조회 버튼을 눌렀을 때
function f_provedocIsprDetail(docNo) {
	location.href="/company/provedocDetailIspr.do?prdocNo=" + docNo;
}

// jstree용 데이터 가공해서 추가하기
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
   
    /* $("#formJstree").jstree(true).refresh(); */
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
    });
    
    // 양식을 선택하면 CKEDITOR에 양식 내용 삽입하기
    $('#formJstree').bind('select_node.jstree', function(event, data){ 
    	// 선택한 사원들 배열 (myArray)중에서 첫번째 배열만 가져와서 전달하기
    	let myArrayFirst = myArray[0];
    	console.log("myArrayFirst : " + myArrayFirst);

       // 노드를 선택했을 때 id = docFormNo 가져오기
       console.log(data.node.li_attr.value);
       let docFormNo = data.node.li_attr.value;
       docFormNoJstree = data.node.li_attr.value;
       
       $('#docFormNo').val(docFormNo);
       console.log("docFormNo : " + docFormNo);
       console.log("docFormNoJstree : " + docFormNoJstree);
       console.log("$('#docFormNo').val() : " + $('#docFormNo').val());
       
       $.ajax({
          url: "/company/proveSelectForm.do?docFormNo=" + docFormNo,
          type: "get",
          contentType : "application/json; charset=utf-8",
          success: function(res) {
             CKEDITOR.instances.provedocEditorCK.setData(res.docFormCn);
             
             // 회원의 정보를 증명서에 집어넣기
             $.ajax({
            	 url: "/company/selectEmpImpl.do?empId=" + myArrayFirst,
            	 type: 'get', 
            	 dataType: "JSON",
                 success: function(data) {
                	 console.log(data);
                	 
                     // CKEditor 내용 가져오기
                     let content = CKEDITOR.instances.provedocEditorCK.getData(); 
                     
                     content = content.replace(/\#\{(\w+)\}/g, function(match, key) {
/*                        	     console.log("Matched:", match); // 일치하는 문자열 출력
                   	     console.log("Key:", key); // 캡처된 키 출력
                   	     console.log("Data:", data[key]); // data 객체에서 키에 해당하는 값 출력 */
                         return data[key] !== null ? data[key] : ""; // 데이터가 없으면 빈칸 반환
                     });

                     // 업데이트된 내용 설정
                     CKEDITOR.instances.provedocEditorCK.setData(content); 
                 }
             });
         }
       });
    });
    
}
 
// HTML 생성 함수
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

</script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- sweetalert2 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
		<h3>양식관리</h3>
		<h6>양식관리</h6>
	</div>
</div>


<div class="kt_app_content_container mx-5 mb-5" class="app-container container-fluid" style="height: 100%"> 
	<div class="card card-flush" style="height: 100%;">
                                
		<!--begin::Card header-->
		<div class="card-header align-items-center py-5 gap-2 gap-md-5">
			<!--begin::Card title-->
			<div class="card-title">
				<div class="me-3">
	        		<button id="selectDelList" type="button" class="btn btn-secondary mt-2" style="width: 100%;">
						선택삭제
					</button>
	        	</div>
				<!--begin::Search-->
				<div class="d-flex align-items-center position-relative my-1">
				
                 			<form id="searchForm" style="display: contents;">
                           <input type="hidden" name="page" id="page">
					    <input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-2ㄴ50px ps-5" style="margin-top: 0.5em;" placeholder="양식 검색" value="${searchWord }"/>
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
				<div class="me-5">
	        		<button id="formKndAdd" type="button" class="btn btn-light-primary mt-2" data-bs-toggle="modal" data-bs-target="#formCall2" style="width: 100%;">
					    양식종류 추가하기
					</button>
	        	</div>
				
				<div class="card-toolbar flex-row-fluid justify-content-end gap-5">
					<a href="/groubear/formInsert.do" class="btn btn-light-info">양식 등록</a>
				</div>
			</div>
		</div>
		<!--end::Card header-->

      		<!-- 양식 추가하기 모달 시작 -->
		<div class="modal fade" tabindex="-1" id="formCall2">
		    <div class="modal-dialog modal-dialog-scrollable">
		        <div class="modal-content">
		            <div class="modal-header"> 
		                <h5 class="modal-title">양식 추가하기</h5>
		                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
		                    <i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
		                </div>
		            </div>
		
		            <div class="modal-body" style="min-height: 300px">
		            	<div class="row">
<%-- 		            	데이터 세팅하지 않은 기존 코드
				            <div class="card-toolbar col-6">
			                    <div class="mb-3" style="margin-top: 10%;">
				                    <div class="me-2">
					                    <div class="mb-5" style="margin-top: 10%;">
						                    <div class="me-2 text-center mt-2 mb-4">
								        		<h5>상위 양식 선택</h5>
								        	</div>
	                                                <select id="docFormKndNm" name="docFormKndUp" class="form-select" data-control="select2" data-hide-search="true">
	                                                   <option value="">선택</option>
	                                                   <c:forEach items="${docFormKndNmList }" var="docFormNm"> 
	                                                      <option value="${docFormNm.docFormNo }" <c:if test="${formVO.docFormKndNm == docFormNm.docFormNm }">selected="selected"</c:if>>${docFormNm.docFormNm }</option>
	                                                   </c:forEach>
	                                                </select> 
	                                             </div>
					                    <div class="mb-5" style="margin-top: 15%;">
						                    <div class="me-2 text-center mt-2 mb-4">
								        		<h5>추가할 양식 이름</h5>
								        	</div>
						                    <div class="mt-5">
								        		<input type="text" class="form-control" id="docFormKndNmAdd">
								        	</div>
								        	<div style="margin-left: 25%; margin-top: 10%;">
									            <input type="button" id="docFormNmAddBtn" class="btn btn-sm btn-primary" value="양식종류 추가" style="height: -webkit-fill-available;">
								        	</div>
					                    </div>
						        	</div>
			                    </div>
							</div>												        			
		             --%>
		             		<!-- 발표를 위한 데이터 세팅 -->
				            <div class="card-toolbar col-6">
			                    <div class="mb-3" style="margin-top: 10%;">
				                    <div class="me-2">
					                    <div class="mb-5" style="margin-top: 10%;">
						                    <div class="me-2 text-center mt-2 mb-4">
								        		<h5>상위 양식 선택</h5>
								        	</div>
                                            <select id="docFormKndNm" name="docFormKndUp" class="form-select" data-control="select2" data-hide-search="true">
                                               <option value="">선택</option>
                                               <c:forEach items="${docFormKndNmList }" var="docFormNm"> 
                                               		<c:choose>
                                               			<c:when test="${docFormNm.docFormNm eq '증명서' }">   
			                                                  <option value="${docFormNm.docFormNo }" selected="selected">${docFormNm.docFormNm }</option>
                                               			</c:when>
                                               			<c:otherwise>
			                                                  <option value="${docFormNm.docFormNo }">${docFormNm.docFormNm }</option>
                                               			</c:otherwise>
                                               		</c:choose>
                                               </c:forEach>
                                            </select> 
                                        </div>
					                    <div class="mb-5" style="margin-top: 15%;">
						                    <div class="me-2 text-center mt-2 mb-4">
								        		<h5>추가할 양식 이름</h5>
								        	</div>
						                    <div class="mt-5">
								        		<input type="text" class="form-control" id="docFormKndNmAdd" value="재직관련">
								        	</div>
								        	<div style="margin-left: 25%; margin-top: 10%;">
									            <input type="button" id="docFormNmAddBtn" class="btn btn-sm btn-primary" value="양식종류 추가" style="height: -webkit-fill-available;">
								        	</div>
					                    </div>
						        	</div>
			                    </div>
							</div>												        			
		            
		            
		            
							<div class="card card-flush col-6" id="formKndList" style="min-height: 200px;"> 
								<div class="mt-5 mb-5">
								    <div class="container-fluid"> 
															<div id="docFormNmRow">
	 										
 										<c:forEach items="${docFormKndNmList }" var="docFormNm">
 																<div>
 																	<span>${docFormNm.docFormNm }</span>  
												<button id="docFormNmDelBtn" class="btn btn-light p-1" style="background-color: #fdfcfb;" value="${docFormNm.docFormNo }">
													<i class="ki-duotone ki-cross fs-2x p-0">
														<span class="path1"></span>
														<span class="path2"></span>
													</i>
												</button>
 																</div>
		        						</c:forEach>
		        						
															</div>
														</div>
								
								</div>
						</div>
						
						
						
						</div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
		            </div>
		        </div>
			</div>
		</div>
		<!-- 양식 추가하기 모달 끝 -->

		<!--begin::Card body-->
		<div class="card-body pt-0 pb-0">
			<!--begin::Table-->
			<table class="table align-middle table-row-dashed fs-4" id="kt_ecommerce_products_table">
				<thead>
					<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
						<th width="5%" class="pe-2">
							<div class="form-check form-check-sm form-check-custom form-check-solid" style="display: flex; justify-content: center;">
								<input class="form-check-input" type="checkbox" data-kt-check="true" data-kt-check-target="#kt_ecommerce_products_table .form-check-input" value="1" />
							</div>
						</th> 
						<th width="15%" class="w-200px h4">양식종류</th> 
						<th width="38%" class="h4">양식명</th>  
						<th width="10%" class="h4">등록인</th>
						<th width="18%" class="h4">등록일시 / 수정일시</th>  
						<th width="14%" class="h4">수정/삭제</th>  
					</tr>
				</thead>
				<tbody class="fw-semibold text-gray-600">
					<c:set value="${pagingVO.dataList }" var="formList"/>
					<c:choose>
						<c:when test="${empty formList }">
							<tr>
								<td colspan="5" class="text-center pt-5">조회하신 게시글이 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${formList }" var="formVO">
								<form action="/groubear/formDelete.do" id="formDelete" method="post">
									<input type="hidden" name="docFormNo" value="${formVO.docFormNo }">
								</form>
								
								<tr>
									<td>  
<%-- 									    <sec:authentication property="principal.member" var="emp"/>
			                            <c:if test="${emp.empId eq formVO.empId}">  --%>
											<div class="form-check form-check-sm form-check-custom form-check-solid" style="display: flex; justify-content: center;">
												<input id="checkWriteList" class="form-check-input" type="checkbox" value="${formVO.docFormNo }" />
											</div>
<%-- 			                            </c:if> --%>
									</td>
									<td>
										<div class="text-center">${formVO.docFormKndNm }</div>
									</td>
									<td> 
										<div>
											<span>
												<a href="/groubear/formUpdate.do?docFormNo=${formVO.docFormNo }">${formVO.docFormNm }</a>&nbsp;
											</span>
											 
											<c:if test="${not empty formVO.docFormExpln }">
												<span>
													<button type="button" class="btn expln p-0" data-bs-toggle="tooltip" data-bs-placement="right" title="${formVO.docFormExpln }">
													   !
													</button> 
												</span>
											</c:if>
											
										</div>
									</td>
									<td>
										<div class="text-center">${formVO.empId }</div>
									</td>
									<td>
										<div class="text-center">
										    <c:out value="${fn:substring(formVO.docFormCrtDt, 0, 16)}" /><br>
										    <c:out value="${fn:substring(formVO.docFormMdfcnDt, 0, 16)}" /> 
										</div>
									</td> 
									<td class="text-end text-center">
<%-- 			                            <sec:authentication property="principal.member" var="emp"/>
			                            <c:if test="${emp.empId eq formVO.empId}"> --%>
					                        <a href="#" class="btn btn-sm btn-light btn-flex btn-center btn-active-light-primary" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">수정/삭제 
											<i class="ki-duotone ki-down fs-5 ms-1"></i></a>
											<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">
												<div class="menu-item px-3">
													<a href="/groubear/formUpdate.do?docFormNo=${formVO.docFormNo }" class="menu-link px-3">수정하기</a>
												</div>
												<div class="menu-item px-3">
													<a href="" id="deleteBtn" class="menu-link px-3" data-kt-ecommerce-product-filter="delete_row">삭제하기</a>
												</div>
											</div>
<%-- 			                            </c:if> --%>
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
	
	// 개별 양식 삭제하기 버튼을 눌렀을 때
	$('tbody #deleteBtn').on('click', function(event) {
		event.preventDefault();	// a 태그의 기본 기능 멈추기
		
		Swal.fire({
			title: '양식을 정말 삭제하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#F06445',
			cancelButtonColor: '#4FC9DA',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false, // 버튼 순서 (기본)
			
		}).then((result) => {
			if (result.isConfirmed) {
				$('#formDelete').submit();
			}
		});
	});

	
	// 양식 종류 삭제하기
	$('#docFormNmRow').on('click', '#docFormNmDelBtn', function() {
		let docFormNo = $(this).val();
		let docFormNmDelBtn = $(this);
		
		let data = {
				docFormNo : docFormNo,
		}
		
		Swal.fire({
			title: '양식 종류를 삭제하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#F06445',
			cancelButtonColor: '#4FC9DA',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false, // 버튼 순서 (기본)
			
		}).then((result) => {
			if (result.isConfirmed) {
				// 양식 종류 하위에 글이 있는지 확인하기
				$.ajax({
					type: "get",
					url: "/groubear/docFormKndWriteCheck.do?docFormNo=" + docFormNo,
				    success: function(res){
						if (res > 0) {
							Swal.fire({
								icon: 'warning',
								title: '해당 양식 종류에 속한 게시글이 있습니다.',
								text: '하위 양식을 모두 삭제한 후, 다시 시도해주세요.',
								confirmButtonColor: '#4FC9DA',
							});
							return false;
						} else {
							// 양식 종류 삭제하기
							$.ajax({
								url: "/groubear/docFormKndNmDel.do",
								type: "post",
								data: JSON.stringify(data),
								contentType : "application/json; charset=utf-8",
							    success: function(data){
							        docFormNmDelBtn.closest("div").remove();
							    }
							});
						}
					}
				});
			}
		});
	});
	
	
	// 양식 종류 추가 버튼 누를 때
	$('#docFormNmAddBtn').on('click', function() {
	    addDocFormKnd();
	});

	// 엔터키를 눌렀을 때 양식 추가
	$('#docFormKndNmAdd').on('keydown', function(event) {
		if (event.keyCode == 13) {	// Enter 키를 눌렀을 때 (엔터키 == 13번)
	        addDocFormKnd();
	    }
	});

	
	// 게시물 선택 삭제 하기
	$('#selectDelList').on('click', function() {
		let checkWriteList = $("tbody #checkWriteList");	// 모든 게시물 가져오기
		let checkArr = new Array();		// 선택된 게시글들의 번호를 넣을 배열
		
		// 체크가 된 상태의 게시물만 배열에 넣기
		for (var i = 0; i < checkWriteList.length; i++) {
			if (checkWriteList[i].checked) {
				checkArr.push(checkWriteList[i].value);
			}
		}
		
		if (checkArr == 0) {
			Swal.fire({
				icon: 'warning',
				title: '선택한 항목이 없습니다.',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}
		
		console.log();
		
		Swal.fire({
			title: '양식을 정말 삭제하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#F06445',
			cancelButtonColor: '#4FC9DA',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false, // 버튼 순서 (기본)
			
		}).then((result) => {	
			if (result.isConfirmed) {
				let data = {
					checkArr : checkArr
				}
				
				$.ajax({
					url: "/groubear/selectWriteListDelete.do",
					type: "post",
					data: JSON.stringify(data),
					contentType : "application/json; charset=utf-8",
					success: function(res) {
						if (res == "OK") {
							setTimeout(() => {
								location.href = "/groubear/formList.do";
							}, 1000);
							const Toast = Swal.mixin({
							    toast: true,
							    position: 'center-center',
							    showConfirmButton: false,
							    timer: 1000,
							    timerProgressBar: true,
							    didOpen: (toast) => {
								        toast.addEventListener('mouseenter', Swal.stopTimer)
								        toast.addEventListener('mouseleave', Swal.resumeTimer)
							    }
						    });
	
							Toast.fire({
							    icon: 'success',
							    title: '게시물이 정상적으로 삭제되었습니다.'
							});
						}
					}
				});
			}
		});
	});
});

// 양식 추가하는 함수
function addDocFormKnd() {
	let docFormKndNm = $('#docFormKndNmAdd').val();	// 추가할 양식 이름
	
    // 선택된 값 가져오기
    let selectForEach = document.getElementById("docFormKndNm");
    var selecteddocFormNo = selectForEach.options[selectForEach.selectedIndex].value; // docFormNo 값 가져오기

    console.log("상위번호" + selecteddocFormNo);
    
	if (selecteddocFormNo == "" || selecteddocFormNo == null) {
		Swal.fire({
			icon: 'warning',
			title: '상위 양식을 선택하지 않았습니다!', 
			confirmButtonColor: '#4FC9DA',
		});
		return false;
	}
    
	if (docFormKndNm == "" || docFormKndNm == null) {
		Swal.fire({
			icon: 'warning',
			title: '입력이 비어있습니다.', 
			confirmButtonColor: '#4FC9DA',
		});
		return false;
	}
	
	if (docFormKndNm.length > 7) {
		Swal.fire({
			icon: 'warning',
			title: '글자수가 너무 많습니다.',
			text: '양식 종류명을 7글자 이하로 작성해주세요.',
			confirmButtonColor: '#4FC9DA',
		});
		return false;
	}
	console.log(docFormKndNm);
	let data = {
			docFormKndNm : docFormKndNm,
			docFormKndUp : selecteddocFormNo
	}
	
	$.ajax({
		type: "post",
		url: "/groubear/docFormKndNmAdd.do",
		data: JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
	    success: function(res){
				        
	        // 스프링 EL 표현과 스크립트의 문자열 템플릿과 문법이 똑같아서, 자바에서 먼저 해석하기 때문에
	        // 자바가 먼저 해석하지 못하게 하기 위해서 이스케이스 문자 (\,역슬래시)를 붙이면
	        // 스프링에서 읽지 않고 그대로 놔두고, 이걸 나중에 자바스크립트에서 읽는다.
	        // jsp가 아니라면 역슬래시를 붙이면 안된다. (예/ js파일), jsp일때만 양쪽을 구분!!!!
	        
	    	let html = "";
	    	  
	    	for (var i = 0; i < res.length; i++) { 
    			
		    		html += `<div>`;
		    		html += `	<span>\${res[i].docFormNm }</span>`;
		    		html += `	<button id='docFormNmDelBtn' class='btn btn-light p-1' style='background-color: #fdfcfb;' value='\${res[i].docFormNo }'>`;
		    		html += `		<i class='ki-duotone ki-cross fs-2x p-0'>`;
		    		html += `			<span class='path1'></span>`;
		    		html += `			<span class='path2'></span>`;
		    		html += `		</i>`;
		    		html += `	</button>`;
		    		html += `</div>`;
		    		
    			
			}
	    	$('#docFormNmRow').html(html);
	    	/* console.log(html);	 */
	    }
	});
	$('#docFormKndNmAdd').val("");
};
</script>
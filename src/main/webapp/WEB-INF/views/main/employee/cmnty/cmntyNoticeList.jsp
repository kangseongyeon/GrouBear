<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- sweetalert2 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
.fs-2x {
    font-size: 1.5rem !important;
}
a {
  color: rgb(21 21 21);
  text-decoration: none;
}
a:hover { 
  color: rgb(57 196 215); 
  text-decoration: none;
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
		<h3>공지사항</h3>
		<h6>시스템 공지</h6>
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
					    <input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-2ㄴ50px ps-5" style="margin-top: 0.5em;" placeholder="게시글 검색" value="${searchWord }"/>
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
			<div style="display: flex; justify-content: center;">
				<div class="card-toolbar flex-row-fluid justify-content-end gap-5">
				</div>
			</div>
		</div>

		<div class="card-body pt-0 pb-0">
			<table class="table align-middle table-row-dashed fs-4" id="kt_ecommerce_products_table">
				<thead>
					<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
						<th width="55%" class="h4">제목</th> 
						<th width="12%" class="h4">등록자</th>
						<th width="20%" class="h4">등록일시</th>   
						<th width="13%" class="h4">조회수</th>  
					</tr>
				</thead>
				<tbody class="fw-semibold text-gray-600">
				
					<c:set value="${pagingVO.dataList }" var="cmntyNoticeList"/>
					
					<c:choose>
						<c:when test="${empty cmntyNoticeList }">
							<tr>
								<td colspan="6" class="text-center pt-5">조회하신 게시글이 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${cmntyNoticeList }" var="cmntyNoticeVO">
								<c:choose>
									<c:when test="${cmntyNoticeVO.cmntyNoticeYn eq 'Y' }">
										<tr style="height: 4em;">
											<td>
												<div>
													<div class="text-start ms-15">
														<a href="/employee/cmntyNoticeDetail.do?cmntyNo=${cmntyNoticeVO.cmntyNo }">
															<font class="fw-bold" style="color: red">[공지] </font>
															<font class="fw-bold text-gray-800">${cmntyNoticeVO.cmntyTtl }</font>
														</a> 
													</div>  
												</div>  
											<td>  
												<div class="text-center">그루베어</div>    
											</td>
											<td>
												<div class="text-center">
												    <c:out value="${fn:substring(cmntyNoticeVO.cmntyRegDt, 0, 10)}" />
												</div>
											</td>  
											<td class="text-end text-center">${cmntyNoticeVO.cmntyInqCnt }</td>
										</tr>
									</c:when> 
									<c:otherwise>
										<tr style="height: 4em;">
											<td> 
												<div>
													<div class="text-start ms-15">
														<a href="/employee/cmntyNoticeDetail.do?cmntyNo=${cmntyNoticeVO.cmntyNo }">
															<font class="text-gray-800">${cmntyNoticeVO.cmntyTtl }</font>
														</a> 
													</div>  
												</div>  
											<td>  
												<div class="text-center">그루베어</div>  
											</td> 
											<td>
												<div class="text-center">
												    <c:out value="${fn:substring(cmntyNoticeVO.cmntyRegDt, 0, 10)}" />
												</div>
											</td>  
											<td class="text-end text-center">${cmntyNoticeVO.cmntyInqCnt }</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					
				</tbody>
			</table>
		</div>

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
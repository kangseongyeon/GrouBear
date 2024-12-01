<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- sweetalert2 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
		<h3>Q&A</h3>
		<h6>시스템 공지</h6>
	</div>
</div>


<div id="kt_app_content_container" class="app-container container-fluid" style="height: 100%;">
	<div style="height: 100%;">
	
		<form action="/groubear/cmntyQstnList.do" id="searchForm" style="display: contents;"> 
			<input type="hidden" name="cmntyType" id="cmntyType"> 
		</form>
	
		<form action="/groubear/cmntyReplyDelete.do" id="delForm" style="display: contents;" method="post"> 
			<input type="hidden" name="cmntyNo" id="cmntyNo" value="${cmntyVO.cmntyNo }"> 
			<input type="hidden" name="commentNo" id="commentNo" value="${cmntyVO.commentNo }"> 
		</form>
		

		<!-- Q&A 메뉴 시작 -->
        <div class="card card-flush mb-2" style="height: 90px;">
            <div class="card-body d-flex fs-3" style="padding: 1em; align-items: center;">  
 
 				   <c:set value="" var="qstnCountAll"/>
 				   <c:set value="" var="qstnCountService"/>
 				   <c:set value="" var="qstnCountPrice"/>
 				   <c:set value="" var="qstnCountOther"/>
 				    
 				   <c:set value="${qstnListCount }" var="qstnListCount"/>
 				   <c:forEach items="${qstnListCount }" var="qstnCount">
 				   		<c:if test="${not empty qstnCount.cmntyQstnAllcount }">
 				   			<c:set value="${qstnCount }" var="qstnCountAll"/>
 				   		</c:if>
 				   		<c:if test="${qstnCount.comDtlCd eq 'QSTNKND001' }">
 				   			<c:set value="${qstnCount }" var="qstnCountService"/>
 				   		</c:if>
 				   		<c:if test="${qstnCount.comDtlCd eq 'QSTNKND002' }">
 				   			<c:set value="${qstnCount }" var="qstnCountPrice"/>
 				   		</c:if> 
 				   		<c:if test="${qstnCount.comDtlCd eq 'QSTNKND003' }">
 				   			<c:set value="${qstnCount }" var="qstnCountOther"/>
 				   		</c:if>
 				   </c:forEach>
 					
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('All')">
                            <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-danger me-3"><span class="path1"></span><span class="path2"></span></i>
                            </span>
                          	<span class="menu-title">전체</span>
                          	<span class="position-absolute top-10 start-100 translate-middle badge badge-circle badge-danger">${qstnCountAll.cmntyQstnSttsAllN }</span>
                       </div>
                   </div>  
 
 					<div class="start-0 top-0 w-3px rounded-2 ms-13" style="background-color: #acaaaa; height: 1.8em;"></div> 
 
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('QSTNKND001')">
                           <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-success me-3"><span class="path1"></span><span class="path2"></span></i>
                              </span>
                          	<span class="menu-title">서비스이용</span>
                          	<c:if test="${qstnCountService.cmntyQstnSttsNCount > 0}">
                          		<span class="position-absolute top-10 start-100 translate-middle badge badge-circle badge-danger">${qstnCountService.cmntyQstnSttsNCount }</span>
                       		</c:if>
                       </div>
                   </div>
  
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('QSTNKND002')">
                           <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-info me-3"><span class="path1"></span><span class="path2"></span></i>
                              </span>
                          	<span class="menu-title">가격</span>
                          	<c:if test="${qstnCountPrice.cmntyQstnSttsNCount > 0}">
                          		<span class="position-absolute top-10 start-100 translate-middle badge badge-circle badge-danger">${qstnCountPrice.cmntyQstnSttsNCount }</span>
                       		</c:if>
                       </div>
                   </div>
 
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('QSTNKND003')">
                           <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-primary me-3"><span class="path1"></span><span class="path2"></span></i>
                              </span>
                          	<span class="menu-title">기타</span>
                          	<c:if test="${qstnCountOther.cmntyQstnSttsNCount > 0}">
                          		<span class="position-absolute top-10 start-100 translate-middle badge badge-circle badge-danger">${qstnCountOther.cmntyQstnSttsNCount }</span>
                       		</c:if>
                       </div>
                   </div>

            </div>
        </div>
		<!-- Q&A 메뉴 시작 -->	

        <div class="p-0 mb-2" style="height: 85%">  
	        <div class="card card-flush">
	        
			    <div class="card-header pt-9 d-flex mb-6">  
					<div class="text-gray-900 d-flex"> 
                    	<c:choose>
                    		<c:when test="${cmntyVO.cmntyQstnSttsYn eq 'N' }">
								<span class="badge badge-light-danger fs-4 d-flex flex-center px-6 py-6 me-5" style="height: 35px">
	                    			대기중 
				                </span>  
                    		</c:when>
                    		<c:otherwise>
								<span class="badge badge-light-primary fs-4 d-flex flex-center px-6 py-6 me-5" style="height: 35px">
	                    			답변완료
				                </span>
                    		</c:otherwise>
                    	</c:choose> 
						<h2 class="mt-2">
							<span>[${cmntyVO.comDtlCdNm }] </span>
							<span>${cmntyVO.cmntyTtl }</span>
							<span class="ms-2"> 
								<c:if test="${cmntyVO.cmntyPrvtPstYn eq 'Y' }"> 
									<i class="ki-duotone ki-lock-3 fs-1 ms-2" style="position: absolute;"> 
										 <span class="path1"></span>
										 <span class="path2"></span>
										 <span class="path3"></span>
									</i>
								</c:if> 
							</span>
						</h2>
					</div>
			        <div>
			        	<span class="fs-3 fw-normal text-gray-700 mx-3">${cmntyVO.qstnEmpId }</span>
			        	<span class="fs-3 fw-normal text-gray-700 mx-3"><c:out value="${fn:substring(cmntyVO.cmntyRegDt, 0, 16)}" /></span>
			        </div>           
			    </div> 
			    
				<div class="separator separator-solid mb-1"></div>

			    <div class="card-body d-flex align-items-center" style="min-height: 15em;">  
					<div class="fs-3 fw-normal text-gray-700">
						${cmntyVO.cmntyCn }
					</div>
				</div>
				<div class="separator separator-solid mb-1"></div>
 				
 				<c:choose>
 					<c:when test="${cmntyVO.cmntyQstnSttsYn eq 'N' }">
		                <div class="my-4 ms-5 ps-5">    
		                    <button id="replyBtn" class="btn btn-sm btn-light-info">답변하기</button> 
		                    <button class="btn btn-sm btn-light-primary" onclick="location.href='/groubear/cmntyQstnList.do'">목록</button> 
		                </div> 
						 
					    <div class="card-footer py-0" style="display: none; width: 70%;"> 
					    	<form id="replyInsertForm" action="/groubear/cmntyReplyInsert.do" method="post">
					    		<input type="hidden" name="cmntyNo" value="${cmntyVO.cmntyNo }">
						        <div class="align-items-center">
						        	<div style="width: 100%"> 
						               <!-- 데이터 세팅하지 않은 기존 코드
						                <textarea class="form-control border" cols="100%" rows="5" id="cmntCn" name="cmntCn" wrap="hard"></textarea>     
 -->

										<!-- 발표를 위한 데이터 세팅 -->
						                <textarea class="form-control border" cols="100%" rows="5" id="cmntCn" name="cmntCn" wrap="hard">안녕하세요!
'베이직'은 메인 홈페이지에서 소개하는 인사관리, 양식, 증명서, 전자결재, 클라우드 등의
기본적인 메뉴들을 사용할 수 있고,
'프리미엄'은 그 외에 추가로 차량관리, 시설예약, 보안 등의 메뉴를 추가로 사용하실 수 있습니다.
감사합니다.</textarea>

						        	</div>
					                <div class="my-3" style="float: right;">    
					                    <button type="button" id="replyAddBtn" class="btn btn-sm btn-primary">등록</button>
					                    <button type="button" id="replyCanBtn" class="btn btn-sm btn-danger">취소</button> 
					                </div>
						        </div> 
					    	</form>
						</div>
 					</c:when>
					<c:otherwise>
						<div id="cardFooter" class="card-footer py-2">
							<div class="ms-5 my-5" style="width: 70%;">
						        <div>
				                    <span class="text-gray-800 text-hover-primary mb-1 fs-6 fw-bold me-5 ms-2">
				                    	그루베어 (${cmntyVO.answrEmpId })
				                    </span> 
				                    <span class="text-gray-500 fw-semibold ms-5">${cmntyVO.cmntRegDt }</span>
						        </div>
						 		
					        	<form id="replyModifyForm" action="/groubear/cmntyReplyModify.do" method="post">
						            <input type="hidden" name="cmntyNo" value="${cmntyVO.cmntyNo }">
						            <input type="hidden" name="commentNo" value="${cmntyVO.commentNo }">
							        <div id="replyModifyContent" class="pt-3">
							            <div class="py-12" style="border: 1px solid lightgray; border-radius: 10px; background-color: #e4e4e442">
								            <div id="cmntCn" class="text-gray-800 fs-6 fw-normal mx-5">${cmntyVO.cmntCn }</div> 
							            </div>
							        </div>
							        
							        <div class="my-3 mb-5 d-flex" style="float: right;">    
							            <button type="button" id="replyModifyBtn" class="btn btn-sm btn-primary me-1">수정</button>
							            <button type="button" id="replyModifyAddBtn" class="btn btn-sm btn-success me-1" style="display: none;">등록</button>
							            <button type="button" id="replyDelBtn" class="btn btn-sm btn-danger me-1">삭제</button>  
							            <button type="button" id="replyCancleBtn" class="btn btn-sm btn-primary me-1" style="display: none;">취소</button> 
					                    <button type="button" class="btn btn-sm btn-info" onclick="location.href='/groubear/cmntyQstnList.do'">목록</button> 
							        </div> 
					        	</form>
							</div>
					    </div>
					</c:otherwise> 				
 				</c:choose>
	        
	        </div>
		</div>
		
	</div>
</div>

<script>
let searchForm = $("#searchForm");		
let cardFooter = $('#cardFooter').html(); 
 
$(function() {
	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
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

	// 답변하기 버튼을 눌렀을 때
	$('#replyBtn').on('click', function(event) {
		$('.card-footer').css("display", "block");
	});

	// 등록1 버튼을 눌렀을 때
	$('#replyAddBtn').on('click', function(event) {
		let cmntCn = $('#cmntCn').val();
		
		if (cmntCn == null || cmntCn == "") {
			Swal.fire({
				icon: 'warning',
				title: '답변 내용이 비어있습니다!',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}
		$('#replyInsertForm').submit();
	});

	// 등록2 버튼을 눌렀을 때
	$('.card-footer').on('click', '#replyAddBtn', function(event) {
		let cmntCn = $('#cmntCn').val();
		
		if (cmntCn == null || cmntCn == "") {
			Swal.fire({
				icon: 'warning',
				title: '답변 내용이 비어있습니다!',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}
		$('#replyInsertForm').submit();
	});

	// 취소 버튼1을 눌렀을 때 
	$('#replyCanBtn').on('click', function(event) {
		$('#replyModifyContent').html('');
		$('#cardFooter').html(cardFooter);
		$('.card-footer').css('display', 'none');
	});  

	// 취소 버튼2을 눌렀을 때 
	$('.card-footer').on('click', '#replyCancleBtn', function(event) {
		$('#replyModifyContent').html('');
		$('#cardFooter').html(cardFooter);
	}); 
	 
	// 삭제 버튼을 눌렀을 때
	$('.card-footer').on('click', '#replyDelBtn', function() {
	      Swal.fire({
	          title: '답변을 삭제하시겠습니까?',
	          icon: 'warning',
	          showCancelButton: true,
	          confirmButtonColor: '#4FC9DA',
	          cancelButtonColor: '#F06445',
	          confirmButtonText: '예',
	          cancelButtonText: '아니요',
	          reverseButtons: false, // 버튼 순서 (기본)
	    
	       }).then((result) => {
	          if (result.isConfirmed) {
	             delForm.submit();
	          }
	       });
	});

	// 수정 버튼을 눌렀을 때
	$('.card-footer').on('click', '#replyModifyBtn', function(event) {
		let replyModifyBtn = $('#replyModifyBtn');
		let replyModifyAddBtn = $('#replyModifyAddBtn');
		let replyCancleBtn = $('#replyCancleBtn');
		let cmntCn = $('#cmntCn').text();
		
		replyModifyBtn.css("display", "none");
		replyModifyAddBtn.css("display", "block");
		replyCancleBtn.css("display", "block");
		
		let replyModifyContent = $('#replyModifyContent');
		

		let html = `<div style="width: 100%"> 
		            	<textarea class="form-control border" cols="100%" rows="5" id="cmntCn" name="cmntCn" wrap="hard">\${cmntCn }</textarea>     
		        	</div>`;

		
		replyModifyContent.html(html);
	});
	
	// 수정 등록 버튼을 눌렀을 떄
	$('.card-footer').on('click', '#replyModifyAddBtn', function() {
		let cmntCn = $('#cmntCn').val();
		
		if (cmntCn == null || cmntCn == "") {
			Swal.fire({
				icon: 'warning',
				title: '답변 내용이 비어있습니다!',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}
		$('#replyModifyForm').submit();
	});
	
	
});

// 카테고리 바로가기 버튼 눌렀을 때
function f_cmntyQstnKndBtn(selectCategory) {
	if (selectCategory == "All") { 
		location.href = "/groubear/cmntyQstnList.do";
		return false;
	}
	searchForm.find("#cmntyType").val(selectCategory);
	
	searchForm.submit(); 
}	

</script>
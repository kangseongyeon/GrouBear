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
	
		<form action="/employee/cmntyQstnList.do" id="searchForm" style="display: contents;"> 
			<input type="hidden" name="cmntyType" id="cmntyType"> 
		</form>
	
		<form action="/employee/cmntyQstnDelete.do" id="delForm" style="display: contents;" method="post"> 
			<input type="hidden" name="cmntyNo" id="cmntyNo" value="${cmntyVO.cmntyNo }"> 
		</form>
		

		<!-- Q&A 메뉴 시작 -->
        <div class="card card-flush mb-5" style="height: 70px;">
            <div class="card-body d-flex" style="padding: 1em; align-items: center;">  
 
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor" onclick="f_cmntyQstnKndBtn('All')">
                           <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-danger me-3"><span class="path1"></span><span class="path2"></span></i>
                              </span>
                          	<span class="menu-title">전체</span>
                       </div>
                   </div>  
 
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor" onclick="f_cmntyQstnKndBtn('QSTNKND001')">
                           <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-success me-3"><span class="path1"></span><span class="path2"></span></i>
                              </span>
                          	<span class="menu-title">서비스이용</span>
                       </div>
                   </div>
 
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor" onclick="f_cmntyQstnKndBtn('QSTNKND002')">
                           <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-info me-3"><span class="path1"></span><span class="path2"></span></i>
                              </span>
                          	<span class="menu-title">가격</span>
                       </div>
                   </div>
 
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor" onclick="f_cmntyQstnKndBtn('QSTNKND003')">
                           <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-primary me-3"><span class="path1"></span><span class="path2"></span></i>
                              </span>
                          	<span class="menu-title">기타</span>
                       </div>
                   </div>

            </div>
        </div>
		<!-- Q&A 메뉴 시작 -->	

        <div class="p-0 mb-2" style="height: 85%">  
	        <div class="card card-flush">
	        
			    <div class="card-header pt-9 d-flex mb-3"> 
					<div class="text-gray-900 d-flex"> 
                    	<c:choose>
                    		<c:when test="${cmntyVO.cmntyQstnSttsYn eq 'N' }">
								<span class="badge badge-light-danger fs-8 d-flex flex-center px-4 py-4 me-5" style="height: 22px">
	                    			대기중 
				                </span> 
                    		</c:when>
                    		<c:otherwise>
								<span class="badge badge-light-primary fs-8 d-flex flex-center px-4 py-4 me-5" style="height: 22px">
	                    			답변완료
				                </span>
                    		</c:otherwise>
                    	</c:choose> 
						<h2>
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
			        	<span class="fs-6 fw-normal text-gray-700 mx-3">${cmntyVO.qstnEmpId }</span>
			        	<span class="fs-6 fw-normal text-gray-700 mx-3"><c:out value="${fn:substring(cmntyVO.cmntyRegDt, 0, 16)}" /></span>
			        </div>           
			    </div> 
			    
				<div class="separator separator-solid mb-1"></div>

			    <div class="card-body d-flex align-items-center" style="min-height: 15em;">  
					<div class="fs-6 fw-normal text-gray-700">
					    	${cmntyVO.cmntyCn }
					</div>
				</div>
				
				<sec:authentication property="principal.member" var="emp"/> 
				<c:choose>
					<c:when test="${cmntyVO.cmntyQstnSttsYn eq 'N'}">
						<c:choose>
							<c:when test="${cmntyVO.qstnEmpId eq emp.empId }">
								<div class="separator separator-solid mb-1"></div>
							    <div class="card-footer py-0"> 
							        <div class="d-flex justify-content-end">  
						                <div class="my-3">
						                    <button id="modifyBtn" class="btn btn-sm btn-info" onclick="location.href='/employee/cmntyQstnModify.do?cmntyNo=${cmntyVO.cmntyNo }'">수정</button>
						                    <button id="delBtn" class="btn btn-sm btn-danger">삭제</button> 
						                    <button id="listBtn" class="btn btn-sm btn-primary" onclick="location.href='/employee/cmntyQstnList.do'">목록</button> 
						                </div>
							        </div> 
								</div>
							</c:when>
							<c:otherwise>
								<div class="separator separator-solid mb-1"></div>
							    <div class="card-footer py-0"> 
							        <div class="d-flex justify-content-end">  
						                <div class="my-3">
						                    <button id="listBtn" class="btn btn-sm btn-primary" onclick="location.href='/employee/cmntyQstnList.do'">목록</button> 
						                </div>
							        </div> 
								</div>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<div class="separator separator-solid mb-1"></div>
						<div id="cardFooter" class="card-footer py-2">
							<div class="ms-5 my-5" style="width: 70%;">
						        <div>
				                    <span class="text-gray-800 text-hover-primary mb-1 fs-6 fw-bold me-5 ms-2">
				                    	그루베어 답변
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
					        	</form>
							</div> 
							<div>
								<button id="listBtn" class="btn btn-sm btn-primary mb-2 float-end" onclick="location.href='/employee/cmntyQstnList.do'">목록</button> 
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
	 
	// 삭제 버튼을 눌렀을 때
	$('#delBtn').on('click', function() {
	      Swal.fire({
	          title: 'Q&A를 삭제하시겠습니까?',
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
	
});

// 카테고리 바로가기 버튼 눌렀을 때
function f_cmntyQstnKndBtn(selectCategory) {
	if (selectCategory == "All") { 
		location.href = "/employee/cmntyQstnList.do";
		return false;
	}
	searchForm.find("#cmntyType").val(selectCategory);
	
	searchForm.submit(); 
}	

</script>
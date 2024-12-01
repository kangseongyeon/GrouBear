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
		<h3>Q&A 게시판</h3>
		<h6>시스템 공지</h6>
	</div>
</div>


<div id="kt_app_content_container" class="app-container container-fluid mb-15" style="height: 100%;">
	<div style="height: 100%;">
 
		<!-- Q&A 메뉴 시작 -->
        <div class="card card-flush mb-5" style="height: 90px;">
            <div class="card-body d-flex fs-3" style="padding: 1em; align-items: center;">   
 
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('All')">
                            <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-danger me-3"><span class="path1"></span><span class="path2"></span></i>
                            </span>
                          	<span class="menu-title">전체</span>
                       </div>
                   </div>  
 
 					<div class="start-0 top-0 w-3px rounded-2 ms-13" style="background-color: #acaaaa; height: 1.8em;"></div> 
 
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('QSTNKND001')">
                           <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-success me-3"><span class="path1"></span><span class="path2"></span></i>
                              </span>
                          	<span class="menu-title">서비스이용</span>
                       </div>
                   </div>
 
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('QSTNKND002')">
                           <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-info me-3"><span class="path1"></span><span class="path2"></span></i>
                              </span>
                          	<span class="menu-title">가격</span>
                       </div>
                   </div>
 
                   <div class="menu-item">
                    <div class="menu-link py-3 divHover clickBackColor position-relative ms-5" onclick="f_cmntyQstnKndBtn('QSTNKND003')">
                           <span class="menu-icon"> 
                               <i class="ki-duotone ki-abstract-8 text-primary me-3"><span class="path1"></span><span class="path2"></span></i>
                              </span>
                          	<span class="menu-title">기타</span>
                       </div>
                   </div>
                   
                   	<div style="width: 60%">
						<button type="button" class="btn btn-flex btn-primary ms-1 py-3 px-5 float-end btn-lg" onclick="location.href='/company/cmntyQstnInsert.do'" style="margin-top: 0.5em;">
							문의하기 
						</button>
					</div>
            </div>
        </div>
		<!-- Q&A 메뉴 시작 -->	

        <div class="p-0 mb-2" style="height: 85%">  
	        <div class="card card-flush" style="height: 103%">
				<div class="card-header align-items-center">
					<div class="card-title" style="width: 100%; justify-content: space-between"> 
						<div class="d-flex">
							<div class="d-flex align-items-center position-relative my-1">
						
			                 	<form id="searchForm" style="display: contents;">
			                        <input type="hidden" name="page" id="page">
			                        <input type="hidden" name="cmntyType" id="cmntyType">
			                        <input type="hidden" name="empId" id="empId">
								    <input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid ps-5" style="margin-top: 0.5em;" placeholder="게시글 검색" value="${searchWord }"/>
			                   		<button id="searchBtn" type="button" class="btn btn-flex btn-light-success ms-1 py-3 px-3" style="margin-top: 0.5em;">
			                  			<i class="ki-duotone ki-magnifier fs-2x">
										 <span class="path1" style="height: 1.1em;"></span> 
										 <span class="path2"></span>
										</i>
									</button>
			                     </form>
		                          
							</div>
							
							<c:choose>
								<c:when test="${empty cmntyType }">
									<div>
										<div class="form-check form-check-sm form-check-custom form-check-solid ms-10 mt-7" style="display: flex; justify-content: center;">
											<c:choose>
												<c:when test="${empty empId }">
													<input class="form-check-input me-3" type="checkbox" onclick="f_cmntyMyQstnBtn('${employeeVO.empId}', this)" />
												</c:when>
												<c:otherwise>
													<input class="form-check-input me-3" type="checkbox" checked="checked" onclick="f_cmntyMyQstnBtn('${employeeVO.empId}', this)" />
												</c:otherwise>
											</c:choose>
											<div class="text-start text-gray-500 fw-bold fs-5 text-uppercase gs-0 text-center">내 글만 보기</div>  
										</div>
									</div> 
								</c:when> 
								<c:otherwise>
									<div style="width: 15%">
									</div> 
								</c:otherwise>
							</c:choose>
						</div>
												
						 
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
 						
						<div style="width: 60%;">
							<c:choose>
								<c:when test="${cmntyType eq 'QSTNKND001' }">
									<span class="badge badge-light-primary badge-lg float-end me-3 fs-3">총 ${qstnCountService.cmntyQstnSttsNCount + qstnCountService.cmntyQstnSttsYCount} 개</span>
								</c:when>
								<c:when test="${cmntyType eq 'QSTNKND002' }">
									<span class="badge badge-light-primary badge-lg float-end me-3 fs-3">총 ${qstnCountPrice.cmntyQstnSttsNCount + qstnCountPrice.cmntyQstnSttsYCount} 개</span>
								</c:when>
								<c:when test="${cmntyType eq 'QSTNKND003' }">
									<span class="badge badge-light-primary badge-lg float-end me-3 fs-3">총 ${qstnCountOther.cmntyQstnSttsNCount + qstnCountOther.cmntyQstnSttsYCount} 개</span>
								</c:when>
								<c:otherwise>
									<span class="badge badge-light-primary badge-lg float-end me-3 fs-3">총 ${qstnCountAll.cmntyQstnAllcount} 개</span>
								</c:otherwise>
							</c:choose>
						</div>		 
						 
					</div>
				</div>
		
				<div class="card-body pt-0 pb-0">
					<table class="table align-middle table-row-dashed fs-4" id="kt_ecommerce_products_table">
						<thead>
							<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
								<th width="5%" class="w-200px h4">번호</th> 
								<th width="13%" class="h4">카테고리</th>  
								<th width="14%" class="w-200px h4">상태</th>    
								<th width="40%" class="h4">제목</th> 
								<th width="11%" class="h4">작성자</th>
								<th width="18%" class="h4">작성일시</th>  
							</tr>
						</thead>
						<tbody class="fw-semibold text-gray-600">
						
							<c:set value="${pagingVO.dataList }" var="cmntyQstnList"/>
							
							<c:choose>
								<c:when test="${empty cmntyQstnList }">
									<tr>
										<td colspan="7" class="text-center pt-15">조회하신 게시글이 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${cmntyQstnList }" var="cmntyQstnVO">
										<tr>
											<td class="py-3">
												<div class="text-center">${cmntyQstnVO.cmntyNo }</div>
											</td>
											<td class="py-3"> 
												<div class="text-end text-center">
													<span class="badge badge-light-info fs-6 d-flex flex-center px-0 py-5" style="height: 35px; width: 100px; margin: auto;">
						                    			${cmntyQstnVO.comDtlCdNm }  
									                </span>  
												</div>
											</td>
											<td class="py-3">
												<div class="text-center">
							                    	<c:choose>
							                    		<c:when test="${cmntyQstnVO.cmntyQstnSttsYn eq 'N' }">
															<span class="badge badge-light-danger fs-6 d-flex flex-center px-0 py-4" style="height: 35px">
								                    			대기중 
											                </span> 
							                    		</c:when>
							                    		<c:otherwise>
															<span class="badge badge-light-primary fs-6 d-flex flex-center px-0 py-4" style="height: 35px">
								                    			답변완료
											                </span>
							                    		</c:otherwise>
							                    	</c:choose> 
												</div> 
											</td>  
											<td class="py-3">
												<div class="text-gray-800 px-5" style="display: flex; justify-content: left;">
													<div class="text-center">
							                            <sec:authentication property="principal.member" var="emp"/>
							                            <c:choose> 
							                            	<c:when test="${cmntyQstnVO.cmntyPrvtPstYn eq 'Y' }">
									                            <c:choose>
										                            <c:when test="${emp.empId eq cmntyQstnVO.qstnEmpId}">
						 												<a href="/company/cmntyQstnDetail.do?cmntyNo=${cmntyQstnVO.cmntyNo }">${cmntyQstnVO.cmntyTtl }</a>
										                            </c:when>
										                            <c:otherwise>
						 												<a href="#" onclick="f_prvtQstn(event)">${cmntyQstnVO.cmntyTtl }</a>
										                            </c:otherwise>
									                            </c:choose>
							                            	</c:when>
							                            	<c:otherwise>
				 												<a href="/company/cmntyQstnDetail.do?cmntyNo=${cmntyQstnVO.cmntyNo }">${cmntyQstnVO.cmntyTtl }</a>
							                            	</c:otherwise>
							                            </c:choose>
														<c:if test="${cmntyQstnVO.cmntyPrvtPstYn eq 'Y' }"> 
															<i class="ki-duotone ki-lock-3 fs-1 ms-2" style="position: absolute;"> 
																 <span class="path1"></span> 
																 <span class="path2"></span>
																 <span class="path3"></span>
															</i>
														</c:if> 
													</div>
												</div>  
											<td class="py-3">
												<div class="text-center">${cmntyQstnVO.qstnEmpId }</div> 
											</td>   
											<td class="py-3">
												<div class="text-center">
												    <c:out value="${fn:substring(cmntyQstnVO.cmntyRegDt, 0, 16)}" />
												</div>
											</td> 
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						
						</tbody>
					</table>

					<div class="dt-paging paging_simple_numbers" id="pagingArea" style="margin-bottom: 10px;">
						${pagingVO.pagingHTML }
					</div>

				</div>
		
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
	
});

// 카테고리 바로가기 버튼 눌렀을 때
function f_cmntyQstnKndBtn(selectCategory) {
	if (selectCategory == "All") { 
		location.href = "/company/cmntyQstnList.do";
		return false;
	}
	searchForm.find("#cmntyType").val(selectCategory);
	
 	searchForm.submit(); 
}	

// 내 글만 보기 버튼 눌렀을 때
function f_cmntyMyQstnBtn(empId, checkbox) {
    if (checkbox.checked) { // 체크가 되어 있다면
        // 내 글만 보기 상태로 설정
        searchForm.find("#empId").val(empId);
    } else { // 체크가 해제되었다면
        // 값을 제거하고 전체 보기 상태로 설정
        searchForm.find("#empId").remove();
    }
    searchForm.submit();
}	

// 본인 작성하지 않은 비밀글 제목을 눌렀을 때
function f_prvtQstn(e) {
	e.preventDefault();
	Swal.fire({
		icon: 'warning',
		title: '비밀글은 작성자 본인만 확인 가능합니다.',
		confirmButtonColor: '#4FC9DA',
	});
}

</script>
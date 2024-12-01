<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>


<link href="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css"/>
<script src="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.js"></script>

<!-- ckeditor API -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script> 

<!-- sweetalert2 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
 
<style> 
.imgPreview:hover {
	color: rgb(79 201 218);
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


<div id="kt_app_content_container" class="app-container container-fluid" style="height: 100%;">
	<div class="row" style="height: 100%;">
		<div class="col-12 pe-2" id="kt_app_root"> 
			<div class="card pe-0 mb-5">
					
					<form id="noticeForm" action="/employee/cmntyNoticeDelete.do" method="post">
						<input type="hidden" name="cmntyNo" value="${cmntyVO.cmntyNo }">
					</form>
					<form id="noticeDelForm" action="/employee/cmntyNoticeDelete.do" method="post">
						<input type="hidden" name="cmntyNo" value="${cmntyVO.cmntyNo }">
						<input type="hidden" name="atchFileCd" value="${cmntyVO.atchFileCd }">
					</form>
					
                    <!-- 시스템 공지사항 디테일 시작 -->
					<div>
					
						<div class="card-header"> 
						
							<div class="mt-7 mb-2 w-100" style="display: flex;">
								<div class="fw-semibold fs-2x" style="width: 100%">
									<c:if test="${cmntyVO.cmntyNoticeYn eq 'Y' }">
										<font class="fw-bold" style="color: red">[공지] </font>
									</c:if>
									<font class="fw-bold text-gray-800">${cmntyVO.cmntyTtl }</font>
								</div> 
							</div> 
							
							<div class="my-4 w-100" class="mt-3 mb-5" style="display: flex;">  
								<div style="width: 3%;">  
									<i class="ki-duotone ki-time fs-3">
										 <span class="path1"></span> 
										 <span class="path2"></span>
									</i>
								</div>     
								<div class="d-flex justify-center fw-semibold text-gray-800" style="width: 15%;">
									<c:out value="${fn:substring(cmntyVO.cmntyRegDt, 0, 10)}" />
							    </div>
								<div style="width: 3%;">  
									<i class="ki-duotone ki-eye fs-3">
										 <span class="path1"></span>
										 <span class="path2"></span>
										 <span class="path3"></span>
									</i>
								</div>   
								<div class="d-flex justify-center fw-semibold text-gray-800" style="width: 13%;"> 
									${cmntyVO.cmntyInqCnt }
							    </div> 
							</div>
							
							<c:if test="${not empty cmntyVO.atchFileDetailList }">
								<div class="mb-4 w-100 pt-5" style="display: flex; border-top: 1px dashed lightgray;">  
									<div style="width: 10%;">
										<label class="form-label fs-6">첨부파일</label>
									</div>   
								      
									<!-- 파일 시작 -->
									<div class="d-flex justify-center" style="width: 90%;">
										<div class="rounded border p-3 pb-0" style="width: 80%;"> 
											<div class="form-group">
							 
												<div class="dropzone dropzone-queue" id="kt_modal_upload_dropzone">
													<div class="dropzone-panel mb-2"> 
														<a id="fileAllDowmload" class="dropzone-select btn btn-sm btn-primary me-2">전체저장</a>
													</div>
													
													<div style="overflow: scroll; max-height: 130px;"> 
														<c:forEach items="${cmntyVO.atchFileDetailList }" var="atchFileDetailVO">
															<div class="dropzone-items wm-200px">
																<div class="dropzone-item p-2 py-1 dz-image-preview mt-1">
																	<div class="dropzone-file"> 
																		<span class="dropzone-filename text-gray-900 ms-2 fs-7">
																			<span>${atchFileDetailVO.atchFileDetailOrgnlNm }</span> <strong>( <span data-dz-size=""><strong>${atchFileDetailVO.atchFileDetailFancysize }</strong></span>)</strong>
																		</span>
																		<c:if test="${atchFileDetailVO.atchFileDetailExtnNm eq 'jpg' ||
																					  atchFileDetailVO.atchFileDetailExtnNm eq 'jpeg' ||
																					  atchFileDetailVO.atchFileDetailExtnNm eq 'png' ||
																					  atchFileDetailVO.atchFileDetailExtnNm eq 'gif' }">
																			<a href="/employee/cmnty/imgPreview.do?atchFileDetailCd=${atchFileDetailVO.atchFileDetailCd }" target="_blank" class="ki-duotone ki-magnifier ms-2 imgPreview fs-5"> 
																				<span class="path1"></span>
																				<span class="path2"></span>
																			</a>
																		</c:if>
																	</div>   
																	<a href="/employee/cmntyDownOne.do?atchFileDetailCd=${atchFileDetailVO.atchFileDetailCd }">
																		<span class="dropzone-start"> 
																			<span> 
																				<i class="ki-duotone ki-file-down fs-2">
																					<span class="path1"></span>
																					<span class="path2"></span>
																				</i>
																			</span>
																		</span>
																	</a>
																</div>
															</div>
														</c:forEach>
													</div>
													
												</div>
							
											</div> 
										</div>
									</div> 
									<!-- 파일 끝 --> 
									
								</div>
							</c:if>
							
						</div>
							 
						<!-- card-body 시작 -->
						<div class="card-body" style="min-height: 20em;">
							<div class="fv-row fv-plugins-icon-container">     
								<div>
									${cmntyVO.cmntyCn }
								</div>
							</div>
						</div>
						<!-- card-body 끝 --> 
						
                        <div class="card-footer p-0 py-5">
							<div class="d-flex justify-content-center pe-5"> 
								<div style="margin-left: 5px;"> 
									<input type="button" id="listBtn" class="btn btn-light-info" value="목록">
								</div> 
							</div>
						</div> 
						
					</div> 
                    <!-- 시스템 공지사항 디테일 끝 -->
					
			</div>
		</div>
	</div> 
</div>

<script>
$(function() {
   
	// ***** Notice Process *****
	let noticeForm = $('#noticeForm');
	let cmntyNo = '${cmntyVO.cmntyNo }';
	let atchFileCd = '${cmntyVO.atchFileCd }'; 
	let modifyBtn = $('#modifyBtn');
	let deleteBtn = $('#deleteBtn');
	let listBtn = $('#listBtn');
	let fileAllDowmload = $('#fileAllDowmload');
   
   // 수정 버튼 클릭
   modifyBtn.on('click', function() {
      location.href= "/employee/cmntyNoticeModify.do?cmntyNo=" + cmntyNo; 
   });
   
   // 삭제 버튼 클릭 
   deleteBtn.on('click', function() { 
	  console.log("cmntyNo : " + cmntyNo);
	  console.log("atchFileCd : " + atchFileCd);
      
      Swal.fire({
          title: '게시글을 정말 삭제하시겠습니까?',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#F06445',
          cancelButtonColor: '#4FC9DA',
          confirmButtonText: '예', 
          cancelButtonText: '아니요',
          reverseButtons: false, // 버튼 순서 (기본)
    
       }).then((result) => {
          if (result.isConfirmed) {
        	  noticeDelForm.submit()
          }
       })
      
   });
   
   // 목록 버튼 클릭
   listBtn.on('click', function() {
	    location.href= "/employee/cmntyNoticeList.do";
   });
   
   // 파일 전체 저장 버튼 클릭
   fileAllDowmload.on('click', function() { 
		console.log("atchFileCd : " + atchFileCd);  
	   	 
        axios.post("/employee/cmntyDownList.do", {
        	atchFileCd: atchFileCd
        })
        .then(function (res) {
            console.log(res.data);
            if (res.data == "OK") {
                Swal.fire({
                    icon: 'success',
                    title: '다운로드가 완료되었습니다.',
                    text: '다운로드 폴더를 확인해주세요.',
                    confirmButtonColor: '#4FC9DA',
                });
            } else {
                Swal.fire({
                    icon: 'warning',
                    title: '서버에 오류가 발생했습니다!',
                    text: '다시 시도해주세요.',
                    confirmButtonColor: '#4FC9DA',
                });
            }
        })
        .catch(function (error) {
            console.error("오류 발생:", error);
        });
	});
   
});

// 파일 개별 저장 버튼을 눌렀을 때
function f_fileDownOne(fileDetailCd) {
	console.log("fileDetailCd : " + fileDetailCd);
	   
	axios.post("/employee/cmntyDownOne.do", {
		atchFileDetailCd: fileDetailCd
	})
	.then(function (res) {
	    console.log(res.data);
	})
	.catch(function (error) {
	    console.error("오류 발생:", error);
	});
}

</script>
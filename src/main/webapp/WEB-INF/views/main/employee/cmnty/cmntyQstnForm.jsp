<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- sweetalert2 --> 
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- axios -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<div style="margin-bottom: 20px;">
   <div style="margin-top: -32px;">
      <div class="separator border-2 my-10"></div>
   </div>
   <div style="margin-left: 30px; margin-top: -100px;">
		<h3>Q&A 등록</h3>
		<h6>시스템 공지</h6>
	</div>
</div>

<c:set value="등록" var="insertAndUpdate"/>
<c:set value="목록" var="cancleAndList"/>
<c:if test="${status eq 'u' }">
   <c:set value="수정" var="insertAndUpdate"/>
</c:if>

<form action="/employee/cmntyQstnInsert.do" id="formInsert" method="post">
	<c:if test="${status eq 'u' }">
		<input type="hidden" id="cmntyNo" name="cmntyNo" value="${cmntyVO.cmntyNo }">
	</c:if>

		<div class="kt_app_content_container mx-5 mb-5" class="app-container container-fluid" style="height: 100%"> 
			<div class="card card-flush">
		                
                <div class="container">
                
                   <div class="card-header">
                       <div class="card-title" style="width: 100%;">
                           <h2><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Q&A ${insertAndUpdate }</font></font></h2>
                       </div>
                   </div>
               
                  <!-- card-body 시작 -->
                   <div class="card-body p-0" style="margin-top: 20px;"> 
                       <div class="fv-row fv-plugins-icon-container" style="margin-left: 3em; margin-right: 3em;">
                          
                          <div style="display: flex; margin-bottom: 10px;">  
                             <div class="d-flex" style="width: 30%">
	                             <div style="width: 33%;">
	                                 <label class="form-label" style="margin-top: 10px;">카테고리 <font style="color: red">*</font></label>
	                             </div>  
								  <div style="width: 55%"> 
						             <select id="comDtlCd" name="comDtlCd" class="form-select" data-control="select2" data-hide-search="true">
						             <option value="0">선택</option>
										<c:forEach items="${commCodeList }" var="commCodeVO"> 
											<option value="${commCodeVO.comDtlCd }" <c:if test="${cmntyVO.comDtlCd == commCodeVO.comDtlCd }">selected="selected"</c:if>>${commCodeVO.comDtlCdNm }</option>
										</c:forEach> 
									</select>  
								  </div>
                             </div>
                              
                             <div>
								<div class="form-check form-check-sm form-check-custom form-check-solid ms-10 mt-2" style="display: flex; justify-content: center;">
									<c:choose>
										<c:when test="${cmntyVO.cmntyPrvtPstYn eq 'Y' }">
											<input class="form-check-input me-3" type="checkbox" id="cmntyPrvtPstYn" name="cmntyPrvtPstYn" value="Y" checked="checked"/>
										</c:when>
										<c:otherwise>
											<input class="form-check-input me-3" type="checkbox" id="cmntyPrvtPstYn" name="cmntyPrvtPstYn" value="Y" />
										</c:otherwise>
									</c:choose>
									<div class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">비밀글 여부</div>  
								</div>
                             </div>
						  </div> 
                          <span class="error invalid-feedback" style="display:block;">${error.comDtlCd }</span>
						  
                          <div style="display: flex;">
                             <div style="width: 10%;"> 
                                 <label class="form-label" style="margin-top: 10px;">제목 <font style="color: red">*</font></label>
                             </div> 
                             <input style="width: 90%;" type="text" id="cmntyTtl" name="cmntyTtl" class="form-control" placeholder="제목을 입력해주세요." value="${cmntyVO.cmntyTtl }"> 
                          </div>   
                          <span class="error invalid-feedback" style="display:block;">${error.cmntyTtl }</span>

                          <div class="mt-3">
                              <label class="form-label" style="margin-top: 5px;">질문내용 <font style="color: red">*</font></label>
                               <textarea class="form-control mt-3" id="cmntyCn" name="cmntyCn" wrap="hard" cols="10" rows="13">${cmntyVO.cmntyCn }</textarea>  
						  </div> 
                          <span class="error invalid-feedback" style="display:block;">${error.cmntyCn }</span> 
                           
							<div class="card-footer p-5 d-flex justify-content-center" style="border-top: none;"> 
								<c:if test="${status ne 'u' }"> 
									<div>
										<input type="button" id="addBtn" class="btn btn-light-primary" value="${insertAndUpdate }">
									</div>
								</c:if>
								<c:if test="${status eq 'u' }">
									<div>
										<input type="button" id="addBtn" class="btn btn-light-primary" value="${insertAndUpdate }">
									</div>
								</c:if>
								<div style="margin-left: 5px;">
									<input type="button" id="cancleBtn" class="btn btn-light-info" value="${cancleAndList }">
								</div> 
							</div> 
                                
                       </div>
                   </div>
                   <!-- card-body 끝 -->
                   
               </div>
               <!-- container -->
      </div>
   </div>
</form>


<script>
$(function() {
   let addBtn = $('#addBtn');
   let cancleBtn = $('#cancleBtn');
   let formInsert = $('#formInsert');
   
   // 목록 버튼 클릭
   cancleBtn.on('click', function() {
      Swal.fire({
         title: '목록으로 돌아가시겠습니까?',
         icon: 'warning',
         showCancelButton: true,
         confirmButtonColor: '#4FC9DA',
         cancelButtonColor: '#F06445',
         confirmButtonText: '예',
         cancelButtonText: '아니요',
         reverseButtons: false, // 버튼 순서 (기본)
   
      }).then((result) => {
         if (result.isConfirmed) {
            location.href= "/employee/cmntyQstnList.do";
         }
      })
   });
   
   // 등록/수정 버튼 클릭
   addBtn.on('click', function() {
		let cmntyTtl = $('#cmntyTtl').val();
 		let cmntyCn = $('#cmntyCn').val();
 		let comDtlCd = $('#comDtlCd').select().val();
		
		console.log("cmntyTtl : ", cmntyTtl);
		console.log("cmntyCn : ", cmntyCn);
		console.log("comDtlCd : ", comDtlCd, typeof(comDtlCd));
		
		// 제목, 내용 등 빈칸 확인
		if (cmntyTtl == null || cmntyTtl == "" ||
			cmntyCn == null || cmntyCn == "" ||
		    comDtlCd == null || comDtlCd == "" || comDtlCd == "0") {
		   Swal.fire({
		      icon: 'warning',
		      title: '필수 입력이 비어있습니다.',
		      text: '필수 입력 내용을 채워주세요.',
		      confirmButtonColor: '#4FC9DA',
		   });
		   return false; 
		}
		
		// 수정일 때
		if ($(this).val() == '수정') {
			formInsert.attr('action', '/employee/cmntyQstnModify.do');
		}
		formInsert.submit();
   });

});

</script>
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
   .cke_notifications_area { display: none; }
</style>

<div style="margin-bottom: 30px;">
   <div style="margin-top: -32px;">
      <div class="separator border-2 my-10"></div>
   </div>
   <div style="margin-left: 30px; margin-top: -100px;">
      <h3>증명서 발급</h3> 
      <h6>증명서 관리</h6>
   </div>
</div>

<div>
   <!--begin::App--> 
   <div class="d-flex flex-column flex-root app-root" id="kt_app_root">
      <!--begin::Page-->
      <div class="app-page flex-column flex-column-fluid" id="kt_app_page">
         <!--begin::Main-->
         <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
            <!--begin::Content wrapper-->
            <div class="d-flex flex-column flex-column-fluid">
               <!--begin::Content-->
               <div id="kt_app_content" class="app-content flex-column-fluid">
                  <!--begin::Content container--> 
                  <div id="kt_app_content_container" class="app-container container-fluid">
                     
                     <div style="display: flex; margin-bottom: 50px;">

                        <!-- 양식 등록 시작 -->
                           <div class="card card-flush" style="width: 100%"> 
                               <div class="container">
                               
                                  <div class="card-header">
                                      <div class="card-title" style="width: 100%;">
                                         <div style="width: 100%; display: flex; justify-content: space-between;">
                                            <div style="display: flex; align-items: center;">
                                                <h2><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">증명서 발급하기</font></font></h2>
                                            </div>
                                         </div>
                                      </div>
                                  </div>
                                  <!-- card-header -->
                              
                                 <!-- card-body 시작 -->
                                  <div class="card-body pt-0" style="margin-top: 20px;">
                                      <div class="mb-10 fv-row fv-plugins-icon-container">
                                         
                                         <div style="display: flex;">
                                          	<label class="form-label mb-2" style="margin-top: 10px; width: 15%;">신청일 : </label>
                                          	<label class="form-label mb-2" style="margin-top: 10px; width: 35%;">${fn:substring(provedocVO.prdocAplyDt, 0, 16)} </label>
                                           	<label class="form-label mb-2" style="margin-top: 10px; width: 15%;">발급일 : </label>
                                           	<label class="form-label mb-2" style="margin-top: 10px; width: 35%;">${fn:substring(provedocVO.prdocIsprDt, 0, 16)} </label>
                                         </div> 
                                         
                                         <div style="display: flex;">
                                           	<label class="form-label mb-2" style="margin-top: 10px; width: 15%;">소속 부서 : </label>
                                           	<label class="form-label mb-2" style="margin-top: 10px; width: 35%;">${provedocVO.deptNm} </label>
                                           	<label class="form-label mb-2" style="margin-top: 10px; width: 15%;">소속 팀 : </label>
                                           	<label class="form-label mb-2" style="margin-top: 10px; width: 35%;">${provedocVO.teamNm} </label>
                                         </div> 
                                         
                                         <div style="display: flex;">
                                           	<label class="form-label mb-2" style="margin-top: 10px; width: 15%;">신청인 : </label>
                                           	<label class="form-label mb-2" style="margin-top: 10px; width: 35%;">${provedocVO.empNm} </label>
                                           	<label class="form-label mb-2" style="margin-top: 10px; width: 15%;"> </label>
                                           	<label class="form-label mb-2" style="margin-top: 10px; width: 35%;"> </label>
                                         </div> 
                                          
                                         <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div>
                                         <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div>
                                         <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div>
                                 
                                         <div> 
                                             <label class="form-label" style="margin-top: 10px;">증명서 내용 <font style="color: red">*</font></label>
                                       	</div> 
                                          
                                         <form action="/employee/comProvedocIsprUpdate.do" method="post">
	                                         <!--CKEditor 시작-->
	                                         <c:choose>
	                                         	<c:when test="${authrityNm eq 'ROLE_employee'}">
			                                         <c:choose>
			                                         	<c:when test="${provedocVO.prdocAprvYn eq 'N'}">
					                                         <div style="width: 100%; min-width: 720px; display: flex; justify-content: center; background-color: #dbdbdb; border: 1px solid #f8f8f8;">
					                                               <textarea id="formEditorCK" name="prdocCn" style="position: absolute;">
					                                               		${provedocVO.prdocCn} 
					                                               </textarea>
					                                         </div>
				                                         </c:when>
					                                       <c:otherwise>
						                                         <div style="width: 100%; min-width: 720px; display: flex; justify-content: center; background-color: #dbdbdb; border: 1px solid #f8f8f8;">
						                                               <textarea id="formEditorCK" name="prdocCn" style="position: absolute;" readonly="readonly">
						                                               		${provedocVO.prdocCn} 
						                                               </textarea>
						                                         </div>
					                                       </c:otherwise>
				                                       </c:choose>
	                                         	</c:when>
	                                         	<c:otherwise>
			                                         <div style="width: 100%; min-width: 720px; display: flex; justify-content: center; background-color: #dbdbdb; border: 1px solid #f8f8f8;">
			                                               <textarea id="formEditorCK" name="prdocCn" style="position: absolute;" readonly="readonly">
			                                               		${provedocVO.prdocCn} 
			                                               </textarea>
			                                         </div>
	                                         	</c:otherwise>
	                                         </c:choose>
	                                         <!--CKEditor 끝-->
	                                         
                                         	<c:if test="${provedocVO.prdocAprvYn eq 'N'}">
		                                         <div style="display: flex; justify-content: right;">
	                                         	  	  <input type="hidden" name="prdocNo" value="${provedocVO.prdocNo}">
		                                              <input type="submit" class="btn btn-light-primary mt-3" value="발급">
		                                         </div>
                                         	</c:if>
                                      	 </form>
                                       
                                      </div>
                                  </div>
                                  <!-- card-body 끝 -->
                                  
                              </div>
                              <!-- container -->
                           </div>
                           <!-- 양식 등록 끝 -->
                     
                     </div>
                     
                  </div>
                  <!--end::Content container-->
               </div>
               <!--end::Content-->
            </div>
            <!--end::Content wrapper-->
         </div>
         <!--end:::Main-->
      </div>
      <!--end::Page-->
   </div>
</div>


<script>
$(function() {
   
    let addBtn = $('#addBtn');
   
    // 등록/수정 버튼 클릭
    addBtn.on('click', function() {
      let docFormNm = $('#docFormNm').val();
      let docFormKndNm = $('#docFormKndNm').val()
      console.log(docFormKndNm);
      let content = CKEDITOR.instances.formEditorCK.getData();
      
      if (docFormNm == null || docFormNm == "" ||
         docFormKndNm == 0 || docFormKndNm == "" ||
         content == null || content == "") {
         Swal.fire({
            icon: 'warning',
            title: '필수 입력이 비어있습니다.',
            text: '필수 입력 내용을 채워주세요.',
            confirmButtonColor: '#4FC9DA',
         });
         return false;
      }
      
    });
   
	CKEDITOR.editorConfig = function( config ) {
		config.removeButtons = 'Link';
	}
	
	/* CKEDITOR 자바스크립트 */
	CKEDITOR.replace( 'formEditorCK', {
	    height: 500,
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
   
});

</script>
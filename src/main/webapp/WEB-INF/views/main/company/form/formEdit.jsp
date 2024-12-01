<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
      <h3>양식관리</h3> 
      <h6>양식관리</h6>
   </div>
</div>

<c:set value="등록" var="insertAndUpdate"/>
<c:set value="취소" var="cancleAndList"/>
<c:set value="등록" var="insertAndUpdate"/>
<c:if test="${status eq 'u' }">
   <c:set value="수정" var="insertAndUpdate"/>
   <c:set value="목록" var="cancleAndList"/>
</c:if>

<form action="/company/formInsert.do" id="formInsert" method="post">
   <c:if test="${status eq 'u' }">
      <input type="hidden" name="docFormNo" value="${formVO.docFormNo }">
   </c:if>

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
                        
                        <div style="display: flex; margin-bottom: 40px;">
   
                           <!-- 양식 등록 시작 -->
                              <div class="card card-flush" style="width: 100%"> 
                                  <div class="container">
                                  
                                     <div class="card-header">
                                         <div class="card-title py-5" style="width: 100%;">
                                            <div style="width: 100%; display: flex; justify-content: space-between;">
                                               <div style="display: flex; align-items: center;">
                                                   <h2><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">양식 등록</font></font></h2>
                                               </div>
                                               
                                               <div>   
	                                               <c:choose>
	                                               		<c:when test="${status ne 'i' }">
														   <sec:authentication property="principal.member" var="emp"/>
			                                               <c:if test="${emp.empId eq formVO.empId}">
			                                                  <button id="formCallJstree" type="button" class="btn btn-light-info ms-2 fs-3 btn-lg" data-bs-toggle="modal" data-bs-target="#formCall1">
			                                                   	 양식 불러오기
			                                                  </button>
			                                               </c:if>
	                                               		</c:when>
	                                               		<c:otherwise>
			                                                  <button id="formCallJstree" type="button" class="btn btn-light-info ms-2 fs-3 btn-lg" data-bs-toggle="modal" data-bs-target="#formCall1">
			                                                   	 양식 불러오기 
			                                                  </button>
	                                               		</c:otherwise>
	                                               </c:choose>
                                               </div>
                                            </div>
                                         
                                            <!-- 양식 불러오기 모달 시작 -->
                                          <div class="modal fade" tabindex="-1" id="formCall1">
                                              <div class="modal-dialog modal-dialog-scrollable">
                                                  <div class="modal-content">
                                                      <div class="modal-header"> 
                                                          <h5 class="modal-title">양식 불러오기</h5>
                                                          <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
                                                              <i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
                                                          </div>
                                                      </div>
                                          
                                                      <div class="modal-body" style="min-height: 300px">
	                                                       <!-- jstree 시작 -->
	                                                       <div class="card card-flush"> 
	                                                         
	                                                         <div class="card bg-light shadow-sm">
	                                                             <div class="card-header">
	                                                                 <h3 class="card-title">양식목록</h3>
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
                                                      <div class="modal-footer">
                                                          <button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
                                                          <button type="button" class="btn btn-skyblue" style="background-color: #569effed; color: white;">불러오기</button>
                                                      </div>
                                                  </div>
                                             </div>
                                          </div>
                                          <!-- 양식 불러오기 모달 끝 -->
                                               
                                         </div>
                                         <!-- card-title -->
                                     </div>
                                     <!-- card-header -->
                                 
                                    <!-- card-body 시작 -->
                                     <div class="card-body pt-0" style="margin-top: 20px;">
                                         <div class="mb-10 fv-row fv-plugins-icon-container">
                                            
                                            <div style="display: flex;">
                                               <div style="width: 13%;">
                                                   <label class="form-label fs-3" style="margin-top: 10px;">양식명 <font style="color: red">*</font></label>
                                               </div> 
                                               	   <c:choose>
	                                               		<c:when test="${status ne 'i' }">
			                                               <sec:authentication property="principal.member" var="emp"/>
			                                               <c:choose>
			                                               		<c:when test="${emp.empId eq formVO.empId}">
					                                                <input style="width: 85%;" type="text" id="docFormNm" name="docFormNm" class="form-control mb-2 fs-3" placeholder="양식명을 입력해주세요." value="${formVO.docFormNm }"> 
			                                               		</c:when>
			                                               		<c:otherwise>
					                                                <input style="width: 85%;" type="text" id="docFormNm" name="docFormNm" class="form-control mb-2 fs-3" placeholder="양식명을 입력해주세요." value="${formVO.docFormNm }" disabled> 
			                                               		</c:otherwise>
			                                               </c:choose>
	                                               		</c:when>
	                                               		<c:otherwise>
			                                                <input style="width: 85%;" type="text" id="docFormNm" name="docFormNm" class="form-control mb-2 fs-3" placeholder="양식명을 입력해주세요." value="${formVO.docFormNm }"> 
	                                               		</c:otherwise>
	                                               </c:choose>
                                               
                                            </div> 
                                            <span class="error invalid-feedback" style="display:block;">${error.docFormNm }</span>
                                            
                                            <div style="display: flex;">
                                               <div style="width: 13%;">
                                                   <label class="form-label fs-3" style="margin-top: 10px;">양식설명 </label>
                                               </div> 
                                               	   <c:choose>
	                                               		<c:when test="${status ne 'i' }">
			                                               <sec:authentication property="principal.member" var="emp"/>
			                                               <c:choose>
			                                               		<c:when test="${emp.empId eq formVO.empId}">
					                                                <input style="width: 85%;" type="text" name="docFormExpln" class="form-control mb-2 fs-3" placeholder="양식 설명을 입력해주세요." value="${formVO.docFormExpln }"> 
			                                               		</c:when>
			                                               		<c:otherwise>
					                                                <input style="width: 85%;" type="text" name="docFormExpln" class="form-control mb-2 fs-3" placeholder="양식 설명을 입력해주세요." value="${formVO.docFormExpln }" disabled> 
			                                               		</c:otherwise>
			                                               </c:choose>
	                                               		</c:when>
	                                               		<c:otherwise>
			                                                <input style="width: 85%;" type="text" name="docFormExpln" class="form-control mb-2 fs-3" placeholder="양식 설명을 입력해주세요." value="${formVO.docFormExpln }"> 
	                                               		</c:otherwise>
	                                               </c:choose>

                                            </div> 
                                            <div style="display: flex; margin-top: 5px;">  
                                               <div style="width: 13%;">
                                                   <label class="form-label fs-3" style="margin-top: 10px;">양식종류 <font style="color: red">*</font></label>
                                               </div>  
                                               <div style="width: 20%;"> 
                                               	   <c:choose>  
	                                               		<c:when test="${status ne 'i' }">
			                                               <sec:authentication property="principal.member" var="emp"/>
			                                               <c:choose>
			                                               		<c:when test="${emp.empId eq formVO.empId}">
				                                                  <select id="docFormKndNm" name="docFormKndUp" class="form-select fs-3" data-control="select2" data-hide-search="true">
				                                                     <option value="0">선택</option>
				                                                     <c:forEach items="${docFormKndNmList }" var="docFormNm"> 
				                                                        <option value="${docFormNm.docFormNo }" <c:if test="${formVO.docFormKndNm == docFormNm.docFormNm }">selected="selected"</c:if>>${docFormNm.docFormNm }</option>
				                                                     </c:forEach>
				                                                  </select> 
			                                               		</c:when>
			                                               		<c:otherwise> 
				                                                  <select id="docFormKndNm" name="docFormKndUp" class="form-select fs-3" data-control="select2" data-hide-search="true" disabled="disabled">
				                                                     <option value="0">선택</option>
				                                                     <c:forEach items="${docFormKndNmList }" var="docFormNm"> 
				                                                        <option value="${docFormNm.docFormNo }" <c:if test="${formVO.docFormKndNm == docFormNm.docFormNm }">selected="selected"</c:if>>${docFormNm.docFormNm }</option>
				                                                     </c:forEach>
				                                                  </select> 
			                                               		</c:otherwise>
			                                               </c:choose> 
	                                               		</c:when>
	                                               		<c:otherwise>
		                                                  <select id="docFormKndNm" name="docFormKndUp" class="form-select fs-3" data-control="select2" data-hide-search="true">
		                                                     <option value="0">선 택</option>
		                                                     <%-- 데이터 세팅하지 않은 기존 코드
		                                                     <c:forEach items="${docFormKndNmList }" var="docFormNm"> 
		                                                        <option value="${docFormNm.docFormNo }">${docFormNm.docFormNm }</option>
		                                                     </c:forEach>
		                                                      --%>
		                                                       
		                                                       <!-- 발표를 위한 데이터 세팅 -->
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
	                                               		</c:otherwise>
	                                               </c:choose>
                                               </div>
                                            </div>
                                            <span class="error invalid-feedback" style="display:block;">${error.docFormKndNm }</span>
                                            
                                            <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div>
                                    
                                            <div>
                                                <label class="form-label fs-3" style="margin-top: 10px;">양식 내용 <font style="color: red">*</font></label>
                                          	</div>
                                           	<span class="error invalid-feedback" style="display:block;">${error.docFormCn }</span>
                                             
                                             
                                             <div class="row mt-5">
	                                             <div class="col-3 me-0 ps-0" style="width: 27%;">
	                                             	<div class="container" style="height: 100%;"> 
	                                             		<div class="card" style="background-color: #c2bcbc21; border: 1px solid #05050529; height: 100%;">
		                                             		<div class="card-header fs-2 fw-blod text-center pt-6" style="border-bottom: 1px dashed #000000;">
		                                             			사용가능 파라미터 목록
		                                             		</div>
		                                             		 
		                                             		<div class="card-body">
			                                             		<div class="fs-4 mb-2"><span>\#{empNm}</span><span> : 사원명</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{empBrdt}</span><span> : 사원 생년월일</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{empAddr}</span><span> : 사원 주소</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{empDaddr}</span><span> : 사원 상세주소</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{empZip}</span><span> : 사원 우편번호</span></div>
			                                             		<div class="fs-4 mb-2">&nbsp;</div> 
			                                             		<div class="fs-4 mb-2"><span>\#{coNm}</span><span> : 회사명</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{coBrno}</span><span> : 사업자등록번호</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{ceoNm}</span><span> : 대표자명</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{coAddr}</span><span> : 회사 주소</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{coDaddr}</span><span> : 회사 상세주소</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{coZip}</span><span> : 회사 우편번호</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{empJncmpYmd}</span><span> : 사원 입사일</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{empRsgntnYmd}</span><span> : 사원 퇴사일</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{deptNm}</span><span> : 부서명</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{teamNm}</span><span> : 팀명</span></div>
			         											<div class="fs-4 mb-2">&nbsp;</div>
			                                             		<div class="fs-4 mb-2"><span>\#{elaprBgngDt}</span><span> : 기안일</span></div>
			                                             		<div class="fs-4 mb-2"><span>\#{currentDt}</span><span> : 현재 날짜</span></div>
		                                             		</div>
		                                             	
	                                             		</div> 
	                                             	</div>
	                                             </div> 
	                                             
	                                            <!--CKEditor 시작-->
	                                            <div style="width: 70%; min-width: 720px; display: flex; justify-content: center; background-color: #dbdbdb; border: 1px solid #f8f8f8;">
	                                            	   <c:choose>
		                                               		<c:when test="${status ne 'i' }">
				                                            	 <sec:authentication property="principal.member" var="emp"/>
				                                                 <c:choose>
				                                                 		<c:when test="${emp.empId eq formVO.empId}">
							                                               <textarea id="formEditorCK" name="docFormCn" style="position: absolute;">
							                                                  ${formVO.docFormCn }
							                                               </textarea>
				                                                 		</c:when>
				                                                 		<c:otherwise>
							                                               <textarea id="formEditorCK" name="docFormCn" style="position: absolute;" disabled>
							                                                  ${formVO.docFormCn }
							                                               </textarea>
				                                                 		</c:otherwise>
				                                                 </c:choose>
		                                               		</c:when>
		                                               		<c:otherwise>
		                                               		   <!-- 데이터 세팅하지 않은 기존 코드 -->
				                                               <!--  <textarea id="formEditorCK" name="docFormCn" style="position: absolute;"></textarea> -->
				                                               
				                                               <!-- 발표를 위한 데이터 세팅 -->
				                                               <textarea id="formEditorCK" name="docFormCn" style="position: absolute;">${formVO.docFormCn }</textarea>
		                                               		</c:otherwise>
		                                               </c:choose>
	                                            	 
	                                            </div>
	                                            <!--CKEditor 끝-->
                                            </div>
                                            
                                            <div class="me-9" style="display: flex; justify-content: right;">
                                            	 <c:choose>
	                                               		<c:when test="${status ne 'i' }">
			                                                 <sec:authentication property="principal.member" var="emp"/>
			                                                 <c:choose>
				                                                 <c:when test="${emp.empId eq formVO.empId}">
					                                                  <div style="margin-top: 25px; margin-bottom: 20px;">
					                                                     <input type="button" id="addBtn" class="btn btn-light-primary fs-3" value="${insertAndUpdate }">
					                                                  </div>
					                                                  <c:if test="${status eq 'u' }">
					                                                     <div style="margin-top: 25px; margin-bottom: 20px; margin-left: 5px;">
					                                                     	<input type="button" id="deleteBtn" class="btn btn-light-danger fs-3" value="삭제">
					                                                  	 </div> 
				                                                 	  </c:if>
					                                                  <div style="margin-top: 25px; margin-bottom: 20px; margin-left: 5px;">
					                                                     <input type="button" id="cancleBtn" class="btn btn-light-info fs-3" value="${cancleAndList }">
					                                                  </div> 
				                                               </c:when>
		                                            	 		<c:otherwise>
					                                                  <div style="margin-top: 25px; margin-bottom: 20px; margin-left: 5px;">
					                                                     <input type="button" id="cancleBtn" class="btn btn-light-info fs-3" value="목록">
					                                                  </div> 
		                                            	 		</c:otherwise>
			                                                </c:choose>
                                            	 		</c:when>
                                            	 		<c:otherwise>
                                           	 				  <div style="margin-top: 25px; margin-bottom: 20px;">
			                                                     <input type="button" id="addBtn" class="btn btn-light-primary fs-3" value="등록">
			                                                  </div>
			                                                  <div style="margin-top: 25px; margin-bottom: 20px; margin-left: 5px;">
			                                                     <input type="button" id="cancleBtn" class="btn btn-light-info fs-3" value="목록">
			                                                  </div> 
                                            	 		</c:otherwise>
	                                             </c:choose>
                                                 
                                            </div>
                                          
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
</form>


<script>
$(function() {
   
	// ***** form Process *****
   let addBtn = $('#addBtn');
   let cancleBtn = $('#cancleBtn');
   let formInsert = $('#formInsert');
   let deleteBtn = $('#deleteBtn');
   
   // 취소 버튼 클릭
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
            location.href= "/company/formList.do";
         }
      })
   });
   
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
      
      // 수정일 때
      if ($(this).val() == '수정') {
         formInsert.attr("action", "/company/formUpdate.do");
      }
      
      formInsert.submit();
   });
   
   // 삭제 버튼 클릭
   deleteBtn.on('click', function() {
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
            formInsert.attr("action", "/company/formDelete.do");
            formInsert.submit();
         }
      })
   });
   
   /* CKEDITOR 자바스크립트 */
   CKEDITOR.replace( 'formEditorCK', {
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
        $.ajax({
            type: "get",
            url: "/company/formSelectJstree.do",
            success: function(data) {
                f_createJstree(data);
                console.log(data);
            }
        });
    });  
    
});

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
        console.log("222");
    });
    
    // 최상위 노드만 추출
    const rootNodes = Object.values(tree).filter(node => node.parent === "#");

    // 정해진 형식으로 HTML 생성하기
    const treeHTML = generateHTML(rootNodes);

    // 결과를 DOM에 삽입하기
    console.log("333");
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
    })
    
    // 양식을 선택하면 CKEDITOR에 양식 내용 삽입하기
    $('#formJstree').bind('select_node.jstree', function(event, data){
       // 노드를 선택했을 때 id = docFormNo 가져오기
       console.log(data.node.li_attr.value);
       let docFormNo = data.node.li_attr.value;
       
       $.ajax({
          url: "/company/selectForm.do?docFormNo=" + docFormNo,
          type: "get",
          contentType : "application/json; charset=utf-8",
          success: function(res) {
             CKEDITOR.instances.formEditorCK.setData(res.docFormCn);
             // Bootstrap 모달 숨기기
             $('#formCall1').modal('hide');
         }
       });
    });
    
}

// HTML 생성 함수
/* function generateHTML(nodes) {
    let html = ""; 
    nodes.forEach(node => {
        const isRoot = node.parent === "#";
        html += `<li data-jstree='{"type" : "\${node.type}"` + (isRoot ? ', "opened" : true' : '') + `}' value='\${node.id}'>\${node.text}`;
        if (node.children.length > 0) { 
            html += "<ul>" + generateHTML(node.children) + "</ul>";
        }
        html += "</li>";
    });
    return html;
} */

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

</script>
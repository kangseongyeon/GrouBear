<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<link href="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css"/>
<script src="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.js"></script>

<!-- ckeditor API -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script> 

<!-- sweetalert2 --> 
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- jstree -->
<link href="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.js"></script>

<!-- axios -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!-- CKEDITOR 경고창 없애기 -->
<style>
   .cke_notifications_area { display: none; }
</style>

<div style="margin-bottom: 20px;">
   <div style="margin-top: -32px;">
      <div class="separator border-2 my-10"></div>
   </div>
   <div style="margin-left: 30px; margin-top: -100px;">
		<h3>공지사항 관리</h3>
		<h6>커뮤니티 관리</h6>
	</div>
</div>

<c:set value="등록" var="insertAndUpdate"/>
<c:set value="목록" var="cancleAndList"/>
<c:if test="${status eq 'u' }">
   <c:set value="수정" var="insertAndUpdate"/>
</c:if>

<form action="/groubear/cmntyNoticeInsert.do" id="formInsert" method="post">
	<input type="hidden" id="cmntyNo" name="cmntyNo" value="${cmntyVO.cmntyNo }">

		<div class="kt_app_content_container mx-5 mb-5" class="app-container container-fluid" style="height: 100%"> 
			<div class="card card-flush">
		                
                <div class="container">
                
                   <div class="card-header">
                       <div class="card-title" style="width: 100%;">
                                 <h2><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">공지사항 ${insertAndUpdate }</font></font></h2>
                       </div>
                   </div>
               
                  <!-- card-body 시작 --> 
                   <div class="card-body p-0" style="margin-top: 20px;"> 
                       <div class="fv-row fv-plugins-icon-container" style="margin-left: 3em; margin-right: 3em;"> 
                          
                          <c:choose> 
                          	<c:when test=""> 
                          	
                          	</c:when>
                          	<c:otherwise>
                          	
                          	</c:otherwise>
                          </c:choose>
                          <div class="my-10" style="width: 90%">
                          		<input id="cmntyNoticeYn" class="form-check-input" type="checkbox" name="cmntyNoticeYn" value="Y" 
                          				<c:if test="${cmntyVO.cmntyNoticeYn == 'Y' }">checked</c:if> style="width: 1.4em; height: 1.4em; margin-top: 0.1em;">
                          		<font class="position-absolute fw-bold ms-3 fs-6" style="color: #ee1d1dc9">필수공지 (상단 고정 여부)</font>
                          </div> 
                           <%-- 데이터 세팅하지 않은 기존 코드
                          <div style="display: flex;">
                             <div style="width: 10%;">
                                 <label class="form-label" style="margin-top: 10px;">제목 <font style="color: red">*</font></label>
                             </div> 
                             <input style="width: 90%;" type="text" id="cmntyTtl" name="cmntyTtl" class="form-control mb-2" placeholder="제목을 입력해주세요." value="${cmntyVO.cmntyTtl }"> 
                          </div> 
                          <span class="error invalid-feedback" style="display:block;">${error.docFormNm }</span>
                  
                  		  <div class="d-flex justify-center">
	                  		  <div style="width: 10%;">
	                  		  	파일첨부
	                  		  </div>
	                  		  <!-- 파일 업로드 시작 -->
							  <div class="rounded border p-3" style="width: 90%;">
							  	 <div class="form-group">
							  		<div class="dropzone dropzone-queue" id="kt_modal_upload_dropzone">
							  			<div class="dropzone-panel mb-1">
							  				<a class="dropzone-select btn btn-sm btn-primary me-2">파일 선택</a>
							  				<a class="dropzone-remove-all btn btn-sm btn-light-primary">전체 삭제</a>
							  				<a class="dropzone-upload"></a> 
							  			</div>
						
							  			<div id="fileList" style="overflow: scroll; max-height: 130px;">
												
											<!-- 깡통이 없으면 첫번째 파일의 영역이 나오지 않음 -> 구매한 템플릿 또는 드롭존의 문제인 듯함 -->
											<!-- 깡통 시작 -->
											<div class="dropzone-items wm-200px"> 
												<div class="dropzone-item p-2 py-1" style="display:none">
													<div class="dropzone-file">
														<div class="dropzone-filename text-gray-900 ms-2" title="some_image_file_name.jpg">
															<span data-dz-name=""></span>
															<strong>(
																<span data-dz-size="">340kb</span>)</strong>
														</div>
														<div class="dropzone-error mt-0 ms-2" data-dz-errormessage=""></div>
													</div>
													<div class="dropzone-toolbar">
														<span class="dropzone-start">
														</span>
														<span class="dropzone-cancel" data-dz-remove="" style="display: none;">
															<i class="ki-duotone ki-cross fs-2">
																<span class="path1"></span>
																<span class="path2"></span>
															</i>
														</span>
														<span class="dropzone-delete" data-dz-remove="">
															<i class="ki-duotone ki-cross fs-2">
																<span class="path1"></span>
																<span class="path2"></span>
															</i> 
														</span>
													</div>
												</div>
											</div>
											<!-- 깡통 끝 --> 
												
											<c:if test="${not empty cmntyVO.atchFileDetailList }">
												<c:forEach items="${cmntyVO.atchFileDetailList }" var="atchFileDetailVO">
													<div class="dropzone-items wm-200px">
														<div class="dropzone-item p-2 py-1 dz-image-preview mt-1">
															<div class="dropzone-file">
													 			<div class="dropzone-filename text-gray-900 ms-2" title="some_image_file_name.jpg">
																	<span data-dz-name="">${atchFileDetailVO.atchFileDetailOrgnlNm}</span> <strong>( <span data-dz-size=""><strong>${atchFileDetailVO.atchFileDetailFancysize }</strong></span>)</strong>
																</div>
															</div>
										  					<div class="dropzone-toolbar divDel" data-atch-file-cd="${cmntyVO.atchFileCd}" 
										  									data-atch-file-detail-cd="${atchFileDetailVO.atchFileDetailCd}">
										  						<span class="dropzone-start">
										  						</span>
										  						<span class="dropzone-cancel" data-dz-remove="" style="display: none;">
										  							<i class="ki-duotone ki-cross fs-2">
										  								<span class="path1"></span>
										  								<span class="path2"></span>
										  							</i>
										  						</span>
										  						<span class="dropzone-delete" data-dz-remove="">
										  							<i class="ki-duotone ki-cross fs-2">
										  								<span class="path1"></span>
										  								<span class="path2"></span>
										  							</i>
										  						</span>
										  					</div>
														</div>
													</div>
												</c:forEach>
											</c:if>
							  			</div>
							  			
							  		</div>
							  		<span class="form-text fs-7 text-muted">&emsp;파일당 최대 파일 크기 : 2MB&emsp;&emsp;||&emsp;&emsp;</span>
							  		<span class="form-text fs-7 text-muted">1회당 최대 파일 갯수 : 10개&emsp;</span> 
							  	 </div> 
							  </div>
							  <!-- 파일 업로드 끝 --> 
                  		  </div>
                  
                          <div>
                              <label class="form-label" style="margin-top: 10px;">공지사항 내용 <font style="color: red">*</font></label>
						  </div>
                          <span class="error invalid-feedback" style="display:block;">${error.docFormCn }</span>
                           
                          <!--CKEditor 시작-->
                          <div style="width: 100%; min-width: 720px; display: flex; justify-content: center; background-color: #dbdbdb; border: 1px solid #f8f8f8;">
                                <textarea id="formEditorCK" name="cmntyCn" style="position: absolute;">
                                	${cmntyVO.cmntyCn }
                                </textarea> 
                          </div> 
                          <!--CKEditor 끝-->
                            --%>
                           
                           
                          <!-- 발표를 위한 데이터 세팅 -->
                          <div style="display: flex;">
                             <div style="width: 10%;">
                                 <label class="form-label" style="margin-top: 10px;">제목 <font style="color: red">*</font></label>
                             </div> 
                             <input style="width: 90%;" type="text" id="cmntyTtl" name="cmntyTtl" class="form-control mb-2" placeholder="제목을 입력해주세요." value="${cmntyVO.cmntyTtl }"> 
                          </div> 
                          <%-- <span class="error invalid-feedback" style="display:block;">${error.docFormNm }</span> --%>
                  
                  		  <div class="d-flex justify-center">
	                  		  <div style="width: 10%;">
	                  		  	파일첨부
	                  		  </div>
	                  		  <!-- 파일 업로드 시작 -->
							  <div class="rounded border p-3" style="width: 90%;">
							  	 <div class="form-group">
							  		<div class="dropzone dropzone-queue" id="kt_modal_upload_dropzone">
							  			<div class="dropzone-panel mb-1">
							  				<a class="dropzone-select btn btn-sm btn-primary me-2">파일 선택</a>
							  				<a class="dropzone-remove-all btn btn-sm btn-light-primary">전체 삭제</a>
							  				<a class="dropzone-upload"></a> 
							  			</div>
						
							  			<div id="fileList" style="overflow: scroll; max-height: 130px;">
												
											<!-- 깡통이 없으면 첫번째 파일의 영역이 나오지 않음 -> 구매한 템플릿 또는 드롭존의 문제인 듯함 -->
											<!-- 깡통 시작 -->
											<div class="dropzone-items wm-200px"> 
												<div class="dropzone-item p-2 py-1" style="display:none">
													<div class="dropzone-file">
														<div class="dropzone-filename text-gray-900 ms-2" title="some_image_file_name.jpg">
															<span data-dz-name=""></span>
															<strong>(
																<span data-dz-size="">340kb</span>)</strong>
														</div>
														<div class="dropzone-error mt-0 ms-2" data-dz-errormessage=""></div>
													</div>
													<div class="dropzone-toolbar">
														<span class="dropzone-start">
														</span>
														<span class="dropzone-cancel" data-dz-remove="" style="display: none;">
															<i class="ki-duotone ki-cross fs-2">
																<span class="path1"></span>
																<span class="path2"></span>
															</i>
														</span>
														<span class="dropzone-delete" data-dz-remove="">
															<i class="ki-duotone ki-cross fs-2">
																<span class="path1"></span>
																<span class="path2"></span>
															</i> 
														</span>
													</div>
												</div>
											</div>
											<!-- 깡통 끝 --> 
												
											<c:if test="${not empty cmntyVO.atchFileDetailList }">
												<c:forEach items="${cmntyVO.atchFileDetailList }" var="atchFileDetailVO">
													<div class="dropzone-items wm-200px">
														<div class="dropzone-item p-2 py-1 dz-image-preview mt-1">
															<div class="dropzone-file">
													 			<div class="dropzone-filename text-gray-900 ms-2" title="some_image_file_name.jpg">
																	<span data-dz-name="">${atchFileDetailVO.atchFileDetailOrgnlNm}</span> <strong>( <span data-dz-size=""><strong>${atchFileDetailVO.atchFileDetailFancysize }</strong></span>)</strong>
																</div>
															</div>
										  					<div class="dropzone-toolbar divDel" data-atch-file-cd="${cmntyVO.atchFileCd}" 
										  									data-atch-file-detail-cd="${atchFileDetailVO.atchFileDetailCd}">
										  						<span class="dropzone-start">
										  						</span>
										  						<span class="dropzone-cancel" data-dz-remove="" style="display: none;">
										  							<i class="ki-duotone ki-cross fs-2">
										  								<span class="path1"></span>
										  								<span class="path2"></span>
										  							</i>
										  						</span>
										  						<span class="dropzone-delete" data-dz-remove="">
										  							<i class="ki-duotone ki-cross fs-2">
										  								<span class="path1"></span>
										  								<span class="path2"></span>
										  							</i>
										  						</span>
										  					</div>
														</div>
													</div>
												</c:forEach>
											</c:if>
							  			</div>
							  			
							  		</div>
							  		<span class="form-text fs-7 text-muted">&emsp;파일당 최대 파일 크기 : 2MB&emsp;&emsp;||&emsp;&emsp;</span>
							  		<span class="form-text fs-7 text-muted">1회당 최대 파일 갯수 : 10개&emsp;</span> 
							  	 </div> 
							  </div>
							  <!-- 파일 업로드 끝 --> 
                  		  </div>
                  
                          <div>
                              <label class="form-label" style="margin-top: 10px;">공지사항 내용 <font style="color: red">*</font></label>
						  </div>
                          <%-- <span class="error invalid-feedback" style="display:block;">${error.docFormCn }</span> --%>
                           
                          <!--CKEditor 시작-->
                          <div style="width: 100%; min-width: 720px; display: flex; justify-content: center; background-color: #dbdbdb; border: 1px solid #f8f8f8;">
                                <textarea id="formEditorCK" name="cmntyCn" style="position: absolute;">
                                	${cmntyVO.cmntyCn }
                                </textarea> 
                          </div> 
                          <!--CKEditor 끝-->
                          
							<div class="card-footer p-3 d-flex justify-content-end" style="border-top: none;"> 
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
	// X 클릭 시 부모 영역 삭제 (기존의 파일 삭제 변동)
	$(".divDel").on("click",function(){
/* 		let atchFileCd = $(this).data("atchFileCd");
		let atchFileDetailCd = $(this).data("atchFileDetailCd");
		
		console.log("atchFileCd : " + atchFileCd + ", atchFileDetailCd : " + atchFileDetailCd); */
		
		$(this).parent().parent().remove();
	});
   
// ***** form Process *****
   let addBtn = $('#addBtn');
   let cancleBtn = $('#cancleBtn');
   
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
            location.href= "/groubear/cmntyNoticeList.do";
         }
      })
   });
   
   // 등록/수정 버튼 클릭
   addBtn.on('click', function() {
		let cmntyNo = $('#cmntyNo').val() ? $('#cmntyNo').val() : 0;
		let cmntyNoticeYn = "";
		let cmntyTtl = $('#cmntyTtl').val();
 		let cmntyCn = CKEDITOR.instances.formEditorCK.getData();
		
 		if ($('#cmntyNoticeYn').prop('checked')) {
 			cmntyNoticeYn = "Y";
 		} else {
 			cmntyNoticeYn = "N";
 		}
 		
		console.log(myDropzone.files.length);
		console.log(myDropzone.files); 
		
		// 최대 파일 갯수 검증하기
		if (myDropzone.files.length > 10) {
			Swal.fire({
				icon: 'warning',
				title: '최대 파일 갯수를 초과하였습니다!',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}
		
		// 최대 파일 크기 검증하기		
		let flag = true;
		myDropzone.files.forEach(files => {
			console.log(files.status);
			
			if (files.status == "error") {
				Swal.fire({
					icon: 'warning',
					title: '최대 파일 크기를 초과한 파일이 있습니다!',
					text: '해당 파일을 제거한 뒤 다시 시도해주세요.',
					confirmButtonColor: '#4FC9DA',
				});
				flag = false;
			}
		});
		
		if (flag == false) {
			return false;
		}
		
		// 제목, 내용 등 빈칸 확인
		if (cmntyTtl == null || cmntyTtl == "" ||
			cmntyCn == null || cmntyCn == "") {
		   Swal.fire({
		      icon: 'warning',
		      title: '필수 입력이 비어있습니다.',
		      text: '필수 입력 내용을 채워주세요.',
		      confirmButtonColor: '#4FC9DA',
		   });
		   return false; 
		}
		
		// 모두 통과했을 때 Ajax로 파일 업로드 하기
		let formData = new FormData();
		
		console.log("cmntyTtl : ", cmntyTtl, " cmntyCn : ", cmntyCn, " cmntyNo : ", cmntyNo, " cmntyNoticeYn : ", cmntyNoticeYn);
		
		formData.append("cmntyTtl", cmntyTtl);
		formData.append("cmntyCn", cmntyCn);  
		formData.append("cmntyNo", cmntyNo);  //EL을 J/S변수로 변경 시 ""를 쓰자
		formData.append("cmntyNoticeYn", cmntyNoticeYn);  
		formData.append("atchFileCd", "${cmntyVO.atchFileCd}");  //EL을 J/S변수로 변경 시 ""를 쓰자
		myDropzone.files.forEach(files => { 
			formData.append("atchFiles", files);//I. 신규추가
			console.log(files);
		});
		
		let action = "/groubear/cmntyNoticeInsert.do"; 
      
		// 수정일 때
		if ($(this).val() == '수정') {
			action = "/groubear/cmntyNoticeModify.do";
		}
		
		//II. 파일변경
		//bef : 1.jpg, 2.jpg, 3.jpg
		//aft : 1.jpg         3.jpg 를 구하자
		
		//DB에는 1.jpg, 2.jpg, 3.jpg
		//aft : 1.jpg delete 3.jpg 를 구하자
		/*
		BEF : GRONTCD148 GRONTCD149 GRONTCD150
		AFT : GRONTCD148            GRONTCD150
		
		UPDATE ATCH_FILE_DETAIL
		SET    ATCH_FILE_DETAIL_DEL_YN = 'Y'
		WHERE  ATCH_FILE_CD = 'GRONTC149'
		AND    ATCH_FILE_DETAIL_CD NOT IN('GRONTCD148','GRONTCD150');
		*/
		
		// 기존에 있던 파일 중에 남아있는 파일들만 모아서 formData 내부의 리스트에 인덱스 값으로 돌려서 값을 넣기
		$(".divDel").each(function(idx){
			let atchFileCd = $(this).data("atchFileCd");
			let atchFileDetailCd = $(this).data("atchFileDetailCd");
			
			console.log("atchFileCd : " + atchFileCd + ", atchFileDetailCd : " + atchFileDetailCd);
			formData.append("atchFileUpdateList["+idx+"].atchFileCd", atchFileCd);
			formData.append("atchFileUpdateList["+idx+"].atchFileDetailCd", atchFileDetailCd);
		});
		
		// 등록 및 수정 요청 (비동기)
        axios.post(action, formData, { 
        	headers: {
        		'Content-Type' : 'multipart/form-data'
        	}
        })
        .then(function (res) {
            console.log(res.data);
            
            if (typeof res.data == 'number') {
            	if (res.data != 0) {
	            	setTimeout(() => {
	            		location.href = "/groubear/cmntyNoticeDetail.do?cmntyNo=" + res.data;
					}, 1000);
	                Swal.fire({
	                    icon: 'success',
	                    title: '공지사항 등록이 완료되었습니다.',
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
                
            } else if (res.data == "updateOK") {
            	setTimeout(() => {
            		location.href = "/groubear/cmntyNoticeDetail.do?cmntyNo=" + cmntyNo;
				}, 1000);
                Swal.fire({
                    icon: 'success',
                    title: '공지사항 수정이 완료되었습니다.',
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
   
   /* CKEDITOR 자바스크립트 */
    CKEDITOR.replace( 'formEditorCK', {
      	height: 500,
      	width: 1010,
		// 사용하려는 툴바의 버튼을 문자열로 지정해서 포함시킴
 		toolbar: [
		    { name: 'document', items: ['Source', 'ExportPdf', 'Print', 'Newpage'] },
		    { name: 'html', items: ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'HiddenField'] },
		    { name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'Undo', 'Redo', 'Find', 'Replace', 'Selectall'] },
		    { name: 'alignment', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', 'BidirectionalLTR', 'BidirectionalRTL'] },
		    { name: 'styles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', 'Numberedlist', 'Bulletedlist', 'Outdent', 'Indent'] },
		    { name: 'insert', items: ['Table', 'HorizontalRule', 'SpecialChar', 'PageBreak', 'CreateDiv', 'Insertdiv'] },
		    { name: 'custom', items: ['Styles', 'Font', 'FontSize', 'TextColor', 'BGColor', 'NumberedList', 'BulletedList', 'Maximize'] }
		] 
   });

    

	// 파일 선택하면 화면에 띄우기 (Dropzone 설정)
	const id = "#kt_modal_upload_dropzone";
	const dropzoneElement = document.querySelector(id);
/* 	console.log("Dropzone element:", dropzoneElement); */

	var previewNode = dropzoneElement.querySelector(".dropzone-item");
	previewNode.id = ""; 
	
	// Dropzone 커스텀 템플릿
	// 원하는 모양으로 만들고 previewTemplate 옵션으로 적용
	var previewTemplate = previewNode.parentNode.innerHTML;
	previewNode.parentNode.removeChild(previewNode); 

	var myDropzone = new Dropzone(dropzoneElement, {
	    url: "https://keenthemes.com/scripts/void.php", // 파일을 업로드할 서버 주소 url
	    method: 'post', // 기본 post로 request 감. put으로도 할수있음
		// 자동으로 보내기. true : 파일 업로드 되자마자 서버로 요청, false : 서버에는 올라가지 않은 상태. 
		// 따로 this.processQueue() 호출시 전송
	    autoProcessQueue: false,  
	    maxFiles: 10, // 업로드 파일수
	    parallelUploads: 10, // 동시파일업로드 수(이걸 지정한 수 만큼 여러파일을 한번에 넘긴다.)
	    uploadMultiple: true, // 다중업로드 기능
	    timeout: 300000, //커넥션 타임아웃 설정 -> 데이터가 클 경우 꼭 넉넉히 설정
	    
	    maxFilesize: 2, // 최대 업로드 용량 2MB  
	    autoQueue: false, // 드래그 드랍 후 바로 서버로 전송 여부
	    previewTemplate: previewTemplate, // Dropzone 커스텀 템플릿
	    previewsContainer: dropzoneElement.querySelector(".dropzone-items"), // 커스텀 템플릿을 넣을 Container 위치
	    clickable: dropzoneElement.querySelector(".dropzone-select") // 클릭 가능 여부
	});

/* 	console.log("Dropzone instance:", myDropzone); */ 

	// 파일 추가 시 이벤트 (Dropzone 설정)
	myDropzone.on("addedfile", function (file) {
       // 중복된 파일 제거하기
       if (this.files.length) {
          var hasFile = false;
          for (var i = 0; i < this.files.length - 1; i++) {
             if (
                this.files[i].name === file.name &&
                this.files[i].size === file.size &&
                this.files[i].lastModifiedDate.toString() === file.lastModifiedDate.toString()
             ) {
                hasFile = true; 
                this.removeFile(file);
             }
          }
       }
		
		file.previewElement.querySelector(id + " .dropzone-start").onclick = function () { myDropzone.enqueueFile(file); };
	    const dropzoneItems = dropzoneElement.querySelectorAll('.dropzone-item');
	    dropzoneItems.forEach(dropzoneItem => {
	        dropzoneItem.style.display = ''; 
	    });
	    dropzoneElement.querySelector('.dropzone-upload').style.display = "inline-block"; 
	    dropzoneElement.querySelector('.dropzone-remove-all').style.display = "inline-block";
	});

	// 전체 삭제 버튼 누를 때 (Dropzone 설정)
	$(document).on('click', ".dropzone-remove-all", function () {
	    Swal.fire({
	        text: "선택한 파일을 모두 삭제하시겠습니까?",
	        icon: "warning",
	        showCancelButton: true,
	        buttonsStyling: false,
	        confirmButtonText: "예",
	        cancelButtonText: "아니요",
	        customClass: {
	            confirmButton: "btn btn-primary",
	            cancelButton: "btn btn-active-light"
	        }
	    }).then(function (result) {
	        if (result.value) {
	            dropzoneElement.querySelector('.dropzone-upload').style.display = "none";
	            dropzoneElement.querySelector('.dropzone-remove-all').style.display = "none";
	            myDropzone.removeAllFiles(true);
	        }
	    });
	});

	// 전체 삭제 버튼 프로세스 (Dropzone 설정)
	myDropzone.on("removedfile", function (file) {
	    if (myDropzone.files.length < 1) {
	        dropzoneElement.querySelector('.dropzone-upload').style.display = "none";
	        dropzoneElement.querySelector('.dropzone-remove-all').style.display = "none";
	    }
	});
	
	// 전체 저장 버튼 누를 때
	$(document).on('click', ".dropzone-upload", function () {
	});
	
});

</script>
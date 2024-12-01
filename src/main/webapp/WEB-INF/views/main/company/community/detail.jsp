<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
input[type=file]::file-selector-button {
  width: 100px;
  height: 30px;
  background: #D0EFF2;
  border: 1px solid rgb(77,77,77);
  border-radius: 10px;
  border-color: #4FC9DA;
  cursor: pointer;
  &:hover {
    background: rgb(77,77,77);
    color: #fff;
  }
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
	<c:remove var="message" scope="request" />
</c:if>

<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>커뮤니티</h3>
		<h6>게시글</h6>
	</div>
</div>

<div class="mb-10" id="kt_social_feeds_posts">
	<div class="card card-flush mb-5">
		<div class="card-header pt-9 ms-3">
			<div class="d-flex ">
				<div
					class="flex-grow-1 d-flex align-items-center position-relative my-1">
					<h2 class="me-3">${comCommunityVO.cmntyTtl }</h2>
					<p class="text-gray-500 fw-semibold d-block"
						style="margin-top: auto;">${comCommunityVO.empNm }</p>
					<!--end::Date-->
					<input type="hidden" id="delYn" class="delYn"
						value="${comCommunityVO.cmntyDelYn }" />
				</div>
			</div>
			<div class="card-toolbar">
				<div class="m-0">
					<button
						class="btn btn-icon btn-color-gray-500 btn-active-color-primary me-n4"
						data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end"
						data-kt-menu-overflow="true">
						<i class="ki-duotone ki-dots-square fs-1"> <span class="path1"></span>
							<span class="path2"></span><span class="path3"></span><span
							class="path4"></span>
						</i>
					</button>
					<div
						class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg-light-primary fw-semibold w-200px"
						data-kt-menu="true">
						<div class="menu-item px-3">
							<a href="" id="cmtUdtBtn" class="menu-link px-3">수정</a>
						</div>

						<div class="menu-item px-3">
							<a href="" id="cmtCelBtn" class="menu-link px-3">삭제</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<p class="text-gray-500 fw-semibold d-block ms-13">${comCommunityVO.cmntyRegDt }</p>
		<div class="card-body">
			<div class="mb-8">
				<div class="separator separator-solid"></div>
			</div>
			<div class="fs-6 fw-normal text-gray-700 ms-3">${comCommunityVO.cmntyCn }</div>
			<div style="display: flex; flex-wrap: wrap;">
				<c:if test="${not empty comCommunityVO.atchFiles}">
					<c:forEach items="${comCommunityVO.atchFiles[0].atchFileDetailList }"
						var="fileDt">
						<input type="hidden" value="${fileDt.atchFileDetailExtnNm }" />
						<c:if
							test="${fileDt.atchFileDetailExtnNm == 'jpg' ||
              						  fileDt.atchFileDetailExtnNm == 'jpeg' || 
              						  fileDt.atchFileDetailExtnNm == 'png' ||
              						  fileDt.atchFileDetailExtnNm == 'gif' }">
							<div style="margin-top: 10px; margin-right: 10px;">
								<img src="/upload/${fileDt.atchFileDetailStrgNm}" width="250"
									height="290">
							</div>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
			<div style="margin-top: 10px;">
				<c:if test="${not empty comCommunityVO.atchFiles}">
					<div class="separator separator-solid mb-4"></div>
					<table id="kt_file_manager_list" data-kt-filemanager-table="files"
						class="table align-middle table-row-dashed fs-6 gy-1">
						<tbody class="fw-semibold text-gray-600">
							<tr>
								<td><div
										class="form-check form-check-sm form-check-custom form-check-solid"
										style="margin-left: 10px; margin-right: 15px;">
										<input class="form-check-input" id="allCheck" type="checkbox"
											value="1">
									</div></td>
								<td style="width: 85%;">파일명</td>
								<td style="width: 15%;">용량</td>
								<td><a
									href="/upload/${atchFileDetailVO.atchFileDetailStrgNm}"
									onclick="fCkDownload()" class="btn btn-light-info"
									style="width: 180%; margin-bottom: 0; float: right;">다운로드</a></td>
							</tr>
						</tbody>
					</table>

					<!-- 파일 리스트 -->
					<div class="separator separator-solid mb-8"></div>
					<c:forEach items="${comCommunityVO.atchFiles[0].atchFileDetailList}"
						var="fileDtDown">
						<table id="kt_file_manager_list" data-kt-filemanager-table="files"
							class="table align-middle table-row-dashed fs-6 gy-1">
							<tbody class="fw-semibold text-gray-600">
								<tr>
									<td>
										<div
											class="form-check form-check-sm form-check-custom form-check-solid"
											style="margin-left: 10px;">
											<input class="form-check-input checkFile"
												data-dabin-ofn="${fileDtDown.atchFileDetailOrgnlNm }"
												data-dabin-sfn="${fileDtDown.atchFileDetailStrgNm }"
												name="checkFile" type="checkbox"
												value="${fileDtDown.atchFileDetailCd }" />
										</div>
									</td>
									<td style="width: 80%;">
										<div class="d-flex align-items-center">
											<i class="ki-duotone ki-files fs-2x text-primary me-4"></i> <a
												href="#" class="text-gray-800 text-hover-primary">${fileDtDown.atchFileDetailOrgnlNm }</a>
										</div>
									</td>
									<td style="width: 20%;">${fileDtDown.atchFileDetailFancysize }</td>
									<td class="text-end" style="width: 20%;"
										data-kt-filemanager-table="action_dropdown"><div
											class="d-flex justify-content-end"></div></td>
								</tr>
							</tbody>
						</table>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<div class="card-footer pt-0">
			<div class="separator separator-solid"></div>
			<div class="mb-6">
				<ul class="nav py-3">
					<li class="nav-item" id="commentShowBtn"><a
						class="nav-link btn btn-sm btn-color-gray-600 btn-active-color-primary btn-active-light-primary fw-bold px-4 me-1 collapsible"
						data-bs-toggle="collapse" href="#kt_social_feeds_comments_4">
							<i class="ki-duotone ki-message-text-2 fs-2 me-1"> <span
								class="path1"></span> <span class="path2"></span> <span
								class="path3"></span>
						</i>댓글
					</a></li>
				</ul>
				<!-- 여기가 댓글 위치 -->

				<div id="commentNull"></div>

				<!-- 여기가 댓글 위치 -->
			</div>

			<!-- 원래 띄워져 있는 답글 입력 칸-->
			<div class="d-flex align-items-center">
				<div class="symbol symbol-35px me-3">
					<img src="/upload/${employeeVO.imgFileUrl }" alt="">
				</div>
				<div class="position-relative w-100">
					<input type="hidden" id="commentCmntyNo" name="commentCmntyNo"
						value="${comCommunityVO.cmntyNo}"> <input type="hidden"
						id="upCmntNo" name="upCmntNo" value="${comCommentVO.upCmntNo }">

					<textarea id="cmntCn"
						class="form-control form-control-solid border ps-5" rows="1"
						name="cmntCn" data-kt-autosize="true" placeholder="댓글을 작성해주세요"
						data-kt-initialized="1"
						style="overflow: hidden; overflow-wrap: break-word; resize: none; text-align: start; height: 80px;"></textarea>

					<div class="position-absolute bottom-0 end-0 me-4 mb-2">

						<!-- 댓글 -->
						<button id="commentAddBtn"
							class="btn btn-icon btn-sm btn-color-gray-500 btn-active-color-primary w-25px p-0">
							<i class="bi bi-chat-square-text-fill fs-2"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div>
		<input type="hidden" id="listType" value="${comCommunityVO.cmntyType }" />
		<input type="button" id="listBtn" class="btn btn-light-info"
			style="margin-left: 20px" value="목록" />
	</div>
</div>


<div class="modal fade" id="kt_modal_add_user">
	<div class="modal-dialog modal-dialog-centered mw-650px">
		<div class="modal-content">
			<div class="modal-header" id="kt_modal_add_user_header">
				<h2 class="fw-bold">수정</h2>
				<div class="btn btn-icon btn-sm btn-active-icon-primary"
					data-bs-dismiss="modal" data-kt-users-modal-action="close">
					<i class="ki-duotone ki-cross fs-1"> <span class="path1"></span>
						<span class="path2"></span>
					</i>
				</div>
			</div>
			<div class="modal-body px-5 my-7">
				<form id="kt_modal_add_user_form" class="form communityModify"
					action="" method="post" enctype="multipart/form-data">
					<input type="hidden" name="cmntyNo" id="cmntyNo"
						value="${comCommunityVO.cmntyNo }" /> <input type="hidden"
						name="atchFileCd" value="${comCommunityVO.atchFileCd }" />

					<!-- 고정된 사용자 아이디 -->
					<div class="d-flex flex-column scroll-y px-5 px-lg-10"
						id="kt_modal_add_user_scroll" data-kt-scroll="true"
						data-kt-scroll-activate="true" data-kt-scroll-max-height="auto"
						data-kt-scroll-dependencies="#kt_modal_add_user_header"
						data-kt-scroll-wrappers="#kt_modal_add_user_scroll"
						data-kt-scroll-offset="300px">
						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">제목</label> <input
								type="text" id="cmntyTtl" name="cmntyTtl"
								value="${comCommunityVO.cmntyTtl }"
								class="form-control form-control-solid mb-3 mb-lg-0" />
						</div>
						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">내용</label>
							<textarea id="cmntyCn" name="cmntyCn" rows="10" cols="10"
								class="form-control form-control-solid mb-3 mb-lg-0">${comCommunityVO.cmntyCn }</textarea>
						</div>
						<div class="fv-row mb-7">
							<label class="d-block fw-semibold fs-6 mb-0 mt-0" for="atchFiles"
								style="padding-top: 8px"></label> <input type="file"
								id="atchFiles" name="atchFiles" multiple="multiple">
						</div>
						<c:if test="${not empty comCommunityVO.atchFiles }">
							<c:if test="${atchFileVO.atchFileDelYn == N }">
								<ul class="mailbox-attachments d-flex align-items-stretch"
									id="atchList">
									<c:set var="cnt" value="0" />
									<c:forEach
										items="${comCommunityVO.atchFiles[0].atchFileDetailList }"
										var="fileList">
										<li style="list-style-type: none; margin-right: 20px"
											id="${fileList.atchFileDetailCd }"><i
											id="atchFileDeleteBtn" onclick="atchFiledelBtn(this)"
											class="ki-duotone ki-cross-square"
											style="list-style-type: none; float: right;"> <span
												class="path1"></span> <span class="path2"></span>
										</i>
											<div id="fileInfo">
												<input type="hidden" id="atchFileDetailCd_${cnt }"
													name="atchFileDetailCd"
													value="${fileList.atchFileDetailCd }" /> <input
													type="hidden" id="atchFileCd" name="atchFileCd"
													value="${fileList.atchFileCd }" /> <input type="hidden"
													id="atchFileDetailPathNm" name="atchFileDetailPathNm"
													value="${fileList.atchFileDetailExtnNm }" /> <input
													type="hidden" id="atchFileDetailExtnNm"
													name="atchFileDetailExtnNm"
													value="${fileList.atchFileDetailCd }" /> <input
													type="hidden" id="atchFileDetailSize"
													name="atchFileDetailSize"
													value="${fileList.atchFileDetailSize }" /> <input
													type="hidden" id="atchFileDetailStrgNm"
													name="atchFileDetailStrgNm"
													value="${fileList.atchFileDetailStrgNm }" /> <input
													type="hidden" id="atchFileDetailRegDt"
													name="atchFileDetailRegDt"
													value="${fileList.atchFileDetailRegDt }" /> <input
													type="hidden" id="atchFileDetailDelYn"
													name="atchFileDetailDelYn"
													value="${fileList.atchFileDetailDelYn }" /> <input
													type="hidden" id="empId" name="empId"
													value="${fileList.empId }" /> <a href="#"
													id="atchFileDetailOrgnlNm"> <i
													class="fas fa-paperclip me-3"></i>${fileList.atchFileDetailOrgnlNm }
												</a> <span class="clearfix mt-1" id="atchFileDetailFancysize">
													<span>${fileList.atchFileDetailFancysize }</span>
												</span>
											</div></li>
										<c:set var="cnt" value="${cnt+1 }" />
									</c:forEach>
								</ul>
							</c:if>
						</c:if>
						<input type="hidden" id="adCnt" value="${cnt }">
					</div>
				</form>
				<div class="text-center pt-10" id="comunityModal">
					<button type="reset" class="btn btn-light me-3" id="modifyCancel"
						data-bs-dismiss="modal">취소</button>
					<button type="button" id="modifyAdd" class="btn btn-primary"
						data-kt-users-modal-action="button">
						<span class="indicator-label">수정</span> <span
							class="indicator-progress">Please wait... <span
							class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
					</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

function fCkDownload(){
	event.preventDefault();  // href 동작 막기
	let ckedBoxs = document.querySelectorAll("[name=checkFile]:checked");
	for(let i=0; i < ckedBoxs.length; i++){
		let ckbox = ckedBoxs[i];
		let orgFn=  ckbox.dataset.dabinOfn;
		let savedFn = ckbox.dataset.dabinSfn;

		// 스크립트 다운로드 기능 구현
		// a 태그 생성
		let aTag = document.createElement("a");
		// href에 웹경로 주기
		aTag.href= `/upload/\${savedFn}`;
		// 다운로드이름은 원래 파일명
		aTag.download = orgFn;
		// 강제 클릭
		aTag.click();
	}

}


function replyBtn(commentNo) {
	
	let data = {
			commentNo : commentNo
		}
		
		$.ajax({
			url : "/company/getreply.do",
			type : "post",
			contentType : "application/json; charset=utf-8",
			data: JSON.stringify(data),
			success: function(result) {
				
				let html = "";
				
				if(result == null && result == ""){
					$("#commentReply").text("댓글이 없습니다.");
				}else{
					for(let i=0; i<result.length; i++){
						html += `
							<div class="border-gray-300" style="padding: 20px 0px 0px 0px;">
								<input type="hidden" id="commentNo" name="replyCommentNo" value="\${result[i].commentNo }" />
								<input type="hidden" id="upCmntNo" name="replyUpCmntNo" value="\${result[i].upCmntNo}" />
								<div class="d-flex mb-2">
									<div class="symbol symbol-35px me-4">
										<img src="/upload/\${result[i].imgFileUrl }" alt="" />
									</div>
									<div class="d-flex flex-column flex-row-fluid">
										<div class="d-flex align-items-center flex-wrap mb-0">
											<a href="#" class="text-gray-800 text-hover-primary fw-bold me-6">\${result[i].empId}</a>
											<span class="text-gray-500 fw-semibold fs-7 me-5">\${result[i].cmntRegDt}</span>
										</div>
										<span id="replyCmntCn" name="replyCmntCn" class="text-gray-800 fs-7 fw-normal pt-1">\${result[i].cmntCn}</span>
									</div>
								</div>
							</div>
						`;
					}
					$("#commentReply"+commentNo).html(html);
				} 
			 },
		        error: function(xhr, status, error) {
		            console.error("AJAX 요청 실패:", error);
		        }
		});
}


function coco(btn){
	let replyUpCmntNo = btn.dataset.dabinConum;
	let replyCmntCn = $(btn).closest('.replyInput').find("textarea[name='replyCmntCn']").val();
	

	console.log("내용", replyCmntCn);
	console.log("up 댓글 번호", replyUpCmntNo);

	let data = {
		cmntCn : replyCmntCn,
		upCmntNo : replyUpCmntNo
	}
	
	console.log(data);
	
	if(replyCmntCn == null || replyCmntCn == ""){
		Swal.fire({
			icon: 'warning',
			title: '답글을 입력해주세요.',
			confirmButtonColor: '#4FC9DA',
		});
		return false;
	}
	
	$.ajax({
		url : "/company/replyInsert/1",
		type : "post", 
		contentType : "application/json; charset=utf-8",
		data: JSON.stringify(data),
		success: function(res) {
			console.log(res);
			Swal.fire({
			    icon: 'success',
			    title: '정상적으로 등록 되었습니다.'
			});
			
		      let sendParams = {
	                  alarmCategory:"cmntyRe",
	                  alarmTarget : replyEmpId,
//	                  alarmCn : empId +'님이 회원님의 게시물에 "'+ cmntCn +'" 댓글이 등록하였습니다.',
	                  alarmCn : replyCmntCn,
	                  alarmUrl : "/employee/communityDetail.do?cmntyNo=" + cmntyNo
	               };
		      
		      
		      	// 두 번째 AJAX 호출
                     $.ajax({
                         url : "/insertAlarm",
                         type : "post", 
                         contentType : "application/json; charset=utf-8",
                         data: JSON.stringify(sendParams),
                         success: function(res){
                             webSocket.send(JSON.stringify(sendParams)); // 웹소켓 메시지 전송
                             
                            	
			           		 $.ajax({
			                        url : "/alarmToast",
			                        type : "get", 
			                        success: function(alarmList){
			                        	
	                        	const button = document.getElementById('kt_docs_toast_stack_button');
	                        	const toastAppend = document.getElementById('kt_docs_toast_stack_container');
	                        	const targetElement = document.querySelector('[data-kt-docs-toast="stack"]'); // Use CSS class or HTML attr to avoid duplicating ids

		                        	
		                       	 console.log("alarm Data",alarmList);
			                       	 
			           			targetElement.parentNode.removeChild(targetElement);
			           		
			           		    // Create new toast element
			           		    const newToast = targetElement.cloneNode(true);
			           		    
			           		    
			           		    toastAppend.append(newToast);
			           		
			           		    // Create new toast instance --- more info: https://getbootstrap.com/docs/5.1/components/toasts/#getorcreateinstance
			           		    const toast = bootstrap.Toast.getOrCreateInstance(newToast);
			           		
			           		    // Toggle toast to show --- more info: https://getbootstrap.com/docs/5.1/components/toasts/#show
			           		    toast.show();
			           		  },
			                     error: function(xhr, status, error) {
			                         console.error("Error inserting alarm:", error);
			                     }
			           		});
				                   
                         },
                         error: function(xhr, status, error) {
                             console.error("Error inserting alarm:", error);
                         }
                  });
			
			setTimeout(() => {
				location.reload();
			}, 1000);

			
		}
	});
	


		
}

function cocomentAdd(button) {
    
    // 클릭된 버튼의 부모 요소에서 댓글을 찾기
    var commentMain = $(button).closest('.commentMain'); 

    // 모든 replyInput 숨기기
    $(".replyInput").hide();

    commentMain.find('.replyAddBtn')[0].dataset.dabinConum=button.dataset.dabinConum;

    // 현재 댓글의 replyInput만 보이기
    commentMain.find('.replyInput').toggle();
}

$(".card-footer").show();

function atchFiledelBtn(asd){

	$(asd).parent().remove();
	console.log($(asd).html()); 
}


$(function() {
	var form = $("#kt_modal_add_user_form");
	var ktModal = $("#kt_modal_add_user");

	var cmtUdtBtn = $("#cmtUdtBtn");					// 수정 들어가는 버튼
	var modifyAdd = $("#modifyAdd");					// 수정 안의 수정버튼
	var cmtCelBtn = $("#cmtCelBtn");					// 삭제
	
	var commentShowBtn = $("#commentShowBtn");			// 댓글 보기
	var commentAddBtn = $("#commentAddBtn");			// 댓글 추가
	var replyAddBtn = $("#replyAddBtn");				// 대댓글 추가
	var replyInput = $(".replyInput");			// 대댓글 추가 div
		
	var atchFileDeleteBtn = $("#atchFileDeleteBtn");	// 파일 지우기 
	
	var listBtn = $("#listBtn");		// 목록 버튼
	
	var downloadBtn = $(".downloadBtn");
	var downForm = $("#downForm");
	
	var allCheck = $("#allCheck");	// 체크박스 전체 선택
	var checkFile = $(".checkFile");	// 개별 선택
	
	downloadBtn.on("click", function(){
		console.log("downloadBtn 클릭");
		                           
		let atchFileDetailCdDown = $(".checkFile").val();
		let atchFileDetailStrgNm = $("#atchFileDetailStrgNm").val();
		let atchFileDetailPathNmDown = $("#atchFileDetailPathNmDown").val();
		let atchFileDetailOrgnlNmDown = $("#atchFileDetailOrgnlNmDown").val();
		
		let formData = new FormData();
	    formData.append("atchFileDetailCdDown", atchFileDetailCdDown);
	    formData.append("atchFileDetailStrgNm", atchFileDetailStrgNm);
	    formData.append("atchFileDetailPathNmDown", atchFileDetailPathNmDown);
	    formData.append("atchFileDetailOrgnlNmDown", atchFileDetailOrgnlNmDown);
	    
	    console.log(formData);
	    
	    let selectedFiles = [];
	    $(".checkFile:checked").each(function() {
	        selectedFiles.push($(this).atchFileDetailStrgNm); // 체크된 파일의 경로를 가져옵니다.
	    });

	    if (selectedFiles.length === 0) {
	    	Swal.fire({
				icon: 'warning',
				title: '다운로드 할 파일을 선택해주세요.',
				confirmButtonColor: '#4FC9DA',
			});
	        return;
	    }
		
		  $.ajax({
		        url: "/company/downloadAtchFile?path=" + atchFileDetailStrgNm,
		        type: "post",
		        processData: false,
		        contentType: false,
		        data: formData,
		        success: function(res) {
		        	
		        	if(checkFile.is(":checked")){
			        	downForm.submit();
		        	}
		        	
		            console.log(res);
		        },
		        error: function(xhr, status, error) {
		        	Swal.fire({
						icon: 'warning',
						title: '다운로드하지 못했습니다',
						confirmButtonColor: '#4FC9DA',
					});
		        }
		    });
	});
	
	allCheck.on("click", function(){
		
		$("input[name='checkFile']").prop("checked", allCheck.is(":checked"));
	
	});
	
	
	listBtn.on("click", function(){
		let listType = $("#listType").val();
		
		if (listType == 'systemCmnty') {
			location.href="communitySystem.do";
		}else if(listType == 'company'){
			location.href="communityCompany.do";
		}else if(listType == 'info'){
			location.href="communityInfo.do";
		}else if(listType == 'free'){
			location.href="communityFree.do";
		}
	});
	
	modifyAdd.on("click", function(){
		
		let cmntyNo = $("#cmntyNo").val();
		let cmntyTtl = $("#cmntyTtl").val();
		let cmntyCn = $("#cmntyCn").val();
		
	    let atchFileDetailCd = $("#atchFileDetailCd").val();
	    let atchFileCd = $("#atchFileCd").val();
	    let atchFileDetailPathNm = $("#atchFileDetailPathNm").val();
	    let atchFileDetailExtnNm = $("#atchFileDetailExtnNm").val();
	    let atchFileDetailSize = $("#atchFileDetailSize").val();
	    let atchFileDetailFancysize = $("#atchFileDetailFancysize").val();
	    let atchFileDetailOrgnlNm = $("#atchFileDetailOrgnlNm").val();
	    let atchFileDetailStrgNm = $("#atchFileDetailStrgNm").val();
	    let atchFileDetailRegDt = $("#atchFileDetailRegDt").val();
	    let empId = $("#empId").val();
	    let atchFileDetailDelYn = $("#atchFileDetailDelYn").val();
	    
	    let atchFiles = $("#atchFiles")[0].files;
	    
	    // 내용, 제목, 게시물 번호
	    let adCnt = $("#adCnt").val();
	    console.log(adCnt);
	    let arr = "";
		for (var i = 0; i < adCnt; i++) {
			arr += $("#atchFileDetailCd_"+i).val() + ",";
		}
	    console.log(atchFileCd);


		let formData = new FormData();
	    formData.append("cmntyNo", cmntyNo);
	    formData.append("cmntyTtl", cmntyTtl);
	    formData.append("cmntyCn", cmntyCn);
	    formData.append("arr", arr);
	    
	    formData.append("atchFileCd", atchFileCd);
	    formData.append("empId", empId);
	    
	    // 모든 파일을 FormData에 추가
	    for (let i = 0; i < atchFiles.length; i++) {
	        formData.append("atchFiles", atchFiles[i]); // 파일 배열로 추가
	        console.log("QWE"+i,atchFiles[i]);
	    }
	    
	    
	    $.ajax({
	        url: "/company/communityModify/1",
	        type: "post",
	        processData: false,
	        contentType: false,
	        data: formData,
	        success: function(res) {
	            
	            Swal.fire({
				    icon: 'success',
				    title: '정상적으로 수정 되었습니다.'
				});
				
				setTimeout(() => {
					location.reload();
				}, 1000);
	            
	        },
	        error: function(xhr, status, error) {
	        	Swal.fire({
					icon: 'warning',
					title: '게시물 수정에 실패하였습니다',
					confirmButtonColor: '#4FC9DA',
				});
	        }
	    });
	    
	});
	
	
	commentShowBtn.ready(function(){
		let cmntyNo = $("#cmntyNo").val();
		let commentNo = $("#commentNo").val();
		
		console.log(cmntyNo);
		
		let data = {
			cmntyNo : cmntyNo
		 }
		
		 
		$.ajax({
			url : "/company/getcomment.do",
			type : "post", 
			contentType : "application/json; charset=utf-8",
			data: JSON.stringify(data),
			success: function(res) {
				
				if(res == null || res == ""){
					$("#commentNull").text("댓글이 없습니다.");
				}else{
				let html = `
					<!-- 시작-->
					<div class="card-footer">
						<div class="mb-6">
							<div class="collapse show" id="kt_social_feeds_comments_1">`;
		
					for(let i=0; i<res.length; i++){
						if (res[i].upCmntNo == 0 || res[i].upCmntNo == null) {

						html += `
									<div class="commentMain" data-comment-no="\${commentNo}">
										<div class="d-flex 0pt-6 mb-10">
											<div class="symbol symbol-45px me-3">
												<img src="/upload/\${res[i].imgFileUrl }" alt=""/>
											</div>
											<div class="d-flex flex-column flex-row-fluid">
												<div class="d-flex align-items-center flex-wrap mb-0">
													<input type="hidden" name="commentNo" value="\${res[i].commentNo}" />
													<input type="hidden" name="upCmntNo" value="\${res[i].upCmntNo}" />
													<a href="#" class="text-gray-800 text-hover-primary fw-bold me-6">\${res[i].empId}</a>
													<span class="text-gray-500 fw-semibold fs-7 me-5">\${res[i].cmntRegDt}</span>
														<button class="ms-auto text-gray-500 text-hover-primary fw-semibold fs-7 cocomentAddBtn" name="cocomentAddBtn"
															style="background-color: transparent; border: none;"  data-dabin-conum="\${res[i].commentNo}" onclick="cocomentAdd(this)">답글</button>
												</div>
												<div class="d-flex align-items-center flex-wrap mb-0 toggle" id="Main">
													<span class="text-gray-800 fs-7 fw-normal pt-1">\${res[i].cmntCn}</span>
														<button name="replyPlus" class="replyPlus ms-auto text-gray-500 text-hover-primary fw-semibold fs-7"
															style="background-color: transparent; border: none;" onclick="replyBtn(\${res[i].commentNo})" >댓글 더보기  ▼</button>
															
												</div>
												<div id="commentReply\${res[i].commentNo}"></div>
												
											</div>
										</div>
								
										
										
										<div class="d-flex align-items-center mb-9 replyInput" style="display : none !important;">
											<div class="symbol symbol-35px me-3">
												<img src="assets/media/avatars/300-3.jpg" alt="">
											</div>
						
											<div class="position-relative w-100">
												<input type="hidden" id="replyCommentNo" name="replyCommentNo" value="\${res[i].commentNo }">
												<input type="hidden" id="replyUpCmntNo" name="replyUpCmntNo" value="\${res[i].upCmntNo }">
												<textarea type="text" class="form-control form-control-solid border ps-5" rows="1"
													name="replyCmntCn"  data-kt-autosize="true" placeholder="답글을 작성해주세요" data-kt-initialized="1"
													style="overflow: hidden; overflow-wrap: break-word; resize: none; text-align: start; height: 80px;"></textarea>
						
												<div class="position-absolute bottom-0 end-0 me-4 mb-2 cocomment">
													<button
														class="btn btn-icon btn-sm btn-color-gray-500 btn-active-color-primary w-25px p-0 replyAddBtn" onclick="coco(this)"> 
														<i class="bi bi-chat-square-text-fill fs-2"> 
														</i> 
													</button> 
												</div>
											</div>
										</div>
									</div>
			             `;
						}
						
					}
					
					$("#commentNull").html(html);	
						html += `
								 </div>
							</div>
						</div>
				<!-- 종료 -->
				`;
				}
			}
		});
		
	});
	
	
	commentAddBtn.on("click", function(){
		let cmntCn = $("#cmntCn").val();
		let cmntyNo = $("#commentCmntyNo").val();
		let empId = $("#empId").val();
		
		let alarmCategory = $("#alarmCategory").val();
		let alarmCn = $("#alarmCn").val();
		let alarmUrl = $("#alarmUrl").val();
		let alarmTarget = $("#alarmTarget").val();
		
		
		let data = {
			cmntCn : cmntCn,
			cmntyNo : cmntyNo
		}
		
		console.log(data);
		
		if(cmntCn == null || cmntCn == ""){
			Swal.fire({
				icon: 'warning',
				title: '댓글을 입력해주세요!',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}
		
		$.ajax({
			url : "/company/commentInsert/1",
			type : "post", 
			contentType : "application/json; charset=utf-8",
			data: JSON.stringify(data),
			 success: function(res) {
		            Swal.fire({
		                icon: 'success',
		                title: '정상적으로 등록 되었습니다.'
		            });
		            
		            setTimeout(() => {
		                location.reload(); // 페이지 새로고침
		            }, 1000);
		            
					let sendParams = {
						alarmCategory:"community",
						alarmTarget :empId,
//						alarmCn : empId +'님이 회원님의 게시물에 "'+ cmntCn +'" 댓글이 등록하였습니다.',
						alarmCn : cmntCn,
						alarmUrl : "/company/communityDetail.do?cmntyNo=" + cmntyNo
					};
					
		         	   // 두 번째 AJAX 호출
			            $.ajax({
			                url : "/insertAlarm",
			                type : "post", 
			                contentType : "application/json; charset=utf-8",
			                data: JSON.stringify(sendParams),
			                success: function(res){
			                    webSocket.send(JSON.stringify(sendParams)); // 웹소켓 메시지 전송
			                    
			                   	
				           		 $.ajax({
				                        url : "/alarmToast",
				                        type : "get", 
				                        success: function(alarmList){
				                        	
		                        	const button = document.getElementById('kt_docs_toast_stack_button');
		                        	const toastAppend = document.getElementById('kt_docs_toast_stack_container');
		                        	const targetElement = document.querySelector('[data-kt-docs-toast="stack"]'); // Use CSS class or HTML attr to avoid duplicating ids

			                        	
			                       	 console.log("alarm Data",alarmList);
				                       	 
				           			targetElement.parentNode.removeChild(targetElement);
				           		
				           		    // Create new toast element
				           		    const newToast = targetElement.cloneNode(true);
				           		    
				           		    
				           		    toastAppend.append(newToast);
				           		
				           		    // Create new toast instance --- more info: https://getbootstrap.com/docs/5.1/components/toasts/#getorcreateinstance
				           		    const toast = bootstrap.Toast.getOrCreateInstance(newToast);
				           		
				           		    // Toggle toast to show --- more info: https://getbootstrap.com/docs/5.1/components/toasts/#show
				           		    toast.show();
				           		  },
				                     error: function(xhr, status, error) {
				                         console.error("Error inserting alarm:", error);
				                     }
				           		});
					                   
			                },
			                error: function(xhr, status, error) {
			                    console.error("Error inserting alarm:", error);
			                }
		            });
		         	   
				 }
			});
		});
		
		
	cmtUdtBtn.on("click", function(e) {
		// 현재 다빈이가 클릭한 버튼은 a태그 이므로, a태그가 가지고 있는 이벤트를 block합니다.
		e.preventDefault();

		// 이제 form 영역을 모달에 띄웠으니까 여기서 해야할일은 무엇일까요?
		// 현재 보고 있는 페이지의 게시글 번호를 이용하여 게시글 번호에 일치하는 게시글 정보를 가져와서
		// 모달 안에 들어있는 각각의 폼 영역에 가져온 데이터를 맵핑하는 일일겁니다!
		// 아셨죠? 네엥

		ktModal.modal("show");

	});


	cmtCelBtn.on("click", function(e) {
		e.preventDefault();
		
	    var cmntyNo = $("#cmntyNo").val(); // 게시물 번호 가져오기
       	let listType = $("#listType").val();
	    
       	Swal.fire({
			title: '정말 삭제하시겠습니까?',
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
					cmntyNo : cmntyNo 
				}
				
				   $.ajax({
				        url: "/company/communityRemove.do", // 올바른 cmntyNo 사용
				        type: "post",
				        data: JSON.stringify(data),
						contentType : "application/json; charset=utf-8",
				        success: function(res) {
				        	console.log("res ::: " , res);
				        	e.preventDefault();	// a 태그의 기본 기능 멈추기
				        	
			    			if (listType == 'systemCmnty') {
				    			location.href="communitySystem.do";
				    		}else if(listType == 'company'){
				    			location.href="communityCompany.do";
				    		}else if(listType == 'info'){
				    			location.href="communityInfo.do";
				    		}else if(listType == 'free'){
				    			location.href="communityFree.do";
				    		}
			    			Toast.fire({
							    icon: 'success',
							    title: '정상적으로 삭제 되었습니다.'
							});
				        }
				    });
				}
			})
		});
	});
	
	$("#modifyCancel").on("click",function(){
		location.reload();
	});
</script>

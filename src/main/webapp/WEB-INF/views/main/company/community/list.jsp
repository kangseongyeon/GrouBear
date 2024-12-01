<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
.image-input-placeholder {
	background-image: url('assets/media/svg/files/blank-image.svg');
}

[data-bs-theme="dark"] .image-input-placeholder {
	background-image: url('assets/media/svg/files/blank-image-dark.svg');
}

input[type=file]::file-selector-button {
	width: 100px;
	height: 30px;
	background: #D0EFF2;
	border: 1px solid rgb(77, 77, 77);
	border-radius: 10px;
	border-color: #4FC9DA;
	cursor: pointer; &: hover { background : rgb( 77, 77, 77);
	color: #fff;
}
}
</style>

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
      <h6>커뮤니티</h6>
   </div>
</div>

<div class="card"
	style="background-color: transparent; border: none; box-shadow: none;">
	<div class="card-body py-0">
		<div class="card-header border-0 pt-0"
			style="padding-left: 0px; padding-right: 0px; !important">
			<div class="card-title">
				<div class="d-flex align-items-center position-relative my-1">
					<form id="searchForm" style="display: contents;">
						<input type="hidden" name="page" id="page"> <input
							id="myInput" name="searchWord" type="text"
							data-kt-ecommerce-product-filter="search"
							class="form-control form-control-solid w-250px ps-5"
							style="margin-top: 0.5em;" placeholder="게시글 검색"
							value="${searchWord }" />
						<button id="searchBtn" type="submit"
							class="btn btn-flex btn-light-success ms-1 py-3 px-3"
							style="margin-top: 0.5em;">
							<i class="ki-duotone ki-magnifier fs-2"> <span class="path1"
								style="height: 1.1em;"></span> <span class="path2"></span>
							</i>
						</button>
					</form>
				</div>
			</div>

			<!--  -->

			<div class="card-toolbar">
				<div class="d-flex justify-content-end"
					data-kt-user-table-toolbar="base">
					<button type="button" class="btn btn-primary"
						data-bs-toggle="modal" data-bs-target="#kt_modal_add_user">
						<i class="ki-duotone ki-plus fs-2"></i>글쓰기
					</button>
				</div>


				<!-- 				글쓰기잉 -->
				<div class="modal fade" id="kt_modal_add_user" tabindex="-1"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered mw-650px">
						<div class="modal-content">
							<div class="modal-header" id="kt_modal_add_user_header">
								<h2 class="fw-bold">글쓰기</h2>
								<div class="btn btn-icon btn-sm btn-active-icon-primary"
									data-bs-dismiss="modal" data-kt-users-modal-action="close">
									<i class="ki-duotone ki-cross fs-1"> <span class="path1"></span>
										<span class="path2"></span>
									</i>
								</div>
							</div>
							<div class="modal-body px-5 my-7">

								<form id="kt_modal_add_user_form" class="form"
									action="company/insert.do" method="post"
									enctype="multipart/form-data">
									<!-- 									고정된 사용자 아이디 -->
									<div class="d-flex flex-column scroll-y px-5 px-lg-10"
										id="kt_modal_add_user_scroll" data-kt-scroll="true"
										data-kt-scroll-activate="true"
										data-kt-scroll-max-height="auto"
										data-kt-scroll-dependencies="#kt_modal_add_user_header"
										data-kt-scroll-wrappers="#kt_modal_add_user_scroll"
										data-kt-scroll-offset="300px">
										<input type="hidden" id="empId" name="empId"
											value="${EmployeeVO.empId }">
										<div class="d-flex align-items-center position-relative my-1">
											<label class="required fw-semibold fs-6 mb-2">커뮤니티
												게시판 종류</label>
											<div
												class="d-flex align-items-center justify-content-end ms-auto">
												<input class="form-check-input w-15px h-15px"
													type="checkbox" id="cmntyNoticeYn" name="cmntyNoticeYn"
													style="margin-bottom: 5px" /> <label
													class="fw-semibold fs-6 mb-2" style="padding-left: 5px">공지
													여부</label>
											</div>
										</div>
										<div class="fv-row mb-7">
											<select name="cmntyType" id="cmntyType"
												class="form-select form-select-solid fw-bold">
												<option value="">-- 게시판 선택 --</option>
												<option value="company">회사 공지사항</option>
												<option value="info">정보공유 게시판</option>
												<option value="free">자유게시판</option>
											</select>
										</div>
										<div class="fv-row mb-7">
											<label class="required fw-semibold fs-6 mb-2">제목</label><input
												type="text" id="cmntyTtl" name="cmntyTtl"
												class="form-control form-control-solid mb-3 mb-lg-0"
												placeholder="제목을 입력해주세요" />
										</div>
										<div class="fv-row mb-7">
											<label class="required fw-semibold fs-6 mb-2">내용</label>
											<textarea id="cmntyCn" name="cmntyCn" rows="10" cols="10"
												class="form-control form-control-solid mb-3 mb-lg-0"
												placeholder="내용을 입력해주세요" wrap="hard"></textarea>
										</div>
										<div class="fv-row mb-7">
											<label class="d-block fw-semibold fs-6 mb-0 mt-0"
												for="atchFiles" style="padding-top: 8px"></label> <input
												type="file" id="atchFiles" name="atchFiles"
												value="${comCommunityVO.atchFiles }">

											<span class="form-text fs-6 text-muted"
												style="color: #FA5858 !important">파일당 최대 파일 크기는
												2MB입니다.</span>
										</div>
									</div>
									<div class="text-center pt-10" id="comunityModal">
										<button type="reset" class="btn btn-light me-3"
											data-kt-users-modal-action="cancel" data-bs-dismiss="modal">취소</button>
										<button type="button" id="addBtn" class="btn btn-primary"
											data-kt-users-modal-action="button">
											<span class="indicator-label">등록</span> <span
												class="indicator-progress">Please wait... <span
												class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
										</button>
									</div>
								</form>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-fluid">
				<div class="card mb-5 mb-xxl-8">
					<div class="card-body pt-0 pb-0">
						<ul
							class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold">
							<li class="wow nav-item mt-2"><a href="communityCompany.do"
								class="nav-link text-active-primary ms-0 me-10 py-5" id="cmntyCom">회사 공지사항</a></li>
							<li class="wow nav-item mt-2"><a href="communityInfo.do"
								class="nav-link text-active-primary ms-0 me-10 py-5" id="cmntyInfo">정보공유 게시판</a></li>
							<li class="wow nav-item mt-2"><a href="communityFree.do"
								class="nav-link text-active-primary ms-0 me-10 py-5" id="cmntyFree">자유게시판</a></li>
						</ul>
					</div>

				</div>
				<div class="card">
					<div class="card-body py-4">
						<table class="table align-middle table-row-dashed fs-6 gy-5"
							id="communityTable">
							<thead>
								<tr
									class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
									<th class="min-w-30px"></th>
									<th class="min-w-200px">제목</th>
									<th class="min-w-150px">작성자</th>
									<th class="min-w-100px">작성일</th>
									<th class="min-w-50px">조회수</th>
								</tr>
							</thead>
							<tbody class="text-gray-600 fw-semibold">
								<c:set value="${pagingVO.dataList }" var="dataList" />
								<c:choose>
									<c:when test="${empty dataList }">
										<tr>
											<td colspan="5">게시물이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${dataList}" var="freeBoardList">
											<c:if test="${freeBoardList.cmntyDelYn eq 'N' }">
												<c:choose>
													<c:when test="${freeBoardList.cmntyNoticeYn == 'Y'}">
														<tr data-id="${freeBoardList.cmntyNo}"
															data-check-value="${freeBoardList.cmntyNoticeYn}">
															<td class="CMlist"><p style="color: #F06445">[공지]</p></td>
															<td class="CMlist"><a
																href="/company/communityDetail.do?cmntyNo=${freeBoardList.cmntyNo }">
																	<p>${freeBoardList.cmntyTtl}</p>
															</a></td>
															<td class="CMlist"><p>${freeBoardList.empNm}</p></td>
															<td class="CMlist"><p>${freeBoardList.cmntyRegDt}</p>
															</td>
															
															<td class="CMlist"><p>${freeBoardList.cmntyInqCnt}</p></td>
														</tr>
													</c:when>
												</c:choose>
											</c:if>
										</c:forEach>
										<c:forEach items="${dataList}" var="freeBoardList">
											<c:if test="${freeBoardList.cmntyDelYn eq 'N' }">
												<c:choose>
													<c:when test="${freeBoardList.cmntyNoticeYn != 'Y'}">
														<tr data-id="${freeBoardList.cmntyNo}"
															data-check-value="${freeBoardList.cmntyNoticeYn}">
															<td class="CMlist"><p>&nbsp;</p></td>
															<td class="CMlist"><a
																href="/company/communityDetail.do?cmntyNo=${freeBoardList.cmntyNo }">
																	<p>${freeBoardList.cmntyTtl}</p>
															</a></td>
															<td class="CMlist"><p>${freeBoardList.empNm}</p></td>
															<td class="CMlist"><p>${freeBoardList.cmntyRegDt}</p></td>
															<td class="CMlist"><p>${freeBoardList.cmntyInqCnt}</p></td>
														</tr>
													</c:when>
												</c:choose>
											</c:if>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
			<div class="card-footer clearfix" style="margin-top: 20px; margin-bottom: 20px;" id="pagingArea">
						${pagingVO.pagingHTML }
					</div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	var pathname = window.location.pathname;
	if (pathname == "/company/communityFree.do") {
		$("#cmntyFree").addClass("active");
	}
	if (pathname == "/company/communityInfo.do") {
		$("#cmntyInfo").addClass("active");
	}
	if (pathname == "/company/communityCompany.do") {
		$("#cmntyCom").addClass("active");
	}
	
	var wow = $(".wow");
	
	var addBtn = $("#addBtn");
	var modal = $("#communityModal");
	
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");

	wow.on("click", function(){
		$(this).find('a').removeClass('disabled');
		wow.not($(this)).find('a').addClass('disabled');
	});

	pagingArea.on("click", "a", function (event) {
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
// 		$("#myInput").val("");
		searchForm.submit();
	});

	addBtn.on("click", function() {
	    console.log("addBtn 클릭");
	    
	    let notice = $("#cmntyNoticeYn").is(":checked") ? "Y" : "N";
	    let type = $("#cmntyType").val();
	    let title = $("#cmntyTtl").val();
	    let content = $("#cmntyCn").val();
	    let empId = $("#empId").val();
	    let files = $("#atchFiles")[0].files; // 모든 파일을 가져옴

	    if (type == null || type == "") {
	    	Swal.fire({
				icon: 'warning',
				title: '등록할 게시판을 선택해주세요',
				confirmButtonColor: '#4FC9DA',
			});
	        return false;
	    }
	    if (title == null || title == "") {
	    	Swal.fire({
				icon: 'warning',
				title: '제목을 입력해주세요',
				confirmButtonColor: '#4FC9DA',
			});
	        return false;
	    }
	    if (content == null || content == "") {
	    	Swal.fire({
				icon: 'warning',
				title: '내용을 입력해주세요',
				confirmButtonColor: '#4FC9DA',
			});
	        return false;
	    }
	        
	    
       	Swal.fire({
			title: '등록하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#F06445',
			cancelButtonColor: '#4FC9DA',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false, // 버튼 순서 (기본)
		}).then((result) => {
			if (result.isConfirmed) {
				
			content = content.replace(/\n/g, '<br>');
				
	    let formData = new FormData();
	    formData.append("cmntyNoticeYn", notice);
	    formData.append("cmntyType", type);
	    formData.append("cmntyTtl", title);
	    formData.append("cmntyCn", content);
	    formData.append("empId", empId);
	    
	    // 모든 파일을 FormData에 추가
	    for (let i = 0; i < files.length; i++) {
	        formData.append("atchFiles", files[i]); // 파일 배열로 추가
	    }
	    
	    console.log(formData);
	    
			 $.ajax({
			        url: "/company/insert/1",
			        type: "post",
			        processData: false,
			        contentType: false,
			        data: formData,
			        success: function(res) {
			            console.log("res ::: ", res);
			            
			            modal.hide(); // 모달 닫기
			        	Swal.fire({
						    icon: 'success',
						    title: '정상적으로 등록 되었습니다.'
						});
			        	setTimeout(() => {
				            location.reload(); // 페이지 새로고침
			        	}, 1000);
			        }
			    });
			}
		})
	    
	    
	    
	    
	    
	    
	});
	

	// 체크된 게시물을 상단에 고정
	$(window).on('load', function() {
		let rows = Array.from($('#communityTable tbody tr')); // 게시물 테이블의 모든 행 가져오기
		let fixedRows = rows.filter(row => $(row).data('check-value') === 'Y'); // 체크된 항목 필터링

		let otherRows = rows.filter(row => $(row).data('check-value') !== 'Y'); // 나머지 항목
		let sortedRows = [...fixedRows, ...otherRows]; // 정렬된 행 배열

		let tableBody = $('#communityTable tbody');
		tableBody.empty(); // 기존 내용 지우기
		sortedRows.forEach(row => tableBody.append(row)); // 정렬된 행 추가
	});
});
</script>

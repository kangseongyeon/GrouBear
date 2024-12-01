<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div style="margin-bottom: 0px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>인사·정보 관리</h3>
		<h6>직급 목록</h6>
	</div>
</div>


<div class="kt_app_content_container mx-5 my-15">
	<div class="app-container container-fluid">
		<div class="card mb-5 mb-lg-10">
			<div class="card-body p-0">
				<div class="table-responsive">
					<div class="card-header border-0 pt-6">
						<div class="card-title">
							<h3>직급 목록 </h3>
						</div>
						<div class="card-toolbar">
							<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#kt_modal_add_jbgd">
							<i class="ki-duotone ki-plus fs-2"></i>직급 추가</button>
						</div>
					</div>
					<table class="table align-middle table-row-bordered table-row-solid gy-4 gs-9">
						<tbody class="fs-4 fw-6 fw-semibold text-gray-600">
							<tr>
								<th class="min-w-100px">직급명</th>
								<th class="min-w-150px">권한등급</th>
								<th class="min-w-150px">직급생성일</th>
								<th class="min-w-150px">직급 편집</th>
							</tr>
							<c:choose>
								<c:when test="${empty jbgdList }">
								
								</c:when>
								<c:otherwise>
									<c:forEach items="${jbgdList }" var="jbgd"> 
										<tr>
											<td>${jbgd.jbgdNm}</td>
											<td>
												<span class="badge badge-light-info fs-7 fw-bold">${jbgd.jbgdAuthPrord }등급</span>
											</td>
											<td>${fn:substring(jbgd.jbgdCrtDt, 0, 10) }</td>
											<td class="justify-content-end">
												<button type="button" class="btn btn-light-primary edit-jbgd" data-cd="${jbgd.jbgdCd}" data-bs-toggle="modal" data-bs-target="#modal_modify_jbgd">
													<i class="ki-duotone ki-abstract-8 text-primary">
													    <span class="path1"></span>
													    <span class="path2"></span>
													</i>
												   	직급 수정
												</button>
		
												<button type="button" class="btn btn-light-success del-jbgd" data-cd="${jbgd.jbgdCd}">
													<i class="ki-duotone ki-abstract-8 text-success">
													<span class="path1"></span>
													<span class="path2"></span></i>
								                	직급 삭제     
												</button>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<form id="delForm" method="post" action="/information/deletejbgd.do">
	<input type="hidden" id="delJbgdCd" name="jbgdCd">
</form>
<!-- 직급 추가 모달 -->
<div class="modal fade" id="kt_modal_add_jbgd" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered mw-650px">
		<div class="modal-content">
			<div class="modal-header" id="kt_modal_add_user_header">
				<h2 class="fw-bold">직급 추가</h2>
				<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
					<i class="ki-duotone ki-cross fs-1">
						<span class="path1"></span>
						<span class="path2"></span>
					</i>
				</div>
			</div>
			<div class="modal-body px-5 my-7">
				<form id="kt_modal_insert_jbgd" class="form" action="/information/jbgdmodify.do" method="post">
					<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
							<input type="hidden" name="coCd" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="기업코드" value="${userVO.coCd }" />
						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">직급명</label>
							<input type="text" name="jbgdNm" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="직급명을 입력해주세요" id="jbgdNm" value="팀장"/>
						</div>
						<div class="fv-row mb-7">
						    <label class="required fw-semibold fs-6 mb-2">권한 등급 </label>
						    <select name="jbgdAuthPrord" id="jbgdAuthPrord" class="form-control form-control-solid mb-3 mb-lg-0">
							    <option value="5">5등급</option>
							    <c:forEach var="i" begin="1" end="10">
							        <option value="${i}">${i}등급</option>
							    </c:forEach>
							</select>
						</div>
					</div>
					<div class="text-center pt-10">
						<button type="button" class="btn btn-primary" id="insertBtn">
							<span class="indicator-label">등록</span>
							<span class="indicator-progress">잠시만 기다려주세요
							<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
						</button>
						<button type="reset" class="btn btn-light me-3" data-bs-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 직급 수정 모달 -->
<div class="modal fade" id="modal_modify_jbgd" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered mw-650px">
		<div class="modal-content">
			<div class="modal-header" id="kt_modal_add_user_header">
				<h2 class="fw-bold">직급 수정</h2>
				<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
					<i class="ki-duotone ki-cross fs-1">
						<span class="path1"></span>
						<span class="path2"></span>
					</i>
				</div>
			</div>
			<div class="modal-body px-5 my-7">
				<form id="kt_modal_modify_jbgd" class="form" method="post">
					<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
							<input type="hidden" name="coCd" class="form-control form-control-solid mb-3 mb-lg-0"  value="${userVO.coCd }" />
							<input type="hidden" name="jbgdCd" class="form-control form-control-solid mb-3 mb-lg-0" id="modifyJbgdCd" />
						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">직급명</label>
							<input type="text" name="jbgdNm" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="직급명을 입력해주세요" id="modifyJbgdNm"/>
						</div>
						<div class="fv-row mb-7">
						    <label class="required fw-semibold fs-6 mb-2">권한 등급 </label>
						    <select name="jbgdAuthPrord" id="modifyJbgdAuthPrord" class="form-control form-control-solid mb-3 mb-lg-0">
							    <option value="null">권한 등급 선택</option>
							    <c:forEach var="i" begin="1" end="10">
							        <option value="${i}">${i}등급</option>
							    </c:forEach>
							</select>
						</div>
					</div>
					<div class="text-center pt-10">
						<button type="button" class="btn btn-primary" id="modifyBtn">
							<span class="indicator-label">수정</span>
							<span class="indicator-progress">잠시만 기다려주세요
							<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
						</button>
						<button type="reset" class="btn btn-light me-3" data-bs-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
    var modifyBtn = $("#modifyBtn");
    var insertBtn = $("#insertBtn");
    var delJbgdCd = $("#delJbgdCd");
    const spinner = $('.spinner-border');
    
    // 직급 추가 버튼 클릭 이벤트
    insertBtn.on("click", function() {
        let jbgdNm = $("#jbgdNm").val();
        let jbgdAuthPrord = $("#jbgdAuthPrord").val();
        let formElement = document.getElementById("kt_modal_insert_jbgd"); // 폼 ID
        let formData = new FormData(formElement); // FormData 객체 생성

        $.ajax({
            url: "/information/jbgdinsert.do", // 서버 URL
            type: "POST",
            data: formData, // FormData 객체 사용
            contentType: false, // 기본 contentType을 false로 설정
            processData: false, // 데이터 자동 변환 방지
            success: function(response) {
                if (response.status === "success") {
                    Swal.fire({
                        icon: 'success',
                        title: '등록 완료!',
                        text: response.message,
                        confirmButtonColor: '#4FC9DA',
                    }).then(() => {
                        location.reload(); // 페이지 리로드
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '등록 실패!',
                        text: response.message,
                        confirmButtonColor: '#4FC9DA',
                    });
                }
            },
            error: function(xhr, status, error) {
                Swal.fire({
                    icon: 'error',
                    title: '서버 오류!',
                    text: '등록 중에 오류가 발생했습니다. 다시 시도해주세요.',
                    confirmButtonColor: '#4FC9DA',
                });
            }
        });
    });

    // 직급 수정 버튼 클릭 이벤트
    modifyBtn.on("click", function() {
        let jbgdNm = $("#modifyJbgdNm").val();
        let jbgdCd = $("#modifyJbgdCd").val();
        let jbgdAuthPrord = $("#modifyJbgdAuthPrord").val();
        let formElement = document.getElementById("kt_modal_modify_jbgd"); // 폼 ID
        
        console.log("jbgdNm 수정버튼 : " + jbgdNm);
        console.log("jbgdCd 수정버튼 : " + jbgdCd);
        console.log("jbgdAuthPrord 수정버튼 : " + jbgdAuthPrord);

        $.ajax({
            url: "/information/jbgdmodify.do", // 서버 URL
            type: "POST",
            data: {
                jbgdNm: jbgdNm,
                jbgdCd: jbgdCd,
                jbgdAuthPrord: jbgdAuthPrord
            }, // 데이터 객체 사용
            success: function(response) {
                if (response.status === "success") {
                    Swal.fire({
                        icon: 'success',
                        title: '수정 완료!',
                        text: response.message,
                        confirmButtonColor: '#4FC9DA',
                    }).then(() => {
                        location.reload(); // 페이지 리로드
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '수정 실패!',
                        text: response.message,
                        confirmButtonColor: '#4FC9DA',
                    });
                }
            },
            error: function(xhr, status, error) {
                Swal.fire({
                    icon: 'error',
                    title: '서버 오류!',
                    text: '수정 중에 오류가 발생했습니다. 다시 시도해주세요.',
                    confirmButtonColor: '#4FC9DA',
                });
            }
        });
    });

    // 직급 수정 버튼 클릭 이벤트
    $(".edit-jbgd").on("click", function() {
        var jbgdCd = $(this).data("cd"); // 클릭한 버튼의 data-id 속성에서 ID 가져오기

        // AJAX 요청
        $.ajax({
            url: '/information/getjbgdvo.do', // 직급 정보를 가져올 API URL
            type: 'GET',
            data: {
                cd: jbgdCd
            },
            success: function(jbgd) {
                // 응답 데이터에서 직급 정보 설정
                $("#delJbgdCd").val(jbgdCd); // 직급명 설정
                $("#kt_modal_modify_jbgd #modifyJbgdCd").val(jbgdCd); // 직급명 설정
                $("#kt_modal_modify_jbgd #modifyJbgdNm").val(jbgd.jbgdNm); // 직급명 설정
                $("#kt_modal_modify_jbgd #modifyJbgdAuthPrord").val(jbgd.jbgdAuthPrord); // 권한 등급 설정
                $("#modal_modify_jbgd").modal('show'); // 모달 열기
            },
            error: function(xhr, status, error) {
                console.error("ajax에러");
            }
        });
    });
    
    $(document).on("click", ".del-jbgd", function(event) {
        var jbgdCd = $(this).data("cd"); // 클릭한 버튼의 data-id 속성에서 ID 가져오기
        
        delJbgdCd.val(jbgdCd);
        console.log("현재 delJbgdCd 값 : " + delJbgdCd.val());
        event.preventDefault(); // 기본 동작 방지

        // 스피너를 보여주고 문구 변경
        spinner.removeClass('d-none');

        console.log("Swal.fire() 호출 전");
        Swal.fire({
            title: '직급을 삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#F06445',
            cancelButtonColor: '#4FC9DA',
            confirmButtonText: '예',
            cancelButtonText: '아니요',
            reverseButtons: false,
        }).then((result) => {
            if (result.isConfirmed) {
                delForm.submit(); // 폼 제출
            }
        });
        console.log("Swal.fire() 호출 후");

    });
});

</script>

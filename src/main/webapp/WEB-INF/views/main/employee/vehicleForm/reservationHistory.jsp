<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div style="margin-bottom: 25px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>차량 관리</h3>
		<h6 class="text-muted min-w-100px">차량 예약 목록</h6>
	</div>
</div>

<div id="kt_app_content_container">
	<div class="app-main flex-column flex-row-fluid">
		<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
			<div class="d-flex flex-column flex-column-fluid">
				<div id="kt_app_content" class="app-content flex-column-fluid">
					<div id="kt_app_content_container" class="app-container container-fluid">
						<div class="card">
							<div class="card-header border-0 pt-6">
								<div class="card-title">
									<div class="d-flex align-items-center position-relative my-1">
										<form id="searchForm" style="display: contents;">
											<input type="hidden" name="page" id="page"/>
											<input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-5" style="margin-top: 0.5em;" placeholder="통합 검색" value="${searchWord }"/>
											<button id="searchBtn" type="button" class="btn btn-flex btn-light-success ms-1 py-3 px-3" style="margin-top: 0.5em;">
									            <i class="ki-duotone ki-magnifier fs-2">
													<span class="path1" style="height: 1.1em;"></span> 
													<span class="path2"></span>
												</i>
											</button>
										</form>
									</div>
								</div>
								<div class="card-toolbar">
									<div class="d-flex justify-content-end" data-kt-user-table-toolbar="base">
										<button type="button" class="btn btn-light-primary me-3" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
										<i class="ki-duotone ki-filter fs-2">
											<span class="path1"></span>
											<span class="path2"></span>
										</i>정렬</button>
										<div class="menu menu-sub menu-sub-dropdown w-300px w-md-325px" data-kt-menu="true">
											<div class="px-7 py-5">
												<div class="fs-5 text-gray-900 fw-bold">정렬 옵션</div>
											</div>
											<div class="separator border-gray-200"></div>
											<div class="px-7 py-5" data-kt-user-table-filter="form">
												<div class="mb-10">
													<label class="form-label fs-6 fw-semibold">정렬</label>
													<select class="form-select form-select-solid fw-bold" name="searchOrder" id="sortSelect" data-placeholder="정렬 기준 선택" data-allow-clear="true">
													    <option value="null" selected="selected">예약 순</option>
													    <option value="empNm">이름 순</option>
													    <option value="oldest">예약 역순</option>
													    <option value="rntlDt">대여일 순</option>
													    <option value="rtnDt">반납일 순</option>
													</select>
												</div>
												<div class="d-flex justify-content-end">
													<button type="submit" id="sortBtn" class="btn btn-primary fw-semibold px-6" data-kt-menu-dismiss="true" data-kt-user-table-filter="filter">정렬</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body py-4">
								<table class="table align-middle table-row-dashed fs-6 gy-5" id="kt_table_users">
									<thead>
										<tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
											<th class="min-w-100px">예약번호</th>
											<th class="min-w-100px">차량 번호</th>
											<th class="min-w-100px">대여자</th>
											<th class="min-w-100px">예약일시</th>
											<th class="min-w-100px">이용 시간</th>
											<th class="min-w-100px">예약 변경</th>
										</tr>
									</thead>
									<tbody class="text-gray-600 fw-semibold">
									<c:set value="${pagingVO.dataList }" var="vhclMyRsvtList"/>
									<c:choose>
										<c:when test="${empty vhclMyRsvtList }">
											<tr>
												<td colspan="7" class="text-center pt-5">
													예약 내역이 없습니다.
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${vhclMyRsvtList }" var="rsvtList">
												<tr class="py-3">
													<td>${fn:replace(rsvtList.rsvtCd, "/", "")}</td>
													<td>${rsvtList.vhclNo}</td>
													<td>${rsvtList.empNm }</td>
													<td>${rsvtList.vhclRsvtDt }</td>
													<td>${fn:replace(rsvtList.vhclRntlDt, "T", "일 ") }시<br/>${fn:replace(rsvtList.vhclRtnDt, "T", "일 ") }시</td>
													<td class="justify-content-end">
														<button type="button" class="btn btn-flex btn-light-primary me-2 edit-rsvt" data-cd="${rsvtList.rsvtCd }" data-bs-toggle="modal" data-bs-target="#modal_modify_rsvt">
								                        	예약 수정
							                        	</button>
														<button type="button" class="btn btn-light-success del-rsvt" data-cd="${rsvtList.rsvtCd }">
										                	예약 취소     
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
		</div>
	</div>
	<div id="kt_app_footer" class="app-footer">
		<div class="app-container container-fluid d-flex align-items-center justify-content-center flex-column flex-md-row flex-center flex-md-stack py-3">
			<div class="card-footer clearfix" id="pagingArea">
				${pagingVO.pagingHTML }
			</div>
		</div>
	</div>
</div>

<!-- 예약 수정 모달 -->
<div class="modal fade" id="modal_modify_rsvt" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered mw-650px">
		<div class="modal-content">
			<div class="modal-header mt-3">
				<h1>예약정보 수정</h1>
				<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
	 						<i class="ki-duotone ki-cross fs-1">
	 							<span class="path1"></span>
	 							<span class="path2"></span>
	 						</i>
	 					</div>
			</div>
			<div class="separator separator-dashed my-0"></div>
			<div class="modal-body px-7 my-7">
			<div class="d-flex flex-column fv-row">
				<div class="fv-row mb-7 d-flex flex-column align-items-center justify-content-center">
					<div class="image-input" data-kt-image-input="true">
						<div class="image-input-wrapper w-450px h-250px" style="background-image: url('/upload/shadow.png'); background-size: contain; background-repeat: no-repeat; background-position: bottom;"></div>
					</div>
				</div>
			</div>
			<div class="row card-body pt-5">
			<form class="form" id="modify_rsvt" method="post">
				<div class="d-flex flex-column fv-row">
					<label class="fs-5 fw-semibold pt-5">이용 시간</label>
				    <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div>
				    <div class="col-12">
				        <div class="d-flex">
				            <input type="hidden" class="form-control flatpickr-input active" id="rsvtCdHidden" name="rsvtCd">
				            <input type="datetime-local" class="form-control flatpickr-input active" id="vhclRntlDt" name="vhclRntlDt">
				            <input type="datetime-local" class="form-control flatpickr-input active" id="vhclRtnDt" name="vhclRtnDt">
				        </div>
				    </div>
					    
					<label class="fs-5 fw-semibold pt-5">목적지</label>
					<div class="input-group">
					    <input type="text" class="form-control" placeholder="목적지를 입력해주세요" name="vhclBtdst" id="vhclBtdst">
					    <span class="input-group-text">검색</span>
					</div>
					
					<label class="fs-5 fw-semibold pt-5">대여사유</label>
					<div class="input-group">
						<textarea class="form-control" placeholder="대여 사유를 입력해주세요" rows="3" name="rntlRsn" id="rntlRsn"></textarea> <!-- Bootstrap 클래스 추가 -->
					</div>
					<div class="card-footer d-flex align-middle justify-content-center py-5">
						<div class="card-toolbar">
							<button type="button" class="btn btn-light-success" id="modifyRsvtBtn">
							수정</button>
							<button type="reset" class="btn btn-light me-3" data-bs-dismiss="modal">취소</button>
						</div>
					</div>
					
					<div class="separator separator-dashed"></div>
					    
					<label class="fs-5 fw-semibold pt-5">차량 정보</label>
				    <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div>
				    <div class="col-12">
				        <div class="d-flex">
				            <input type="text" class="form-control form-control-solid mx-1" id="modifyVhclNo" name="vhclNo" readonly="readonly">
				            <input type="text" class="form-control form-control-solid mx-1" id="modifyVhclMdlNm" name="vhclMdlNm" readonly="readonly">
				        </div>
				    </div>
					<label class="fs-5 fw-semibold form-control-solid pt-5">차종</label>
					<div class="input-group">
					    <input type="text" class="form-control form-control-solid mx-1" name="vhclKndNm" id="modifyVhclKndNm" readonly="readonly">
					</div>
					<label class="fs-5 fw-semibold pt-5">유종</label>
					<div class="input-group">
					    <input type="text" class="form-control form-control-solid mx-1" name="vhclTypeFuel" id="modifyVhclTypeFuel" readonly="readonly">
					</div>
					<label class="fs-5 fw-semibold pt-5">연비</label>
					<div class="input-group">
					    <input type="text" class="form-control form-control-solid mx-1" name="vhclAvgFuel" id="modifyVhclAvgFuel" readonly="readonly">
					    <span class="input-group-text">㎞/ℓ</span>
					</div>
				</div>
			</form>
			</div>
			</div>
		</div>
	</div>
</div>

<form action="/empvehicle/delrsvt.do" id="delForm" method="post">
	<input type="hidden" name="rsvtCd" id="delRsvtCd">
</form>

<script type="text/javascript">

$(document).ready(function() {
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	var searchBtn = $("#searchBtn");
	var searchOrderId = $("#searchOrderId");
	var sortBtn = $("#sortBtn");
	var delete_rsvt = $("#delete_rsvt");
    var delRsvtCd = $("#delRsvtCd");
    var modifyRsvtBtn = $("#modifyRsvtBtn");
    const spinner = $('.spinner-border');
	
	pagingArea.on("click", "a", function (event) {
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	searchBtn.on("click", function () {
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	sortBtn.on("click", function () {
		event.preventDefault();
		sortSelect = $("#sortSelect").val();
		console.log("선택된 벨류 : " + sortSelect);
		var pageNo = $(this).data("page");
		searchOrderId.val(sortSelect);
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	$(".edit-rsvt").on("click", function() {
        var rsvtCd = $(this).data("cd"); // 클릭한 버튼의 data-id 속성에서 ID 가져오기
		console.log("예약수정버튼 눌림");
		console.log("예약수정버튼 rsvt값 확인 : " + rsvtCd);
        
        // AJAX 요청
        $.ajax({
            url: '/empvehicle/getrsvtvo.do',
            type: 'GET',
            data: {
            	rsvtCd : rsvtCd
            },
            success: function(rsvt) {
            	
				console.log("ajax후  rsvt값 : " + rsvt);
                // 응답 데이터에서 직급 정보 설정
                $("#rsvtCdHidden").val(rsvtCd); 
                
                $("#modal_modify_rsvt .image-input-wrapper").css("background-image", "url('/upload/" + rsvt.vhclVO.vhclImgPath + "')");
                
                $("#modify_rsvt #rsvtCd").val(rsvtCd);
                $("#modify_rsvt #vhclRntlDt").val(rsvt.vhclRntlDt);
                $("#modify_rsvt #vhclRtnDt").val(rsvt.vhclRtnDt);
                $("#modify_rsvt #vhclBtdst").val(rsvt.vhclBtdst);
                $("#modify_rsvt #rntlRsn").val(rsvt.rntlRsn);
                
                $("#modify_rsvt #modifyVhclNo").val(rsvt.vhclNo);
                $("#modify_rsvt #modifyVhclMdlNm").val(rsvt.vhclVO.vhclMdlNm);
                $("#modify_rsvt #modifyVhclKndNm").val(rsvt.vhclVO.vhclKndNm);
                $("#modify_rsvt #modifyVhclTypeFuel").val(rsvt.vhclVO.vhclTypeFuel);
                $("#modify_rsvt #modifyVhclAvgFuel").val(rsvt.vhclVO.vhclAvgFuel);
                $("#modal_modify_rsvt").modal('show'); // 모달 열기
            },
            error: function(xhr, status, error) {
                console.error("ajax에러");
            }
        });
    });
	
	modifyRsvtBtn.on("click", function() {
        let rsvtCd = $("#rsvtCdHidden").val();
        let vhclRntlDt = $("#vhclRntlDt").val();
        let vhclRtnDt = $("#vhclRtnDt").val();
        let vhclBtdst = $("#vhclBtdst").val();
        let rntlRsn = $("#rntlRsn").val();
        let formElement = document.getElementById("modify_rsvt"); // 폼 ID
        
        console.log("rsvtCd 수정버튼 : " + rsvtCd);
        console.log("vhclRntlDt 수정버튼 : " + vhclRntlDt);
        console.log("vhclRtnDt 수정버튼 : " + vhclRtnDt);
        console.log("vhclBtdst 수정버튼 : " + vhclBtdst);
        console.log("rntlRsn 수정버튼 : " + rntlRsn);

        $.ajax({
            url: "/empvehicle/rsvtmodify.do", // 서버 URL
            type: "POST",
            data: {
            	rsvtCd : rsvtCd,
            	vhclRntlDt: vhclRntlDt,
            	vhclRtnDt: vhclRtnDt,
            	vhclBtdst: vhclBtdst,
            	rntlRsn: rntlRsn
            },
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
	
	
	$(document).on("click", ".del-rsvt", function(event) {
        var rsvtCd = $(this).data("cd"); // 클릭한 버튼의 data-id 속성에서 ID 가져오기
        
        delRsvtCd.val(rsvtCd);
        console.log("현재 delRsvtCd 값 : " + delRsvtCd.val());
        event.preventDefault(); // 기본 동작 방지

        // 스피너를 보여주고 문구 변경
        spinner.removeClass('d-none');

        console.log("Swal.fire() 호출 전");
        Swal.fire({
            title: '예약을 취소하시겠습니까?',
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
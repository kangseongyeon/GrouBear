<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>.image-input-placeholder { background-image: url('assets/media/svg/files/blank-image.svg'); }
[data-bs-theme="dark"] .image-input-placeholder { background-image: url('assets/media/svg/files/blank-image-dark.svg'); }
</style>
<div style="margin-bottom: 25px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>인사·정보 관리</h3>
		<h6>전체사원목록</h6>
	</div>
</div>
<div id="kt_app_content_container">
	<div class="app-main flex-column flex-row-fluid">
		<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container" class="app-container container-fluid">
					<div class="card">
						<div class="card-header border-0 pt-6">
							<div class="card-title">
								<div class="d-flex align-items-center position-relative my-1">
									<form id="searchForm" style="display: contents;">
										<input type="hidden" name="page" id="page"/>
										<input type="hidden" name="searchOrder" id="searchOrderId" value="${searchOrder }"/>
										<input name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-5" style="margin-top: 0.5em;" placeholder="통합 검색" value="${searchWord }"/>
										<button id="searchBtn" type="button" class="btn btn-flex btn-light-success ms-1 py-3 px-3" style="margin-top: 0.5em;">
								            <i class="ki-duotone ki-magnifier fs-2">
												<span class="path1" style="height: 1.1em;"></span> 
												<span class="path2"></span>
											</i>
										</button>
									</form>
									<table class="table align-middle table-row-dashed fs-6">
										<tbody class="text-gray-600 align-middle fw-semibold d-flex justify-content-end align-items-center pt-5">
											<tr>
												<td><h6 class="text-gray-600">검색 된 사원 수  </h6></td>
												<td><h6 class="text-gray-600">:</h6></td>
												<td><h6 class="text-gray-600">${pagingVO.totalRecord }명</h6></td>
											</tr>
										</tbody>
									</table>
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
												    <option value="empNm" selected="selected">이름 순</option>
												    <option value="recent">최근 등록 순</option>
												    <option value="empNo">사번 순</option>
												    <option value="jbgdCd">직급 순</option>
												</select>
											</div>
											<div class="d-flex justify-content-end">
												<button type="submit" id="sortBtn" class="btn btn-primary fw-semibold px-6" data-kt-menu-dismiss="true" data-kt-user-table-filter="filter">정렬</button>
											</div>
										</div>
									</div>
									<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#kt_modal_export_users">
									<i class="ki-duotone ki-exit-up fs-2">
										<span class="path1"></span>
										<span class="path2"></span>
									</i>엑셀로 일괄추가</button>
									<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#kt_modal_add_user">
									<i class="ki-duotone ki-plus fs-2"></i>사원 추가</button>
								</div>
								<div class="d-flex justify-content-end align-items-center d-none" data-kt-user-table-toolbar="selected">
									<div class="fw-bold me-5">
									<span class="me-2" data-kt-user-table-select="selected_count"></span>Selected</div>
									<button type="button" class="btn btn-danger" data-kt-user-table-select="delete_selected">Delete Selected</button>
								</div>
								<div class="modal fade" id="kt_modal_export_users" tabindex="-1" aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered mw-650px">
										<div class="modal-content">
											<div class="modal-header">
												<h2 class="fw-bold">엑셀로 일괄추가</h2>
												<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
													<i class="ki-duotone ki-cross fs-1">
														<span class="path1"></span>
														<span class="path2"></span>
													</i>
												</div>
											</div>
											<div class="modal-body scroll-y mx-5 mx-xl-15 my-7">
												<form id="kt_modal_export_users_form" class="form" action="#">
												</form>
											</div>
										</div>
									</div>
								</div>
								<div class="modal fade" id="kt_modal_add_user" tabindex="-1" aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered mw-650px">
										<div class="modal-content">
											<div class="modal-header" id="kt_modal_add_user_header">
												<h2 class="fw-bold">사원 추가</h2>
												<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
													<i class="ki-duotone ki-cross fs-1">
														<span class="path1"></span>
														<span class="path2"></span>
													</i>
												</div>
											</div>
											<div class="modal-body px-5 my-7">
												<form id="kt_modal_add_user_form" class="form" action="/empinformation/empinsert.do" method="post" enctype="multipart/form-data">
													<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
													    <div class="fv-row mb-7 d-flex flex-column align-items-center justify-content-center">
													        <label class="d-block fw-semibold fs-6 mb-5">프로필 이미지</label>
													        
													        <div class="image-input image-input-outline image-input-placeholder" data-kt-image-input="true">
													            <div class="image-input-wrapper w-125px h-125px" style="background-image: url('/upload/noimg.jpg');"></div>
													            <label class="btn btn-icon btn-circle btn-active-color-primary w-25px h-25px bg-body shadow" data-kt-image-input-action="change" data-bs-toggle="tooltip" >
													                <i class="ki-duotone ki-pencil fs-7">
													                    <span class="path1"></span>
													                    <span class="path2"></span>
													                </i>
													                <input type="file" name="imgFile" accept=".png, .jpg, .jpeg" />
													            </label>
															</div>
															<div class="form-text">지원하는 확장자 : png, jpg, jpeg.</div>
														</div>
															<input type="hidden" name="coCd" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="기업코드" value="${employee.coCd }" />
														<div class="fv-row mb-7">
															<label class="required fw-semibold fs-6 mb-2">이름</label>
															<input type="text" name="empNm" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="사원이름을 입력해주세요" id="empNm"/>
														</div>
														<div class="fv-row mb-7">
															<label class="required fw-semibold fs-6 mb-2">사번</label>
															<input type="text" name="empNo" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="사번을 입력해주세요" id="empNo"/>
														</div>
														<div class="fv-row mb-7">
															<label class="required fw-semibold fs-6 mb-2">아이디</label>
															<input type="text" name="empId" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="사원 아이디를 입력해주세요" id="empId"/>
															<label class="d-block fw-semibold fs-6 mb-5" id="empId_chk"></label>
														</div>
														<div class="fv-row mb-7">
															<label class="required fw-semibold fs-6 mb-2">임시 비밀번호</label>
															<input type="text" name="empPw" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="임시비밀번호" value="1234" id="empPw"/>
														</div>
														<div class="fv-row mb-7">
														    <label class="required fw-semibold fs-6 mb-2">소속 부서</label>
														    <select name="deptCd" id="deptSelect" class="form-control form-control-solid mb-3 mb-lg-0">
														        <option value="소속부서 선택">소속부서 선택</option>
														        <c:forEach var="dept" items="${deptList}">
														            <option value="${dept.deptCd}">${dept.deptNm}</option>
														        </c:forEach>
														    </select>
														</div>
														
														<div class="fv-row mb-7">
														    <label class="required fw-semibold fs-6 mb-2">소속 팀</label>
														    <select name="teamCd" id="teamSelect" class="form-control form-control-solid mb-3 mb-lg-0">
														        <option value="팀을 선택해주세요">부서를 선택해주세요</option>
														    </select>
														</div>
														<div class="fv-row mb-7">
														    <label class="required fw-semibold fs-6 mb-2">직급</label>
														    <select name="jbgdCd" id="jbgdSelect" class="form-control form-control-solid mb-3 mb-lg-0">
														        <option value="직급을 선택해주세요">직급을 선택해주세요</option>
														        <c:forEach var="jbgd" items="${jbgdList}">
														            <option value="${jbgd.jbgdCd}">${jbgd.jbgdNm}</option>
														        </c:forEach>
														    </select>
														</div>
														<div class="fv-row mb-7">
															<label class="required fw-semibold fs-6 mb-2">생년월일</label>
															<input type="text" name="empBrdt" id="empBrdt" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="생년월일을 입력해주세요" value="2001-11-18" />
														</div>
														<div class="fv-row mb-7">
														    <label class="required fw-semibold fs-6 mb-2">성별</label>
														    <select name="empGndr" id="empGndr" class="form-control form-control-solid mb-3 mb-lg-0">
													            <option value="GNDR01">남</option>
													            <option value="GNDR02">여</option>
														    </select>
														</div>
												        <div class="fv-row mb-7">
												            <label class="required fw-semibold fs-6 mb-2">입사일</label>
												            <input type="date" id="empJncmpYmd" name="empJncmpYmd" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="YYYY-MM-DD" value=""/>
												        </div>
														<div class="fv-row mb-7">
															<label class="required fw-semibold fs-6 mb-2">전화번호</label>
															<input type="tel" name="empTelno" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="전화번호 입력  " value="" id="empTelno"/>
														</div>
													</div>
													<div class="text-center pt-10">
														<button type="button" class="btn btn-primary" data-kt-users-modal-action="submit" id="subBtn">
															<span class="indicator-label">등록</span>
															<span class="indicator-progress">Please wait... 
															<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
														</button>
														<button type="reset" class="btn btn-light me-3" data-bs-dismiss="modal">취소</button>
													</div>
												</form>
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
										<th class="w-10px pe-2">
											<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
												<input class="form-check-input" type="checkbox" data-kt-check="true" data-kt-check-target="#kt_table_users .form-check-input" value="1" />
											</div>
										</th>
										<th class="min-w-100px">이름</th>
										<th class="min-w-100px">사번</th>
										<th class="min-w-100px">부서</th>
										<th class="min-w-100px">팀</th>
										<th class="min-w-100px">직급</th>
										<th class="min-w-100px">입사일</th>
										<th class="min-w-100px">전화번호</th>
									</tr>
								</thead>
								<tbody class="text-gray-600 fw-semibold">
								<c:set value="${pagingVO.dataList }" var="empAllList"/>
								<c:choose>
									<c:when test="${empty empAllList }">
										<tr>
											<td colspan="7" class="text-center pt-5">
												사원이 존재하지 않습니다.
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${empAllList }" var="empList">
											<tr>
												<td>
													<div class="form-check form-check-sm form-check-custom form-check-solid">
														<input class="form-check-input" type="checkbox" value="1" />
													</div>
												</td>
												<td class="d-flex align-items-center">
													<div class="symbol symbol-circle symbol-50px overflow-hidden me-3">
														<a href="/empinformation/empdetail.do?empId=${empList.empId }">
															<span class="symbol-label">
																<img src="/upload/${empList.imgFileUrl }" alt="" class="w-100" />
															</span>
														</a>
													</div>
													<div class="d-flex flex-column">
													    <div class="text-gray-800 text-hover-primary mb-1" style="cursor: pointer;">
													    	<a href="/empinformation/empdetail.do?empId=${empList.empId }">
													        ${empList.empNm}
													        </a>
													    </div>
														<span>${empList.empEmlAddr }</span>
													</div>
												</td>
												<td>${empList.empNo }</td>
												<td>
													<div class="badge badge-light-success fw-bold">${empList.deptCd }</div>
												</td>
												<td>
													<div class="badge badge-light fw-bold">${empList.teamCd }</div>
												</td>
												<td>
													<div class="badge badge-light-primary fw-bold">${empList.jbgdCd }</div>
												</td>
												<td>${fn:substring(empList.empJncmpYmd, 0, 10)}</td>
												<td>${empList.empTelno }</td>
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
	<div id="kt_app_footer" class="app-footer">
		<div class="app-container container-fluid d-flex align-items-center justify-content-center flex-column flex-md-row flex-center flex-md-stack py-3">
			<div class="card-footer clearfix" id="pagingArea">
				${pagingVO.pagingHTML }
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	var searchBtn = $("#searchBtn");
	var subBtn = $("#subBtn");
	var searchOrderId = $("#searchOrderId");
	var sortBtn = $("#sortBtn");
	
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
	
    $('#deptSelect').change(function() {
        var deptCd = $(this).val();
        var teamSelect = $('#teamSelect');
        var option = $('');
        
        // 기존 팀 옵션 제거
        teamSelect.html('<option value="" disabled selected>소속 팀 선택</option>');
        console.log(deptCd);
        if (deptCd) {
            $.ajax({
                url: '/empinformation/getteam.do',
                type: 'GET',
                data: { deptCd: deptCd },
                contentType: 'application/json; charset=UTF-8',
                success: function(data) {
                	console.log(data);
                    $.each(data, function(index, team) {
                        option = $('<option></option>')
                            .attr('value', team.teamCd)
                            .text(team.teamNm);
                        teamSelect.append(option);
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching teams:', error);
                }
            });
        }
    });
    
    subBtn.on("click", function(){
        let empNm = $("#empNm").val();
        let empNo = $("#empNo").val();
        let empId = $("#empId").val();
        let empPw = $("#empPw").val();
        let deptSelect = $("#deptSelect").val();
        let teamSelect = $("#teamSelect").val();
        let jbgdSelect = $("#jbgdSelect").val();
        let empJncmpYmd = $("#empJncmpYmd").val();
        let empTelno = $("#empTelno").val();
        
		if(empNm == ""){
			console.log("Name_null");
			$("#empNm").text("사원명을 입력해주세요.");
			Swal.fire({
			    icon: 'warning',
			    title: '사원명을 입력해주세요!',
			    confirmButtonColor: '#4FC9DA',
			});
		   return false;
		}
		if(empNo == ""){
		   console.log("Name_null");
		    $("#empNo").text("사번을 입력해주세요.");
		    Swal.fire({
			      icon: 'warning',
			      title: '사번을 입력해주세요!',
			      confirmButtonColor: '#4FC9DA',
			    });
		   return false;
		}
		if(empId == ""){
			console.log("Name_null");
			$("#empId").text("사원 아이디를 입력해주세요.");
			Swal.fire({
				icon: 'warning',
				title: '사원 아이디를 입력해주세요!',
				confirmButtonColor: '#4FC9DA',
			});
		   return false;
		}
		if(empPw == ""){
			console.log("Name_null");
			$("#empPw").text("임시비밀번호를 입력해주세요.");
			Swal.fire({
				icon: 'warning',
				title: '임시비밀번호를 입력해주세요!',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}
		if(!deptSelect || deptSelect == "소속부서 선택"){
			console.log("Name_null");
			Swal.fire({
				icon: 'warning',
				title: '부서를 선택해주세요!',
				confirmButtonColor: '#4FC9DA',
			}).then(() => {
	            // Swal 창이 닫힌 후 실행
	            $('#deptSelect').val(''); // 초기값으로 돌리기
	            $('#deptSelect option:first').prop('selected', true); // 첫 번째 옵션을 선택
	        });
			return false;
		}
		if(!teamSelect || teamSelect == "팀을 선택해주세요"){
			console.log("Name_null");
			Swal.fire({
				icon: 'warning',
				title: '팀을 선택해주세요!',
				confirmButtonColor: '#4FC9DA',
			}).then(() => {
	            // Swal 창이 닫힌 후 실행
	            $('#teamSelect').val(''); // 초기값으로 돌리기
	            $('#teamSelect option:first').prop('selected', true); // 첫 번째 옵션을 선택
	        });
			return false;
		}
		if(!jbgdSelect || jbgdSelect == "직급을 선택해주세요"){
			console.log("Name_null");
			Swal.fire({
				icon: 'warning',
				title: '직급을 선택해주세요!',
				confirmButtonColor: '#4FC9DA',
			}).then(() => {
	            // Swal 창이 닫힌 후 실행
	            $('#jbgdSelect').val(''); // 초기값으로 돌리기
	            $('#jbgdSelect option:first').prop('selected', true); // 첫 번째 옵션을 선택
	        });
			return false;
		}
		if(empJncmpYmd == ""){
			console.log("Name_null");
			$("#empJncmpYmd").text("입사일을 입력해주세요.");
			Swal.fire({
				icon: 'warning',
				title: '입사일을 선택해주세요!',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}
		if(empTelno == ""){
			console.log("Name_null");
			$("#empTelno").text("전화번호를 입력해주세요.");
			Swal.fire({
				icon: 'warning',
				title: '전화번호를 입력해주세요!',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}
	
		empTelno = empTelno.replaceAll("-","");	
		
	    var numberPattern = /^[0-9]+$/;
	    if (!numberPattern.test(empNo)) {
	        Swal.fire({
	            icon: 'warning',
	            title: '사번은 숫자만 입력 가능합니다!',
	            confirmButtonColor: '#4FC9DA',
	        });
	        return false; // 검증 실패 시 함수 종료
	    }
		
		var data = {
		     "empId" : empId,
		};
		
		
		if (boolid) {
			$.ajax({
	            url: "/signupidchk",
	            type: "post",
	            contentType: "application/json; charset=utf-8",
	            data: JSON.stringify(data),
	            success: function(res){
	                console.log("success");
	                Swal.fire({
	    	            icon: 'success',
	    	            title: '사원 등록 완료!',
	    	            confirmButtonColor: '#4FC9DA',
	    	        });
	                $("#kt_modal_add_user_form").submit();
	            },
	            error: function(){
	            	Swal.fire({
	    	            icon: 'warning',
	    	            title: '이미 등록된 아이디입니다!',
	    	            confirmButtonColor: '#4FC9DA',
	    	        });
	            	$("#empId").val("");
	            }
			});
		}
	});
    var boolid = false;
    
	$("#empId").focusout(function() {
		var userIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/);
	
		if(!userIdCheck.test($("#empId").val())) {
			Swal.fire({
				icon: 'warning',
				title: '아이디는 영문과 숫자, 특수기호(_),(-)만 사용 가능합니다.',
				confirmButtonColor: '#4FC9DA',
			});
			$("#empId").val("");
			boolid = false;		
		}else{
			boolid = true;
		}
	});
});
</script>					

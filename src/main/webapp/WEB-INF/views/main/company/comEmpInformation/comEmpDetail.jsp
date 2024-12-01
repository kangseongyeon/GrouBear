<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>인사·정보 관리</h3>
		<h6>전체사원목록 - 사원 상세</h6>
	</div>
</div>
<div id="kt_app_content_container" class="app-container container-fluid">
	<div class="card mb-5 mb-xxl-8">
		<div class="card-body pt-9 pb-0" style="background-color : #f8f6f2;">
			<div class="d-flex flex-wrap flex-sm-nowrap mb-6 align-middle">
				<c:choose>
				    <c:when test="${empVO.empGndr == 'GNDR01'}">
						<span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-150px mh-100 me-4 bg-info mt-1">
						</span>
				    </c:when>
				    <c:otherwise>
				    	<span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-150px mh-100 me-4 bg-warning mt-1">
						</span>
				    </c:otherwise>
				</c:choose>
				<div class="me-7 mb-4">
					<div class="symbol symbol-160px symbol-lg-160px symbol-fixed position-relative" style="overflow: hidden;">
						<img src="/upload/${empVO.imgFileUrl }" class="img-fluid rounded" style="object-fit: cover;"/>
					</div>
				</div>
				<div class="flex-grow-1">
					<div class="d-flex justify-content-between align-items-start flex-wrap mb-2">
						<div class="d-flex flex-column py-3">
							<div class="d-flex align-items-center mb-2">
								<div class="text-gray-800 text-hover-primary fs-2 fw-bold me-1"><h2>${empVO.empNm }</h3></div>
								<i class="ki-duotone ki-verify fs-1 text-primary pb-2">
									<span class="path1"></span>
									<span class="path2"></span>
								</i>
							</div>
							<div class="flex-wrap fw-semibold fs-6 mb-4 pe-2">
								<a href="#" class="d-flex align-items-center text-gray-500 text-hover-primary me-5 mb-2 py-1" data-clipboard="${empVO.empEmlAddr}">
								<i class="ki-duotone ki-address-book fs-4 me-1">
									<span class="path1"></span>
									<span class="path2"></span>
									<span class="path3"></span>
								</i>${empVO.empEmlAddr}</a>
								<a href="#" class="d-flex align-items-center text-gray-500 text-hover-primary me-5 mb-2 py-1" data-clipboard="${empVO.empAddr} ${empVO.empDaddr}">
								<i class="ki-duotone ki-geolocation fs-4 me-1">
									<span class="path1"></span>
									<span class="path2"></span>
								</i>${empVO.empAddr} ${empVO.empDaddr}</a>
								<a href="#" class="d-flex align-items-center text-gray-500 text-hover-primary mb-2 py-1" data-clipboard="${empVO.empTelno}">
								<i class="ki-duotone ki-sms fs-4 me-1">
									<span class="path1"></span>
									<span class="path2"></span>
								</i>${empVO.empTelno}</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<form action="/information/empdelete.do" method="post" id="delForm">
    <input type="hidden" name="empId" value="${empVO.empId }" />
<!--     <button type="submit" id="delSubmit"></button> -->
</form>
	<div class="row g-5 g-xxl-8 d-flex">
		<div class="col-xl-12">
			<table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered">
				<tbody>
					<tr>
						<td class="text-center" style="background-color: #fdfcfb">이름</td>
						<td>${empVO.empNm }</td>
						<td class="text-center" style="background-color: #fdfcfb">입사일</td>
						<td>${fn:substring(empVO.empJncmpYmd, 0, 10)}</td>
						<td class="text-center" style="background-color: #fdfcfb">퇴사일</td>
						<td>${fn:substring(empVO.empRsgntnYmd, 0, 10)}</td>
						<td class="text-center" style="background-color: #fdfcfb">생년월일</td>
						<td>${fn:substring(empVO.empBrdt, 0, 10)}</td>
					</tr>
					<tr>
						<td class="text-center" style="background-color: #fdfcfb">사번</td>
						<td>${empVO.empNo }</td>
						<td class="text-center" style="background-color: #fdfcfb">부서</td>
						<td>${empVO.deptNm }</td>
						<td class="text-center" style="background-color: #fdfcfb">소속</td>
						<td>${empVO.teamNm }</td>
						<td class="text-center" style="background-color: #fdfcfb">직급</td>
						<td>${empVO.jbgdNm }</td>
					</tr>
					<tr>
						<td class="text-center" style="background-color: #fdfcfb">국적</td>
						<td>${empVO.empNtn }</td>
						<td class="text-center" style="background-color: #fdfcfb">주소</td>
						<td>${empVO.empAddr } ${empVO.empDaddr }</td>
						<td class="text-center" style="background-color: #fdfcfb">성별</td>
						<td>
						<c:choose>
						    <c:when test="${empVO.empGndr == 'GNDR01'}">
								남성
						    </c:when>
						    <c:otherwise>
						    	여성
						    </c:otherwise>
						</c:choose>
						</td>
						<td class="text-center" style="background-color: #fdfcfb">연봉</td>
						<td></td>
						
					</tr>
					<tr>
						<td class="text-center" style="background-color: #fdfcfb">전화번호</td>
						<td>${empVO.empTelno }</td>
						<td class="text-center" style="background-color: #fdfcfb">Email</td>
						<td>${empVO.empEmlAddr }</td>
<!-- 						<td class="text-center" style="background-color: #fdfcfb">장애여부</td> -->
<!-- 						<td>X</td> -->
						<td class="text-center" style="background-color: #fdfcfb">최종학력</td>
						<td>4년제 대학(졸)</td>
						<td class="text-center" style="background-color: #fdfcfb">혈액형</td>
						<td>
						<c:choose>
						    <c:when test="${empVO.empDelYn == 'Y' }">
								B
						    </c:when>
						    <c:otherwise>
						    	A
						    </c:otherwise>
						</c:choose>
						</td>
					</tr>
					<tr>
						<td class="text-center" style="background-color: #fdfcfb">병역유형</td>
						<td>
						<c:choose>
						    <c:when test="${empVO.empGndr == 'GNDR01'}">
								군필
						    </c:when>
						    <c:otherwise>
						    	미필
						    </c:otherwise>
						</c:choose>
						</td>
						<td class="text-center" style="background-color: #fdfcfb">면허여부</td>
						<td>
						<c:choose>
						    <c:when test="${empVO.empDlnYn == 'Y' }">
								O
						    </c:when>
						    <c:otherwise>
						    	X
						    </c:otherwise>
						</c:choose>
						</td>
						<td class="text-center" style="background-color: #fdfcfb">결혼여부</td>
						<td>X</td>
						<td class="text-center" style="background-color: #fdfcfb">퇴사여부</td>
						<td>
						<c:choose>
						    <c:when test="${empVO.empDelYn == 'Y' }">
								O
						    </c:when>
						    <c:otherwise>
						    	X
						    </c:otherwise>
						</c:choose>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="card mb-5 mb-xxl-8">
			<div class="card-body py-5">
				<div class="d-flex flex-wrap flex-sm-nowrap align-middle">
					<div class="flex-grow-1">
						<div class="d-flex justify-content-between align-items-start flex-wrap mb-2">
							<div class="d-flex col-12 py-5">
								<div class="flex-wrap fw-semibold fs-6 mb-4 pe-2 col-xl-6">
								<h3>인사정보 일괄등록</h3>
								</div>
							</div>
							<div class="d-flex col-12">
								<div class="flex-wrap fw-semibold fs-6 mb-4 pe-2 col-xl-6">
									<table class="table align-middle table-row-dashed" style="border: 1px solid; width: auto;">
									    <thead>
									        <tr>
									            <td class="text-center d-flex align-items-center" style="cursor: pointer;" id="empExcelDown">
									                <div class="d-flex align-items-center px-5">
									                    <div class="symbol" style="overflow: hidden; margin-right: 5px;">
									                        <img src="/upload/excelicon.png" class="img-fluid rounded" style="object-fit: cover; width: 30px; height: 30px;">
									                    </div>
									                    <span>전체 사원 다운로드</span>
									                </div>
									            </td>
									        </tr>
									    </thead>
									</table>
									<div class="flex-wrap text-gray-500 fw-semibold fs-6 mb-4 pe-2">
										현재 등록 되어있는 전 직원의 인사정보를 다운로드 합니다.<br/>
										다운로드 후 수정하여 일괄등록 할 수 있습니다.
									</div>
								</div>
								<span data-kt-element="bullet" class="bullet bullet-vertical me-5 d-flex align-items-center min-h-150px">
								</span>
								<div class="flex-wrap fw-semibold fs-6 mb-4 pe-2 col-xl-6">
									<table class="table align-middle table-row-dashed" style="border: 1px solid; width: auto;">
									    <thead>
									        <tr>
									            <td class="text-center d-flex align-items-center" style="cursor: pointer;" id="empExcelDown">
									                <div class="d-flex align-items-center px-5">
									                    <div class="symbol" style="overflow: hidden; margin-right: 5px;">
									                        <img src="/upload/excelicon.png" class="img-fluid rounded" style="object-fit: cover; width: 30px; height: 30px;">
									                    </div>
									                    <span>현재 사원 다운로드</span>
									                </div>
									            </td>
									        </tr>
									    </thead>
									</table>
									<div class="flex-wrap text-gray-500 fw-semibold fs-6 mb-4 pe-2">
										현재 설정되어있는 직원의 인사정보를 다운로드 합니다.<br/>
										다운로드 후 수정하여 일괄등록 할 수 있습니다.
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>	
		</div>	
		<div class="d-flex justify-content-end pb-10">
			<div class="align-items-center">
				<a href="#" class="btn btn-light-danger" id="empDeleteDiv">
				    <i class="ki-duotone ki-abstract-8 text-danger">
					<span class="path1"></span>
					<span class="path2"></span></i>
				    <span class="indicator-label" id="deleteBtn">퇴사</span>
				    <span class="indicator-progress">퇴사
				    <span class="spinner-border spinner-border-sm align-middle ms-2 d-none"></span></span>
				</a>
				<a href="#" class="btn btn-flex btn-light-success" data-bs-toggle="modal" data-bs-target="#kt_modal_modify_user">
				<i class="ki-duotone ki-abstract-8 text-success">
				<span class="path1"></span>
				<span class="path2"></span></i>
				수정</a>
				<button type="button" id="listBtn" class="btn btn-flex btn-light-info">
				<i class="ki-duotone ki-abstract-8 text-info">
					<span class="path1"></span>
					<span class="path2"></span></i>
					목록</button>
			</div> 
		</div>
	</div>
</div>
<div class="modal fade" id="kt_modal_modify_user" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered mw-650px">
		<div class="modal-content">
			<div class="modal-header" id="kt_modal_add_user_header">
				<h2 class="fw-bold">인사정보 수정</h2>
				<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
					<i class="ki-duotone ki-cross fs-1">
						<span class="path1"></span>
						<span class="path2"></span>
					</i>
				</div>
			</div>
			<div class="modal-body px-5 my-7">
				<form id="kt_modal_modify_user_form" class="form" action="/information/empinfomodify.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="empId" value="${empVO.empId }" id="empId"/>
					<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
					    <div class="fv-row mb-7 d-flex flex-column align-items-center justify-content-center">
					        <label class="d-block fw-semibold fs-6 mb-5">프로필 이미지</label>
					        <style>
					            .image-input-placeholder { background-image: url('assets/media/svg/files/blank-image.svg'); }
					            [data-bs-theme="dark"] .image-input-placeholder { background-image: url('assets/media/svg/files/blank-image-dark.svg'); }
					        </style>
					        <div class="image-input image-input-outline image-input-placeholder" data-kt-image-input="true">
					            <div class="image-input-wrapper w-125px h-125px" style="background-image: url('/upload/${empVO.imgFileUrl }');"></div>
					            <label class="btn btn-icon btn-circle btn-active-color-primary w-25px h-25px bg-body shadow" data-kt-image-input-action="change" data-bs-toggle="tooltip">
					                <i class="ki-duotone ki-pencil fs-7">
					                    <span class="path1"></span>
					                    <span class="path2"></span>
					                </i>
					                <input type="hidden" name="imgFileUrl" value="${empVO.imgFileUrl }">
					                <input type="file" name="imgFile" accept=".png, .jpg, .jpeg" />
					            </label>
							</div>
							<div class="form-text">지원하는 확장자 : png, jpg, jpeg.</div>
						</div>
							<input type="hidden" name="coCd" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="기업코드" value="${employee.coCd }" />
						

						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">이름</label>
							<input type="text" name="empNm" id="empNm" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="사원이름을 입력해주세요" value="${empVO.empNm }" />
						</div>
						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">입사일</label>
							<input type="text" name="empJncmpYmd" id="empJncmpYmd" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="입사을 입력해주세요" value="${fn:substring(empVO.empJncmpYmd, 0, 10)}" />
						</div>
						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">생년월일</label>
							<input type="text" name="empBrdt" id="empBrdt" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="생년월일을 입력해주세요" value="${fn:substring(empVO.empBrdt, 0, 10)}" />
						</div>
						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">성별</label>
							<select class="form-select form-select-solid fw-bold" name="empGndr" id="empGndr" data-placeholder="정렬 기준 선택" data-allow-clear="true">
							    <c:choose>
								    <c:when test="${empVO.empGndr == 'GNDR01'}">
									    <option value="GNDR01">
											남성
										</option>
									    <option value="GNDR02">
									    	여성
										</option>
								    </c:when>
								    <c:otherwise>
									    <option value="GNDR01">
											남성
										</option>
									    <option value="GNDR02" selected="selected">
									    	여성
										</option>
								    </c:otherwise>
								</c:choose>
							</select>
						</div>
						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">사번</label>
							<input type="text" name="empNo" id="empNo" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="사번을 입력해주세요" value="${empVO.empNo }" />
						</div>
						<div class="fv-row mb-7">
                            <label class="required fw-semibold fs-6 mb-2">소속 부서</label>
                            <select name="deptCd" id="deptSelect" class="form-control form-control-solid mb-3 mb-lg-0">
                                <option value="${empVO.deptCd }">${empVO.deptNm }</option>
                                <c:forEach var="dept" items="${deptList}">
                                	<c:if test="${dept.deptCd != empVO.deptCd}">
	                                    <option value="${dept.deptCd}">${dept.deptNm}</option>
							        </c:if>
                                </c:forEach>
                            </select>
                        </div>
						
						<div class="fv-row mb-7">
						    <label class="required fw-semibold fs-6 mb-2">소속 팀</label>
						    <select name="teamCd" id="teamSelect" class="form-control form-control-solid mb-3 mb-lg-0">
						        <option value="${empVO.teamCd }">${empVO.teamNm }</option>
						    </select>
						</div>
						<div class="fv-row mb-7">
						    <label class="required fw-semibold fs-6 mb-2">직급</label>
						    <select name="jbgdCd" id="jbgdSelect" class="form-control form-control-solid mb-3 mb-lg-0">
							    <option value="${empVO.jbgdCd}">${empVO.jbgdNm}</option>
							    <c:forEach var="jbgd" items="${jbgdList}">
							        <c:if test="${jbgd.jbgdCd != empVO.jbgdCd}">
							            <option value="${jbgd.jbgdCd}">${jbgd.jbgdNm}</option>
							        </c:if>
							    </c:forEach>
							</select>
						</div>
						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">국적</label>
							<input type="text" name="empNtn" id="empNtn" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="사원 국적을 입력해주세요" value="${empVO.empNtn }" />
						</div>
						<div class="fv-row mb-7">
							<label class="form-label fw-bold text-gray-900 fs-6">우편번호<span style="color: red;">*</span></label>
						<div class="d-flex align-items-center position-relative my-1">   
						   <input class="form-control form-control-md form-control-solid" type="text" placeholder="" name="empZip" id="empZip" autocomplete="off" value="${empVO.empZip }" readonly/>
						   <input type="button" class="btn btn-primary" value="검색" onclick="DaumPostcode()" >
						</div>
						</div>
						<div class="fv-row mb-7">
						   <label class="form-label fw-bold text-gray-900 fs-6">주소<span style="color: red;">*</span></label>
						<input class="form-control form-control-lg form-control-solid" type="text" placeholder="" name="empAddr" id="empAddr" autocomplete="off" value="${empVO.empAddr }" readonly/>
						</div>
						<div class="fv-row mb-7">
						   <label class="form-label fw-bold text-gray-900 fs-6">상세주소</label>
						   <input class="form-control form-control-lg form-control-solid" type="text" placeholder="" name="empDaddr" id="empDaddr" autocomplete="off" value="${empVO.empDaddr }"/>
						</div>
						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">전화번호</label>
							<input type="tel" name="empTelno" class="form-control form-control-solid mb-3 mb-lg-0" id="empTelno" placeholder="전화번호를 입력해주세요 " value="${empVO.empTelno }" />
						</div>
						<div class="fv-row mb-7">
							<label class="required fw-semibold fs-6 mb-2">Email</label>
							<input type="text" name="empEmlAddr" class="form-control form-control-solid mb-3 mb-lg-0" id="empEmlAddr" placeholder="이메일를 입력해주세요" value="${empVO.empEmlAddr }" />
						</div>
					</div>
					<div class="text-center pt-10">
						<button type="button" class="btn btn-primary" id="modifyBtn">
							<span class="indicator-label">수정</span>
							<span class="indicator-progress">잠시만 기다려주세요..!
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
    var deleteBtn = $("#deleteBtn");
    const spinner = $('.spinner-border');
    const empDeleteDiv = $("#empDeleteDiv");
//     const delSubmit = $("#delSubmit");
    var delForm = $("#delForm");
    var listBtn = $("#listBtn");
    var modifyBtn = $("#modifyBtn");
    
    
    modifyBtn.on("click", function(){
        let alarmCategory = $("#alarmCategory").val();
        let alarmTarget = $("#alarmTarget").val();
        let alarmCn = $("#alarmCn").val();
        let alarmUrl = $("#alarmUrl").val();
    	
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
		
	    var formElement = document.getElementById("kt_modal_modify_user_form"); // form ID
        var formData = new FormData(formElement); // FormData 객체 생성

        $.ajax({
            url: "/information/empinfomodify.do", // 서버 URL
            type: "POST",
            data: formData, // FormData 객체 사용
            contentType: false, // 기본 contentType을 false로 설정
            processData: false, // 데이터 자동 변환 방지
            success: function(response) {
                if (response.status === "success") {
                    Swal.fire({
                        icon: 'success',
                        title: '수정 완료!',
                        text: response.message,
                        confirmButtonColor: '#4FC9DA',
                    }).then(() => {

	                    let sendParams = {
	                            alarmCategory:"info",
	                            alarmTarget : $("#empId").val(),    // 알림 받을 사원의 아이디
	//                            alarmCn : empId +'님이 회원님의 게시물에 "'+ cmntCn +'" 댓글이 등록하였습니다.',
	                            alarmCn : alarmCn,            // alarmCn 부분은 위 주석 처럼 작성해서 저장해주세여 제가 알람 컨트롤러에서 set해줘야 하는게 있어요
	                            alarmUrl : "/empinformation/empdetail.do?empId=" + empId 
	                         };
	
						console.log("sendParams ::: ",sendParams);
	                   // 두 번째 AJAX 호출
	                               $.ajax({
	                                   url : "/insertAlarm",
	                                   type : "post", 
	                                   contentType : "application/json; charset=utf-8",
	                                   data: JSON.stringify(sendParams),
	                                   success: function(res){
	                                       webSocket.send(JSON.stringify(sendParams)); // 웹소켓 메시지 전송
	                                   },
	                                   error: function(xhr, status, error) {
	                                       console.error("Error inserting alarm:", error);
	                                   }
	                            }); 
	                   
	                   
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
    
    $('#deptSelect').change(function() {
        var deptCd = $(this).val();
        var teamSelect = $('#teamSelect');
        var option = $('');
        
        // 기존 팀 옵션 제거
        teamSelect.html('<option value="" disabled selected>소속 팀 선택</option>');
        console.log(deptCd);
        if (deptCd) {
            $.ajax({
                url: '/information/getteam.do',
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
    
    $('[data-clipboard]').on('click', function(event) {
        event.preventDefault(); // 기본 링크 클릭 동작 방지

        // 복사할 텍스트 가져오기
        var textToCopy = $(this).data('clipboard');

        // 텍스트 영역 생성
        var temp = $('<textarea>');
        $('body').append(temp);
        temp.val(textToCopy).select();
        document.execCommand('copy');
        temp.remove(); // 텍스트 영역 제거
    });
    
    
    listBtn.on('click', function(event) {
        event.preventDefault(); // 기본 링크 클릭 동작 방지
        location.href = "/information/allinfo.do"; // URL을 직접 할당
    });

    
    deleteBtn.on('click', function(event) {
        event.preventDefault(); // 기본 동작 방지

        // 스피너를 보여주고 문구 변경
        spinner.removeClass('d-none');

        Swal.fire({
            title: '퇴사처리 하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#F06445',
            cancelButtonColor: '#4FC9DA',
            confirmButtonText: '예',
            cancelButtonText: '아니요',
            reverseButtons: false,
        }).then((result) => {
            // 스피너와 문구 초기화
            spinner.addClass('d-none');

            if (result.isConfirmed) {
                delForm.submit();
            }
        });
    });
});

function DaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('empZip').value = data.zonecode;
            document.getElementById("empAddr").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("empAaddr").focus();
        }
    }).open();
}
</script>
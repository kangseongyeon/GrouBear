<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>기업 관리</h3>
		<h6>기업 정보 수정</h6>
	</div>
</div>
<div id="kt_app_content_container" class="app-container container-fluid">
	<div class="card mb-5 mb-xxl-8">
		<div class="card-body pt-9 pb-0" style="background-color : #f8f6f2;">
			<div class="d-flex flex-wrap flex-sm-nowrap mb-6 align-middle">
				<table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered">
					<tbody>
						<tr>
							<td class="text-center" style="background-color: #fdfcfb">기업명</td>
							<td>${companyVO.coNm }</td>
							<td class="text-center" style="background-color: #fdfcfb">대표명</td>
							<td>${companyVO.ceoNm }</td>
							<td class="text-center" style="background-color: #fdfcfb">사업자등록번호</td>
							<td>${companyVO.coBrno }</td>
							<td class="text-center" style="background-color: #fdfcfb">기업주소</td>
							<td>${companyVO.coAddr } ${companyVO.coDaddr }</td>
						</tr>
						<tr>
							<td class="text-center" style="background-color: #fdfcfb">계약일</td>
							<td>${empVO.empNo }</td>
							<td class="text-center" style="background-color: #fdfcfb">계약 종료일</td>
							<td>${empVO.deptNm }</td>
							<td class="text-center" style="background-color: #fdfcfb">계약 기간</td>
							<td>${empVO.teamNm }</td>
							<td class="text-center" style="background-color: #fdfcfb">남은 기간</td>
							<td>${empVO.jbgdNm }</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="row g-5 g-xxl-8 d-flex">
		<div class="d-flex justify-content-end pb-10">
			<div class="align-items-center">
				<a href="#" class="btn btn-flex btn-light-success" data-bs-toggle="modal" data-bs-target="#kt_modal_modify_user">
				<i class="ki-duotone ki-abstract-8 text-success">
				<span class="path1"></span>
				<span class="path2"></span></i>
				수정</a>
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
				<form id="kt_modal_modify_user_form" class="form" action="/empinformation/empinfomodify.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="empId" value="${empVO.empId }" />
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
							<input type="text" name="empJncmpYmd" id="empJncmpYmd" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="입사을 입력해주세요" value="${fn:substring(empVO.empJncmpYmd, 0, 10)}" readonly="readonly"/>
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
							<input type="text" name="empNo" id="empNo" class="form-control form-control-solid mb-3 mb-lg-0" placeholder="사번을 입력해주세요" value="${empVO.empNo }" readonly="readonly"/>
						</div>
						<div class="fv-row mb-7">
                            <label class="required fw-semibold fs-6 mb-2">소속 부서</label>
                            <select name="deptCd" id="deptSelect" class="form-control form-control-solid mb-3 mb-lg-0">
                                <option value="${empVO.deptCd }">${empVO.deptNm }</option>
<%--                                 <c:forEach var="dept" items="${deptList}"> --%>
<%--                                 	<c:if test="${dept.deptCd != empVO.deptCd}"> --%>
<%-- 	                                    <option value="${dept.deptCd}">${dept.deptNm}</option> --%>
<%-- 							        </c:if> --%>
<%--                                 </c:forEach> --%>
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
<%-- 							    <c:forEach var="jbgd" items="${jbgdList}"> --%>
<%-- 							        <c:if test="${jbgd.jbgdCd != empVO.jbgdCd}"> --%>
<%-- 							            <option value="${jbgd.jbgdCd}">${jbgd.jbgdNm}</option> --%>
<%-- 							        </c:if> --%>
<%-- 							    </c:forEach> --%>
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

</script>
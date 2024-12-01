<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div style="margin-bottom: 25px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>인사·정보 관리</h3>
		<h6>부서 관리</h6>
	</div>
</div>
<input type="hidden" id="empCoCd" value="${employeeVO.coCd }"/>
<div id="kt_app_content_container">
	<div class="app-main flex-column flex-row-fluid">
		<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
			<div class="d-flex flex-column flex-column-fluid">
				<div id="kt_app_content" class="app-content flex-column-fluid">
					<div id="kt_app_content_container" class="app-container container-fluid">
						<div class="card">
							<div class="card-header border-0 pt-6">
								<div class="card-title">
								</div>
								<div class="card-toolbar">
									<div class="d-flex justify-content-end" data-kt-user-table-toolbar="base">
										<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#kt_modal_add_dept">
										<i class="ki-duotone ki-plus fs-2"></i>부서 추가</button>
									</div>
								</div>
							</div>
							<div class="card-body py-4">
								<div class="row gx-5 gx-xl-10">
								<c:choose>
									<c:when test="${empty deptAllList}">
										<div class="d-flex flex-column flex-center my-10">
						                    <img src="/resources/file/image/cloudEmpty.png" class="mw-300px">
						                    <div class="fs-1 fw-bolder text-dark">등록된 부서가  없습니다.</div>
		              				 	</div>
									</c:when>
								<c:otherwise>
									<c:forEach items="${deptAllList }" var="dept">
										<div class="col-12 col-xl-4 mb-10">
											<div class="card card-flush">
												<div class="card-header rounded bgi-no-repeat bgi-size-cover bgi-position-y-top bgi-position-x-center align-items-start h-200px" style="background-image:url('/upload/${dept.deptImgFileUrl}'); position: relative;" data-bs-theme="light">
													<h1 class="align-items-start fw-bold text-white pt-15">
													    <span class="fw-bold fs-2x mb-3 deptNm">${dept.deptNm}</span>
													</h1>
													<div class="card-toolbar pt-5">
														<button class="btn btn-sm btn-icon btn-active-color-primary btn-color-white bg-white bg-opacity-25 bg-hover-opacity-100 bg-hover-white bg-active-opacity-25 w-20px h-20px" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end" data-kt-menu-overflow="true" data-dept-modify="${dept.deptCd }">
															<i class="ki-duotone ki-dots-square fs-4">
																<span class="path1"></span>
																<span class="path2"></span>
																<span class="path3"></span>
																<span class="path4"></span>
															</i>
														</button>
														<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg-light-primary fw-semibold w-200px pb-3" data-kt-menu="true">
															<div class="menu-item px-3">
																<div class="menu-content fs-6 text-gray-900 fw-bold px-3 py-4">부서 편집</div>
															</div>
															<div class="separator mb-3 opacity-75"></div>
															<div class="menu-item px-3" data-kt-menu-trigger="hover" data-kt-menu-placement="right-start">
																<a href="#" class="menu-link px-3">
																	<span class="menu-title">부서 수정</span>
																	<span class="menu-arrow"></span>
																</a>
																<div class="menu-sub menu-sub-dropdown w-175px py-4">
																	<div class="menu-item px-3">
																		<div class="text-gray-700 menu-link px-3" style="cursor: pointer;" data-modify-deptNm="${dept.deptCd }">부서명 수정</div>
																	</div>
																	<div class="menu-item px-3">
																		<div class="text-gray-700 menu-link px-3" style="cursor: pointer;" data-delyn-deptCd="${dept.deptCd }">부서 삭제</div>
																	</div>
																</div>
															</div>
															<div class="menu-item px-3">
																<div class="text-gray-700 menu-link px-3" style="cursor: pointer;" data-insert-teamCd="${dept.deptCd }">팀 생성</div>
															</div>
															<div class="menu-item px-3">
																<div class="text-gray-700 menu-link px-3" style="cursor: pointer;" data-modify-menu="${dept.deptCd}">부서 기능 편집</div>
															</div>
														</div>
													</div>
												</div>
												<div class="card-body mt-n20">
													<div class="mt-n20 position-relative">
														<div class="row g-3 g-lg-3">
														<c:forEach items="${dept.teamVO }" var="team">
															<div class="bg-gray-100 bg-opacity-70 rounded-2 px-6 py-5 col-12" style="background-color: #f6f1e9">
															    <div class="col-12 d-flex justify-content-between align-items-center">
															        <div class="pt-5 d-flex col-xl-9">
															            <i class="ki-duotone ki-abstract-35 fs-2 py-1 px-1 text-success">
															                <span class="path1"></span>
															                <span class="path2"></span>
															            </i>
															            <a href="/information/teamdetail.do?teamCd=${team.teamCd }">
															            <span class="text-gray-700 fw-bolder d-block fs-2qx lh-1 ls-n1 mb-1">${team.teamNm}</span>
															            </a>
															        </div>
															    </div>
															    <span class="text-gray-500 fw-semibold fs-6">생성일 : ${team.teamCrtDt}</span>
															</div>
														</c:forEach>
														</div>
													</div>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:otherwise>
								</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 부서명 수정 모달 -->
<div class="modal fade" id="modalEditDept" tabindex="-1" aria-labelledby="modalEditDeptLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content modal-rounded">
            <div class="modal-header py-7 d-flex justify-content-between">
                <h5 class="modal-title" id="modalEditDeptLabel">부서명 수정하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="text" id="deptNameInput" class="form-control" placeholder="부서명 수정하기"/>
                <input type="hidden" id="deptCodeInput" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="saveDeptBtn">저장</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- 부서명 수정 모달 -->
<div class="modal fade" id="modalInsertTeam" tabindex="-1" aria-labelledby="modalInsertTeamLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content modal-rounded">
            <div class="modal-header py-7 d-flex justify-content-between">
                <h5 class="modal-title" id="modalInsertTeamLabel">팀 생성</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="text" id="teamNmInput" class="form-control" placeholder="팀명 입력" />
                <input type="hidden" id="deptCdInput" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="insertTeamBtn">생성</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>


<!-- 부서 추가 모달 -->
<div class="modal-content modal-rounded">
	<div class="modal fade" id="kt_modal_add_dept" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen p-9">
			<div class="modal-content modal-rounded">
				<div class="modal-header py-7 d-flex justify-content-between">
					<h2>부서 추가</h2>
					<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
						<i class="ki-duotone ki-cross fs-1">
							<span class="path1"></span>
							<span class="path2"></span>
						</i>
					</div>
				</div>
				<div class="modal-body scroll-y">
					<div class="stepper stepper-links d-flex flex-column" id="kt_modal_create_campaign_stepper">
						<div class="stepper-nav justify-content-center py-2">
							<div class="stepper-item me-5 me-md-15 current" data-kt-stepper-element="nav">
								<h3 class="stepper-title">부서명</h3>
							</div>
							<div class="stepper-item me-5 me-md-15" data-kt-stepper-element="nav">
								<h3 class="stepper-title">사용할 기능</h3>
							</div>
							<div class="stepper-item me-5 me-md-15" data-kt-stepper-element="nav">
								<h3 class="stepper-title">팀 생성</h3>
							</div>
							<div class="stepper-item me-5 me-md-15" data-kt-stepper-element="nav">
								<h3 class="stepper-title">최종 확인</h3>
							</div>
						</div>
						<form class="mx-auto w-100 mw-600px pt-5 pb-10" novalidate="novalidate" id="kt_modal_create_campaign_stepper_form" action="/information/deptinsert.do" method="post" enctype="multipart/form-data">
							<div class="current" data-kt-stepper-element="content">
								<div class="w-100 pt-10">
									<div class="mb-10 fv-row">
										<input type="text" class="form-control form-control-lg form-control-solid" name="deptNm" placeholder="부서명을 입력해주세요" id="deptNmInput" value="영업부"/>
										<span id="deptNm_chk" style="color: green;"></span>
									</div>
									<div class="fv-row d-flex flex-column align-items-center justify-content-center">
										<label class="d-block fw-semibold fs-6 mb-5">
											<span>부서 이미지</span>
											<span class="ms-1" data-bs-toggle="tooltip" title="그루베어에서 사용할 부서 이미지를 추가해보세요!">
												<i class="ki-duotone ki-information-5 text-gray-500 fs-6">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
												</i>
											</span>
										</label>
										<style>.image-input-placeholder { background-image: url('/upload/nodeptimg.jpg'); } [data-bs-theme="dark"] .image-input-placeholder { background-image: url('assets/media/svg/files/blank-image-dark.svg'); }</style>
										<div class="image-input image-input-empty image-input-outline image-input-placeholder" data-kt-image-input="true">
											<div class="image-input-wrapper w-125px h-125px"></div>
											<label class="btn btn-icon btn-circle btn-active-color-primary w-25px h-25px bg-body shadow" data-kt-image-input-action="change" data-bs-toggle="tooltip" title="부서 이미지 추가">
												<i class="ki-duotone ki-pencil fs-7">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
												<input type="file" name="deptImgFile" accept=".png, .jpg, .jpeg" />
											</label>
										</div>
										<div class="form-text">지원하는 확장자 : png, jpg, jpeg.</div>
									</div>
								</div>
							</div>
							<div data-kt-stepper-element="content">
								<div class="row justify-content-center">
									<div class="row pb-6 text-center">
										<div>
											<i class="ki-duotone ki-award fs-3x text-success">
											<span class="path1"></span>
											<span class="path2"></span>
											<span class="path3"></span>
											</i>
										</div>
										<h1 class="fw-bold text-gray-700">고객님은 
										<c:choose>
										    <c:when test="${contractVO.premiumYn == 'Y'}">
												프리미엄
										    </c:when>
										    <c:otherwise>
												베이직
										    </c:otherwise>
										</c:choose>
										회원이십니다!</h1>
									</div>
									<div class="image-input image-input-empty image-input-outline">
								        <div class="image-input-wrapper w-auto h-auto px-5">
									        <div class="pb-10 pb-lg-5 text-center pt-3">
												<div class="row card card-header text-white fw-semibold fs-4 pt-4" style="background-color: #2d2736" id="deptNmDisplay"></div>
											</div>
									        <div class="row col-12 pl-5">
												<div class="col-12 col-xl-5 py-3">
													<div class="mh-300px scroll-y me-n7 pe-7">
													    <div class="d-flex flex-column py-4" id="menuChk"> 
													        <c:forEach items="${menuList}" var="menu">
												            
												            <div class="mb-3" data-menu-no="${menu.menuNo }">
										                    	<div class="d-flex justify-content-between px-3">
										                    		<div class="d-flex align-items-center">
													                    <div class="row symbol symbol-35px me-2">
													                        <span>
													                       		${menu.menuIcon }
													                        </span>
													                    </div>
												                        <div class="fw-bold text-gray-800">${menu.menuNm }</div>
										                    		</div>
											                        <div class="text-gray-600">
											                        <i class="ki-duotone ki-plus fs-2" data-menu-no="${menu.menuNo }" style="cursor: pointer;"></i>
											                        </div>
										                    	</div>
												            </div>
													        </c:forEach>
													    </div>
													</div>
												</div>
			 									<div class="col-12 col-xl-2 px-5">
													<div class="symbol-label d-flex justify-content-center align-items-center" style="flex-grow: 1; height: 100%;">
												        <img src="/upload/arrow_forward_ios_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png" style="width: auto; height: 50px;">
												    </div>
												</div>
												<div class="col-12 col-xl-5 py-3">
													<div class="mh-300px scroll-y me-n7">
													    <div class="col-12 d-flex flex-column py-4" id="moveData">
													    </div>
													</div>
												</div>
									        </div>
								        </div>
							        </div>
								</div>
							</div>
							<div data-kt-stepper-element="content">
								<div class="w-100">
									<div class="text-center">
									<h1 class="fw-bold text-gray-700">팀 생성</h1>
									<div class="text-muted fw-semibold fs-4 justify-content-center align-items-center">부서에서 가용할 팀을 생성하세요!</div>
										<div class="d-flex justify-content-center align-items-center">
											<div class="col-7 mb-10 align-middle pt-5">
												<div class="card card-flush h-xl-100">
													<div class="card-header rounded bgi-no-repeat bgi-size-cover bgi-position-y-top bgi-position-x-center align-items-start h-200px" style="background-image:url('/upload/nodeptimg.jpg'); position: relative;" data-bs-theme="light">
														<h1 class="align-items-center fw-bold text-white pt-15">
														    <span class="fw-bold fs-2x mb-3" id="deptNmDisplay2"></span>
														</h1>
													</div>
													<div class="card-body mt-n20">
														<div class="mt-n20 position-relative">
															<div class="row g-3 g-lg-3">
																<div class="col-12 d-flex flex-wrap justify-content-center align-items-center" id="addTeamCard">
																	<div class="col-12" style="padding : 15px;">
																		<div class="bg-gray-100 bg-opacity-70 rounded-2 px-6 py-6 d-flex">
																			<input type="text" class="form-control form-control-lg form-control-solid text-center" value="영업 팀" placeholder="팀명 입력" id="teamNameInput">
																			<div class="m-0">
																				<span class="text-gray-700 fw-bolder d-block fs-2qx lh-1 ls-n1 mb-1"></span>
																				<span class="text-gray-500 fw-semibold fs-6"></span>
																			</div>
																			<i class="ki-duotone ki-plus fs-2 pt-4" id="plusTeam" style="cursor: pointer;"></i>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div data-kt-stepper-element="content">
								<div class="w-100">
									<div class="pb-12 text-center">
										<h1 class="fw-bold text-gray-700">생성하려는 부서가 맞습니까?</h1>
									</div>
							        <div class="row col-12">
										<div class="col-12 col-xl-7 py-3">
								       		<div class="image-input image-input-empty image-input-outline">
									       		<div class="image-input-wrapper w-auto h-auto px-5 py-3">
													<div class="card card-flush h-xl-100">
														<div class="card-header rounded bgi-no-repeat bgi-size-cover bgi-position-y-top bgi-position-x-center align-items-start h-200px" style="background-image:url('/upload/nodeptimg.jpg'); position: relative;" data-bs-theme="light">
															<h1 class="align-items-center fw-bold text-white pt-15">
															    <span class="fw-bold fs-2x mb-3" id="deptNmDisplay3"></span>
															</h1>
														</div>
														<div class="card-body mt-n15">
															<div class="mt-n20 position-relative">
																<div class="row g-3 g-lg-3">
																	<div class="col-12 d-flex flex-wrap justify-content-center align-items-center" id="addTeamCard2">
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-12 col-xl-1">
										</div>
										<div class="col-12 col-xl-4 py-3 px-0 d-flex justify-content-center">
											<div class="image-input image-input-empty image-input-outline">
							       				<div class="image-input-wrapper w-auto h-auto px-5">
													<div class="pb-10 pb-lg-5 text-center pt-3">
														<div class="row card card-header text-white fw-semibold fs-4 pt-4" style="background-color: #2d2736" id="deptNmDisplay">기능</div>
													</div>
													<div class="mh-300px scroll-y">
													    <div class="col-12 d-flex flex-column py-4" id="moveData2">
										               	</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="d-flex flex-stack pt-10">
								<div class="me-2">
									<button type="button" class="btn btn-lg btn-light-primary me-3" data-kt-stepper-action="previous" data-kt-stepper-state="hide-on-last-step">
<!-- 									<i class="ki-duotone ki-arrow-left fs-3 me-1"> -->
<!-- 										<span class="path1"></span> -->
<!-- 										<span class="path2"></span> -->
<!-- 									</i> -->
									이전</button>
								</div>
								<div>
									<button type="button" class="btn btn-lg btn-primary" data-kt-stepper-action="submit">
										<span class="indicator-label">부서 생성하기</span>
										<span class="indicator-progress">잠시만 기다려주세요!</span>
										<span class="spinner-border spinner-border-sm align-middle ms-2"></span>
									</button>
									<button type="button" class="btn btn-lg btn-primary" data-kt-stepper-action="next">다음 
<!-- 									    <i class="ki-duotone ki-arrow-right fs-3 me-1"> -->
<!-- 									        <span class="path1"></span> -->
<!-- 									        <span class="path2"></span> -->
<!-- 									    </i> -->
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$(function() {
    let currentStep = 1; // 현재 단계
    const totalSteps = 4; // 총 단계 수
	var addTeamCard = $("#addTeamCard");
	var addTeamCard2 = $("#addTeamCard2");
	var html = "";
	var menuChk = $("#menuChk");
	var moveData = $("#moveData");
	var moveData2 = $("#moveData2");
	var teamNameInput = $("#teamNameInput");
	var plusTeam = $("#plusTeam");
	var deptNmInput = $("#deptNmInput");
	
	var myDeptNm = "";
	var myMenu = [];
	var myTeam = [];
	
    
	deptNmInput.keyup(function() {
	    var deptNmChk = deptNmInput.val();
	    var coCd = $("#empCoCd").val();
	    console.log("deptNmChk : " + deptNmChk);
	    console.log("coCd : " + coCd);

	    $.ajax({
	        url: '/information/deptnmchk.do',
	        type: 'POST',
	        contentType: 'application/json; charset=UTF-8',
	        data: JSON.stringify({ 
	            deptNm: deptNmChk,
	            coCd: coCd
	        }),
	        success: function (res) {
	        	if (res == "success") {
		            $("#deptNm_chk").text("사용 가능한 부서명입니다.");
				}
	        },
	        error: function (xhr, status, error) {
	            $("#deptNm_chk").text("중복된 부서명입니다.");
	            $("#deptNm_chk").css("color", "red");
	            console.error('Error:', error);
	        }
	    });
	});
	
	
	$('[data-insert-teamCd]').on('click', function () {
		var deptCode = $(this).attr('data-insert-teamCd'); // .data() 대신 .attr() 사용
	    console.log('Dept Code:' +  deptCode);
	    
        $('#deptCdInput').val(deptCode);

        // 모달 열기
        $('#modalInsertTeam').modal('show');
    });
	
    // 팀 생성 버튼 클릭 이벤트
    $('#insertTeamBtn').on('click', function () {
        var teamNm = $('#teamNmInput').val();
        var deptCd = $('#deptCdInput').val();
        
	    console.log("teamNmInput:" + teamNm);
        console.log("deptCode : " + deptCd);
        

        // AJAX 요청으로 부서명 수정
		$.ajax({
			url: '/information/insertteam.do', // API 엔드포인트
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({ 
				deptCd: deptCd,
				teamNm: teamNm 
			}),
			success: function (data) {
			// 성공적으로 수정된 경우
				if (data) {
					if (data == "success") {
						Swal.fire({
							icon: 'success',
							title: '팀 생성 완료!',
							confirmButtonColor: '#4FC9DA',
							confirmButtonText: '확인',
						}).then((result) => {
						if (result.isConfirmed) {
							location.reload();
							}
						});
					} else {
						Swal.fire({
						icon: 'warning',
						title: '팀 생성에 실패했습니다',
						confirmButtonColor: '#4FC9DA',
						});
					}
				}
			},
			error: function (xhr, status, error) {
			console.error('Error:', error);
			alert('팀 생성중 오류가 발생했습니다.');
			}
		});
    });
	
    $(document).on('click', '[data-modify-deptNm]', function () {
        var deptCode = $(this).attr('data-modify-deptNm'); // .data() 대신 .attr() 사용
        console.log('deptCode: ' + deptCode);
        
        // 부서명이 포함된 요소를 찾기
        var deptName = $(this).closest('.card').find('.deptNm').text().trim();
        console.log('deptName: ' + deptName);
        
        // 모달의 인풋에 부서명과 부서코드 세팅
        $('#deptNameInput').val(deptName);
        $('#deptCodeInput').val(deptCode);

        // 모달 열기
        $('#modalEditDept').modal('show');
    });
	
	$('[data-delyn-deptCd]').on('click', function () {
		var deptCode = $(this).attr('data-delyn-deptCd'); // .data() 대신 .attr() 사용
	    console.log('Dept Code:', deptCode);
	    Swal.fire({
			title: '정말 부서를 삭제하시겠습니까?',
			text: '해당하는 부서의 사원 정보가 사라집니다',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#4FC9DA',
			cancelButtonColor: '#F06445',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false,
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
		            url: '/information/deldept.do', // API 엔드포인트
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify({ 
		            	deptCd: deptCode, 
		            	}),
		            success: function (data) {
		                // 성공적으로 수정된 경우
		                if (data) {
		                	if (data == "success") {
			                	Swal.fire({
									icon: 'success',
									title: '부서 삭제 완료!',
									confirmButtonColor: '#4FC9DA',
									confirmButtonText: '확인',
							    }).then((result) => {
									if (result.isConfirmed) {
										location.reload();
									}
								});
							}else {
			                	Swal.fire({
									icon: 'warning',
									title: '부서명 삭제에 실패했습니다',
									confirmButtonColor: '#4FC9DA',
							    });
							}
		                }
		            },
		            error: function (xhr, status, error) {
		                console.error('Error:', error);
		                alert('부서명 수정 중 오류가 발생했습니다.');
		            }
		        });
			}
		});
    });

    
    $('#saveDeptBtn').on('click', function () {
        var newDeptName = $('#deptNameInput').val();
        var deptCode = $('#deptCodeInput').val();
        
        console.log("newDeptName : " + newDeptName);
        console.log("deptCode : " + deptCode);
        

        // AJAX 요청으로 부서명 수정
		$.ajax({
			url: '/information/modifydeptnm.do', // API 엔드포인트
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({ 
				deptCd: deptCode, 
				deptNm: newDeptName 
			}),
			success: function (data) {
			// 성공적으로 수정된 경우
				if (data) {
					if (data == "success") {
						Swal.fire({
							icon: 'success',
							title: '부서명 수정 완료!',
							confirmButtonColor: '#4FC9DA',
							confirmButtonText: '확인',
						}).then((result) => {
						if (result.isConfirmed) {
							location.reload();
							}
						});
					} else {
						Swal.fire({
						icon: 'warning',
						title: '부서명 수정에 실패했습니다',
						confirmButtonColor: '#4FC9DA',
						});
					}
				}
			},
			error: function (xhr, status, error) {
			console.error('Error:', error);
			alert('부서명 수정 중 오류가 발생했습니다.');
			}
		});
    });
	
	deptNmInput.on("keydown", function (event) { // event 매개변수 추가
    	myDeptNm = deptNmInput.val().trim();
	});
	
// 	teamNameInput.on("keydown", function (event) { // event 매개변수 추가
// 	    if (event.key === "Enter") {
// 	    	let teamName = teamNameInput.val().trim();
// 	    	console.log("teamName : " + teamName);
// 	    	if (teamName !== null && teamName !== "") {
// 		        let teamNm = $(this).val();
// 				if (!myTeam.includes(teamNm)) {
// 					myTeam.push(teamNm);
// 			        addCard(teamName);
// 				} else {
// 					Swal.fire({
// 					      icon: 'warning',
// 					      title: '중복된 팀이 존재합니다!',
// 					      confirmButtonColor: '#4FC9DA',
// 					    });
// 				}
// 			} else {
// 				Swal.fire({
// 				      icon: 'warning',
// 				      title: '팀 명을 입력해주세요!',
// 				      confirmButtonColor: '#4FC9DA',
// 				    });
// 			}
// 		    teamNameInput.val("");
// 	    };
	
// 	});
	
	plusTeam.on("click", function () {
		
		let teamName = teamNameInput.val().trim();
    	console.log("teamName : " + teamName);
    	console.log("myTeam 푸쉬 전 : " + myTeam);
    	if (teamName !== null && teamName !== "") {
	        let teamNm = $(this).val();
			if (!myTeam.includes(teamName)) {
				myTeam.push(teamName);
				
		    	console.log("myTeam 푸쉬 후 : " + myTeam);
		        addCard(teamName);
		        addCard2(teamName);
			} else {
				Swal.fire({
				      icon: 'warning',
				      title: '중복된 팀이 존재합니다!',
				      confirmButtonColor: '#4FC9DA',
				    });
			}
		} else {
			Swal.fire({
			      icon: 'warning',
			      title: '팀 명을 입력해주세요!',
			      confirmButtonColor: '#4FC9DA',
			    });
		}
	    teamNameInput.val("");
	})
	
	menuChk.on("click", ".ki-plus", function () {
		let menuNo = $(this).data("menu-no");
		console.log("menuNo : " +  menuNo);
		
		
		if (!myMenu.includes(menuNo)) {
			myMenu.push(menuNo);
		}
		
		$("#menuChk div[data-menu-no='" + menuNo + "']").remove();
		
		$.ajax({
				url: '/information/getmenu.do',
				type: 'GET',
				data: { 
				menuNo : menuNo
				},
				contentType: 'application/json; charset=UTF-8',
				success: function(menu) {
               	let html = `
               		<div class="mb-3" data-menu-no="\${menu.menuNo }">
                    	<div class="d-flex justify-content-between px-3">
                    		<div class="d-flex align-items-center">
			                    <div class="row symbol symbol-35px me-2">
			                        <span>
			                       		\${menu.menuIcon }
			                        </span>
			                    </div>
		                        <div class="fw-bold text-gray-800">\${menu.menuNm }</div>
                    		</div>
	                        <div class="text-gray-600">
	                        <i class='ki-duotone ki-trash fs-3 remove-menu' data-menu-no='\${menu.menuNo}' style='cursor: pointer; color: #gray;'>
	                        <span class='path1'></span>
	                        <span class='path2'></span>
	                        <span class='path3'></span>
	                        <span class='path4'></span>
	                        <span class='path5'></span>
	                        </i>
	                        </div>
                    	</div>
			            <input type="hidden" name="menuNum" value="\${menu.menuNo }">
		            </div>
               	`;
               	let html2 = `
               		<div class="mb-3" data-menu-no="\${menu.menuNo }">
	                	<div class="d-flex justify-content-between px-3">
	                		<div class="d-flex align-items-center">
			                    <div class="row symbol symbol-35px me-2">
			                        <span>
			                       		\${menu.menuIcon }
			                        </span>
			                    </div>
		                        <div class="fw-bold text-gray-800">\${menu.menuNm }</div>
	                		</div>
	                	</div>
		            </div>
               	`;
               	moveData.append(html);
               	moveData2.append(html2);
               },
               error: function(jqXHR, textStatus, errorThrown) {
                   console.error("AJAX 요청 실패:", textStatus, errorThrown);
               }
		});
	});
	
	
	function addCard(teamNm) {
	    let teamName = teamNm;
	    console.log("addCard 추가중 : " + teamName);
	    
	    let html = `
	    	<div class="col-12" style="padding : 15px;" data-team-nm="\${teamName}">
	    		<input type="hidden" name="teamName" value="\${teamName }">
				<div class="bg-gray-100 bg-opacity-70 rounded-2 px-6 py-6 d-flex">
					<input type="text" class="form-control form-control-lg form-control-solid text-center" value="\${teamName }" readonly="readonly" style="background-color : #f6f1e9">
					<div class="m-0">
						<span class="text-gray-700 fw-bolder d-block fs-2qx lh-1 ls-n1 mb-1"></span>
						<span class="text-gray-500 fw-semibold fs-6"></span>
					</div>
					<div class="btn btn-sm btn-icon btn-active-color-primary pt-4 remove-card-btn" data-nm="\${teamName}">
					<i class="ki-duotone ki-cross fs-1">
						<span class="path1"></span>
						<span class="path2"></span>
					</i>
					</div>
				</div>
			</div>
	    	`;
	    
	    addTeamCard.append(html);
	    html = "";
	}
	function addCard2(teamNm) {
	    let teamName = teamNm;
	    console.log("addCard 추가중 : " + teamName);
	    
	    let html = `
	    	<div class="col-12" style="padding : 5px;" data-team-nm="\${teamName}">
				<div class="bg-gray-100 bg-opacity-70 rounded-2 px-6 py-6 d-flex">
					<input type="text" class="form-control form-control-lg form-control-solid text-center" value="\${teamName }" readonly="readonly" style="background-color : #f6f1e9">
					<div class="m-0">
						<span class="text-gray-700 fw-bolder d-block fs-2qx lh-1 ls-n1 mb-1"></span>
						<span class="text-gray-500 fw-semibold fs-6"></span>
					</div>
				</div>
			</div>
	    	`;
	    
	    addTeamCard2.append(html);
	    html = "";
	}
	$(document).on("click", ".remove-card-btn", function () {
		let teamNm = $(this).data('nm');
		console.log("카드 지우기에서 팀네임 : " + String(teamNm));
		myTeam = myTeam.filter(value => value !== String(teamNm));
		console.log("배열 지워졌냐 : " + myTeam);
		$("#addTeamCard div[data-team-nm='" + teamNm + "']").remove();
		$("#addTeamCard2 div[data-team-nm='" + teamNm + "']").remove();
	});
    
	$(document).on("click", ".remove-menu", function () {
		let menuNo = $(this).data('menu-no');
		console.log("리무브 눌리는 중!");
		console.log("menuNo : " + menuNo);
		$("#moveData div[data-menu-no='" + menuNo +"']").remove();
		$("#moveData2 div[data-menu-no='" + menuNo +"']").remove();
		
		myMenu = myMenu.filter(value => value !== menuNo);
		
		console.log(myMenu);
		$.ajax({
			url: '/information/getmenu.do',
            type: 'GET',
            data: { 
            	menuNo : menuNo
            	},
            contentType: 'application/json; charset=UTF-8',
            success: function(menu) {
            	let html = `
            		<div class="mb-3" data-menu-no="\${menu.menuNo }">
	                	<div class="d-flex justify-content-between px-3">
	                		<div class="d-flex align-items-center">
			                    <div class="row symbol symbol-35px me-2">
			                        <span>
			                       		\${menu.menuIcon }
			                        </span>
			                    </div>
		                        <div class="fw-bold text-gray-800">\${menu.menuNm }</div>
	                		</div>
	                        <div class="text-gray-600">
	                        <i class="ki-duotone ki-plus fs-2" data-menu-no="\${menu.menuNo }" style="cursor: pointer;"></i>
	                        </div>
	                	</div>
		            </div>
            	`;
            	menuChk.append(html);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("AJAX 요청 실패:", textStatus, errorThrown);
            }
		});
		
	});
    
    // "Continue" 버튼 클릭 이벤트
    $('[data-kt-stepper-action="next"]').on("click", function() {
       	myDeptNm = deptNmInput.val().trim();
        if (currentStep < totalSteps) {
        	if (currentStep == 1) {
	        	if (myDeptNm !== "") {
		            if ($("#deptNm_chk").text() == "중복된 부서명입니다.") {
		            	Swal.fire({
						      icon: 'warning',
						      title: '중복된 부서명입니다',
						      confirmButtonColor: '#4FC9DA',
						    });
		            	$("#deptNm_chk").text("다시 입력해주세요!");
		            	$("#deptNmInput").val("");
					}else {
						$("#deptNmDisplay").text(myDeptNm + " 내에서 사용할 기능을 추가하세요.");
						$("#deptNmDisplay2").text(myDeptNm);
						$("#deptNmDisplay3").text(myDeptNm);
			            currentStep++;
						console.log(currentStep);
			            updateStep();
			            return;
					}
				} else {
					Swal.fire({
				      icon: 'warning',
				      title: '부서명을 입력해주세요!',
				      confirmButtonColor: '#4FC9DA',
				    });
				};
			};
        	if (currentStep == 2) {
	        	if (myMenu.length !== 0) {
		            currentStep++;
					console.log(currentStep);
		            updateStep();
		            return;
				} else {
					Swal.fire({
				      icon: 'warning',
				      title: '기능을 추가해주세요!',
				      confirmButtonColor: '#4FC9DA',
				    });
				};
			};
        	if (currentStep == 3) {
	        	if (myTeam.length !== 0) {
		            currentStep++;
					console.log(currentStep);
					console.log(myDeptNm);
					console.log(myMenu);
					console.log(myTeam);
		            updateStep();
		            return;
				} else {
					Swal.fire({
				      icon: 'warning',
				      title: '팀을 추가해주세요!',
				      confirmButtonColor: '#4FC9DA',
				    });
				};
			};
        } else {
        	if (currentStep == 4) {
	        	console.log("서밋실행됨!");
				$("#kt_modal_create_campaign_stepper_form").submit();
			};
		}
    });

    // "Back" 버튼 클릭 이벤트
    $('[data-kt-stepper-action="previous"]').on("click", function() {
        if (currentStep > 1) {
        	if (currentStep == 2) {
        		deptNmInput.val("");
				myDeptNm = "";
	            currentStep--;
	            updateStep();
			} else {
	            currentStep--;
	            updateStep();
			}
        }
    });
    
    // 단계 업데이트 함수
    function updateStep() {
        // 모든 단계 숨기기
        $('[data-kt-stepper-element="content"]').each(function(index) {
            $(this).removeClass('current');
            $(this).css('display', (index + 1 === currentStep) ? 'block' : 'none');
        });

        // 현재 단계의 nav 항목 활성화
        $('.stepper-item').each(function(index) {
            $(this).toggleClass('current', index + 1 === currentStep);
        });

        // 이전 버튼의 가시성 설정
        const prevButton = $('[data-kt-stepper-action="previous"]');
        if (prevButton.length) {
            prevButton.css('display', (currentStep === 1) ? 'none' : 'inline-block');
        }
        
        const nextButton = $('[data-kt-stepper-action="next"]');
        if (nextButton.length) {
            nextButton.text((currentStep === totalSteps) ? '생성하기' : '다음');
        }
    }

    // 초기 단계 표시
    updateStep();
    
});

</script>

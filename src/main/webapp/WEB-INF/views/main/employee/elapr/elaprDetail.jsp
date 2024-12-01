<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- ckeditor API -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script> 

<!-- sweetalert2 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- jstree -->
<link href="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.js"></script>

<style>
   .cke_notifications_area { display: none; }
   .highlight-blue {
   		background-color: #e9f5f6;
   		border-left: 5px solid #00a1b9;
   		height: 120px;  
   		width: 330px;
   		}
</style>

<div style="margin-bottom: 50px;">
   <div style="margin-top: -32px;">
      <div class="separator border-2 my-10"></div>
   </div>
   <div style="margin-left: 30px; margin-top: -100px;">
      <h3>전자결재</h3> 
      <h6>전자결재</h6>
   </div>
</div>


<c:set var="firstApln001" value="false"/>


<c:set value="결재" var="stts"/>
<c:if test="${status eq 'statusWating' }">
	<c:set value="대기" var="stts"/>
</c:if>
<c:if test="${status eq 'statusDraft' }">
	<c:set value="기안" var="stts"/>
</c:if>
<c:if test="${status eq 'statusRernc' }">
	<c:set value="참조" var="stts"/>
</c:if>
<c:if test="${status eq 'statusPrsl' }">
	<c:set value="열람" var="stts"/>
</c:if>

<c:if test="${status eq 'statusAll' }">
	<c:set value="전체" var="stts"/>
</c:if>
<c:if test="${status eq 'statusProgress' }">
	<c:set value="진행" var="stts"/>
</c:if>
<c:if test="${status eq 'statusComplete' }">
	<c:set value="완료" var="stts"/>
</c:if>
<c:if test="${status eq 'statusRjct' }">
	<c:set value="반려" var="stts"/>
</c:if>
<c:if test="${status eq 'statusEmrg' }">
	<c:set value="긴급" var="stts"/>
</c:if>

<c:if test="${status eq 'statusMyAll' }">
	<c:set value="전체" var="stts"/>
</c:if>
<c:if test="${status eq 'statusMyProgress' }">
	<c:set value="진행" var="stts"/>
</c:if>
<c:if test="${status eq 'statusMyComplete' }">
	<c:set value="완료" var="stts"/>
</c:if>
<c:if test="${status eq 'statusMyRjct' }">
	<c:set value="반려" var="stts"/>
</c:if>
<c:if test="${status eq 'statusMyEmrg' }">
	<c:set value="긴급" var="stts"/>
</c:if>


<c:if test="${status eq 'statusMyAll' }">
	<c:set value="전체" var="stts"/>
</c:if>
<c:if test="${status eq 'statusMyProgress' }">
	<c:set value="진행" var="stts"/>
</c:if>
<c:if test="${status eq 'statusMyComplete' }">
	<c:set value="완료" var="stts"/>
</c:if>
<c:if test="${status eq 'statusMyRjct' }">
	<c:set value="반려" var="stts"/>
</c:if>
<!--begin::Main-->
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<!--begin::Content wrapper-->
	<div class="d-flex flex-column flex-column-fluid">
		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<!--begin::Content container-->
			<div id="kt_app_content_container" class="app-container container-fluid">
				<!--begin::About main-->
				<div class="col-12">
				<div class="d-flex flex-column flex-xl-row">
					<!--begin::Content-->
					<div class="card bg-body me-9 pb-lg-18 col-12 col-xl-8">
						<div class="card-body pb-lg-20">
							<!--전자결재 양식 시작 -->
							<div class="mb-13">
								<!--전자결재 제목 · 양식 제목 시작-->
								<div class="mb-9">
									<h3 class="fs-2qx fw-bold text-gray-900">${elaprVO.elaprNm }</h3>
									<span class="fs-5 fw-semibold text-gray-500">in ${elaprVO.docFormNm }</span>
								</div>
								<!--전자결재 제목 · 양식 제목 종료-->
								
								<c:choose>
									<c:when test="${status eq 'statusWating' }">
										<button type="button" id="" class="btn btn-outline-secondary me-2" data-bs-toggle="modal"  data-bs-target="#reqElapr"><i class="bi bi-pencil-square">결재</i></button>
										<button type="button" id="" class="btn btn-outline-secondary me-2" data-bs-toggle="modal"  data-bs-target="#rjctElapr"><i class="bi bi-arrow-right">반려</i></button>
										<button type="button" id="" class="btn btn-outline-secondary me-2" data-bs-toggle="modal"  data-bs-target="#modal_add_addrBook"><i class="bi bi-person-check">결재정보</i></button>
										<!-- <button type="button" id="" class="btn btn-outline-secondary me-2"><i class="bi bi-person-check">문서수정</i></button> -->
									</c:when>
									<c:when test="${status eq 'statusDraft'} ">
										<c:if test="${isCancelable  }">
											<button type="button" id="" class="btn btn-outline-secondary me-2" data-bs-toggle="modal"  data-bs-target="#cancleModal"><i class="bi bi-x-circle">상신취소</i></button>
										</c:if>
										<button type="button" class="btn btn-outline-secondary me-2" data-bs-toggle="modal" data-bs-target="#modal_add_addrBook"><i class="bi bi-person-check">결재정보</i></button>
									</c:when>
									<c:when test="${status eq 'statusRernc' || status eq 'statusPrsl' || status eq 'statusAll' ||  status eq 'statusProgress' || status eq 'statusComplete' || status eq 'statusRjct' || status eq 'statusEmrg'  
											|| status eq 'statusMyAll' ||  status eq 'statusMyProgress' || status eq 'statusMyComplete' || status eq 'statusMyRjct' || status eq 'statusMyEmrg'}">
										<button type="button" class="btn btn-outline-secondary me-2" data-bs-toggle="modal" data-bs-target="#modal_add_addrBook"><i class="bi bi-person-check">결재정보</i></button>
									</c:when>
									<c:otherwise>
										<c:if test="${isCancelable  }">
											<button type="button" id="" class="btn btn-outline-secondary me-2" data-bs-toggle="modal"  data-bs-target="#cancleModal"><i class="bi bi-x-circle">상신취소</i></button>
										</c:if>
										<button type="button" id="" class="btn btn-outline-secondary me-2" data-bs-toggle="modal"  data-bs-target="#modal_add_addrBook"><i class="bi bi-person-check">결재정보</i></button>
									</c:otherwise>
								</c:choose>
					            
					            
					            <!-- 결재정보 모달 시작 -->
								<div class="modal-content modal-rounded">
								    <div class="modal fade" id="modal_add_addrBook" tabindex="-1" aria-hidden="true">
								        <div class="modal-dialog modal-fullscreen p-9">
								            <div class="modal-content modal-rounded">
								                <div class="row modal-body">
								                    <div class="col-12">
								                        <div class="row">
								                            <div class="col-4">
								                                <div class="card card-flush h-xl-100 d-flex flex-column">
								                                    <div class="card-header border-0 pt-7">
								                                        <h4 class="card-title fw-bold text-gray-800 fs-2">결재자</h4>
								                                    </div>
								                                    <div class="card-body pt-2">
								                                        <c:forEach items="${aplnList}" var="aplnVO">
								                                            <div class="d-flex align-items-center mb-7">
								                                                <div class="symbol symbol-60px symbol-2by3 me-4">
								                                                    <div class="symbol symbol-35px me-3">
								                                                        <img src="/upload/${aplnVO.imgFileUrl}" alt="">
								                                                    </div>
								                                                </div>
								                                                <div class="m-0">
								                                                    <h5>${aplnVO.empNm} ${aplnVO.jbgdNm}</h5>
								                                                    <span class="text-gray-600 fw-semibold d-block pt-1 fs-8">${aplnVO.deptNm}</span>
								                                                    <span class="text-gray-600 fw-semibold d-block pt-1 fs-8">
								                                                        <c:if test="${aplnVO.aplnSttsCd eq 'APLN001'}">결재대기</c:if>
								                                                        <c:if test="${aplnVO.aplnSttsCd eq 'APLN002'}">결재완료</c:if>
								                                                        <c:if test="${aplnVO.aplnSttsCd eq 'APLN003'}">결재반려</c:if>
								                                                    </span>
								                                                </div>
								                                            </div>
								                                        </c:forEach>
								                                    </div>
								                                </div>
								                            </div>
								
								                            <!-- 참조자 리스트 -->
								                            <div class="col-4">
								                                <div class="card card-flush h-xl-100 d-flex flex-column">
								                                    <div class="card-header border-0 pt-7">
								                                        <h4 class="card-title fw-bold text-gray-800 fs-2">참조자</h4>
								                                    </div>
								                                    <div class="card-body pt-2">
								                                        <c:forEach items="${rerncList}" var="rerncVO">
								                                            <div class="d-flex align-items-center mb-7">
								                                                <div class="symbol symbol-60px symbol-2by3 me-4">
								                                                    <div class="symbol symbol-35px me-3">
								                                                        <img src="/upload/${rerncVO.imgFileUrl}" alt="">
								                                                    </div>
								                                                </div>
								                                                <div class="m-0">
								                                                    <h5>${rerncVO.empNm} ${rerncVO.jbgdNm}</h5>
								                                                    <span class="text-gray-600 fw-semibold d-block pt-1 fs-8">${rerncVO.deptNm}</span>
								                                                </div>
								                                            </div>
								                                        </c:forEach>
								                                    </div>
								                                </div>
								                            </div>
								
								                            <!-- 열람자 리스트 -->
								                            <div class="col-4">
								                                <div class="card card-flush h-xl-100 d-flex flex-column">
								                                    <div class="card-header border-0 pt-7">
								                                        <h4 class="card-title fw-bold text-gray-800 fs-2">열람자</h4>
								                                    </div>
								                                    <div class="card-body pt-2">
								                                        <c:forEach items="${prslList}" var="prslVO">
								                                            <div class="d-flex align-items-center mb-7">
								                                                <div class="symbol symbol-60px symbol-2by3 me-4">
								                                                    <div class="symbol symbol-35px me-3">
								                                                        <img src="/upload/${prslVO.imgFileUrl}" alt="">
								                                                    </div>
								                                                </div>
								                                                <div class="m-0">
								                                                    <h5>${prslVO.empNm} ${prslVO.jbgdNm}</h5>
								                                                    <span class="text-gray-600 fw-semibold d-block pt-1 fs-8">${prslVO.deptNm}</span>
								                                                </div>
								                                            </div>
								                                        </c:forEach>
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

								
								<input type="hidden" value="${companyVO.ceoId }" id="ceoIdVal">
								<input type="hidden" value="${companyVO.ceoNm }" id="ceoNmVal">
								
								<input type="hidden" id="aplnList" name="card1List">
								<input type="hidden" id="rerncList" name="card2List">
								<input type="hidden" id="prslList" name="card3List">
					            <!-- 결재정보 모달 종료 -->
					            
					            
					            <!-- 기안 문서 中 상신취소 모달 시작 -->
					            <div class="modal fade" tabindex="-1" id="cancleModal">
					            	<div class="modal-dialog modal-dialog-scrollable">
					            		<div class="modal-content">
					            			<div class="modal-header">
					            				<h5 class="modal-title">상신취소</h5>
					            				<div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
					            					<i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>	
					            				</div>
					            			</div>
											<div class="modal-body" style="min-height: 200px">
											    <div class="mb-10 fv-row row">
											        <label class="required form-label col-4">결재문서명</label>
											        <div class="col-8">
											            ${elaprVO.docFormNm }
											        </div>
											    </div>
											    <div class="mb-10 fv-row row">
											        <label class="required form-label col-4">결재자</label>
											        <div class="col-8">
											            ${elaprVO.empNm }  ${elaprVO.jbgdNm }
											        </div>
											    </div>
											</div>
											<div class="modal-footer">
												<button type="submit" id="cancleBtn" class="btn btn-primary me-2">확인</button>
												<button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
											</div>
										</div>
									</div>
								</div>
								<!-- 기안 문서 中 상신취소 모달 종료 -->
								
								<!-- 결재 대기 中 결재 모달 시작-->
								<div class="modal fade" tabindex="-1" id="reqElapr">
								    <div class="modal-dialog modal-dialog-scrollable">
								        <div class="modal-content">
								            <div class="modal-header">
								                <h5 class="modal-title">결재하기</h5>
								                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
								                    <i class="ki-duotone ki-cross fs-2x"></i>
								                </div>
								            </div>
								            <div class="modal-body" style="min-height: 200px">
								                <!-- Form 시작 -->
								                <form id="approvalForm" action="/employee/elaprWatingUpdate.do" method="post">
								                    <!-- 결재문서명 -->
								                    <div class="mb-10 fv-row">
								                        <label class="required form-label">결재문서명</label>
								                        <input type="hidden" name="elaprNo" value="${elaprVO.elaprNo}">${elaprVO.elaprNm }
								                    </div>
								                    <!-- 결재의견 -->
								                    <div class="mb-10 fv-row">
								                        <label class="required form-label">결재의견</label>
								                        <textarea id="aplnOpninCn" name="aplnOpninCn" class="form-control mb-2"  placeholder="결재 의견을 입력해주세요."></textarea>
								                    </div>
								                </form>
								                <!-- Form 끝 -->
								            </div>
								            <div class="modal-footer">
								                <input type="button" value="승인" id="watingBtn" class="btn btn-primary me-2">
								                <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
								            </div>
								        </div>
								    </div>
								</div>
								<!-- 결재 대기 中 결재 모달 종료 -->
					
								
								<!-- 결재 대기 中 반려 모달 시작-->
								<div class="modal fade" tabindex="-1" id="rjctElapr">
                              		<div class="modal-dialog modal-dialog-scrollable">
                              			<div class="modal-content">
                              				<div class="modal-header">
                              					<h5 class="modal-title">반려하기</h5>
												<div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
													<i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
												</div>
											</div>
											<div class="modal-body" style="min-height: 200px">
												<form id="rjctForm" action="/employee/elaprRjctUpdate.do" method="post">
													<div class="mb-10 fv-row">
														<label class="required form-label">결재문서명</label>
														<input type="hidden" name="elaprNo" value="${elaprVO.elaprNo }">${elaprVO.elaprNm }
													</div>
													<div class="mb-10 fv-row">
														<label class="required form-label">반려결재의견</label>
														<textarea id="aplnOpninCn" name="aplnOpninCn" class="form-control mb-2" placeholder="반려 의견을 입력해주세요."></textarea>
													</div>
												</form>
											</div>
											<div class="modal-footer">
												<input type="button" value="반려" id="rjctBtn" class="btn btn-primary me-2">
												<button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
											</div>
										</div>
									</div>
								</div>
								<!-- 결재요청 모달 종료 -->
					
								
								
								<!--결재양식 시작-->
								<hr/>
								<div>
									<label class="form-label" style="margin-top: 10px;">증명서 내용 <font style="color: red">*</font></label>
								</div>
								<form action="/employee/elaprUpdate.do" method="post">
									<input type="hidden" name="elaprNo" value="${elaprVO.elaprNo}"/>
									<!--CKEditor 시작-->
									<c:choose>
										<c:when test="${authrityNm eq 'ROLE_EMPLOYEE'}">
											<c:choose>
												<c:when test="">
													<div style="width: 100%; min-width: 720px; display: flex; justify-content: center; background-color: #dbdbdb; border: 1px solid #f8f8f8;">
														<textarea id="formEditorCK" name="elaprCn" style="position: absolute;">
															${elaprVO.elaprCn } 
														</textarea>
													</div>
												</c:when>
												<c:otherwise>
													<div style="width: 100%; min-width: 720px; display: flex; justify-content: center; background-color: #dbdbdb; border: 1px solid #f8f8f8;">
														<textarea id="formEditorCK" name="elaprCn" style="position: absolute;" readonly="readonly">
															${elaprVO.elaprCn } 
														</textarea>
													</div>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<div style="width: 100%; min-width: 720px; display: flex; justify-content: center; background-color: #dbdbdb; border: 1px solid #f8f8f8;">
												<textarea id="formEditorCK" name="elaprCn" style="position: absolute;" readonly="readonly">
													${elaprVO.elaprCn } 
												</textarea>
											</div>
										</c:otherwise>
									</c:choose>
									<!--CKEditor 끝-->
								</form>
								<!--결재양식 종료-->
							</div>
							<!-- 전자결재 양식 시작  -->
						</div>
					</div>
					<!-- 결재선 시작-->
					<div class="card card-flush bg-body mb-9 col-12 col-xl-3">
						<!--결재선 제목 시작 -->
						<div class="card-header">
							<h4 class="card-title fw-bold text-gray-800 fs-2">결재선</h4>
						</div>
						<!-- 결재선 제목 종료 -->
						<div class="card-body pt-2">
							<!-- 기안자 리스트 출력 시작 -->
							<div class="d-flex align-items-center mb-7">
								<!-- 기안자 이미지 시작 -->
								<div class="symbol symbol-60px symbol-2by3 me-4">
									<div class="symbol symbol-35px me-3 ms-3">
										<img alt="${elaprVO.empNm }" src="/upload/${elaprVO.imgFileUrl }">
									</div>
								</div>
								<!-- 기안자 이미지 종료 -->
								<!-- 기안자 정보 시작 -->
								<div class="m-0">
									<h5>${elaprVO.empNm }  ${elaprVO.jbgdNm }</h5>
									<span class="text-gray-600 fw-semibold d-block pt-1 fs-8">${elaprVO.deptNm }</span>
									<span class="text-gray-600 fw-semibold d-block pt-1 fs-8">기안상신 | ${elaprVO.elaprBgngDt }</span>
									<!-- 기안자 의견 시작 -->
									<div class="my-2">
										<!--begin::Row-->
										<div class="d-flex align-items-center mb-3">
											<!--begin::Bullet-->
											<span class="bullet me-3"></span>
											<!--end::Bullet-->
											<!--begin::Label-->
											<div class="text-gray-600 fw-semibold fs-6">${elaprVO.elaprOpnnCn }</div>
											<!--end::Label-->
										</div>
										<!--end::Row-->
									</div>
									<!-- 기안자 의견 종료 -->
								</div>
								<!-- 기안자 정보 종료 -->
							</div>
							<!-- 기안자 리스트 출력 종료 -->
							<!-- 결재자 리스트 출력 시작 -->
							<c:forEach items="${aplnList }" var="aplnVO">
								<!-- 결재상태 색 표시 -->
								<c:choose>
									<c:when test="${aplnVO.aplnSttsCd eq 'APLN001' && !firstApln001 }">
										<div class="d-flex align-items-center mb-7 highlight-blue" data-apln-stts-cd="${aplnVO.aplnSttsCd}"  data-reg-date="${aplnVO.aplnDt}">
											<c:set var="firstApln001" value="true"/>
									</c:when>
									<c:otherwise>
										<div class="d-flex align-items-center mb-7">
									</c:otherwise>
								</c:choose>
							
									<!-- 결재자 이미지 종료 -->
									<div class="symbol symbol-60px symbol-2by3 me-4 ms-3" data-apln-stts-cd="${aplnVO.aplnSttsCd}" data-reg-date="${aplnVO.aplnDt}">
										<div class="symbol symbol-35px me-3">
											<img alt="${aplnVO.empNm }" src="/upload/${aplnVO.imgFileUrl }">
										</div>
									</div>
									<!-- 결재자 이미지 종료 -->
									<!-- 결재자 정보 시작 -->
									<div class="m-0">
										<h5>${aplnVO.empNm }  ${aplnVO.jbgdNm }</h5>
										<span class="text-gray-600 fw-semibold d-block pt-1 fs-8">${aplnVO.deptNm }</span>
										<!-- 결재자 상태 시작 -->
										<span class="text-gray-600 fw-semibold d-block pt-1 fs-8">
											<c:if test="${aplnVO.aplnSttsCd eq 'APLN001' }">결재대기</c:if>
											<c:if test="${aplnVO.aplnSttsCd eq 'APLN002' }">결재완료</c:if>
											<c:if test="${aplnVO.aplnSttsCd eq 'APLN003' }">결재반려</c:if>
										</span>
										<!-- 결재자 상태 종료 -->
										<!-- 결재자 의견 시작 -->
										<div class="my-2">
											<!--begin::Row-->
											<div class="d-flex align-items-center mb-3">
												<!--begin::Bullet-->
												<span class="bullet me-3"></span>
												<!--end::Bullet-->
												<!--begin::Label-->
												<div class="text-gray-600 fw-semibold fs-6">${aplnVO.aplnOpninCn }</div>
												<!--end::Label-->
											</div>
											<!--end::Row-->
										</div>
										<!-- 결재자 의견 종료 -->
									</div>
									<!-- 결재자 정보 종료 -->
								</div>
							</c:forEach>
						</div>
						<!-- 결재자 리스트 출력 종료 -->
					</div>
					<!--결재선 종료 -->
				</div>
				<form action="/employee/elaprUpdate.do" method="get" id="updateForm">
					<input type="hidden" name="elaprNo" value="${elaprVO.elaprNo }">
				</form>
				<!--end::About main-->
				</div>
			</div>
			<!--end::Content container-->
		</div>
		<!--end::Content-->
	</div>
	<!--end::Content wrapper-->
	<!--begin::Footer-->
	<div id="kt_app_footer" class="app-footer">
		<div class="app-container container-fluid d-flex flex-column flex-md-row flex-center flex-md-stack py-3">
		</div>
	</div>
	<!--end::Footer-->
</div>
<script type="text/javascript">
$(function () {
	var cancleBtn = $("#cancleBtn");		// 상신취소 버튼
	var watingBtn = $("#watingBtn");		// 결재대기 中 결재하기 버튼
	var rjctBtn = $("#rjctBtn");			// 결재대기 中 반려하기 버튼
	
	// 결재대기 中 결재하기 버튼 
    watingBtn.on("click", function () {
        console.log("watingBtn click");
        $("#approvalForm").submit();
        
        Swal.fire({
			icon: 'success',
			title: '결재가 완료되었습니다.'
		  });
    });

	// 결재대기 中 반려하기 버튼
	rjctBtn.on("click", function () {
		console.log("rjctBtn click");
		$("#rjctForm").submit();
		
		Swal.fire({
			icon : 'success',
			title : '반려가 완료되었습니다.'
		});
	});
	
	
	// 상신 취소 버튼
	cancleBtn.on("click", function () {
		console.log("click");
		updateForm.submit();
	});
	

    CKEDITOR.editorConfig = function( config ) {
		config.removeButtons = 'Link';
	}
	
	/* CKEDITOR 자바스크립트 */
	CKEDITOR.replace( 'formEditorCK', {
	    height: 500,
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
	
	// 결재 상태에 따른 이미지 출력
	const contextPath = "${pageContext.request.contextPath}";

    // 상태 코드에 따라 이미지를 반환하는 함수
    function getStatusImageHTML(statusCode, index) {
        let imagePath = "";
        // let leftPosition = 480 + (index * 170); // 첫 번째는 430px, 두 번째는 600px으로 증가
        let leftPosition;
		if (index === 0) {
		    leftPosition = 480; // 첫 번째는 480px
		} else if (index === 1) {
		    leftPosition = 605; // 두 번째는 605px
		} else {
		    leftPosition = 605 + ((index - 1) * 170); // 이후는 605 + 170씩 증가
		}

        if (statusCode === "APLN002") {
            imagePath = contextPath + "/resources/file/image/elapr_complete.png";
        } else if (statusCode === "APLN003") {
            imagePath = contextPath + "/resources/file/image/elapr_rjct.png";
        }

        if (imagePath) {
        	
        	// (인) 위에 이미지 넣기
            return "<img src='" + imagePath + "' style='position:absolute; width:30px; left:" + leftPosition + "px; top:205px;'>";
        } else {
            return " "; // APLN001일 경우 빈칸으로 출력
        }
    }

    // CKEditor가 준비되면 데이터를 가져와 각 상태 코드에 따라 개별적으로 업데이트
    CKEDITOR.instances.formEditorCK.on("instanceReady", function () {
        let content = CKEDITOR.instances.formEditorCK.getData();

        // 각 반복에서 하나의 (인)마다 상태 코드에 맞는 이미지로 대체
        $('[data-apln-stts-cd]').each(function (index) {
            const statusCode = $(this).data('apln-stts-cd');
            const imageHTML = getStatusImageHTML(statusCode, index);

            // "(인)"을 이미지로 대체
            content = content.replace(/\(인\)/, imageHTML);
        });

        CKEDITOR.instances.formEditorCK.setData(content); // CKEditor에 업데이트된 내용 설정
    });
    
});



</script>
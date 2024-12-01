<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div style="margin-bottom: 0px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>차량 관리</h3>
		<h6>차량 목록</h6>
	</div>
</div>
<style>
    #vhclslideshow-container {
        position: relative;
        width: 100%;
        height: 300px; /* 카드 높이에 맞게 조정 */
        overflow: hidden;
    }
    .slide {
        position: absolute;
        width: 100%;
        height: 100%;
        display: none; /* 기본적으로 숨김 */
    }
</style>

<div class="card">
	<div style="background-image: url('/upload/Gradient03.jpg'); background-size: cover; background-repeat: no-repeat; background-position: center;">
		<div class="card-header border-0 pt-6">
			<div class="d-flex flex-column fv-row">
				<h3 class="fw-bold text-gray-800 py-3">차량 목록</h3>
				<span class="fs-4 fw-semibold text-gray-600 d-block">
				</span>
			</div>
			<c:choose>
				<c:when test="${empty vhclList}">
					<div class="text-center mt-3">
					    <span>0</span> / <span>0</span>
					</div>
				</c:when>
				<c:otherwise>
					<div id="slide-index" class="text-center mt-3">
					    <span id="current-slide">1</span> / <span id="total-slides">${fn:length(vhclList)}</span>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="card-toolbar pb-3">
				<button type="button" class="btn btn-light-info" data-bs-toggle="modal" data-bs-target="#kt_modal_add_vehicle">
				<i class="ki-duotone ki-plus fs-2"></i>차량 추가</button>
			</div>
		</div>
		<div class="d-flex align-items-center justify-content-center h-600px">
		    <div class="image-input px-5" data-kt-image-input="true">
		        <div class="image-input-wrapper w-50px h-50px arrow" onclick="slide('prev')" style="background-image: url('/upload/arrow_back_ios_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png'); cursor: pointer;" id="leftBtn"></div>
		    </div>
		
		    <div class="image-input px-5 h-550px" id="vhclslideshow-container">
					<c:choose>
						<c:when test="${empty vhclList}">
							<div class="slide" style="display: none;">
			                    <div class="row">
					                <div class="image-input d-flex align-items-center justify-content-center" data-kt-image-input="true">
					                    <div class="image-input-wrapper w-1000px h-550px" style="background-image: url('/upload/shadow.png'); background-size: contain; background-repeat: no-repeat; background-position: bottom;"></div>
					                </div>
			                    </div>
				            </div>
						</c:when>
						<c:otherwise>
					        <c:forEach items="${vhclList }" var="vhcl">
				            <div class="slide" style="display: none;">
			                    <div class="row vhclNoFind" data-vhcl-no="${vhcl.vhclNo }">
					                <table class="table py-5">
					                    <tbody class="d-flex align-items-center justify-content-center">
					                        <tr>
					                            <td><span class="badge badge-light-success fs-4 fw-bold px-4 py-2">모델명 - ${vhcl.vhclMdlNm }</span></td>
					                            <td><span class="badge badge-light-primary fs-4 fw-bold px-4 py-2">차량 번호 - ${vhcl.vhclNo }</span></td>
					                            <td><span class="badge badge-light-info fs-4 fw-bold px-4 py-2">차종 - ${vhcl.vhclKndNm }</span></td>
					                            <td><span class="badge badge-light fs-4 fw-bold px-4 py-2">유종 - ${vhcl.vhclTypeFuel}</span></td>
					                            <td><span class="badge badge-light-danger fs-4 fw-bold px-4 py-2">연비 - ${vhcl.vhclAvgFuel }㎞/ℓ</span></td>
					                        </tr>
					                    </tbody>
					                </table>
					                <div class="image-input d-flex align-items-center justify-content-center" data-kt-image-input="true">
					                    <div class="image-input-wrapper w-1000px h-550px" style="background-image: url('/upload/${vhcl.vhclImgPath }'); background-size: contain; background-repeat: no-repeat; background-position: center;"></div>
					                </div>
			                    </div>
				            </div>
					        </c:forEach>
						</c:otherwise>
					</c:choose>		        	
		    </div>
		
		    <div class="image-input px-5" data-kt-image-input="true">
		        <div class="image-input-wrapper w-50px h-50px arrow" onclick="slide('next')" style="background-image: url('/upload/arrow_forward_ios_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png'); cursor: pointer;" id="rightBtn"></div>
		    </div>
		</div>
	</div>
	<div class="card-footer d-flex align-middle justify-content-center">
		<div class="card-toolbar">
			<button type="button" class="btn btn-light-secondary" data-bs-toggle="modal" data-bs-target="#kt_modal_modify_vehicle" id="modifyModalBtn">
			수정</button>
			<button type="button" class="btn btn-light-danger" id="vhclDelBtn">
			삭제</button>
		</div>
	</div>
</div>




<!-- 차량  삭제 폼 -->
<form action="/comvehicle/vhcldelte.do" method="post" id="delForm">
	<input type="hidden" name="vhclNo" id="delVhclNo">
</form>

<!-- 차량 수정 모달 -->
<div class="modal fade" id="kt_modal_modify_vehicle" tabindex="-1" aria-hidden="true">
	<form class="form" action="/comvehicle/vhclmodify.do" method="post" enctype="multipart/form-data" id="vhclModifyId">
		<input type="hidden" name="vhclImgPath" id="hiddenVhclImgPath">
		<div class="modal-dialog modal-dialog-centered mw-650px">
   			<div class="modal-content">
   				<div class="modal-header" id="kt_modal_add_user_header">
   					<h2 class="fw-bold">차량 정보 수정</h2>
   					<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
   						<i class="ki-duotone ki-cross fs-1">
   							<span class="path1"></span>
   							<span class="path2"></span>
   						</i>
   					</div>
   				</div>
   				<div class="separator"></div>
   				<div class="modal-body px-5 my-7">
   					<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
   					    <div class="fv-row mb-7 d-flex flex-column align-items-center justify-content-center">
   							<div class="card-body">
   								<div class="d-flex flex-column fv-row">
   									<div class="fv-row mb-7 d-flex flex-column align-items-center justify-content-center">
   										<label class="d-block fw-semibold fs-6 mb-5">차량 이미지</label>
   										<div class="image-input" data-kt-image-input="true">
   											<div class="image-input-wrapper w-450px h-250px" id="modifyVhclImgPath" style="background-size: contain; background-repeat: no-repeat; background-position: bottom;"></div>
   											<label class="btn btn-icon btn-circle btn-active-color-primary w-25px h-25px bg-body shadow" data-kt-image-input-action="change" data-bs-toggle="tooltip">
   												<i class="ki-duotone ki-pencil fs-7">
   													<span class="path1"></span>
   													<span class="path2"></span>
   												</i>
   												<input type="file" name="vehicleImgFile" accept=".png, .jpg, .jpeg"/>
   											</label>
   										</div>
   									</div>
   									<label class="fs-5 fw-semibold">차량 정보 입력</label>
   									    <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div>
   									    <div class="col-12">
   									        <div class="d-flex">
   									            <input type="text" class="form-control form-control-solid mx-1" id="modifyVhclNo" name="vhclNo" placeholder="차량 번호 (ex : 123가1234)">
   									            <input type="text" class="form-control form-control-solid mx-1" id="modifyVhclMdlNm" name="vhclMdlNm" placeholder="모델명 (ex : K5)">
   									        </div>
   									    </div>
   									<label class="fs-5 fw-semibold pt-5">차종</label>
   									<span class="selection">
   										<select class="select2-selection select2-selection--single form-select form-select-solid" name="vhclKndNm" id="modifyVhclKndNm">
									        <option value="승용차">승용차</option>
									        <option value="소형차">소형차</option>
									        <option value="SUV">SUV</option>
									        <option value="트럭">트럭</option>
									        <option value="밴">밴</option>
   										</select>
   									</span>
   									<label class="fs-5 fw-semibold pt-5">유종</label>
   									<span class="selection">
   										<select class="select2-selection select2-selection--single form-select form-select-solid" name="vhclTypeFuel" id="modifyVhclTypeFuel">
									        <option value="휘발유(가솔린)">휘발유(가솔린)</option>
									        <option value="경유(디젤)">경유(디젤)</option>
									        <option value="가스(LPG)">가스(LPG)</option>
									        <option value="전기">전기</option>
									        <option value="하이브리드">하이브리드</option>
   										</select>
   									</span>
   									<label class="fs-5 fw-semibold pt-5">연비</label>
   									<div class="input-group">
   									    <input type="text" class="form-control" placeholder="연비를 입력해주세요(ex : 9.0)" name="vhclAvgFuel" id="modifyVhclAvgFuel">
   									    <span class="input-group-text">㎞/ℓ</span>
   									</div>
   									<label class="fs-5 fw-semibold pt-5">차량 예약</label>
									<span class="selection">
										<select class="select2-selection select2-selection--single form-select form-select-solid" name="vhclRsvtPsbltyYn" id="modifyVhclRsvtPsbltyYn">
											<option value="Y">활성</option>
											<option value="N">비활성</option>
										</select>
									</span>
   								</div>
   							</div>
   						</div>
   				    </div>
   					<div class="text-center pt-10">
   						<button type="submit" class="btn btn-primary" data-kt-users-modal-action="submit">
   							<span class="indicator-label">수정</span>
   							<span class="indicator-progress">수정중!
   							<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
   						</button>
   						<button type="button" class="btn btn-light me-3" data-bs-dismiss="modal">취소</button>
   					</div>
   				</div>
   			</div>
   		</div>
	</form>
</div>

<!-- 차량 추가 모달 -->
<div class="modal fade" id="kt_modal_add_vehicle" tabindex="-1" aria-hidden="true">
	<form class="form" action="/comvehicle/vhclinsert.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="coCd" value="${userVO.coCd }">
		<div class="modal-dialog modal-dialog-centered mw-650px">
			<div class="modal-content">
				<div class="modal-header" id="kt_modal_add_user_header">
					<h2 class="fw-bold">차량 추가</h2>
					<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
						<i class="ki-duotone ki-cross fs-1">
							<span class="path1"></span>
							<span class="path2"></span>
						</i>
					</div>
				</div>
				<div class="separator"></div>
				<div class="modal-body px-5 my-7">
					<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
					    <div class="fv-row mb-7 d-flex flex-column align-items-center justify-content-center">
							<div class="card-body">
								<div class="d-flex flex-column fv-row">
									<div class="fv-row mb-7 d-flex flex-column align-items-center justify-content-center">
										<label class="d-block fw-semibold fs-6 mb-5">차량 이미지</label>
										<div class="image-input" data-kt-image-input="true">
											<div class="image-input-wrapper w-450px h-250px" style="background-image: url('/upload/shadow.png'); background-size: contain; background-repeat: no-repeat; background-position: bottom;"></div>
											<label class="btn btn-icon btn-circle btn-active-color-primary w-25px h-25px bg-body shadow" data-kt-image-input-action="change" data-bs-toggle="tooltip">
												<i class="ki-duotone ki-pencil fs-7">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
												<input type="file" name="vehicleImgFile" accept=".png, .jpg, .jpeg"/>
											</label>
										</div>
									</div>
									<label class="fs-5 fw-semibold">차량 정보 입력</label>
									    <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div>
									    <div class="col-12">
									        <div class="d-flex">
									            <input type="text" class="form-control form-control-solid mx-1" id="vhclNo" name="vhclNo" placeholder="차량 번호 (ex : 123가1234)" value="396수2063">
									            <input type="text" class="form-control form-control-solid mx-1" id="vhclMdlNm" name="vhclMdlNm" placeholder="모델명 (ex : K5)" value="GV70">
									        </div>
									    </div>
									<label class="fs-5 fw-semibold pt-5">차종</label>
									<span class="selection">
										<select class="select2-selection select2-selection--single form-select form-select-solid" name="vhclKndNm">
											<option value="null">차종을 선택해주세요</option>
											<option value="승용차">승용차</option>
											<option value="소형차">소형차</option>
											<option value="SUV" selected="selected">SUV</option>
											<option value="트럭">트럭</option>
											<option value="밴">밴</option>
										</select>
									</span>
									<label class="fs-5 fw-semibold pt-5">유종</label>
									<span class="selection">
										<select class="select2-selection select2-selection--single form-select form-select-solid" name="vhclTypeFuel">
											<option value="null">유종을 선택해주세요</option>
											<option value="휘발유(가솔린)" selected="selected">휘발유(가솔린)</option>
											<option value="경유(디젤)">경유(디젤)</option>
											<option value="가스(LPG)">가스(LPG)</option>
											<option value="전기">전기</option>
											<option value="하이브리드">하이브리드</option>
										</select>
									</span>
									<label class="fs-5 fw-semibold pt-5">연비</label>
									<div class="input-group">
									    <input type="text" class="form-control" placeholder="연비를 입력해주세요(ex : 9.0)" name="vhclAvgFuel" value="7.5">
									    <span class="input-group-text">㎞/ℓ</span>
									</div>
								</div>
							</div>
						</div>
				    </div>
					<div class="text-center pt-10">
						<button type="submit" class="btn btn-primary" data-kt-users-modal-action="submit">
							<span class="indicator-label">등록</span>
							<span class="indicator-progress">등록중!
							<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
						</button>
						<button type="reset" class="btn btn-light me-3" data-kt-users-modal-action="cancel">취소</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
$(function() {
    let currentSlide = 0; // 현재 슬라이드 인덱스
    const slides = $('#vhclslideshow-container .slide'); // 모든 슬라이드 요소 가져오기
    const totalSlides = slides.length;
    var vhclModifyId = $("#vhclModifyId");
    var delForm = $("#delForm");
    var vhclDelBtn = $("#vhclDelBtn");
    var delVhclNo = $("#delVhclNo");
    var modifyVhclNo = $("#modifyVhclNo");
    var modifyVhclMdlNm = $("#modifyVhclMdlNm");
    var modifyVhclAvgFuel = $("#modifyVhclAvgFuel");
    var modifyVhclKndNm = $("#modifyVhclKndNm");
    var modifyVhclTypeFuel = $("#modifyVhclTypeFuel");
    var modifyVhclImgPath = $("#modifyVhclImgPath");
    var modifyVhclRsvtPsbltyYn = $("#modifyVhclRsvtPsbltyYn");
    var hiddenVhclImgPath = $("#hiddenVhclImgPath");
    var vhclNo = ""; // 차량 번호를 전역 변수로 선언
    
    vhclDelBtn.on("click", function () {
		console.log("삭제버튼 눌림");
		Swal.fire({
		    title: '차량을 삭제하시겠습니까?',
		    text: '저장된 차량 정보가 사라집니다.',
		    icon: 'warning',
		    showCancelButton: true,
		    confirmButtonColor: '#F06445',
		    cancelButtonColor: '#4FC9DA',
		    confirmButtonText: '예',
		    cancelButtonText: '아니요',
		    reverseButtons: false,
		}).then((result) => {
		
		    if (result.isConfirmed) {
		        delForm.submit();
		    }
		});
    });
    // 수정 버튼 클릭 이벤트
//     rightBtn.on("click", function () {
//         console.log("vhclNo : " + vhclNo); // vhclNo 확인
        
//         if (!vhclNo) {
//             Swal.fire({
//                 icon: 'warning',
//                 title: '차량을 선택해주세요!',
//                 confirmButtonColor: '#4FC9DA',
//             });
//             return; // 빈 경우 AJAX 호출을 중단
//         }
        
//         $.ajax({
//             url: "/comvehicle/findvhclvo.do",
//             type: "POST",
//             contentType: "application/json; charset=utf-8",
//             data: JSON.stringify({ vhclNo: vhclNo }), // vhclNo를 JSON 문자열로 변환하여 요청
//             success: function(vhcl) {
//             	console.log("실행후 나온 번호" + vhcl.vhclNo);
//             	console.log("실행후 이미지 경로값" + vhcl.vhclImgPath);
            	
//             	modifyVhclNo.val(vhcl.vhclNo);
//             	modifyVhclMdlNm.val(vhcl.vhclMdlNm);
//             	modifyVhclAvgFuel.val(vhcl.vhclAvgFuel);
//             	modifyVhclKndNm.val(vhcl.vhclKndNm).change();
//             	modifyVhclTypeFuel.val(vhcl.vhclTypeFuel).change();
//             	modifyVhclImgPath.css('background-image', `url('/upload/\${vhcl.vhclImgPath}')`);
//     	    },
//             error: function() {
//                 Swal.fire({
//                     icon: 'warning',
//                     title: '수정 실행 실패!',
//                     confirmButtonColor: '#4FC9DA',
//                 });
//             }
//         });
//     });
//     leftBtn.on("click", function () {
//         console.log("vhclNo : " + vhclNo); // vhclNo 확인
        
//         if (!vhclNo) {
//             Swal.fire({
//                 icon: 'warning',
//                 title: '차량을 선택해주세요!',
//                 confirmButtonColor: '#4FC9DA',
//             });
//             return; // 빈 경우 AJAX 호출을 중단
//         }
        
//         $.ajax({
//             url: "/comvehicle/findvhclvo.do",
//             type: "POST",
//             contentType: "application/json; charset=utf-8",
//             data: JSON.stringify({ vhclNo: vhclNo }), // vhclNo를 JSON 문자열로 변환하여 요청
//             success: function(vhcl) {
//             	console.log("실행후 나온 번호" + vhcl.vhclNo);
            	
//             	modifyVhclNo.val(vhcl.vhclNo);
//             	modifyVhclMdlNm.val(vhcl.vhclMdlNm);
//             	modifyVhclAvgFuel.val(vhcl.vhclAvgFuel);
//             	modifyVhclKndNm.val(vhcl.vhclKndNm).change();
//             	modifyVhclTypeFuel.val(vhcl.vhclTypeFuel).change();
//             	modifyVhclImgPath.css('background-image', `url('/upload/\${vhcl.vhclImgPath}')`);
//     	    },
//             error: function() {
//                 Swal.fire({
//                     icon: 'warning',
//                     title: '수정 실행 실패!',
//                     confirmButtonColor: '#4FC9DA',
//                 });
//             }
//         });
//     });
    
    // 현재 슬라이드 인덱스 표시 업데이트 함수
    function updateSlideIndex() {
        $('#current-slide').text(currentSlide + 1); // 1부터 시작하도록 +1
        $('#total-slides').text(totalSlides); // 총 슬라이드 수
    }

    // 첫 번째 슬라이드 표시
    function showSlide(index) {
        slides.hide(); // 모든 슬라이드 숨김
        const currentSlideElement = slides.eq(index); // 현재 슬라이드 요소 가져오기
        currentSlideElement.show(); // 현재 슬라이드만 보이도록 설정
        
        // 현재 슬라이드의 vhclNo 값 가져오기
        vhclNo = currentSlideElement.find('.vhclNoFind').data('vhcl-no'); // .vhclNoFind에서 data-vhcl-no 가져오기
        console.log("현재 슬라이드의 vhclNo: " + vhclNo); // 확인을 위한 로그 출력
        
        $.ajax({
            url: "/comvehicle/findvhclvo.do",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ vhclNo: vhclNo }), // vhclNo를 JSON 문자열로 변환하여 요청
            success: function(vhcl) {
            	console.log("실행후 나온 번호" + vhcl.vhclNo);
            	
            	modifyVhclNo.val(vhcl.vhclNo);
            	delVhclNo.val(vhcl.vhclNo);
            	modifyVhclMdlNm.val(vhcl.vhclMdlNm);
            	modifyVhclAvgFuel.val(vhcl.vhclAvgFuel);
            	modifyVhclKndNm.val(vhcl.vhclKndNm).change();
            	modifyVhclTypeFuel.val(vhcl.vhclTypeFuel).change();
            	modifyVhclRsvtPsbltyYn.val(vhcl.vhclRsvtPsbltyYn).change();
            	modifyVhclImgPath.css('background-image', `url('/upload/\${vhcl.vhclImgPath}')`);
            	hiddenVhclImgPath.val(vhcl.vhclImgPath);
    	    },
            error: function() {
                Swal.fire({
                    icon: 'warning',
                    title: '수정 실행 실패!',
                    confirmButtonColor: '#4FC9DA',
                });
            }
        });

        updateSlideIndex(); // 슬라이드 인덱스 업데이트
    }

    // 슬라이드 이동 함수
    window.slide = function(direction) {
        if (direction === 'next') {
            currentSlide = (currentSlide + 1) % totalSlides; // 다음 슬라이드로 이동 (순환)
        } else if (direction === 'prev') {
            currentSlide = (currentSlide - 1 + totalSlides) % totalSlides; // 이전 슬라이드로 이동 (순환)
        }
        showSlide(currentSlide); // 현재 슬라이드 표시
        
        
    };

    // 페이지 로드 시 첫 번째 슬라이드 표시
    showSlide(currentSlide);
});

</script>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
.Slidesbackground {
    margin: 0;
    padding: 0;

}
.slideshow-image{
    border-radius:3%;
    width: 100%;
    height: 100%;
    overflow: hidden;
}
.mySlides {
    border-radius:3%;
    width: 400px;
    height: 350px;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: 0px 15px 15px rgba(0, 0, 0, 0.5);
}

.slideshow-container {
    display: flex;
    justify-content: center;
    position: relative;
    margin: auto;
}

.fade {
    animation-name: fade;
    animation-duration: 2.8s;
}

@keyframes fade {
    from {
        opacity: .4
    }
    to {
        opacity: 1
    }
}
</style>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>시설 예약</h3>
		<h6>시설 현황</h6>
	</div>
</div>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-fluid">
					<div class="d-flex flex-column flex-lg-row">
						<!--begin::Sidebar-->
						<div class="flex-column flex-lg-row-auto w-100 w-lg-500px w-xl-500px mb-10 mb-lg-0">
							<!--begin::Contacts-->
							<div class="card card-flush">
								<!--end::Card header-->
								<!--begin::Card body-->
								<div class="card-body pt-5" id="kt_chat_contacts_body">
									<!--begin::List-->
									<div class="scroll-y me-n5 pe-5 h-200px h-lg-auto" data-kt-scroll="true" data-kt-scroll-activate="{default: false, lg: true}" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_header, #kt_app_header, #kt_toolbar, #kt_app_toolbar, #kt_footer, #kt_app_footer, #kt_chat_contacts_header" data-kt-scroll-wrappers="#kt_content, #kt_app_content, #kt_chat_contacts_body" data-kt-scroll-offset="5px">
										
										<!--begin::User-->
										<div class="d-flex flex-stack py-4">
											<!--begin::Details-->
											<div class="d-flex align-items-center">
												<!--begin::Details-->
												<div class="ms-5">
													<h2>공간 대여</h2>
												</div>
												<!--end::Details-->
											</div>
											<!--end::Lat seen-->
										</div>
										<!--end::User-->
										<!--begin::Separator-->
										<div class="separator separator-dashed d-none"></div>
										<!--end::Separator-->
										
										
										<!-- 회의실 이미지 -->
										<!--begin::User-->
										<div class="d-flex flex-stack py-4">
											<!--begin::Details-->
											<div class="d-flex align-items-center">
												<!--begin::Details-->
												<div class="ms-5">
													<span class="slideshow-container">
													    <div class="Slidesbackground">
													    	<c:forEach items="${imgList }" var="imgList">
													    		<div class="mySlides fade">
													       			<img src="/upload/${imgList.atchFileDetailStrgNm }" class="slideshow-image">
													       		</div>
													    	</c:forEach> 
													   </div>
													</span>
												</div>
												<!--end::Details-->
											</div>
											<!--end::Details-->
										</div>
										<!--end::User-->
										<!--begin::Separator-->
										<div class="separator separator-dashed d-none"></div>
										<!--end::Separator-->
										
										
										
									</div>
									<!--end::List-->
								</div>
								<!--end::Card body-->
							</div>
							<!--end::Contacts-->
						</div>
						<!--end::Sidebar-->
						
						
						
						
						<!--begin::Content-->
						<div class="flex-lg-row-fluid ms-lg-7 ms-xl-10">
							<!--begin::Messenger-->
							<div class="card" id="kt_chat_messenger">
								<!--begin::Card header-->
								
								<!--end::Card header-->
								<!--begin::Card body-->
								<div class="card-body"  id="kt_chat_messenger_body">
									<input type="hidden" id="fcltCd" value="${fcltVO.fcltCd }">
									<!--begin::Row-->
										<div class="row mb-7">
											<label class="col-lg-2 fw-semibold text-muted">위치</label>
											<div class="col-lg-10">
												<span class="fw-bold fs-6 text-gray-800">${fcltCtgrVO.fcltCtgrNm }</span>
											</div>
										</div>
										<div class="row mb-7">
											<label class="col-lg-2 fw-semibold text-muted">시설명</label>
											<div class="col-lg-10">
												<span class="fw-bold fs-6 text-gray-800">${fcltVO.fcltNm }</span>
											</div>
										</div>
										<div class="row mb-7">
											<label class="col-lg-2 fw-semibold text-muted">이용 시간 </label>
											<div class="col-lg-10">
												<span class="fw-bold fs-6 text-gray-800">${fcltVO.fcltStartTm } ~ ${fcltVO.fcltEndTm }</span>
											</div>
										</div>
										<div class="row mb-7">
											<label class="col-lg-2 fw-semibold text-muted">최대 인원수</label>
											<div class="col-lg-10">
												<span class="fw-bold fs-6 text-gray-800">${fcltVO.fcltNope }명</span>
											</div>
										</div>
										<div class="row mb-7">
											<label class="col-lg-2 fw-semibold text-muted">시설 안내</label>
											<div class="col-lg-10">
												<span class="fw-bold fs-6 text-gray-800">${fcltVO.fcltInfo }</span>
											</div>
										</div>
										<div class="row mb-7">
											<label class="col-lg-2 fw-semibold text-muted">비품</label>
											<div class="col-lg-10">
												<span class="fw-bold fs-6 text-gray-800">
													<c:forEach items="${eqList }" var="item">
														${item.equipmentIcon } ${item.equipmentNm } &nbsp;
													</c:forEach>
												</span>
											</div>
										</div>
										<div class="row mb-7">
											<label class="col-lg-2 fw-semibold text-muted">예약자명</label>
											<div class="col-lg-10">
												<input id="reservationNm" name="reservationNm" readonly="readonly" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-400px ps-12" style="margin-top: 0.5em;" value="${empVO.empNm }"/>
											</div>
										</div>
										<div class="row mb-7">
											<label class="col-lg-2 fw-semibold text-muted">연락처</label>
											<div class="col-lg-10">
												    <input id="reservationTel" name="reservationTel" readonly="readonly" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-400px ps-12" style="margin-top: 0.5em;" value="${empVO.empTelno }"/>
											</div>
										</div>
										<div class="row mb-7">
											<label class="col-lg-2 fw-semibold text-muted">예약일자</label>
											<div class="col-lg-10">
												<input id="reservationDt" name="reservationDt" type="date" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-400px ps-12" style="margin-top: 0.5em;" value="${sdfNow }"/>
											</div>
										</div>
										<div class="row mb-7">
											<label class="col-lg-2 fw-semibold text-muted">예약 시간</label>
											<div class="col-lg-3">
												<select class="col form-select form-select-solid fw-bold" id="rsvStartTm" data-kt-select2="true" data-placeholder="부서 선택" data-allow-clear="true" data-kt-user-table-filter="role" data-hide-search="true">
													<option disabled="disabled" selected="selected">시작 시간 선택</option>
													<c:forEach items="${rsvList }" var="tm">
														<option value="${tm }">${tm }</option>
													</c:forEach> 
												</select>
											</div>
											~
											<div class="col-lg-3">
												<select class="col form-select form-select-solid fw-bold" id="rsvEndTm" data-kt-select2="true" data-placeholder="부서 선택" data-allow-clear="true" data-kt-user-table-filter="role" data-hide-search="true">
													<option disabled="disabled" selected="selected">종료 시간 선택</option>
													<%-- <c:forEach>
													</c:forEach> --%>
												</select>
											</div>
											<div class="col-lg-3">
												<input type="button" class="form-control" id="rsvBtn" value="예약"/>
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
	
<script type="text/javascript">
$(function() {
	$("#rsvStartTm").on("change",function(){
		console.log("시작시간 변경");
		var startTm = $("#rsvStartTm option:selected").val();
		var fcltCd = $("#fcltCd").val();
		var reservationDt = $("#reservationDt").val();
		var formData = {
			rsvtBgngTm : startTm,
			fcltCd : fcltCd,
			rsvtYmd : reservationDt
		}
		//시작 시간부터 선택 가능한 시간 가져오기
		$.ajax({
			url : "/employee/facilties/rsvTm.do",
			type : "post",
			contentType: "application/json; charset=utf-8",
	        data: JSON.stringify(formData) ,
	        success: function(res) {
	        	var html = "";
	        	for (var i = 0; i < res.length; i++) {
	        		 html += "<option value="+res[i]+">"+res[i]+"</option>";	
				}
	        	$("#rsvEndTm").html(html)
	        }
		});
	});
	
	$("#rsvBtn").on("click",function(){
		var fcltCd = $("#fcltCd").val();
		var rsvDt = $("#reservationDt").val();
		var rsvStartTm = $("#rsvStartTm option:selected").val();
		var rsvEndTm = $("#rsvEndTm option:selected").val();
		
		var formData = {
				fcltCd : fcltCd,
				rsvtYmd : rsvDt,
				rsvtBgngTm : rsvStartTm,
				rsvtEndTm : rsvEndTm
		}
		console.log(formData);
		$.ajax({
			url : "/employee/facilties/available.do",
			type : "post",
			contentType: "application/json; charset=utf-8",
	        data: JSON.stringify(formData) ,
	        success: function(res) {
	        	Swal.fire({
					icon: 'success',
					title: '시설을 예약했습니다.',
					confirmButtonColor: '#4FC9DA',
				});
	        },
	        error: function(res) {
	        	Swal.fire({
					icon: 'warning',
					title: '시설예약에 실패했습니다.',
					confirmButtonColor: '#4FC9DA',
				});
			}
		});
	});
});


var slideIndex = 0;
showSlides();

function showSlides() {
    var i;
    var slides = document.getElementsByClassName("mySlides");
   
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    slideIndex++;
    if (slideIndex > slides.length) {
        slideIndex = 1
    }
    slides[slideIndex - 1].style.display = "block";

    setTimeout(showSlides, 3000); // 2초마다 이미지가 체인지됩니다
};


</script>

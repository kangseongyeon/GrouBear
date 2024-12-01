<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>

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
				<div class="card mb-5 mb-xxl-8">
					<div class="card-body pt-0 pb-0">
						<!--begin::Navs-->
						<ul class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold">
							<c:if test="${not empty fcltCtgrList }">
								<c:forEach items="${fcltCtgrList }" var="ctgrList">
									<li class="nav-item mt-2">
										<a class="nav-link text-active-primary ms-0 me-10 py-5" name="fcltList" id="${ctgrList.fcltCtgrCd }" onclick="clickCtgr('${ctgrList.fcltCtgrCd}')">
											${ctgrList.fcltCtgrNm }
										</a>
									</li>
								</c:forEach>
							</c:if>	
						</ul>
						<!--begin::Navs-->
					</div>
				</div>
					
					<div class="d-flex flex-column flex-lg-row">
						<!--begin::Sidebar-->
						<div class="flex-column flex-lg-row-auto w-100 w-lg-300px w-xl-400px mb-10 mb-lg-0">
							<!--begin::Contacts-->
							<div class="card card-flush">
								<!--end::Card header-->
								<!--begin::Card body-->
								<div class="card-body pt-5" id="kt_chat_contacts_body">
									<!--begin::List-->
									<div class="scroll-y me-n5 pe-5 h-200px h-lg-auto" id="div_fcltList" data-kt-scroll="true" data-kt-scroll-activate="{default: false, lg: true}" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_header, #kt_app_header, #kt_toolbar, #kt_app_toolbar, #kt_footer, #kt_app_footer, #kt_chat_contacts_header" data-kt-scroll-wrappers="#kt_content, #kt_app_content, #kt_chat_contacts_body" data-kt-scroll-offset="5px">
										
										<!--begin::시작-->
										<div class="d-flex flex-stack py-4">
											<!--begin::Details-->
											<div class="d-flex align-items-center">
											
												<!--begin::Details-->
												<div class="ms-5">
													<div class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">위치를 선택해주세요.</div>
												</div>
												<!--end::Details-->
											</div>
											<!--end::Details-->
											<!--begin::Lat seen-->
											<div class="d-flex flex-column align-items-end ms-2">
												<span class="text-muted fs-7 mb-1"></span>
											</div>
											<!--end::Lat seen-->
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
								<div class="card-body" id="kt_chat_messenger_body">
									<div id="fcltCtgrImg">
										<img id="preview">
									</div>
								</div>
								<!--end::Card body-->
							</div>
							<!--end::Messenger-->
						</div>
						<!--end::Content-->
					</div>
					<!--end::Layout-->
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
function clickCtgr(ctgrCd) {
	console.log("ctgrCd ::: ", ctgrCd);
	$('[id*=FCLTCTGR]').removeClass('active');
	document.getElementById(ctgrCd).classList.add('active');
	
	var formData = {
		fcltCtgrCd : ctgrCd			
	}	
	
	$.ajax({
		url : '/employee/facilties/getfcltList.do',
		type : 'post',
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify(formData),
		success : function(res) {
			console.log("success :: ", res);
			var fcltListHtml = "";
			var imgHtml = "";
			if(res.fcltList.length == 0){
				fcltListHtml += 
					`
						<div class="d-flex flex-stack py-4">
						    <div class="d-flex align-items-center">
						        <div class="ms-5">
						            <a href="#" class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">등록된 시설이 없습니다.</a>
						        </div>
						    </div>
					    	<div class="d-flex flex-column align-items-end ms-2">
					        	<span class="text-muted fs-7 mb-1"></span>
					    	</div>
						</div>
						<div class="separator separator-dashed d-none"></div>
					`;
			}else{
				for (var i = 0; i < res.fcltList.length; i++) {
					fcltListHtml += 
						`
							<div class="d-flex flex-stack py-4">
							    <div class="d-flex align-items-center">
							        <div class="ms-5">
							            <a href="/employee/facilities/detail.do?fcltCd=\${res.fcltList[i].fcltCd }" class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">\${res.fcltList[i].fcltNm}</a>
							        </div>
							    </div>
						    	<div class="d-flex flex-column align-items-end ms-2">
						        	<span class="text-muted fs-7 mb-1"></span>
						    	</div>
							</div>
							<div class="separator separator-dashed d-none"></div>
						`;
				}
			}
			$("#div_fcltList").html(fcltListHtml);
			imgHtml = `<img alt="" src="/upload/\${res.fcltCtgrImgUrl}" style="width: 100%; height: 100%;">`;
			$("#fcltCtgrImg").html(imgHtml);
		},
		error : function(res) {
			console.log("error :: ", res);
		}
		
	});
}

$(function () {
	$("a[name=fcltList]:first").click();
});


</script>

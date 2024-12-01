<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>근태 관리</h3>
		<h6>출퇴근 관리</h6>
	</div>
</div>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<!--begin::Content wrapper-->
	<div class="d-flex flex-column flex-column-fluid">
		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<!--begin::Content container-->
			<div id="kt_app_content_container" class="app-container container-fluid">
				<div class="d-flex flex-wrap flex-stack my-5">
					<h2 class="fs-2 fw-semibold my-2">올해 근무 현황</h2> 
				</div>
				<div class="row g-6 g-xl-9">
					<div class="col-md-6 col-xl-4">
						<a href='javascript:void(0)' class="card border-hover-primary" onclick='preventClick(event)'>
							<div class="card-header border-0 pt-9">
								<div class="card-title m-0">
									<h4>근태 현황</h4>
								</div>
								<div class="card-toolbar">
								</div>
							</div>
							<div class="card-body p-9">
								<div style="display: flex; justify-content: space-between; width: 100%;">
								    <div style="width: 50%; text-align: center;">
								        <h4>지각</h4>
								        <h4>${lateCnt }회</h4>
								    </div>
								    <div style="width: 50%; text-align: center;">
								        <h4>결근</h4>
								        <h4>${absenceCnt }회</h4>
								    </div>
								</div>
							</div>
						</a>
					</div>
					<div class="col-md-6 col-xl-4">
						<a href='javascript:void(0)' class="card border-hover-primary" onclick='preventClick(event)'>
							<div class="card-header border-0 pt-9">
								<div class="card-title m-0">
									<h4>휴가 현황</h4>
								</div>
								<div class="card-toolbar">
								</div>
							</div>
							<div class="card-body p-9">
								<div style="display: flex; justify-content: space-between; width: 100%;">
								    <div style="width: 50%; text-align: center;">
								        <h4>사용 휴가</h4>
								        <h4>${uesVctCnt }회</h4>
								    </div>
								    <div style="width: 50%; text-align: center;">
								        <h4>잔여 휴가</h4>
								        <h4>${remainVctCnt }회</h4>
								    </div>
								</div>
							</div>
						</a>
					</div><div class="col-md-6 col-xl-4">
						<a href='javascript:void(0)' class="card border-hover-primary" onclick='preventClick(event)'>
							<div class="card-header border-0 pt-9">
								<div class="card-title m-0">
									<h4>근무 시간</h4>
								</div>
								<div class="card-toolbar">
								</div>
							</div>
							<div class="card-body p-9">
								<div style="display: flex; justify-content: space-between; width: 100%;">
								    <div style="width: 50%; text-align: center;">
								        <h4>근무 일수</h4>
								        <h4>${workCnt }일</h4>
								    </div>
								    <div style="width: 50%; text-align: center;">
								        <h4>근무 시간</h4>
								        <h4>${workTm }</h4>
								    </div>
								</div>
							</div>
						</a>
					</div>
					
					
					
				</div>
				
					<div class="d-flex flex-wrap flex-stack my-5">
					<!--begin::Heading-->
						<h2 class="fs-2 fw-semibold my-2">근무 현황</h2> 
					<!--end::Heading-->
					</div>
					
					<div class="row g-6 g-xl-9">
						<div class="col-md-6 col-xl-6">
							<a href='javascript:void(0)' class="card border-hover-primary" onclick='preventClick(event)'>
								<div class="card-header border-0 pt-9">
									<div class="card-title m-0">
										<h4>근무 시간</h4>
									</div>
									<div class="card-toolbar">
									</div>
								</div>
								<div class="card-body p-9">
									<div style="display: flex; justify-content: space-between; width: 100%;">
									    <div style="width: 50%; text-align: center;">
									        <h4>출근 시간</h4>
									        <h4>${wfVO.workFormBreakBgngTm }</h4>
									    </div>
									    <div style="width: 50%; text-align: center;">
									        <h4>퇴근 시간</h4>
									        <h4>${wfVO.workFormLvrmTm }</h4>
									    </div>
									</div>
								</div>
							</a>
						</div>
						
						
						
						<div class="col-md-6 col-xl-6">
							<a href='javascript:void(0)' class="card border-hover-primary" onclick='preventClick(event)'>
								<div class="card-header border-0 pt-9">
									<div class="card-title m-0">
										<h4>금일 근태 현황</h4>
									</div>
									<div class="card-toolbar">
									</div>
								</div>
								<div class="card-body p-9">
									<div style="display: flex; justify-content: space-between; width: 100%;">
									    <div style="width: 50%; text-align: center;">
									        <h4>출근 시간</h4>
									        <c:choose>
									        	<c:when test="${empty wsVO.workBgngTm }">
									        		<h4>-</h4>
									        	</c:when>
									        	<c:otherwise>
									        		<h4>${wsVO.workBgngTm }</h4>
									        	</c:otherwise>
									        </c:choose>
									        
									    </div>
									    <div style="width: 50%; text-align: center;">
									        <h4>퇴근 시간</h4>
									        <c:choose>
									        	<c:when test="${empty wsVO.workEndTm }">
									        		<h4>-</h4>
									        	</c:when>
									        	<c:otherwise>
									        		<h4>${wsVO.workEndTm }</h4>
									        	</c:otherwise>
									        </c:choose>
									    </div>
									</div>
								</div>
							</a>
						</div>
						
				</div>
					
				<!--end::Row-->
			</div>
			
			<!--end::Content container-->
		</div>
		
		<!--end::Content-->
	</div>
	
	<!--end::Content wrapper-->
	<!--begin::Footer-->
	<div id="kt_app_footer" class="app-footer">
	<br>
	</div>
	<!--end::Footer-->
</div>

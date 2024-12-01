<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>시설 예약</h3>
		<h6>예약 현황</h6>
	</div>
</div>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-fluid">
				<div class="card" id="workCard">
				
					<div class="card-header border-0 pt-6">
						<div class="card-title">
							<h2>시설 예약 현황</h2>
						</div>
						<div class="card-toolbar"> 
	                        <div class="d-flex justify-content-end" data-kt-filemanager-table-toolbar="base">
	                        </div>
						</div>
					</div>
					<div class="card-body py-4" id="workList">
						<table class="table align-middle table-row-dashed fs-6 gy-5" id="kt_table_users">
							<thead>
								<tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
									<th class="min-w-100px">번호</th>
									<th class="min-w-100px">예약자명</th>
									<th class="min-w-100px">예약일자</th>
									<th class="min-w-100px">예약시간</th>
									<th class="min-w-100px">위치</th>
									<th class="min-w-100px">시설명</th>
								</tr>
							</thead>
							<tbody class="text-gray-600 fw-semibold" id="reserveTable">
								<c:choose>
									<c:when test="${empty List }">
										<tr>
				                            <td colspan="6" class="dt-empty">
					                            <div class="d-flex flex-column flex-center mt-10">
								                    <img src="${pageContext.request.contextPath }/resources/file/image/cloudEmpty.png" class="mw-300px">
								                    <div class="fs-1 fw-bolder text-dark">예약 내역이 없습니다.</div>
			              				 		</div> 
		              						</td> 
	              						</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${List }" var="list">
											<tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
												<th class="min-w-100px">${list.fcltRsvtDsctnCd }</th>
												<th class="min-w-100px">${list.empNm }</th>
												<th class="min-w-100px">${list.rsvtYmd }</th>
												<th class="min-w-100px">${list.rsvtBgngTm} ~ ${list.rsvtEndTm }</th>
												<th class="min-w-100px">${list.fcltCtgrNm } </th>
												<th class="min-w-100px">${list.fcltNm } </th>
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
<script type="text/javascript">
s</script>			

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>프로젝트</h3> 
		<h6>프로젝트</h6>
	</div>
</div>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-fluid">
				<div class="d-flex flex-wrap flex-stack pb-8">
					<h3 class="fw-bold my-2">내 프로젝트</h3>
						<div class="card-toolbar flex-row-fluid justify-content-end gap-5" data-select2-id="select2-data-188-5om8">
							<div class="d-flex flex-end my-1">
								<ul class="nav nav-pills me-5">
									<li class="nav-item m-0">
										<a class="btn btn-sm btn-icon btn-light btn-color-muted btn-active-primary active me-3" data-bs-toggle="tab" href="#kt_project_targets_card_pane">
											<i class="ki-duotone ki-element-plus fs-1">
												<span class="path1"></span>
												<span class="path2"></span>
												<span class="path3"></span>
												<span class="path4"></span>
												<span class="path5"></span>
											</i>
										</a>
									</li>
								<li class="nav-item m-0">
										<a class="btn btn-sm btn-icon btn-light btn-color-muted btn-active-primary" data-bs-toggle="tab" href="#kt_project_targets_table_pane">
											<i class="ki-duotone ki-row-horizontal fs-2">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>
										</a>
									</li>
								</ul>
							<button type="button" id="addProBtn" class="btn btn-primary">프로젝트 추가하기</button>
						</div>
					</div>
				</div>
				<!-- 프로젝트 메인 홈 리스트 -->
				<div class="tab-content">
					<!-- 프로젝트 메인 홈 카드 리스트 -->
					<div id="kt_project_targets_card_pane" class="tab-pane fade show active">
						<div class="col-lg-12">
						    <div class="row">
						    	<c:set value="${proCardList }" var="proCardList"/>
									<c:choose>
										<c:when test="${empty proCardList }">
											<div class="card-body">
												프로젝트가 존재하지 않습니다.
											</div>
										</c:when>
										<c:otherwise>
								        <c:forEach items="${proCardList }" var="projectVO">           
								            <div class="col-md-3">
								                <div class="card mb-6 mb-xl-12">
													<a href="/employee/canbanList.do?proNo=${projectVO.proNo }" class="text-gray-900 text-hover-primary">
									                    <div class="card-body">
									                    	<c:if test="${projectVO.proSttsCd eq 'PRO001'}">
																<span class="badge badge-light-warning mb-2">진행</span>
															</c:if>
															<c:if test="${projectVO.proSttsCd eq 'PRO002'}">
																<span class="badge badge-light-warning mb-2">진행</span>
															</c:if>
															<c:if test="${projectVO.proSttsCd eq 'PRO003'}">
																<span class="badge badge-light-success mb-2">완료</span>
															</c:if>
									                        <div class="mb-5">
										                        <h4> ${projectVO.proNm } </h4>
									                        </div>
									                        <div class="badge badge-light-success px-3 py-2">
									                        	등록자 : ${projectVO.empNm }
									                        </div>
									                        <div class="mb-2 fw-bold">
									                        	시작일 : ${projectVO.proStartDt } <br/> 
									                        	종료일 : ${projectVO.proEndDt }
									                        </div>
									                        참여자 프로필 <br/>
									                        <div class="d-flex flex-stack flex-wrap mb-2">
															    <div class="symbol-group symbol-hover my-1">
															        <c:forEach items="${projectVO.participantImgFileUrlsList}" var="participantImgFileUrl" varStatus="status">
															        	<c:choose>
															        		 <c:when test="${status.index lt projectVO.participantEmpNamesList.size()}">
															        			<div class="symbol symbol-45px symbol-circle" data-bs-toggle="tooltip"  title="${projectVO.participantEmpNamesList[status.index] }" style="overflow: hidden;">
															        				<img alt="${projectVO.participantEmpNamesList[status.index] }" src="/upload/${participantImgFileUrl.trim() }" style="object-fit: cover;">
															        			</div>
															        		</c:when>
															        	</c:choose>
															        </c:forEach>
															    </div>
															</div>
									                    </div>
								                   	</a>
								                    <div class="card-footer d-flex justify-content-end" >
								                        <button type="button" class="btn btn-flex btn-light-primary me-2" onclick="javascript:location.href='/employee/canbanList.do?proNo=${projectVO.proNo }'">
								                        	<i class="ki-duotone ki-tablet-text-up fs-2">
								                        		<span class="path1"></span>
								                        		<span class="path2"></span>
							                        		</i>
								                        	칸반보드
							                        	</button>
								                        <button type="button" class="btn btn-light-success" onclick="javascript:location.href='/employee/ganttList.do?proNo=${projectVO.proNo }'">
								                        	<i class="bi bi-bar-chart">
											                     <span class="path1"></span>
											                     <span class="path2"></span>
										                     </i>
										                     간트차트
									                  </button>
								                    </div>
								                </div>
								            </div>
								        </c:forEach>
						       		 </c:otherwise>
						        </c:choose>
						    </div> 
						</div>
					</div>
					<!-- 프로젝트 메인 홈 테이블 리스트 -->
					<div id="kt_project_targets_table_pane" class="tab-pane fade">
						<div class="card card-flush">
							<div class="card-body pt-3">
								<table id="kt_profile_overview_table" class="table table-row-bordered table-row-dashed gy-4 align-middle fw-bold">
									<thead class="fs-7 text-gray-500 text-uppercase">
										<tr>
											<th class="min-w-250px">프로젝트명</th>
											<th class="min-w-90px">시작일</th>
											<th class="min-w-150px">마감일</th>
											<th class="min-w-90px">등록자</th>
											<th class="min-w-90px">참가자</th>
											<th class="min-w-50px">자세히보기</th>
										</tr>
									</thead>
									<tbody class="fs-6">
										<c:set value="${proCardList }" var="proCardList"/>
										<c:choose>
											<c:when test="${empty proCardList }">
												<tr>
													<td colspan="6" >
														프로젝트가 존재하지 않습니다.
													</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${proCardList }" var="projectVO">
													<tr>
														<td class="fw-bold">
															<a href="/employee/canbanList.do?proNo=${projectVO.proNo }" class="text-gray-900 text-hover-primary">
																${projectVO.proNm }
															</a>
														</td>
														<td>${projectVO.proStartDt }</td>
														<td>${projectVO.proEndDt }</td>
														<td>${projectVO.empNm }</td>
														<td>
															<div class="d-flex flex-stack flex-wrap mb-2">
															    <div class="symbol-group symbol-hover my-1">
															        <c:forEach items="${projectVO.participantImgFileUrlsList}" var="participantImgFileUrl" varStatus="status">
															        	<c:choose>
															        		 <c:when test="${status.index lt projectVO.participantEmpNamesList.size()}">
										 					        			<div class="symbol symbol-35px symbol-circle" data-bs-toggle="tooltip"  title="${projectVO.participantEmpNamesList[status.index] }" style="overflow: hidden;">
															        				<img alt="${projectVO.participantEmpNamesList[status.index] }" src="/upload/${participantImgFileUrl.trim() }" style="object-fit: cover;">
															        			</div>
															        		</c:when>
															        	</c:choose>
															        </c:forEach>
															    </div>
															</div>
														</td>
														
														<td>
															<a href="#" class="btn btn-sm btn-light btn-flex btn-center btn-active-light-primary" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">자세히 보기 
															<i class="ki-duotone ki-down fs-5 ms-1"></i></a>
															<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">
																<div class="menu-item px-3">
																	<a href="/employee/canbanList.do?proNo=${projectVO.proNo }" class="menu-link px-3">칸반보드</a>
																</div>
																<div class="menu-item px-3">
																	<a href="/employee/ganttList.do?proNo=${projectVO.proNo }" class="menu-link px-3">간트차트</a>
																</div>
															</div>
														</td>
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
	</div>
</div>

<script type="text/javascript">
$(function(){
	var addProBtn = $("#addProBtn");		// 프로젝트 추가

	// 프로젝트 추가
	addProBtn.on("click", function () {
		location.href = "/employee/projectForm.do";
	});
});
</script>
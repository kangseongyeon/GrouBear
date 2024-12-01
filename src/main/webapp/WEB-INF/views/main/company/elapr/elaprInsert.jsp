<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- ckeditor API -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script> 

<!-- sweetalert2 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- jstree -->
<link href="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.js"></script>

<!-- CKEDITOR 경고창 없애기 -->
<style>
   .cke_notifications_area { display: none; }
</style>

<div style="margin-bottom: 50px;">
   <div style="margin-top: -32px;">
      <div class="separator border my-10"></div>
   </div>
   <div style="margin-left: 30px; margin-top: -100px;">
      <h3>전자결재</h3> 
      <h6>전자결재</h6>
   </div>
</div>

<%-- <c:set value="등록" var="insertAndUpdate"/>
<c:set value="취소" var="cancleAndList"/>
<c:set value="등록" var="insertAndUpdate"/>
<c:if test="${status eq 'u' }">
   <c:set value="수정" var="insertAndUpdate"/>
   <c:set value="목록" var="cancleAndList"/>
</c:if> --%>
<c:set value="결재요청" var="stts"/>
<c:if test="${status eq 'u' }">
	<c:set value="결재재요청" var="stts"/>
</c:if>


<form action="/company/empElaprInsert.do" id="formInsert" method="post">
	<c:if test="${status eq 'u' }">
		<input type="hidden" name="docFormNo" value="${elaprVO.elaprNo }"/>
		<input type="hidden" name="elaprNo" value="${elaprVO.elaprNo }"/>
	</c:if>
	<div>
		<div class="d-flex flex-column flex-root app-root" id="kt_app_root">
	         <div class="app-page flex-column flex-column-fluid" id="kt_app_page">
	            <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	               <div class="d-flex flex-column flex-column-fluid">
	                  <div id="kt_app_content" class="app-content flex-column-fluid">
	                  	<div id="kt_app_content_container" class="app-container container-fluid">
	                        <div style="display: flex; margin-bottom: 50px;">
	                           <!-- 양식 등록 시작 -->
	                              <div class="card card-flush" style="width: 100%"> 
	                                  <div class="container">
											<div class="card-header">
		                                         <div class="card-title" style="width: 100%;">
		                                            <div style="width: 100%; display: flex; justify-content: space-between;">
		                                               <div style="display: flex; align-items: center; width: 120%;">
		                                               
		                                               		<!-- 
		                                               			결재(i) 	 : 양식 불러오기 / 결재 정보 / 취소 / 미리보기 / 결재요청
		                                               			상신취소 (u) : 결재정보 / 취소 / 미리보기 / 삭제 / 결재요청
		                                               		 -->
			                                               	<c:if test="${status eq 'i' }">
			                                               		<h2><font style="vertical-align: inherit;" class="me-2"><font style="vertical-align: inherit;">결재하기</font></font></h2>
			                                               	</c:if>
			                                               	<c:if test="${status eq 'u' }">
			                                               		<h2><font style="vertical-align: inherit;" class="me-2"><font style="vertical-align: inherit;">상신취소</font></font></h2>
			                                               	</c:if>
			                                               	
			                                               	<button type="button" class="btn btn-outline-secondary me-2" data-bs-toggle="modal" data-bs-target="#modal_add_addrBook"><i class="bi bi-person-check">결재정보</i></button>
			                                               	<c:if test="${status eq 'i'}">
			                                               		<button id="formCallJstree" type="button" class="btn btn-outline-secondary me-2" data-bs-toggle="modal" data-bs-target="#formCall1"><i class="bi bi-card-checklist">양식 불러오기</i></button>
			                                               	</c:if>
			                                               	<button type="button" id="cancleBtn" class="btn btn-outline-secondary me-2"><i class="bi bi-x-circle">취소</i></button>
			                                               	<button type="button" id="previewBtn2" class="btn btn-outline-secondary me-2"><i class="bi bi-eye">미리보기</i></button>
			                                               	<c:if test="${status eq 'u' }">
			                                               		<button type="button" id="delBtn" class="btn btn-outline-secondary me-2"><i class="bi bi-trash">삭제</i></button>
			                                               	</c:if>
			                                               	<button type="button" id="" class="btn btn-outline-secondary me-2"  data-bs-toggle="modal"  data-bs-target="#reqElapr"><i class="bi bi-pencil-square">결재요청</i></button>
		                                               </div>
		                                               
		                                               
		                                               <!-- 결재정보 모달 시작  -->
														<div class="modal-content modal-rounded">
															<div class="modal fade" id="modal_add_addrBook" tabindex="-1" aria-hidden="true">
																<div class="modal-dialog modal-fullscreen p-9">
																	<div class="modal-content modal-rounded">
																		<div class="row modal-body">
																			<div class="col-12 col-xl-6">
																				<div class="card card-flush h-xl-100 d-flex flex-column">
																					<div class="card-header border-0 pt-7">
																						<h1>${companyVO.coNm }</h1>
																					</div>
																					<div class="separator separator-dashed my-0"></div>
																					<div class="row card-body pt-5">
																						<div class="col-5">
																							<div class="bg-gray-100 bg-opacity-70 rounded-2 px-6 pt-5 pb-5">
																								<div class="container mt-3 mb-max">
																									<h1>주소록</h1>
																						            <div class="separator separator-dashed my-0 pt-3"></div>
																									<div class="scrollable-list pb-5" style="max-height: 355px; overflow-y: auto;">
																										<div class="d-flex align-items-center collapsible py-1 toggle mb-0" data-bs-toggle="collapse" data-bs-target="#kt_job_all">
																									        <div class="btn btn-sm btn-icon mw-20px btn-active-color-primary me-2">
																									            <i class="ki-duotone ki-plus-square toggle-off fs-1">
																									                <span class="path1"></span>
																									                <span class="path2"></span>
																									                <span class="path3"></span>
																									            </i>
																									            <i class="ki-duotone ki-minus-square toggle-on text-primary fs-1">
																									                <span class="path1"></span>
																									                <span class="path2"></span>
																									            </i>
																									        </div>
																									        <h4 class="text-gray-700 fw-bold cursor-pointer mt-2">전체 부서</h4>
																									    </div>
																									    <div class="container pl-max">
																										    <div id="kt_job_all" class="collapse fs-6">
																										        <c:forEach items="${deptTeamList}" var="dept">
																											    <div class="d-flex align-items-center collapsible py-1 toggle mb-0" data-bs-toggle="collapse" data-bs-target="#kt_job_${dept.deptCd}">
																											        <div class="btn btn-sm btn-icon mw-20px btn-active-color-primary me-2">
																											            <i class="ki-duotone ki-plus-square toggle-off fs-1">
																											                <span class="path1"></span>
																											                <span class="path2"></span>
																											                <span class="path3"></span>
																											            </i>
																											            <i class="ki-duotone ki-minus-square toggle-on text-primary fs-1">
																											                <span class="path1"></span>
																											                <span class="path2"></span>
																											            </i>
																											        </div>
																											        <h4 class="text-gray-700 fw-bold cursor-pointer mt-2">${dept.deptNm}</h4>
																											    </div>
																											    <div id="kt_job_${dept.deptCd}" class="collapse fs-6 ml-5">
																											        <c:forEach items="${dept.teamVO}" var="team">
																											            <div id="team_${team.teamCd }" class="nested-team-list mb-2 text-gray-600 fw-semibold fs-6 ps-10" style="flex-grow: 1; cursor: pointer;"> ㆍ ${team.teamNm}
																												        	<input type="hidden" id="teamCdVal" value="${team.teamCd }">
																											            </div>
																											        </c:forEach>
																											    </div>
																												</c:forEach>
																										    </div>
																									    </div>
																									</div>
																								</div>
																							</div>
																						</div>
																						<div class="col-7">
																						    <div class="bg-gray-100 bg-opacity-70 rounded-2 px-6 py-5" style="height: auto;">
																						        <div class="container mt-3">
																						            <div class="d-flex justify-content-between align-items-center">
														                                                <h1>사원 목록</h1>
														                                                <i class="ki-duotone ki-abstract-41 fs-5 text-gray-700" id="showAllEmployees" style="cursor: pointer;">
														   	                                                <span class="path1"></span>
														       	                                            <span class="path2"></span>
														           	                                    </i>
														                                            </div>
																						            <table class="table">
																						                <thead>
																						                    <tr>
																						                        <th style="width: 30px;">
																						                            <div class="form-check form-check-sm form-check-custom form-check-solid">
																						                                <input class="form-check-input" id="allChk" type="checkbox" value="1" style='cursor: pointer;'/>
																						                            </div>
																						                        </th>
																						                        <th class="align-middle text-gray-600 fw-semibold fs-6" style="width: 180px;">아이디</th>
																						                        <th class="align-middle text-gray-600 fw-semibold fs-6">이름</th>
																						                    </tr>
																						                </thead>
																						            </table>
																						            <div class="separator separator-dashed"></div>
																						            <div class="scrollable-list" style="max-height: 300px; overflow-y: auto;">
																						                <table class="table table-borderless" id="addrEmpList">
																						                    <tbody>
																						                        <c:forEach items="${empAllList}" var="emp">
																						                            <tr>
																						                                <td style="width: 30px;">
																						                                    <div class="form-check form-check-sm form-check-custom form-check-solid">
																						                                        <input class="form-check-input" type="checkbox" value="${emp.empId }" style='cursor: pointer;'/>
																						                                    </div>
																						                                </td>
																						                                <td class="align-middle">
																						                                    <div class="fv-row mb-1 text-gray-600 fw-semibold fs-6" style="width: 150px;">${emp.empId}</div>
																						                                </td>
																						                                <td class="align-middle">
																						                                    <div class="fv-row mb-1 text-gray-600 fw-semibold fs-6">${emp.empNm}</div>
																						                                </td>
																						                            </tr>
																						                        </c:forEach>
																						                    </tbody>
																						                </table>
																						            </div>
																						        </div>
																						    </div>
																						</div>
																					</div>
																				</div>
																			</div>
																			<div class="col-12 col-xl-5">
																				<div class="card card-flush h-xl-100 d-flex flex-column" id="empIdChk">
																					<div class="row card-body">
																					    <div class="row col-12">  
																					        <div style="display: flex"> 
																					        	<h5 class="col-12" style="width: 82%;">결재선</h5> 
																					        	<div>   
																						            <span class="form-check-label me-2">대표 포함</span>
																						            <input class="form-check-input" type="checkbox" id="sendToCeoCard1">
																					        	</div>
																					        </div>
														                                    <div class="scrollable-list bg-gray-100 bg-opacity-70 rounded-2 px-6 py-1 ms-3" style="height: 120px; flex-grow: 1; cursor: pointer; border: 2px solid #aee2fc" id="card1">
														                                        <div class="scrollable-list" style="max-height: 110px; overflow-y: auto;">
														                                            <table class="table">
														                                                <tbody id="moveData1">
														                                                </tbody>
														                                            </table>
														                                        </div>
														                                    </div>
														                                </div>
														                            </div>
														                            <div class="row card-body">
														                                <div class="col-12">
														                                    <h5>참조자</h5>
														                                    <div class="scrollable-list bg-gray-100 bg-opacity-70 rounded-2 px-6 py-1" style="height: 120px; flex-grow: 1; cursor: pointer;" id="card2">
														                                        <div class="scrollable-list" style="max-height: 110px; overflow-y: auto;">
														                                            <table class="table">
														                                                <tbody id="moveData2">
														                                                </tbody>
														                                            </table>
														                                        </div>
														                                    </div>
														                                </div>
														                            </div>
														                            <div class="row card-body">
														                                <div class="col-12">
														                                    <h5>열람자</h5>
														                                    <div class="scrollable-list bg-gray-100 bg-opacity-70 rounded-2 px-6 py-1" style="height: 120px; flex-grow: 1; cursor: pointer;" id="card3" >
														                                        <div class="scrollable-list" style="max-height: 110px; overflow-y: auto; ">
														                                            <table class="table">
														                                                <tbody id="moveData3">
														                                                </tbody>
														                                            </table>
														                                        </div>
														                                    </div>
														                                </div>
														                            </div>
																				</div>
																				<div class="col-12 col-xl-2">
																				</div>
																			</div>
																			<div class="col-12 col-xl-1 d-flex flex-column justify-content-between"> 
																			    <div class="symbol-label d-flex justify-content-center" style="cursor: pointer;" onclick="$('#modal_add_addrBook').modal('hide');">
																			        <img src="/upload/close_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png" class="w-25">
																			    </div>
																			    <div class="symbol-label d-flex justify-content-center align-items-center" style="flex-grow: 1;">
																			        <img src="/upload/arrow_forward_ios_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png" class="w-75" style="cursor: pointer;" id="submitBtn">
																			    </div>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
														
														<input type="hidden" value="${companyVO.ceoId }" id="ceoIdVal">
														<input type="hidden" value="${companyVO.ceoNm }" id="ceoNmVal">
														<%-- <c:forEach var="apln" items="${aplnList}" varStatus="status">
														    <input type="hidden" name="aplnList[${status.index}].empId" value="${apln.empId}">
														    <input type="hidden" name="aplnList[${status.index}].empNm" value="${apln.empNm}">
														</c:forEach> --%>
														
														<input type="hidden" id="aplnList" name="card1List">
														<input type="hidden" id="rerncList" name="card2List">
														<input type="hidden" id="prslList" name="card3List">


		                                               <!-- 결재정보 모달 종료 -->
		                                               <!-- 결재요청 모달 시작 -->
		                                               <div class="modal fade" tabindex="-1" id="reqElapr">
		                                               		<div class="modal-dialog modal-dialog-scrollable">		                                               			
		                                               			<div class="modal-content">
		                                               				<div class="modal-header">
		                                               					<h5 class="modal-title">결재요청</h5>
																		<div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
																			<i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
																		</div>
																	</div>
																	<div class="modal-body" style="min-height: 200px">
																		<div class="mb-10 fv-row">
																			<label class="required form-label">기안의견</label>
																			<textarea id="elaprOpnnCn" name="elaprOpnnCn" class="form-control mb-2" placeholder="의견을 작성해주세요">${elaprVO.elaprOpnnCn}</textarea>
																		</div>
																		<div class="mb-10 fv-row">
																			<label class="required form-label">긴급문서</label>
																			<label class="form-check form-check-custom form-check-solid me-10">
																				<input class="form-check-input h-15px w-15px" type="checkbox" id="elaprEmrgYnCheckbox" value="Y" >
																				<span class="form-check-label fw-semibold">긴급</span>
																			</label>
																			<input type="hidden" id="elaprEmrgYn" name="elaprEmrgYn" value="N">
																		</div>
																	</div>
																	<div class="modal-footer">
																		<input type="button" value="${stts }" id="addBtn" class="btn btn-primary me-2">
																		<button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
																	</div>
																</div>
															</div>
														</div>
														<!-- 결재요청 모달 종료 -->
														<div>
															<c:choose>
																<c:when test="${status ne 'i' }">
																<sec:authentication property="principal.member" var="emp"/>
																	<c:if test="${emp.empId eq formVO.empId}">
																		<!-- <button id="formCallJstree" type="button" class="btn btn-light-info ms-2" data-bs-toggle="modal" data-bs-target="#formCall1">
																		 	 양식 불러오기
																		</button> -->
																	</c:if>
																</c:when>
																<c:otherwise>
																	<!-- <button id="formCallJstree" type="button" class="btn btn-light-info ms-2" data-bs-toggle="modal" data-bs-target="#formCall1">
																	 	 양식 불러오기
																	</button> -->
																</c:otherwise>
															</c:choose>
														</div>
													</div>
													<!-- 양식 불러오기 모달 시작 -->
													<div class="modal fade" tabindex="-1" id="formCall1">
														<div class="modal-dialog modal-dialog-scrollable">
															<div class="modal-content">
																<div class="modal-header">
																	<h5 class="modal-title">양식 불러오기</h5>
																	<div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
																		<i class="ki-duotone ki-cross fs-2x">
																			<span class="path1"></span><span class="path2"></span>
																		</i>
																	</div>
																</div>
																<div class="modal-body" style="min-height: 300px">
																	<!-- jstree 시작 -->
																	<div class="card card-flush">
																		<div class="card bg-light shadow-sm">
																			<div class="card-header">
																				<h3 class="card-title">양식목록</h3>
																			</div>
																			<div class="card-body">
																				<div id="formJstree">
																					<ul id="treeUl">
																						<c:forEach var="form" items="${docFormKndNmList }">
																							<li data-docformno="${form.docFormNo }">${form.docFormKndNm }</li>
																						</c:forEach>
		                                                                  			</ul>
		                                                               			</div>
		                                                           			</div>
		                                                    			</div>
		                                                   			</div>
		                                                      		<!-- jstree 끝 -->
		                                                      	</div>
		                                                      	<input type="hidden" name="docFormNo" value="" id="docFormNo">
		                                                      	<div class="modal-footer">
		                                                      		<button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
		                                                      		<button type="button" id="previewBtn" class="btn btn-skyblue" style="background-color: #569effed; color: white;">불러오기</button>
		                                                      	</div>
		                                                  	</div>
		                                             	</div>
		                                          	</div>
		                                          <!-- 양식 불러오기 모달 끝 -->
		                                        </div>
	                                   		</div>
	                                    	<!-- card-body 시작 -->
		                                    <div class="card-body pt-0" style="margin-top: 20px;">
		                                    	<div class="mb-10 fv-row fv-plugins-icon-container">
		                                    		<div style="display: flex;">
		                                    			<div style="width: 13%;">
		                                    				<label class="form-label" style="margin-top: 10px;">제목 <font style="color: red">*</font></label>
		                                   				</div>
		                                   				<c:choose>
		                                   					<c:when test="${status eq 'u' }">
		                                   					<sec:authentication property="principal.member" var="emp" />
				                                 				<c:choose>
				                                 					<c:when test="${emp.empId eq elaprVO.empId}">
				                                 						<input style="width: 85%;" type="text" id="elaprNm" name="elaprNm" class="form-control mb-2" value="${elaprVO.elaprNm }">
				                                					</c:when>
					                                				<c:otherwise>
					                                						<input style="width: 85%;" type="text" id="elaprNm" name="elaprNm" class="form-control mb-2" value="${elaprVO.elaprNm }" disabled>
					                                				</c:otherwise>
				                               					</c:choose>
		                               						</c:when>
		                               						<c:otherwise>
		                               							<input style="width: 85%;" type="text" id="elaprNm" name="elaprNm" class="form-control mb-2" placeholder="제목을 입력해주세요." value="${elaprVO.elaprNm }">
		                              						</c:otherwise>
		                            					</c:choose>
		                           					</div>
		                           					<span class="error invalid-feedback" style="display:block;">${error.docFormNm }</span>
		                           					<!--CKEditor 시작-->
		                           					<div style="width: 100%; min-width: 720px; display: flex; justify-content: center; background-color: #dbdbdb; border: 1px solid #f8f8f8;">
		                           						<c:choose>
		                           							<c:when test="${status eq 'u' }">
		                           							<sec:authentication property="principal.member" var="emp" />
			                           							<c:choose>
			                           								<c:when test="${emp.empId eq elaprVO.empId}">
			                           									<textarea id="formEditorCK" name="elaprCn" style="position: absolute;">
												                            ${elaprVO.elaprCn }
												              			</textarea>
												            		</c:when>
												            		<c:otherwise>
												              			<textarea id="formEditorCK" name="elaprCn" style="position: absolute;" disabled>
												                    	    ${elaprVO.elaprCn }
												              			</textarea>
												            		</c:otherwise>
												          		</c:choose>
											        		</c:when>
											        		<c:otherwise>
											         			<textarea id="formEditorCK" name="elaprCn" style="position: absolute;"></textarea>
										         			</c:otherwise>
									         			</c:choose>
								         			</div>
											    	<%-- <div style="display: flex; justify-content: right;">
											     		<c:choose>
											        		<c:when test="${status ne 'i' }">
											          			<sec:authentication property="principal.member" var="emp" />
											          			<c:if test="${emp.empId eq formVO.empId}">
											           				<div style="margin-top: 25px; margin-bottom: 20px;">
											              				<input type="button" id="addBtn" class="btn btn-light-primary" value="${insertAndUpdate }">
											            			</div>
												            		<c:if test="${status eq 'u' }">
												              			<div style="margin-top: 25px; margin-bottom: 20px; margin-left: 5px;">
												                			<input type="button" id="deleteBtn" class="btn btn-light-danger" value="삭제">
												              			</div>
												            		</c:if>
												            		<div style="margin-top: 25px; margin-bottom: 20px; margin-left: 5px;">
												              			<input type="button" id="cancleBtn" class="btn btn-light-info" value="${cancleAndList }">
												            		</div>
											          			</c:if>
											        		</c:when>
										        			<c:otherwise>
										          				<div style="margin-top: 25px; margin-bottom: 20px;">
										            				<input type="button" id="addBtn" class="btn btn-light-primary" value="등록">
										          				</div>
										          				<div style="margin-top: 25px; margin-bottom: 20px; margin-left: 5px;">
										            				<input type="button" id="cancleBtn" class="btn btn-light-info" value="목록">
										          				</div>
										        			</c:otherwise>
											      		</c:choose>
											    	</div> --%>
											  	</div>
											</div>
		                                    <!-- card-body 끝 -->
		                                    <!-- 미리보기 모달 시작 -->
	                                    	<div class="modal fade" id="previewModal" tabindex="-1" aria-labelledby="previewModalLabel" aria-hidden="true">
												<div class="modal-dialog modal-lg">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title" id="previewModalLabel">미리보기</h5>
															<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
														</div>
														<div class="modal-body">
												        	<!-- CKEditor 내용을 표시할 부분 -->
												        	<div id="modalContent"></div>
												        </div>
												       	<div class="modal-footer">
												       		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
												       	</div>
										       		</div>
									       		</div>
									       	</div>
		                                    <!-- 미리보기 모달 끝 -->
	                                 	</div>
	                                	<!-- container -->
	                                </div>
									<!-- 양식 등록 끝 -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<script>
let docFormNoSelect = "";

$(function () {
	// ***** form Process *****
	let addBtn = $('#addBtn');
	let cancleBtn = $('#cancleBtn');
	let formInsert = $('#formInsert');
	let delBtn = $('#delBtn');
	let deleteBtn = $('#deleteBtn');
	let delForm = $('#delForm');
	let udtBtn = $('#udtBtn');

	// 취소 버튼 클릭
	cancleBtn.on('click', function () {
		Swal.fire({
			title: '취소하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#4FC9DA',
			cancelButtonColor: '#F06445',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false, // 버튼 순서 (기본)

		}).then((result) => {
			if (result.isConfirmed) {
				location.href = "/company/empElaprDraft.do";		// 기안 문서함 이동
			}
		})
	});

	// 등록/수정 버튼 클릭
	addBtn.on('click', function () {
	    console.log("addBtn click");
	    
	    let docFormNo = $("#docFormNo").val();
	    console.log("docFormNo", docFormNo);

	    let elaprNm = $('#elaprNm').val();
	    let docFormKndNm = $('#docFormKndNm').val();
	    let content = CKEDITOR.instances.formEditorCK.getData();

	    console.log("elaprNm", elaprNm);
	    console.log("docFormKndNm", docFormKndNm);
	    console.log("content", content);
	    
	    // 긴급문서 체크 여부 확인 후 값 설정
	    let elaprEmrgYn = $('#elaprEmrgYnCheckbox').is(":checked") ? 'Y' : 'N';
	    $('#elaprEmrgYn').val(elaprEmrgYn);

	    console.log("긴급여부 체크 : ", elaprEmrgYn);

	    // 필수 항목 검증
	    if ( elaprNm == null || elaprNm == "" || elaprOpnnCn == null || elaprOpnnCn == "") {
	        Swal.fire({
	            icon: 'warning',
	            title: '필수 입력이 비어있습니다.',
	            text: '필수 입력 내용을 채워주세요.',
	            confirmButtonColor: '#4FC9DA',
	        });
	        return false;
	    }

	    // 수정일 때
	    if ($(this).val() == '결재재요청') {
	        formInsert.attr("action", "/company/empElaprUpdate.do");
	    }

	    formInsert.submit();
	});


	// 삭제 버튼 클릭
	delBtn.on('click', function () {
		Swal.fire({
			title: '결재를 정말 삭제하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#F06445',
			cancelButtonColor: '#4FC9DA',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false, // 버튼 순서 (기본)

		}).then((result) => {
			if (result.isConfirmed) {
				formInsert.attr("action", "/company/empElaprDelete.do");
				formInsert.submit();
			}
		})
	});
	
	// 삭제 버튼 클릭
	deleteBtn.on('click', function () {
		Swal.fire({
			title: '양식을 정말 삭제하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#F06445',
			cancelButtonColor: '#4FC9DA',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false, // 버튼 순서 (기본)

		}).then((result) => {
			if (result.isConfirmed) {
				formInsert.attr("action", "/company/empElaprDelete.do");
				formInsert.submit();
			}
		})
	});
	
	  
	CKEDITOR.editorConfig = function( config ) {
		config.removeButtons = 'Link';
	}

	/* CKEDITOR 자바스크립트 */
	CKEDITOR.replace('formEditorCK', {
		height: 500,
		width: 740,
		// 사용하려는 툴바의 버튼을 문자열로 지정해서 포함시킴
		toolbar: [
			{ name: 'document', items: ['Source', 'ExportPdf', 'Print', 'Newpage'] },
			{ name: 'html', items: ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'HiddenField'] },
			{ name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'Undo', 'Redo', 'Find', 'Replace', 'Selectall'] },
			{ name: 'alignment', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', 'BidirectionalLTR', 'BidirectionalRTL'] },
			{ name: 'styles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', 'Numberedlist', 'Bulletedlist', 'Outdent', 'Indent'] },
			{ name: 'insert', items: ['Image', 'Table', 'HorizontalRule', 'SpecialChar', 'PageBreak', 'CreateDiv', 'Insertdiv'] },
			{ name: 'custom', items: ['Styles', 'Font', 'FontSize', 'TextColor', 'BGColor', 'NumberedList', 'BulletedList', 'Maximize'] }
		]
	});
	

	
	$("#previewBtn2").on("click", function () {
		console.log("click");
        // CKEditor에 있는 내용을 가져옴
        let content = CKEDITOR.instances.formEditorCK.getData();

        // 모달창의 콘텐츠 영역에 CKEditor에서 가져온 내용 삽입
        $("#modalContent").html(content);

        // 모달창 표시
        $("#previewModal").modal('show');
    });

	// jstree 자바스크립트에서 사용할 계층형 데이터 가져오기
	$('#formCallJstree').on('click', function () {
		$('#treeUl').html("");
		$.ajax({
			type: "get",
			url: "/company/elaprSelectJstree.do",
			success: function (data) {
				f_createJstree(data);
				console.log(data);
			}
		});
	});
	
	$("#previewBtn").on("click", function () {
		console.log("docForlmNoSelect", docFormNoSelect);
		$("#docFormNo").val(docFormNoSelect);
		
		$.ajax({
			url : "/company/elaprSelectForm.do?docFormNo=" + docFormNoSelect,
			type : "get",
			success : function (data) {
				
				if (CKEDITOR.instances.formEditorCK) {
					CKEDITOR.instances.formEditorCK.setData(data.docFormCn);
				} else {
					console.error("CKEDITOR instance not found");
				}
				
				
				$.ajax({
					url : "/company/empElaprSelectImpl.do",
					type : "get",
					dataType : "JSON",
					success : function (data) {
						console.log(data);
						
						let content = CKEDITOR.instances.formEditorCK.getData();
						
						content = content.replace(/\#\{(\w+)\}/g, function(match, key) {
                            return data[key] !== undefined ? data[key] : match; // 데이터가 없으면 원래의 값을 반환
                        });

                        CKEDITOR.instances.formEditorCK.setData(content); 
                        
                        $("#formCall1").modal('hide');
					}
				})
			}
		})
	});
});

// jstree용 데이터 가공해서 추가하기
function f_createJstree(treeData) {
	// 트리 구조를 만들기 위한 객체
	const tree = {};

	// 데이터 구조를 트리 형태로 변환
	treeData.forEach(node => {
		tree[node.id] = { ...node, children: [] };
	});

	// 자식 노드를 연결
	Object.values(tree).forEach(node => {
		if (node.parent !== "#") {
			tree[node.parent].children.push(node);
		}
	});

	// 최상위 노드만 추출
	const rootNodes = Object.values(tree).filter(node => node.parent === "#");

	// 정해진 형식으로 HTML 생성하기
	const treeHTML = generateHTML(rootNodes);

	// 결과를 DOM에 삽입하기
	console.log(treeHTML);

	$('#treeUl').html(treeHTML); // treeUl에 jstree HTML을 삽입함

	// 삽입한 HTML을 jstree 형식과 매칭하기
	$('#formJstree').jstree({
		"core": {
			"themes": {
				"responsive": false
			}
		},
		"types": {
			"default": {
				"icon": "ki-outline ki-file text-warning"
			},
			"file": {
				"icon": "ki-outline ki-notification-status text-danger fs-7"
			}
		},
		"plugins": ["types", "dnd"]
	})

	// 양식을 선택하면 CKEDITOR에 양식 내용 삽입하기
	$("#formJstree").bind("select_node.jstree", function (event, data) {
		console.log(data.node.li_attr.value);
		let docFormNo = data.node.li_attr.value;
		
		docFormNoSelect = docFormNo;
	})

}

//HTML 생성 함수
function generateHTML(nodes) {
	let html = "";
	nodes.forEach(node => {
		const isRoot = node.parent === "#";
		html += `<li data-jstree='{"type" : "\${node.type}"` + (', "opened": true') + `}' value='\${node.id}'>\${node.text}`;

		// 자식 노드가 있는 경우 
		if (node.children && node.children.length > 0) {
			html += "<ul>" + generateHTML(node.children) + "</ul>"; // 자식 노드 재귀 호출
		}

		html += "</li>";
	});
	return html;
}


// 결재 정보 모달
$(function () {
	  var teamName = $(".nested-team-list");
	    var moveData1 = $("#moveData1");
	    var moveData2 = $("#moveData2");
	    var moveData3 = $("#moveData3");
	    var card1 = $("#card1");
	    var card2 = $("#card2");
	    var card3 = $("#card3");
	    var nowCard = "card1";
	    var showAllEmployees = $("#showAllEmployees");
	    var myArray = [];
	    var submitBtn = $("#submitBtn");
	    var sendToCeoCard1 = $("#sendToCeoCard1");
	    
	    submitBtn.on("click", function () {
			let card1Data = [];
			let card2Data = [];
			let card3Data = [];
	    	
			moveData1.find('tr').each(function () {
		        let empId = $(this).data('emp-id');
		        let empNm = $(this).find('td:eq(1)').text(); // 이름 가져오기
		        
		        console.log("empId : " + empId);
		        console.log("empNm : " + empNm);
		        
		        card1Data.push({ 
		        	empId: empId, 
		        	empNm: empNm
		        });
		        
		        // ------------ 수정한 부분 ------------
		        $('#aplnList').val(JSON.stringify(card1Data));
		        $('#modal_add_addrBook').modal('hide');
		    });

		    moveData2.find('tr').each(function () {
		        let empId = $(this).data('emp-id');
		        let empNm = $(this).find('td:eq(1)').text(); // 이름 가져오기
		        card2Data.push({ 
		        	empId: empId, 
		        	empNm: empNm
		        });
		    });

		    moveData3.find('tr').each(function () {
		        let empId = $(this).data('emp-id');
		        let empNm = $(this).find('td:eq(1)').text(); // 이름 가져오기
		        card3Data.push({
		        	empId: empId,
		        	empNm: empNm 
		        });
		    });

		    console.log(card1Data);
		    console.log(card2Data);
		    console.log(card3Data);
		    
		    
		    // 결재선 등록
 		    let aplnHtml = '';
		    card1Data.forEach(function(emp, index) {
		    	console.log("index" + index);
		    	aplnHtml += `
		            <input type='hidden' name='aplnList[\${index}].empId' value='\${emp.empId}'>
		            <input type='hidden' name='aplnList[\${index}].empNm' value='\${emp.empNm}'>
		        `;
		    });
		    document.getElementById('aplnList').innerHTML = aplnHtml;
		    
		    // 참조자 등록
 		    let rerncHtml = '';
		    card2Data.forEach(function(emp, index) {
		    	rerncHtml += `
					<input type='hidden' name='rerncList[\${index}].empId' value='\${emp.empId}'>
					<input type='hidden' name='rerncList[\${index}].empNm' value='\${emp.empNm}'>
				`;
			});
			document.getElementById('rerncList').innerHTML = rerncHtml;
				
			// 열람자 등록
 		    let prslHtml = '';
			card3Data.forEach(function(emp, index) {
				prslHtml += `
				<input type='hidden' name='prslList[\${index}].empId' value='\${emp.empId}'>
				<input type='hidden' name='prslList[\${index}].empNm' value='\${emp.empNm}'>
				`;
			})
			document.getElementById('prslList').innerHTML = prslHtml;

		    
		    console.log(aplnHtml, rerncHtml, prslHtml);

		    $('#modal_add_addrBook').modal('hide');
		});
	    /*
	    $(document).ready(function () {
	        // JSP에서 aplnList를 JSON 문자열로 받아 JavaScript 객체로 변환
	        const aplnList = JSON.parse('${aplnListJson}');

	        // `aplnList` 값을 동적으로 각 `<td>`에 할당
	        aplnList.forEach((apln, index) => {
	            // 첫 번째 tr의 td: 사원 ID를 설정
	            $(`#approval-table tr:eq(1) td:eq(\${index + 1})`).text(apln.empId);

	            // 두 번째 tr의 td: 사원 이름 설정
	            $(`#approval-table tr:eq(2) td:eq(\${index + 1})`).text(apln.empNm);

	            // 세 번째 tr의 td: 도장 이미지 추가
	            $(`#approval-table tr:eq(3) td:eq(\${index + 1})`).html(`
	                <span style="position: relative;">
	                    (인)
	                    <img src="\${contextPath}/resources/file/image/groubear_sign.png" 
	                         style="position: absolute; width: 20px; top: -2px; left: 10px;">
	                </span>
	            `);
	        });
	    });
	    */
	    sendToCeoCard1.on("change", function () {
	    	console.log("바뀌긴 바뀜");
	    	let ceoNm = $("#ceoNmVal").val();
	    	let ceoId = $("#ceoIdVal").val();
	    	
	        if ($(this).is(':checked')) {
	        	 let html = "<tr data-emp-id='" + ceoId + "'><td class='align-middle'><div class='fv-row mb-1 text-gray-900 fw-bold fs-6' style='width: 150px;'>" + ceoId + "</div></td>";
	             html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-900 fw-bold fs-6'>" + ceoNm + "</div></td>";
	             html += "<td class='align-middle text-gray-900 fw-bold fs-6'>대표</td></tr>";
	            
	            moveData1.append(html);
	        } else {
	        	$("#moveData1 tr[data-emp-id='" + ceoId + "']").remove();
	        }
	    });
	    
	    showAllEmployees.on("click", function () {
	        let addrEmpList = $("#addrEmpList");
	        console.log("클릭이벤트실행 : ");
	        updateAllChkState()
	        $.ajax({
	            url: "/addressbook/getaddrallemp.do",
	            type: 'GET',
	            contentType: 'application/json; charset=UTF-8',
	            success: function (res) {
	                let html = "";

	                if (res && res.length > 0) {
	                    res.forEach(emp => {
	                        html += "<tbody>";
	                        html += "<tr><td style='width: 30px;'><div class='form-check form-check-sm form-check-custom form-check-solid'><input class='form-check-input' type='checkbox' value='" + emp.empId + "' /></div></td>";
	                        html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6' style='width: 150px;'>" + emp.empId + "</div></td>";
	                        html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6'>" + emp.empNm + "</div></td></tr>";
	                        html += "</tbody>";
	                    });
	                } else {
	                    html += "<tr><td colspan='4' class='text-center text-gray-600 fw-semibold fs-6 pt-10'>사원 정보가 없습니다.</td></tr>";
	                }

	                addrEmpList.empty().append(html);

	                // 팀 사원 목록을 불러온 후, 체크된 상태 유지
	                $("#addrEmpList .form-check-input").each(function () {
	                    let empId = $(this).val();
	                    if ($("#moveData1 tr[data-emp-id='" + empId + "']").length > 0) {
	                        $(this).prop('checked', true);
	                    }
	                    if ($("#moveData2 tr[data-emp-id='" + empId + "']").length > 0) {
	                        $(this).prop('checked', true);
	                    }
	                    if ($("#moveData3 tr[data-emp-id='" + empId + "']").length > 0) {
	                        $(this).prop('checked', true);
	                    }
	                });
	            },
	        });
		})
	    
	    card1.on("click", function () {
	    	console.log("card1 클릭");
	    	nowCard = 'card1';
	    	console.log(nowCard);
	    	
	    	$("#card1").css("border", "2px solid #aee2fc");
	    	$("#card2").css("border", "none");
	    	$("#card3").css("border", "none");
	    });    
	    
	    card2.on("click", function () {
	    	console.log("card2 클릭");
	    	nowCard = 'card2';
	    	console.log(nowCard);
	    	$("#card1").css("border", "none");
	    	$("#card2").css("border", "2px solid #aee2fc");
	    	$("#card3").css("border", "none");
		});
	    
	    card3.on("click", function () {
	    	console.log("card3 클릭");
	    	nowCard = 'card3';
	    	console.log(nowCard);
	    	$("#card1").css("border", "none");
	    	$("#card2").css("border", "none");
	    	$("#card3").css("border", "2px solid #aee2fc");
		});

	    $(document).on("change", "#allChk", function () {
	       	myArray = [];
	        // 체크박스가 상위 체크박스일 경우
	        if ($(this).is(':checked')) {
	        	
	        	
	        	$("#empIdChk [data-emp-id]").each(function () {
	                let firstEmpId = $(this).data('emp-id');
	                if (!myArray.includes(firstEmpId)) {
	                    myArray.push(firstEmpId);
	                }
	            });
	        	
	    		console.log(myArray);
	    		
	            $("#addrEmpList .form-check-input").prop('checked', true); // 체크박스 체크
	            $("#addrEmpList .form-check-input").each(function () {
	                let empId = $(this).val();
	                
	                
	                if (!myArray.includes(empId)) {
	                    let empNm = $(this).closest('tr').find('td:eq(2)').text(); // 이름 가져오기
	                    let html = "";
	                 
	                    html += "<tr data-emp-id='" + empId + "'><td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6' style='width: 150px;'>" + empId + "</div></td>";
	                    html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6'>" + empNm + "</div></td>";
	                    html += "<td class='align-middle'><i class='ki-duotone ki-trash fs-6 remove-emp' data-emp-id='" + empId + "' style='cursor: pointer; color: #gray;'><span class='path1'></span><span class='path2'></span><span class='path3'></span><span class='path4'></span><span class='path5'></span></i></td></tr>";
	                    
	                    if (nowCard === "card1") {
	                        moveData1.append(html); 
	    				}
	                    if (nowCard === "card2") {
	                        moveData2.append(html); 
	    				}
	                    if (nowCard === "card3") {
	                        moveData3.append(html); 
	    				}
	                } else {
	    				console.log("중복된 아이디 : " + empId);
	    			}
	            });
	        } else {
	        	//////////////////////////
	        	$("#empIdChk [data-emp-id]").each(function () {
	                let firstEmpId = $(this).data('emp-id');
	                if (!myArray.includes(firstEmpId)) {
	                    myArray.push(firstEmpId);
	                }
	            });
	    		console.log(myArray);
	    		console.log("이거 실행 안 되는 중");
	    		$("#addrEmpList .form-check-input").prop('checked', false);
	        	$("#addrEmpList .form-check-input").each(function () {
	                let empId = $(this).val();
	                console.log("중복된 아이디들  : " + empId);
	                console.log("배열 안에 푸쉬된 값들  : " + myArray);
	               
	                if (myArray.includes(empId)) {
	                	console.log("이거 실행 안 되는 중인가?");
	                    $("#moveData1 tr[data-emp-id='" + empId + "']").remove();
	                    $("#moveData2 tr[data-emp-id='" + empId + "']").remove();
	                    $("#moveData3 tr[data-emp-id='" + empId + "']").remove();
	                    
	                    $(this).prop('checked', false);
	                }
	            });
		        myArray = [];
	        }
	    });


	    $(document).on("change", ".form-check-input", function () {
	        let empId = $(this).val();
	        let empNm = $(this).closest('tr').find('td:eq(2)').text(); // 이름 가져오기
	        
	        if ($(this).is(':checked')) {
	            // 체크된 경우: "옮긴 데이터"에 추가
	            $.ajax({
	                url: "/addressbook/getaddempid.do",
	                type: 'GET',
	                contentType: 'application/json; charset=UTF-8',
	                data: { empId: empId },
	                success: function (res) {
	                    let html = "";
	                    console.log("ajax 결과값 :", res);

	                    // res가 객체인지 확인
	                    if (!myArray.includes(empId)) {
		                    if (res && res.empId && res.empNm) {
		                        html += "<tr data-emp-id='" + res.empId + "'><td><div class='fv-row text-gray-600 fw-semibold fs-6' style='width: 150px;'>" + res.empId + "</div></td>";
		                        html += "<td><div class='fv-row text-gray-600 fw-semibold fs-6'>" + res.empNm + "</div></td>";
		                        html += "<td><i class='ki-duotone ki-trash fs-6 remove-emp' data-emp-id='" + res.empId + "' style='cursor: pointer; color: #gray;'><span class='path1'></span><span class='path2'></span><span class='path3'></span><span class='path4'></span><span class='path5'></span></i></td></tr>"; // 아이콘 추가
		
		                        if (nowCard === "card1") {
			                        moveData1.append(html); 
								}
		                        if (nowCard == "card2") {
			                        moveData2.append(html)
								}
		                        if (nowCard == "card3") {
			                        moveData3.append(html);
								}
		                    }
	                    }
	                    $("#empIdChk [data-emp-id]").each(function () {
	                        let firstEmpId = $(this).data('emp-id');
	                        if (!myArray.includes(firstEmpId)) {
	                            myArray.push(firstEmpId);
	                        }
	                    });
						console.log(myArray);
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    console.error("AJAX 호출 실패: " + textStatus, errorThrown);
	                }
	            });
	        } else {
	            // 체크 해제된 경우: "옮긴 데이터"에서 해당 사원 제거
	            $("#moveData1 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 삭제
	            $("#moveData2 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 삭제
	            $("#moveData3 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 삭제
	        }
	        updateAllChkState();
	        myArray = [];
	    });

	    // 아이콘 클릭 이벤트 추가
	    $(document).on("click", ".remove-emp", function () {
	        let empId = $(this).data('emp-id'); // 아이콘에 저장된 empId 가져오기
	        $("#moveData1 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 해당 사원 제거
	        $("#moveData2 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 해당 사원 제거
	        $("#moveData3 tr[data-emp-id='" + empId + "']").remove(); // "옮긴 데이터"에서 해당 사원 제거
	        $("#allChk").prop('checked', false);
	        $("#addrEmpList .form-check-input[value='" + empId + "']").prop('checked', false); // 사원 목록에서 체크박스 해제
	    });

	    // 팀 클릭 이벤트
	    teamName.on("click", function () {
	        let teamCd = $(this).find("input[id='teamCdVal']").val(); 
	        let addrEmpList = $("#addrEmpList");
	        
	        $.ajax({
	            url: "/addressbook/getaddremp.do",
	            type: 'GET',
	            contentType: 'application/json; charset=UTF-8',
	            data: { teamCd: teamCd },
	            success: function (res) {
	                let html = "";

	                if (res && res.length > 0) {
	                    res.forEach(emp => {
	                        html += "<tbody>";
	                        html += "<tr><td style='width: 30px;'><div class='form-check form-check-sm form-check-custom form-check-solid'><input class='form-check-input' style='cursor: pointer;' type='checkbox' value='" + emp.empId + "' /></div></td>";
	                        html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6' style='width: 150px;'>" + emp.empId + "</div></td>";
	                        html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6'>" + emp.empNm + "</div></td></tr>";
	                        html += "</tbody>";
	                    });
	                } else {
	                    html += "<tr><td colspan='4' class='text-center text-gray-600 fw-semibold fs-6 pt-10'>사원 정보가 없습니다.</td></tr>";
	                }

	                addrEmpList.empty().append(html);
					
	                $("#addrEmpList .form-check-input").each(function () {
	                    let empId = $(this).val();
	                    if ($("#moveData1 tr[data-emp-id='" + empId + "']").length > 0) {
	                        $(this).prop('checked', true);
	                    }
	                    if ($("#moveData2 tr[data-emp-id='" + empId + "']").length > 0) {
	                        $(this).prop('checked', true);
	                    }
	                    if ($("#moveData3 tr[data-emp-id='" + empId + "']").length > 0) {
	                        $(this).prop('checked', true);
	                    }
	                });
	                updateAllChkState();
	            },
	        });
	    });

	    function updateAllChkState() {
	        const allCheckboxes = $("#addrEmpList .form-check-input");
	        const allChecked = allCheckboxes.length > 0 && allCheckboxes.length === allCheckboxes.filter(':checked').length;
	        
	        $("#allChk").prop('checked', allChecked);
	    }

	    $(document).on("change", "#addrEmpList .form-check-input", function () {
	        updateAllChkState(); // individual checkbox 상태 변경 시 allChk 상태 업데이트
	    });
});

</script>

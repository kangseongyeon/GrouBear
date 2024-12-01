<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>


<link href="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css"/>
<script src="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.js"></script>

<!-- ckeditor API -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script> 

<!-- sweetalert2 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
 
<style> 
.clickBackColor {
    background-color: #f0ede8;
    border-radius: 0.95rem;
    width: 95%;
}

.fontColor {
	color: #4FC9DA;
}

.divHover:hover {
	background-color: var(--bs-menu-link-bg-color-show);
    border-radius: 0.95rem;
    width: 95%;
}

.word {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    width: 30em;
    display: block;
}

.cke_notifications_area { display: none; }

.button_user {
	background-color: #6e6e6e1a;
} 

.button_user:hover {
	background-color: rgb(0 115 230 / 10%);
}
 
.none {
	display: none;
}

.divHover:hover #cloudStrgDeleteBtn {
	display: block;
}

</style> 

<!-- 넘겨받은 메세지가 있을 때만 자바스크립트를 실행-->
<c:if test="${not empty message }">
	<script type="text/javascript">
		Swal.fire({ 
			icon: 'success',
			title: '${message}',
			confirmButtonColor: '#4FC9DA',
		});
	</script>
	<c:remove var="message" scope="request"/>
</c:if>

<div style="margin-bottom: 20px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>메일함</h3>
		<h6>메일함</h6>
	</div>
</div>


<div id="kt_app_content_container" class="app-container container-fluid" style="height: 100%;">
	<div class="row" style="height: 100%;">

			<!-- 메일함 목록 시작 -->
			<div class="col-2 p-0" style="width: 18%">  
		        <div class="card card-flush" style="height: 98%;"> 
		            <div class="card-body" style="padding: 0.5em;">  
		                
		                <div class="d-flex mt-3 mb-3" style="justify-content: center;">
		                	<button class="btn btn-primary px-3" style="border-right: 1px solid #F6F1E9; border-radius: 15px 0px 0px 15px; width: 7em; font-size: 0.9em;"
		                			onclick="location.href='/company/mailForm.do'">
		                	메일쓰기</button>
		                	<button class="btn btn-primary px-3" style="border-radius: 0px 15px 15px 0px; width: 7em; font-size: 0.9em;">내게쓰기</button>
		                </div>
		                
			            <div class="d-flex flex-column"> 
	                        
	                    </div>
	                    
						<!-- 메일함 메뉴 시작 -->
						<div>
						
							<!-- 중요 메일함 시작 -->
							<div class="menu-title-gray-700">
							    <div class="menu-item">
							    
									<div class="menu-title-gray-700">
				                        <div class="menu-link py-1 divHover">
					                        <div class="menu-link p-0" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')">
					                            <span class="menu-icon"> 
					                                <i class="ki-duotone ki-star text-warning"></i></span>
				                            	<span class="menu-title">중요 메일함</span>
					                        </div>
				                        </div> 
									</div>
							         
							    </div>
							</div>
							<!-- 중요 메일함 시작 끝 -->
							
							<!-- 안읽은 메일함 시작 -->
							<div class="menu-title-gray-700">
							    <div class="menu-item">
							    
									<div class="menu-title-gray-700">
				                        <div class="menu-link py-1 divHover">
					                        <div class="menu-link p-0" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')">
					                            <span class="menu-icon"> 
					                                <i class="ki-duotone ki-sms"><span class="path1"></span><span class="path2"></span></i>
				                            	</span>
				                            	<span class="menu-title">안읽은 메일함</span>
					                        </div>
				                        </div> 
									</div>
							         
							    </div>
							</div>
							<!-- 안읽은 메일함 시작 끝 -->
							
							<!-- 임시 보관함 시작 -->
							<div class="menu-title-gray-700 mb-2">
							    <div class="menu-item">
							    
									<div class="menu-title-gray-700">
				                        <div class="menu-link py-1 divHover">
					                        <div class="menu-link p-0" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')">
					                            <span class="menu-icon"> 
					                                <i class="ki-duotone ki-cube-2">
													 <span class="path1"></span>
													 <span class="path2"></span>
													 <span class="path3"></span>
													</i>
				                            	</span>
				                            	<span class="menu-title">임시 보관함</span>
					                        </div>
				                        </div> 
									</div>
							         
							    </div>
							</div>
							<!-- 임시 보관함 시작 끝 -->
							<div class="separator separator-dashed"></div>
						
							<!-- 기본 메일함 시작 -->
							<div class="menu-title-gray-700 my-2">
							    <div class="menu-item">
							    
									<div class="menu-title-gray-700">
				                        <div class="menu-link py-2 divHover">
					                        <div class="menu-link p-0" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
					                            <span class="menu-icon"> 
					                                <i class="ki-duotone ki-abstract-8 text-danger me-3"><span class="path1"></span><span class="path2"></span></i>
				                                </span>
				                            	<span class="menu-title">메일함</span>
					                        </div>
				                        </div> 
									</div>
				                    
							        <div id="customCloudStrg"> 
							        
							            <div class="menu-link py-2 divHover">
					                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
							                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
				                            	<span class="menu-title">전체 메일함</span> 
					                        </div>
				                        </div> 
							        
							            <div class="menu-link py-2 divHover clickBackColor">
					                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
							                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
				                            	<span class="menu-title">받은 메일함</span>
					                        </div>
				                        </div> 
							        
							            <div class="menu-link py-2 divHover">
					                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
							                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
				                            	<span class="menu-title">보낸 메일함</span>
					                        </div>
				                        </div> 
							        
							            <div class="menu-link py-2 divHover">
					                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
							                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
				                            	<span class="menu-title">임시 메일함</span>
					                        </div>
				                        </div> 
						
							        </div>
							         
							    </div>
							</div>
							<!-- 기본 메일함 끝 -->
							<div class="separator separator-dashed"></div>
							<!-- 개인 메일함 시작 -->
							<div class="menu-title-gray-700 my-2">
							    <div class="menu-item">
							    
									<div class="menu-title-gray-700">
				                        <div class="menu-link py-1 divHover">
					                        <div class="menu-link p-0" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 8em;">
					                            <span class="menu-icon"> 
					                                <i class="ki-duotone ki-abstract-8 text-info me-3"><span class="path1"></span><span class="path2"></span></i>
				                                </span>
				                            	<span class="menu-title">개인</span>
					                        </div>
			                            	<div id="cloudStrgPlusBtn" class="ki-outline ki-plus fs-3"></div>   
				                        </div> 
									</div>
							        
				                    <div id="cloudStrgNmDiv" style="display: none;">
					                    <div style="display: flex; justify-content: center;">
				                        	<input type="text" class="form-control" id="cloudStrgNm" name="cloudStrgNm" style="width: 70%; height: 2em; border-radius: 0.75rem;">
				                            <div class="ki-duotone ki-check fs-1 ms-1 divHover" onclick="f_cloudStrgAddBtn('${myCloudStrgVO.cloudStrgCd }')">
												 <span class="path1"></span>
												 <span class="path2"></span> 
											</div> 
					                    </div>
				                    </div> 
				                    
							        <div id="customCloudStrg" class="pt-1"> 
							            <div class="menu-link py-2 divHover blockHover">
					                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
							                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
				                            	<span class="menu-title">${myCloudStrgVO.cloudStrgNm }개인1</span>
					                        </div>
					                        <div id="cloudStrgDeleteBtn" class="ki-outline ki-cross fs-3 none" data-selectstrgCd="${myCloudStrgCustom.cloudStrgCd}"></div>   
				                        </div> 
							            <div class="menu-link py-2 divHover blockHover">
					                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
							                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
				                            	<span class="menu-title">${myCloudStrgVO.cloudStrgNm }개인2</span>
					                        </div> 
					                        <div id="cloudStrgDeleteBtn" class="ki-outline ki-cross fs-3 none" data-selectstrgCd="${myCloudStrgCustom.cloudStrgCd}"></div>   
				                        </div> 
							            <div class="menu-link py-2 divHover blockHover">
					                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
							                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
				                            	<span class="menu-title">${myCloudStrgVO.cloudStrgNm }개인3</span>
					                        </div>
					                        <div id="cloudStrgDeleteBtn" class="ki-outline ki-cross fs-3 none" data-selectstrgCd="${myCloudStrgCustom.cloudStrgCd}"></div>   
				                        </div> 
						
						            	<c:forEach items="${myCloudStrgCustomList }" var="myCloudStrgCustom">
								            <div class="menu-link py-2 divHover blockHover">
						                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgCustom.cloudStrgCd }')" style="max-width: 7em;">
								                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
					                            	<span class="menu-title">${myCloudStrgCustom.cloudStrgNm }</span>
						                        </div> 
							                    <div id="cloudStrgDeleteBtn" class="ki-outline ki-cross fs-3 none" data-selectstrgCd="${myCloudStrgCustom.cloudStrgCd}"></div>   
					                        </div> 
						            	</c:forEach>
							
							        </div>
							         
							    </div>
							</div>
							<!-- 개인 메일함 끝 -->
							<div class="separator separator-dashed"></div>
							<!-- 기타 메일함 시작 --> 
							<div class="menu-title-gray-700 mb-3 my-2">
							    <div class="menu-item">
							    
									<div class="menu-title-gray-700">
				                        <div class="menu-link py-1 divHover">
					                        <div class="menu-link p-0" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
					                            <span class="menu-icon"> 
					                                <i class="ki-duotone ki-abstract-8 text-success me-3"><span class="path1"></span><span class="path2"></span></i>
				                                </span>
				                            	<span class="menu-title">기타</span>
					                        </div>
				                        </div> 
									</div>
				                    
							        <div id="customCloudStrg" class="pt-1"> 
							        
							            <div class="menu-link py-2 divHover">
					                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
							                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
				                            	<span class="menu-title">스팸 메일함</span>
					                        </div>
				                        </div>  
							        
							            <div class="menu-link py-2 divHover">
					                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
							                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
				                            	<span class="menu-title">휴지통</span>
					                        </div>
				                        </div> 
							        
							        </div>
							         
							    </div>
							</div>
							<!-- 기타 메일함 시작 끝 -->
						</div>
						<!-- 메일함 메뉴 끝 -->
						<div class="separator separator-dashed"></div>
						
			            <div class="d-flex flex-column mt-5 mx-3 mb-3"> 
	                        <div class="d-flex justify-content-between w-100 fs-7 fw-bold">
	                            <span>메일함 용량</span>
	                        </div>
	 
	                        <div class="h-6px bg-light rounded" style="border: 1px solid #e2d2d270;">
	                            <div class="bg-danger rounded h-4px" role="progressbar" style="width: 70%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
	                        </div>
	
	                        <div class=" fw-semibold text-gray-600 fs-8 mb-3 mt-2">10GB 중 5GB 사용</div>
	                    </div>

		            </div>
		        </div>
		    </div>
			<!-- 메일함 목록 끝 -->
	
			<div class="col-10 pe-0" id="kt_app_root" style="width: 82%"> 
				<div class="card pe-0 mb-5" style="height : 98%;">
   
                           <!-- 양식 등록 시작 -->
   						   <form class="form" action="none" id="kt_modal_upload_form">
                                            
	                                <div class="align-items-center py-3">
										<div class="d-flex flex-wrap ms-5">
											<a href="#" class="btn btn-sm btn-icon btn-light btn-active-light-primary me-3" style="width: 7em;">
												<i class="ki-duotone ki-sms fs-2 me-1">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
												<span>답장</span>
											</a>
											<a href="#" class="btn btn-sm btn-icon btn-light btn-active-light-success me-3" style="width: 7em;">
												<i class="ki-duotone ki-trash fs-2 me-1">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
													<span class="path5"></span>
												</i>
												<span>전달</span>
											</a>
											<a href="#" class="btn btn-sm btn-icon btn-light btn-active-light-danger me-3" style="width: 7em;">
												<i class="ki-duotone ki-arrows-circle fs-2">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
												<span>삭제</span>
											</a> 
											<a href="#" class="btn btn-sm btn-icon btn-light btn-active-light-info me-3" style="width: 7em;">
												<i class="ki-duotone ki-arrows-circle fs-2">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
												<span>스팸차단</span>
											</a> 
											<!-- 이동 시작 -->
											<div>
												<a href="#" class="btn btn-sm btn-icon btn-light btn-active-light-primary" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-start" style="width: 7em;">
													<span class="ms-1">이동</span>
													<i class="ki-duotone ki-down fs-2"></i>
												</a>
								
												<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">
													<div class="menu-item px-3">
														<a href="#" class="menu-link px-3">받은 메일함</a>
													</div>
													<div class="menu-item px-3">
														<a href="#" class="menu-link px-3">개인1</a>
													</div> 
													<div class="menu-item px-3">
														<a href="#" class="menu-link px-3">개인2</a>
													</div> 
												</div>
								
											</div>
											<!-- 이동 끝 -->
										</div>
									</div>
	                                         
                                    <div class="separator separator-dashed mb-3"></div>
                                 
                                    <!-- card-body 시작 -->
                                     <div class="card-body pt-0">
                                         <div class="fv-row fv-plugins-icon-container">
                                                                                                                                    	                                             
                                            <div class="mt-5 mb-2" style="display: flex; ">
                                               <div style="width: 10%;"> 
                                                   <label class="form-label" style="margin-top: 10px;">제목</label>
                                               </div> 
			                                   <h1 class="fw-semibold my-2 mb-5">
				                                   	여행 알림. 저희와 함께 비행해 주셔서 감사합니다!
				                               </h1>
                                            </div> 
                                            
                                            <div style="display: flex;"> 
                                               <div style="width: 10%;"> 
                                                   <label class="form-label" style="margin-top: 10px;">보낸 사람 </label>
                                               </div> 
                                            
	                                            <div class="send_option_area">
													<div> 
		                                            	<button type="button" class="btn button_user" style="padding: 5px 15px 5px 15px;" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-start">
		                                            		김연희 &lt;sysiphus28&gt;
		                                            	</button>
										 
														<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">
															<div class="app-sidebar-deckription text-gray-500 fw-semibold d-block fs-8 text-center mb-3">
																<div class="fs-7 text-gray-800 fw-bold mb-3">
														        	  김연희 (yh002)  
														        </div>
															</div> 
															<div class="separator separator-dashed"></div>
															<div class="menu-item px-3">
																<a href="#" class="menu-link px-3">메일쓰기</a> 
															</div>
															<div class="menu-item px-3">
																<a href="#" class="menu-link px-3">보낸이 검색</a>
															</div>
															<div class="menu-item px-3">
																<a href="#" class="menu-link px-3">받는이 검색</a>
															</div>
															<div class="menu-item px-3">
																<a href="#" class="menu-link px-3">스팸등록</a>
															</div>
														</div>
													</div>
												</div>
                                            </div> 
                                            
                                            <div style="display: flex;">
                                               <div style="width: 10%;"> 
                                                   <label class="form-label" style="margin-top: 10px;">참조 </label>
                                               </div> 
                                            
	                                            <div class="sendPlus_option_area">
													<div> 
		                                            	<button type="button" class="btn button_user" style="padding: 5px 15px 5px 15px;" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-start">
		                                            		김연희 &lt;sysiphus28&gt;
		                                            	</button>
										 
														<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">
															<div class="app-sidebar-deckription text-gray-500 fw-semibold d-block fs-8 text-center mb-3">
																<div class="fs-7 text-gray-800 fw-bold mb-3">
														        	  김연희 (yh002)  
														        </div>
															</div> 
															<div class="separator separator-dashed"></div>
															<div class="menu-item px-3">
																<a href="#" class="menu-link px-3">메일쓰기</a> 
															</div>
															<div class="menu-item px-3">
																<a href="#" class="menu-link px-3">보낸이 검색</a>
															</div>
															<div class="menu-item px-3">
																<a href="#" class="menu-link px-3">받는이 검색</a>
															</div>
															<div class="menu-item px-3">
																<a href="#" class="menu-link px-3">스팸등록</a>
															</div>
														</div>
													</div>
												</div>
												
                                            </div> 
                                             
                                            <div class="mt-3 mb-5" style="display: flex;">  
                                               <div style="width: 10%;">
                                                   <label class="form-label" style="margin-top: 10px;">첨부파일</label>
                                               </div>  
                                               
												<!-- 파일 업로드 시작 -->
												<div id="kt_modal_upload" tabindex="-1" style="width: 90%;">
													<div class="modal-dialog modal-dialog-centered">
														<div class="modal-content">
																
																<div class="modal-body"> 
																	<!-- 파일 업로드 시작 -->
																	<div class="form-group">
																		<div class="dropzone dropzone-queue mb-4" id="kt_modal_upload_dropzone">
																			<div class="dropzone-panel mb-4">
																				<a class="dropzone-select btn btn-sm btn-light-info me-2 dz-clickable">모두 저장</a>
																			</div>
																			<div class="dropzone-select dropzone-items wm-200px" style="overflow: auto; height: 8em; border: 1px dashed lightgray; border-radius: 10px;"> 
																				<div class="dropzone-select dropzone-item p-2 mt-1"> 
																					<div class="dropzone-file">
																						<div class="dropzone-filename text-gray-900" title="some_image_file_name.jpg">  
																							<span data-dz-name="">고양이.jpg</span> 
																							<strong>(
																								<span data-dz-size="">340kb</span>)</strong> 
																						</div>
																					</div>
																					<div class="dropzone-toolbar"> 
																						<span class="dropzone-cancel" data-dz-remove="">
																							<i class="ki-duotone ki-folder-down fs-2">
																								<span class="path1"></span>
																								<span class="path2"></span>
																							</i>
																						</span>
																						<span class="dropzone-cancel" data-dz-remove="">
																							<i class="ki-duotone ki-cross fs-2">
																								<span class="path1"></span>
																								<span class="path2"></span>
																							</i>
																						</span>
																					</div>
																				</div>
																			</div>
																		</div>
																	</div>
																	<!-- 파일 업로드 끝 -->
																</div>
															
														</div>
													</div>
												</div>
												<!-- 파일 업로드 끝 --> 
                                            </div> 
                                    
                                            <!--CKEditor 시작-->
                                           <div class="collapse fade show" data-kt-inbox-message="message">
										        <div class="py-5">
										            <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">안녕 밥,</font></font></p>
										            <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
										                다시 한 번 말씀드리지만, 저는 Zinsser 씨의 의견에 동의할 수 없습니다. 우리 모두는 모든 기사에서 가장 중요한 부분이 제목이라는 것을 알고 있습니다. 설득력 있는 제목이 없다면 독자는 첫 문장도 읽지 못할 것입니다. 그러나 제목 다음으로 기사의 처음 몇 문장이 확실히 가장 중요한 부분입니다.
										            </font></font></p>
										            <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
										                저널리스트들은 이 중요한 서론 부분을 "Lede"라고 부르며, 적절하게 브리지를 실행하면 독자의 주의를 끌기 위한 헤드라인에서 블로그 게시물 본문까지 독자를 이끌어갈 수 있습니다. 다음 블로그 게시물을 강타로 알리는 10가지 영리한 방법 중 하나를 선택하세요.
										            </font></font></p>
										            <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
										                감사합니다,
										            </font></font></p>
										            <p class="mb-0"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
										                제이슨 뮬러
										            </font></font></p>
										        </div>
										    </div>
                                            <!--CKEditor 끝-->
                                           
                                         </div>
                                     </div>
                                     <!-- card-body 끝 -->
                              </form>
                              <!-- 양식 등록 끝 -->
					
				</div>
			</div>
				

	</div> 
</div>

<script>
$(function() {
   
	// ***** form Process *****
   let addBtn = $('#addBtn');
   let cancleBtn = $('#cancleBtn');
   let formInsert = $('#formInsert');
   let deleteBtn = $('#deleteBtn');
   
   // 취소 버튼 클릭
   cancleBtn.on('click', function() {
      Swal.fire({
         title: '목록으로 돌아가시겠습니까?',
         icon: 'warning',
         showCancelButton: true,
         confirmButtonColor: '#4FC9DA',
         cancelButtonColor: '#F06445',
         confirmButtonText: '예',
         cancelButtonText: '아니요',
         reverseButtons: false, // 버튼 순서 (기본)
   
      }).then((result) => {
         if (result.isConfirmed) {
            location.href= "/company/formList.do";
         }
      })
   });
   
   // 등록/수정 버튼 클릭
   addBtn.on('click', function() {
      let docFormNm = $('#docFormNm').val();
      let docFormKndNm = $('#docFormKndNm').val()
      console.log(docFormKndNm);
      let content = CKEDITOR.instances.formEditorCK.getData();
      
      if (docFormNm == null || docFormNm == "" ||
         docFormKndNm == 0 || docFormKndNm == "" ||
         content == null || content == "") {
         Swal.fire({
            icon: 'warning',
            title: '필수 입력이 비어있습니다.',
            text: '필수 입력 내용을 채워주세요.',
            confirmButtonColor: '#4FC9DA',
         });
         return false;
      }
      
      // 수정일 때
      if ($(this).val() == '수정') {
         formInsert.attr("action", "/company/formUpdate.do");
      }
      
      formInsert.submit();
   });
   
   // 삭제 버튼 클릭
   deleteBtn.on('click', function() {
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
            formInsert.attr("action", "/company/formDelete.do");
            formInsert.submit();
         }
      }) 
   });
   
   /* CKEDITOR 자바스크립트 */
   CKEDITOR.replace( 'formEditorCK', {
		height: 500,
		width: 740,
		// 사용하려는 툴바의 버튼을 문자열로 지정해서 포함시킴
		toolbar: [
		    { name: 'document', items: ['Source', 'Preview', 'ExportPdf', 'Print', 'NewPage'] },
		    { name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'Undo', 'Redo', 'Find', 'Replace', 'Selectall'] },
		    { name: 'alignment', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', 'BidirectionalLTR', 'BidirectionalRTL'] },
		    { name: 'styles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', 'Numberedlist', 'Bulletedlist', 'Outdent', 'Indent'] },
	        { name: 'insert', items: ['Image', 'Table', 'HorizontalRule', 'SpecialChar', 'PageBreak', 'CreateDiv', 'Insertdiv'] },
		    { name: 'custom', items: ['Styles', 'Font', 'FontSize', 'TextColor', 'BGColor', 'NumberedList', 'BulletedList', 'Maximize'] }
		]
   });
   
    
});

</script>
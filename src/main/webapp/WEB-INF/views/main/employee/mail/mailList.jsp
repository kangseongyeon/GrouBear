<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>


<link href="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css"/>
<script src="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.js"></script>

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
		                			onclick="location.href='/employee/mailForm.do'">
		                	메일쓰기</button>
		                	<button class="btn btn-primary px-3" style="border-radius: 0px 15px 15px 0px; width: 7em; font-size: 0.9em;"
		                			onclick="location.href='/employee/mailForm.do'">
		                	내게쓰기</button>
		                </div>
		                
			            <div class="d-flex flex-column"> 
	                        
	                    </div>
	                    
						<!-- 메일함 메뉴 시작 -->
						<div style="overflow: auto; height: 34.5em">
						
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
					<div class="card-header align-items-center py-5 gap-2 gap-md-5">
						<div class="d-flex flex-wrap gap-2">
							<div class="form-check form-check-sm form-check-custom form-check-solid me-4 me-lg-7">
								<input class="form-check-input" type="checkbox" data-kt-check="true" data-kt-check-target="#kt_inbox_listing .form-check-input" value="1" />
							</div>
							<a href="#" class="btn btn-sm btn-icon btn-light btn-active-light-success" data-bs-toggle="tooltip" data-bs-dismiss="click" data-bs-placement="top" title="Reload">
								<i class="ki-duotone ki-arrows-circle fs-2">
									<span class="path1"></span>
									<span class="path2"></span>
								</i>
							</a>
							<!-- 읽음/안읽음 시작 -->
							<div>
								<a href="#" class="btn btn-sm btn-icon btn-light btn-active-light-primary" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-start" style="width: 6em;">
									<span class="ms-1">읽음</span>
									<i class="ki-duotone ki-down fs-2"></i>
								</a> 
				
								<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">
									<div class="menu-item px-3">
										<a href="#" class="menu-link px-3">읽음</a>
									</div>
									<div class="menu-item px-3">
										<a href="#" class="menu-link px-3">안읽음</a>
									</div> 
								</div>
				
							</div>
							<!-- 읽음/안읽음 끝 -->
							<a href="#" class="btn btn-sm btn-icon btn-light btn-active-light-info" style="width: 6em;">
								<i class="ki-duotone ki-sms fs-2 me-1">
									<span class="path1"></span>
									<span class="path2"></span>
									</i>
								<span>
									답장
								</span>
							</a>
							<a href="#" class="btn btn-sm btn-icon btn-light btn-active-light-danger" style="width: 6em;">
								<i class="ki-duotone ki-trash fs-2 me-1">
									<span class="path1"></span>
									<span class="path2"></span>
									<span class="path3"></span>
									<span class="path4"></span>
									<span class="path5"></span>
								</i>
								<span>
									삭제
								</span>
							</a>
							<!-- 이동 시작 -->
							<div>
								<a href="#" class="btn btn-sm btn-icon btn-light btn-active-light-primary" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-start" style="width: 6em;">
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
				
						<!--begin::Actions-->
						<div class="d-flex align-items-center flex-wrap gap-2">
							<!--begin::Search-->
							<div class="d-flex align-items-center position-relative">
					            <form id="searchForm" style="display: contents;">
									<input type="hidden" name="page" id="page">
									<input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-5" placeholder="메일 검색" value="${searchWord }"/>
									<button id="searchBtn" type="button" class="btn btn-flex btn-light-success ms-1 py-1 px-1">
										<i class="ki-duotone ki-magnifier fs-2x">
											<span class="path1" style="height: 1.1em;"></span> 
											<span class="path2"></span>
										</i>	
									</button>
			                    </form>
				            </div>
							<!--end::Search-->
							<!--begin::Toggle-->
							<a href="#" class="btn btn-sm btn-icon btn-color-primary btn-light btn-active-light-primary d-lg-none" data-bs-toggle="tooltip" data-bs-dismiss="click" data-bs-placement="top" title="Toggle inbox menu" id="kt_inbox_aside_toggle">
								<i class="ki-duotone ki-burger-menu-2 fs-3 m-0">
									<span class="path1"></span>
									<span class="path2"></span>
									<span class="path3"></span>
									<span class="path4"></span>
									<span class="path5"></span>
									<span class="path6"></span>
									<span class="path7"></span>
									<span class="path8"></span>
									<span class="path9"></span>
									<span class="path10"></span>
								</i>
							</a>
							<!--end::Toggle-->
						</div>
						<!--end::Actions-->
					</div>
					<div class="card-body p-0">
						<!--begin::Table-->
						<table class="table table-row-dashed" id="kt_inbox_listing">
							<thead class="d-none">
								<tr>
									<th>체크박스</th>
									<th>중요</th>
									<th>중요</th>
									<th>보낸사람</th>
									<th>메일제목</th>
									<th>날짜</th>
								</tr>
							</thead>
							<tbody>
							
								<tr>
									<td width="5%" class="ps-9 p-2"> 
										<div class="form-check form-check-sm form-check-custom form-check-solid mt-3">
											<input class="form-check-input" type="checkbox" value="1" />
										</div>
									</td>
									<td width="5%" class="p-2">
										<a href="#" class="btn btn-icon btn-color-gray-500 btn-active-color-warning w-35px h-35px" data-bs-toggle="tooltip" data-bs-placement="right" title="Star">
											<i class="ki-duotone ki-star fs-3"></i>
										</a>
									</td> 
									<td width="5%" class="p-2">
										<a href="#" class="btn btn-icon btn-color-gray-500 btn-active-color-success w-35px h-35px" data-bs-toggle="tooltip" data-bs-placement="right" title="Star">
			                                <i class="ki-duotone ki-sms fs-2 text-primary">
												 <span class="path1"></span>
												 <span class="path2"></span>
											</i> 
										</a>
									</td> 
									<td width="15%" class="p-2"> 
										<div> 
											<a href="#" class="btn btn-sm btn-iconbtn btn-bg-light btn-active-light" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-start">
												<span class="ms-1">김연희</span>
												<i class="ki-duotone ki-down fs-2"></i>
											</a>
							 
											<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">
												<div class="app-sidebar-deckription text-gray-500 fw-semibold d-block fs-8 text-center mb-3">
													<div href="#" class="fs-7 text-gray-800 fw-bold mb-3">
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
									
									</td>
									<td width="45%" class="p-2">
										<div class="text-gray-900 gap-1 pt-2 fw-bold">
											<a href="#" class="text-gray-800 text-hover-primary word" onclick="location.href='/company/mailDetail.do'">
												Digital PPV Customer ConfirmationDigital PPV Customer ConfirmationDigital PPV Customer ConfirmationDigital PPV Customer Confirmation
				                             </a>
				                        </div> 
									</td>  
									<td width="15%" class="text-end fs-7 pe-9 p-2">
										<div class="text-gray-900 gap-1 pt-2">
											<span class="fw-semibold">2024-10-15 11:08</span>  
										</div> 
									</td>
								</tr>
								
							
								<tr>
									<td width="5%" class="ps-9 p-2"> 
										<div class="form-check form-check-sm form-check-custom form-check-solid mt-3">
											<input class="form-check-input" type="checkbox" value="1" />
										</div>
									</td>
									<td width="5%" class="p-2">
										<a href="#" class="btn btn-icon btn-color-gray-500 btn-active-color-warning w-35px h-35px" data-bs-toggle="tooltip" data-bs-placement="right" title="Star">
											<i class="ki-duotone ki-star fs-3"></i>
										</a>
									</td> 
									<td width="5%" class="p-2">
										<a href="#" class="btn btn-icon btn-color-gray-500 btn-active-color-primary w-35px h-35px" data-bs-toggle="tooltip" data-bs-placement="right" title="Star">
			                                <i class="ki-duotone ki-directbox-default fs-2">
												 <span class="path1"></span>
												 <span class="path2"></span>
												 <span class="path3"></span>
												 <span class="path4"></span>
											</i>
										</a>
									</td> 
									<td width="15%" class="p-2"> 
										<div> 
											<a href="#" class="btn btn-sm btn-iconbtn btn-bg-light btn-active-light" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-start">
												<span class="ms-1">김연희</span>
												<i class="ki-duotone ki-down fs-2"></i>
											</a>
							 
											<div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">
												<div class="app-sidebar-deckription text-gray-500 fw-semibold d-block fs-8 text-center mb-3">
													<div href="#" class="fs-7 text-gray-800 fw-bold mb-3">
											        	  김연희 (yh002)  
											        </div>
													<div class="badge badge-sm badge-light-primary d-inline mb-3">개발부 개발 3팀 </div>
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
									
									</td>
									<td width="45%" class="p-2">
										<div class="text-gray-900 gap-1 pt-2">
											<a href="#" class="text-gray-800 text-hover-primary word">
												Digital PPV Customer ConfirmationDigital PPV Customer ConfirmationDigital PPV Customer ConfirmationDigital PPV Customer Confirmation
				                             </a>
										</div>  
									</td>
									<td width="15%" class="text-end fs-7 pe-9 p-2">
										<div class="text-gray-900 gap-1 pt-2">
											<span class="fw-semibold">2024-10-15 11:08</span>  
										</div> 
									</td>
								</tr>
								
							</tbody>
						</table>
						<!--end::Table-->
					</div>
					 
					<div class="dt-paging paging_simple_numbers mt-3 mb-3" id="pagingArea">
					1
						${pagingVO.pagingHTML }
					</div> 
					
				</div>
			</div>
				

	</div> 
</div>

<script>
let parentTr;
let cloudFileNo;
let fileNameTd;
let cloudFileName;


$(function() {
	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
	let searchForm = $("#searchForm");		
	let pagingArea = $("#pagingArea");		// 페이징 처리 위한 div
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a 태그의 기본 기능 멈추기
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		
		$('#myInput').val("");
		
		searchForm.submit();
	});
	
	// 검색 버튼 눌렀을 때 키워드 검색
	$('#searchBtn').on('click', function() {
		searchForm.submit();
	});

	// 엔터키를 눌렀을 때 키워드 검색
	$('#searchForm').on('keydown', function(event) {
		if (event.keyCode == 13) {	// Enter 키를 눌렀을 때 (엔터키 == 13번)
			searchForm.submit();
	    }
	});
	
	// 커스텀 개인함 + 버튼 눌렀을 때
	$('#cloudStrgPlusBtn').on('click', function () {
		$('#cloudStrgNmDiv').css('display', 'block');
	});
	
	// 새폴더 추가 저장 버튼 눌렀을 때
	$('#newFolderAddBtn').on('click', function () {
		let cloudStrgFldrUpNo = ""; 
		let cloudStrgFldrNm = "";
		
		console.log("cloudStrgFldrUpNo : " + cloudStrgFldrUpNo);
		console.log("cloudStrgFldrNm : " + cloudStrgFldrNm);
		
	});
	
	// 파일 선택하면 화면에 띄우기 (Dropzone 설정)
	const id = "#kt_modal_upload_dropzone";
	const dropzoneElement = document.querySelector(id);
	console.log("Dropzone element:", dropzoneElement);

	var previewNode = dropzoneElement.querySelector(".dropzone-item");
	previewNode.id = ""; 
	var previewTemplate = previewNode.parentNode.innerHTML;
	previewNode.parentNode.removeChild(previewNode); 

	var myDropzone = new Dropzone(dropzoneElement, {
	    url: "path/to/your/server",
	    parallelUploads: 10,
	    previewTemplate: previewTemplate,
	    maxFilesize: 2,
	    autoProcessQueue: false,
	    autoQueue: false, 
	    previewsContainer: dropzoneElement.querySelector(".dropzone-items"),
	    clickable: dropzoneElement.querySelector(".dropzone-select")
	});

	console.log("Dropzone instance:", myDropzone);

	// 파일 추가 시 이벤트 (Dropzone 설정)
	myDropzone.on("addedfile", function (file) {

	    const dropzoneItems = dropzoneElement.querySelectorAll('.dropzone-item');
	    dropzoneItems.forEach(dropzoneItem => {
	        dropzoneItem.style.display = '';
	    });
	    dropzoneElement.querySelector('.dropzone-upload').style.display = "inline-block";
	    dropzoneElement.querySelector('.dropzone-remove-all').style.display = "inline-block";
	});

	// 전체 삭제 버튼 누를 때 (Dropzone 설정)
	$(document).on('click', ".dropzone-remove-all", function () {
	    Swal.fire({
	        text: "선택한 파일을 모두 삭제하시겠습니까?",
	        icon: "warning",
	        showCancelButton: true,
	        buttonsStyling: false,
	        confirmButtonText: "예",
	        cancelButtonText: "아니요",
	        customClass: {
	            confirmButton: "btn btn-primary",
	            cancelButton: "btn btn-active-light"
	        }
	    }).then(function (result) {
	        if (result.value) {
	            dropzoneElement.querySelector('.dropzone-upload').style.display = "none";
	            dropzoneElement.querySelector('.dropzone-remove-all').style.display = "none";
	            myDropzone.removeAllFiles(true);
	        }
	    });
	});

	// 전체 삭제 버튼 프로세스 (Dropzone 설정)
	myDropzone.on("removedfile", function (file) {
	    if (myDropzone.files.length < 1) {
	        dropzoneElement.querySelector('.dropzone-upload').style.display = "none";
	        dropzoneElement.querySelector('.dropzone-remove-all').style.display = "none";
	    }
	});

	// 전체 저장 버튼 누를 때
	$(document).on('click', ".dropzone-upload", function () {
	    console.log("fff");
	});
 
	// 커스텀 클라우드함 삭제 누를 때
	$('#customCloudStrg').on('click', "#cloudStrgDeleteBtn", function () {
	    console.log("ㄹㄹㄹㄹ"); 
	    
	    let cloudStorageCd = $(this).data('selectstrgcd');
	    console.log(cloudStorageCd);
	});  

});


// 클라우드함을 클릭했을 때
function f_cloudStrgClick(cloudStrgCd) {
	let cloudStorageCd = cloudStrgCd;
	console.log("클라우드함 번호 : " + cloudStrgCd);  
	
	
}

// 파일 경로에서 폴더를 클릭했을 때
function f_cloudFldrPathClick(strgFldrCd) {
	let cloudStrgFldrCd = strgFldrCd;
	console.log("폴더 코드aa : " + cloudStrgFldrCd);  
	
}

// 파일 경로에서 클라우드함을 클릭했을 때
function f_cloudStrgPathClick(strgCd) {
	let cloudStrgCd = strgCd;
	console.log("클라우드함 코드bb : " + cloudStrgCd);  
	
}
 

// 커스텀 개인함 추가 체크버튼 눌렀을 때
function f_cloudStrgAddBtn(strgUpCd) {
	let cloudStrgUpCd = strgUpCd;
	let cloudStrgNm = $('#cloudStrgNm').val();
	
	console.log("cloudStrgUpCd : " + cloudStrgUpCd);
	console.log("cloudStrgNm : " + cloudStrgNm);
	
	$('#cloudStrgNmDiv').css('display', 'none');

	if (cloudStrgNm == "" || cloudStrgNm == null) {
		return false;
	}
	
}

// 폴더 삭제 버튼을 눌렀을 때
function f_fldrDelBtn(fldeCd) {
	console.log("fldeCd : " + fldeCd);
	
}

// 파일 삭제 버튼을 눌렀을 때
function f_fileDelBtn(fileCd) {
	console.log("fileCd : " + fileCd);
	
}

// 파일명 수정 버튼을 눌렀을 때
function f_fileNameModify(fileNm) {
	let cloudFileNm = fileNm;
	console.log(cloudFileNm);
	
	$('#modifyFolderName').val(cloudFileNm);
} 
 
 


</script>
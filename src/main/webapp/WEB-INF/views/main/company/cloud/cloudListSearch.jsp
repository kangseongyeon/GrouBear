<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>


<link href="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css"/>
<script src="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.js"></script>

<!-- sweetalert2 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- jstree -->
<link href="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.js"></script>

<!-- axios -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<style> 
.clickBackColor {
    background-color: #f0ede8;
    border-radius: 0.95rem;
}

.fontColor {
	color: #4FC9DA;
}

.divHover:hover {
	background-color: var(--bs-menu-link-bg-color-show);
    border-radius: 0.95rem;
}

.none {
	display: none;
}

.divHover:hover #cloudStrgDeleteBtn {
	display: block;
}

.imgPreview:hover { 
	color: rgb(79 201 218);
}
</style>


<!-- 넘겨받은 리스트들이 들어있는 Map  -->
<c:set var="cloudStrgListMap" value="${cloudStrgListMap }"/>

<!-- 사이드바 클라우드함 리스트 -->
<c:set var="allCloudStrgList" value="${cloudStrgListMap.allCloudStrgList }"/>

<!-- 개인 클라우드의 커스텀 클라우드함 목록 -->
<c:set var="myCloudStrgCustomList" value="${cloudStrgListMap.myCloudStrgCustomList }"/>	

<!-- 키워드로 검색한 폴더 및 파일 목록 -->
<c:set var="pagingVO" value="${pagingVO }"/>	

<!-- 검색한 키워드명 -->
<c:set var="searchWord" value="${searchWord }"/>	
 
<!-- 사원의 직급 코드 -->
<c:set var="jbgdCd" value="${jbgdCd }"/>	
 
<!-- 선택한 클라우드함의 현재 사용 용량 -->
<c:set var="cloudStrgFileSizeSumStr" value="${cloudStrgFileSizeSumStr }"/>	

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
		<h3>클라우드</h3>
		<h6>클라우드</h6>
	</div>
</div>


<div id="kt_app_content_container" class="app-container container-fluid" style="height: 100%;">
	<div class="row" style="height: 100%;">

			
			<!-- 전체파일목록 출력 모달 시작 -->
			<div class="modal fade" tabindex="-1" id="modalCloudList" style="background-color: rgb(29 29 29 / 62%)">
			    <div class="modal-dialog modal-dialog-scrollable mw-550px">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title">전체 폴더 목록</h5>
			
			                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
			                    <i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
			                </div>
			            </div>
			 
			            <div class="modal-body ms-5">
    	                    <div class="strgJstree">
                               <ul class="treeUl"></ul>
                            </div>
			            </div>
			
			            <div class="modal-footer p-3" style="justify-content: center;">
	                        <div>
	                            <button type="button" class="btn btn-light-primary me-1" onclick="f_fldrLocateSelectBtn()">선택 폴더로 이동</button> 
	                            <button type="button" class="btn btn-light-danger" data-bs-dismiss="modal">취소</button>
	                        </div>
                        </div>
			        </div>
			    </div>
			</div>
			<!-- 전체파일목록 출력 모달 끝 -->
			
			<!-- 파일 업로드 모달 시작 -->
			<div class="modal fade" id="kt_modal_upload" tabindex="-1" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered mw-550px">
					<div class="modal-content">
						
						<!-- 파일 업로드 폼 시작 -->
						<form class="form" action="none" id="kt_modal_upload_form">
							<div class="modal-header">
								<h2 class="fw-bold">파일 업로드</h2>
								<div class="btn btn-icon btn-sm btn-active-icon-primary" data-bs-dismiss="modal">
									<i class="ki-duotone ki-cross fs-1">
										<span class="path1"></span>
										<span class="path2"></span>
									</i>
								</div>
							</div>
							
							<div class="modal-body pt-5 pb-5 px-lg-10">
							
								<div class="card card-flush mb-5">
									 <!-- 폴더 위치 시작 -->
                                     <div class="mt-5 ms-5 mb-5" style="display: flex;">  
                                        <div class="ms-5" style="width: 15%;">
                                            <label class="form-label mt-3">폴더위치<font style="color: red">*</font></label>
                                        </div>  
                                        
                                        <div class="d-flex justify-content-center" style="width: 75%;">  
                                        	<div id="selectStrg">
                                        	</div>
											<button type="button" class="btn btn-primary callJstree" data-bs-stacked-modal="#kt_modal_scrollable_strgList">
											 	폴더 선택
											</button>
                                        </div> 
                                     </div>
                                     <!-- 폴더 위치 끝 -->
								</div>
								
								<div class="rounded border p-3">
									<!-- 파일 업로드 시작 -->
									<div class="form-group">
										<div class="dropzone dropzone-queue mb-1" id="kt_modal_upload_dropzone">
											<div class="dropzone-panel mb-2">
												<a class="dropzone-select btn btn-sm btn-primary me-2">파일 선택</a>
												<a class="dropzone-upload btn btn-sm btn-light-primary me-2">전체 저장</a>
												<a class="dropzone-remove-all btn btn-sm btn-light-primary">전체 삭제</a>
											</div>
											<div class="dropzone-items wm-200px rounded border" style="min-height: 25em;">
												<div class="dropzone-item p-2" style="display:none">
													<div class="dropzone-file">
														<div class="dropzone-filename text-gray-900 ms-2" title="some_image_file_name.jpg">
															<span data-dz-name=""></span>
															<strong>(
																<span data-dz-size="">340kb</span>)</strong>
														</div>
														<div class="dropzone-error mt-0 ms-2" data-dz-errormessage=""></div>
													</div>
													<div class="dropzone-toolbar">
														<span class="dropzone-start">
														</span>
														<span class="dropzone-cancel" data-dz-remove="" style="display: none;">
															<i class="ki-duotone ki-cross fs-2">
																<span class="path1"></span>
																<span class="path2"></span>
															</i>
														</span>
														<span class="dropzone-delete" data-dz-remove="">
															<i class="ki-duotone ki-cross fs-2">
																<span class="path1"></span>
																<span class="path2"></span>
															</i>
														</span>
													</div>
												</div>
											</div>
										</div>
										<span class="form-text fs-7 text-muted">&emsp;파일당 최대 파일 크기 : 2MB&emsp;&emsp;||&emsp;&emsp;</span>
										<span class="form-text fs-7 text-muted">1회당 최대 파일 갯수 : 10개&emsp;</span> 
									</div> 
									<!-- 파일 업로드 끝 --> 
								</div>
							</div>
						</form>
						<!-- 파일 업로드 폼 끝 -->
						
					</div>
				</div>
			</div>
			<!-- 파일 업로드 모달 끝 -->
			
			<!-- 파일 업로드 경로 출력 모달 시작 -->
			<div class="modal fade" tabindex="-1" id="kt_modal_scrollable_strgList" style="background-color: rgb(29 29 29 / 62%)">
			    <div class="modal-dialog modal-dialog-scrollable mw-550px">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title">위치 선택</h5>
			
			                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
			                    <i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
			                </div>
			            </div>
			 
			            <div class="modal-body ms-5">
    	                    <div class="strgJstree">
                               <ul class="treeUl"></ul>
                            </div>
			            </div>
			
			            <div class="modal-footer p-3" style="justify-content: center;">
	                        <div>
	                            <button type="button" id="strgSelectBtn" class="btn btn-light-primary me-1">선택</button>
	                            <button type="button" class="btn btn-light-danger" data-bs-dismiss="modal">취소</button>
	                        </div>
                        </div>
			        </div>
			    </div>
			</div>
			<!-- 파일 업로드 경로 출력 모달 끝 -->
			
			<!-- 폴더로 이동 리스트 경로 출력 모달 시작 -->
			<div class="modal fade" tabindex="-1" id="modalMoveList" style="background-color: rgb(29 29 29 / 62%)">
			    <div class="modal-dialog modal-dialog-scrollable mw-550px">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title">위치 선택</h5>
			
			                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
			                    <i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
			                </div>
			            </div>
			 
			            <div class="modal-body ms-5">
    	                    <div class="strgJstree">
                               <ul class="treeUl"></ul>
                            </div>
			            </div>
			
			            <div class="modal-footer p-3" style="justify-content: center;">
	                        <div>
	                            <button type="button" class="btn btn-light-primary me-1" onclick="f_cloudMoveListBtn()">선택</button>
	                            <button type="button" class="btn btn-light-danger" data-bs-dismiss="modal" onclick="f_checkArrClear()">취소</button>
	                        </div>
                        </div>
			        </div>
			    </div>
			</div>
			<!-- 폴더로 이동 리스트 경로 출력 모달 끝 -->
			
			<!-- 폴더 수정 모달 시작 -->
			<div class="modal fade" id="kt_modal_modify_Folder" tabindex="-1" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered mw-650px">
					<div class="modal-content">
						
						<!-- 파일 업로드 폼 시작 -->
						<form id="modifyFldrForm" action="/company/modifyCloudFldr.do" method="post">
							<input id="cloudStrgFldrCd" type="hidden" name="cloudStrgFldrCd" value="">
							<input id="cloudFldrUpCdHidden" type="hidden" name="cloudFldrUpCd" value="${selectStrgCd }">
						
							<div class="modal-header">
								<h2 class="fw-bold">폴더 수정</h2>
								<div class="btn btn-icon btn-sm btn-active-icon-primary" data-bs-dismiss="modal">
									<i class="ki-duotone ki-cross fs-1"> 
										<span class="path1"></span>
										<span class="path2"></span>
									</i>
								</div>
							</div>
							
							<div class="modal-body pt-5 pb-5 px-lg-17">
							
								<div class="card card-flush mb-5 mt-5" style="min-height: 18em; display: flex; justify-content: center; margin-bottom: 1em;">
									 <!-- 폴더 이름 시작 -->
                                     <div class="mt-4 ms-5" style="display: flex; min-height: 6em; padding-top: 1em;">  
                                        <div class="ms-5" style="width: 20%;">
                                            <label class="form-label mt-3">폴더 이름<font style="color: red">*</font></label>
                                        </div>  
                                        <div style="width: 70%;">  
											<input id="modifyFldrName" type="text" class="form-control" name="cloudStrgFldrNm" placeholder="새로운 폴더명을 적어주세요">
                                        </div>
                                     </div> 
                                     <!-- 폴더 이름 끝 -->
                                     
                                     <!-- 직급 출력 시작 -->
                                     <div class="mt-5 ms-5 mb-3" style="display: flex;">  
                                        <div class="ms-5" style="width: 20%;">
                                            <label class="form-label">공개여부 <font style="color: red">*</font></label>
                                        </div>  
                                        <div id="modifyFolderCheckRow" class="row ms-3" style="width: 70%;">  
                                        </div> 
                                     </div>
                                     <!-- 직급 출력 끝 -->
								</div>
								
	                            <div class="mb-3" style="display: flex; justify-content: center;">
	                                <button type="button" class="btn btn-light-primary me-2" onclick="f_modifyFldr()">저장</button>
	                                <button type="button" class="btn btn-light-danger" data-bs-dismiss="modal">취소</button>
	                            </div>
							</div> 
							  
							
						</form>
						<!-- 파일 업로드 폼 끝 -->
						
					</div>
				</div>
			</div>
			<!-- 폴더 수정 모달 끝 -->
			
			<!-- 전사, 개인 클라우드함 나누기 -->
			<c:set var="comCloudStrgVO" value="${null }"/>
			<c:set var="myCloudStrgVO" value="${null }"/>
			
			<c:forEach items="${allCloudStrgList }" var="allCloudStrg">
				<c:if test="${allCloudStrg.cloudStrgKnd eq 'com' }">
					<c:set var="comCloudStrgVO" value="${allCloudStrg }"/>
				</c:if>
				<c:if test="${allCloudStrg.cloudStrgKnd eq 'prvt' }">
					<c:set var="myCloudStrgVO" value="${allCloudStrg }"/>
				</c:if>
			</c:forEach>
			

			<!-- 클라우드함 목록 시작 -->
			<div class="col-2 p-0 mb-5">  
		        <div class="card card-flush" style="height: 100%">
		            <div class="card-body" style="padding: 1em;"> 
	
		                <div>
	                        <button type="button" class="btn btn-flex btn-primary fw-bold w-100 mb-8 mt-3 fs-3 d-flex justify-content-center" data-bs-toggle="modal" data-bs-target="#kt_modal_upload">
	                           <i class="ki-duotone ki-folder-up fs-1" style="margin-left: -7px;"><span class="path1"></span><span class="path2"></span></i>
	                           <span>&nbsp;파일 업로드</span> 
                        	</button>
		                </div> 
		                
		                <%-- 
			            <div class="d-flex flex-column">
	                        <div class="d-flex justify-content-between w-100 fs-7 fw-bold mb-3">
	                            <span>전사 클라우드함 용량</span>
	                        </div>
	                        
	                        <div class="h-6px bg-light rounded" style="border: 1px solid #e2d2d270;" data-bs-toggle="tooltip" title="현재  ${fileSizePercent}% 사용 중">
	                            <div class="bg-danger rounded h-4px" role="progressbar" style="width: ${fileSizePercent}%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
	                        </div>
	
	                        <div class=" fw-semibold text-gray-600 fs-8 mb-3 mt-2">10GB 중 ${cloudStrgFileSizeSumStr } 사용</div>
	                    </div>
		  --%>
						<!-- 클라우드함 메뉴 시작 -->
						<!-- 전사 클라우드함 시작 -->
						<div class="menu-title-gray-700">
		                    <div class="menu-item">
							<c:choose>
								<c:when test="${parentCloud.cloudKnd eq 'com' }">
			                        <div class="menu-link py-3 divHover clickBackColor" onclick="f_cloudStrgClick('${comCloudStrgVO.cloudStrgCd }', 'com')">
								</c:when>
								<c:otherwise>
			                        <div class="menu-link py-3 divHover" onclick="f_cloudStrgClick('${comCloudStrgVO.cloudStrgCd }', 'com')">
								</c:otherwise>
							</c:choose>
		                            <span class="menu-icon"> 
		                                <i class="ki-duotone ki-abstract-8 text-danger me-3"><span class="path1"></span><span class="path2"></span></i>
	                                </span>
	                            	<span class="menu-title fs-4">${comCloudStrgVO.cloudStrgNm }</span>
		                        </div>
		                    </div>
						</div> 
						<!-- 전사 클라우드함 끝 -->
						
						<!-- 부서 클라우드함 시작 -->
<%-- 						<div class="menu-title-gray-700">
							<c:choose>
								<c:when test="${parentCloud.cloudKnd eq 'dept' }">
				                    <div class="menu-item clickBackColor">
								</c:when>
								<c:otherwise>
				                    <div class="menu-item">
								</c:otherwise>
							</c:choose>
		                        <div class="menu-link py-3" onclick="f_cloudStrgClick('${deptCloudStrgVO.cloudStrgCd }')">
		                            <span class="menu-icon"> 
		                                <i class="ki-duotone ki-abstract-8 text-success me-3"><span class="path1"></span><span class="path2"></span></i>
	                                </span>
	                            	<span class="menu-title">${deptCloudStrgVO.cloudStrgNm }</span>
		                        </div>
		                    </div>
						</div> --%>
						<!-- 부서 클라우드함 끝 -->

						<!-- 개인 클라우드함 시작 -->
						<div class="menu-title-gray-700">
						    <div class="menu-item">
								<div class="menu-title-gray-700">
									<c:choose>
										<c:when test="${parentCloud.cloudKnd eq 'prvt' }">
					                        <div class="menu-link py-3 divHover clickBackColor">
										</c:when>
										<c:otherwise>
					                        <div class="menu-link py-3 divHover">
										</c:otherwise>
									</c:choose>
				                        <div class="menu-link p-0" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
				                            <span class="menu-icon"> 
				                                <i class="ki-duotone ki-abstract-8 text-info me-3"><span class="path1"></span><span class="path2"></span></i>
			                                </span>
			                            	<span class="menu-title fs-4">개인</span>
				                        </div>
		                            	<div id="cloudStrgPlusBtn" class="ki-outline ki-plus fs-3" style="margin-left: 4em;"></div>   
			                        </div> 
								</div>
						        
			                    <div id="cloudStrgNmDiv" style="display: none;">
				                    <div style="display: flex; justify-content: center;">
			                        	<input type="text" class="form-control fs-6" id="cloudStrgNm" name="cloudStrgNm" style="width: 70%; height: 2.5em; border-radius: 0.75rem;">
			                            <div class="ki-duotone ki-check fs-1 ms-1 mt-1 divHover" onclick="f_cloudStrgAddBtn()" style="margin-left: 4em;">
											 <span class="path1"></span>
											 <span class="path2"></span> 
										</div> 
				                    </div>
			                    </div> 
			                    
						        <div id="customCloudStrg" class="pt-1"> 
						            <div class="menu-link py-3 divHover">
				                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgVO.cloudStrgCd }')" style="max-width: 7.5em;">
						                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
			                            	<span class="menu-title fs-4">${myCloudStrgVO.cloudStrgNm }</span>
				                        </div>
			                        </div> 
					
									<div id="customDiv">
						            	<c:forEach items="${myCloudStrgCustomList }" var="myCloudStrgCustom">
								            <div class="menu-link py-3 divHover blockHover">
						                        <div class="menu-link p-0 ms-2" onclick="f_cloudStrgClick('${myCloudStrgCustom.cloudStrgCd }')" style="max-width: 7em;">
								                    <span class="menu-bullet"><span class="bullet bullet-dot"></span></span>
					                            	<span class="menu-title fs-4">${myCloudStrgCustom.cloudStrgNm }</span>
						                        </div> 
							                    <div id="cloudStrgDeleteBtn" class="ki-outline ki-cross fs-3 none" data-selectstrgCd="${myCloudStrgCustom.cloudStrgCd}" style="margin-left: 4em;"></div>   
					                        </div> 
						            	</c:forEach>
						            </div>
						
						        </div> 
						         
						    </div>
						</div>
						<!-- 개인 클라우드함 끝 -->
						<!-- 클라우드함 메뉴 끝 -->
		
		            </div>
		        </div>
		    </div>
			<!-- 클라우드함 목록 끝 -->
	
	
			 
			<!-- 파일 목록 시작 -->					
			<div class="col-10 pe-0 mb-5" id="kt_app_root"> 
	            <div class="card card-flush" style="height : 100%;">
	                <!-- 카드 헤더 시작-->
	                <div class="card-header mt-3">
	            
	                    <!-- 파일 및 폴더 검색 시작 -->
	                    <div class="card-title">
	                        <div class="d-flex align-items-center position-relative my-1">
                    			<form action="#" id="searchForm" style="display: contents;" method="get">
		                            <!-- <input type="hidden" name="page" id="page"> -->
								    <input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-5" placeholder="파일 및 폴더 검색" value="${searchWord }"/>
		                       		<button id="searchBtn" type="button" class="btn btn-flex btn-body ms-1 py-1 px-1"> 
		                       			<i class="ki-duotone ki-magnifier fs-2x">
											 <span class="path1" style="height: 1.1em;"></span> 
											 <span class="path2"></span>
										</i>
									</button>
	                            </form>
	                        </div>
	                    </div> 
	                    <!-- 파일 및 폴더 검색 끝 --> 
	            
	                    <div class="card-toolbar">
	                        <div class="d-flex justify-content-end" data-kt-filemanager-table-toolbar="base">
	                            <button type="button" class="btn btn-flex btn-secondary me-1 px-4 callJstree" data-bs-toggle="modal" data-bs-target="#modalCloudList">
	                                <i class="ki-duotone ki-tablet-text-up fs-2"><span class="path1"></span><span class="path2"></span></i> 
	                                	전체파일목록 
	                            </button>  
	                        </div>  
	                        <div class="d-flex justify-content-end" data-kt-filemanager-table-toolbar="base">
	                            <button type="button" class="btn btn-flex btn-light-success me-1 px-4" onclick="f_cloudDownListBtn()">
	                                <i class="ki-duotone ki-folder-down fs-2"><span class="path1"></span><span class="path2"></span></i>
	                                	다운로드
	                            </button>
	                        </div>
	                        <div class="d-flex justify-content-end" data-kt-filemanager-table-toolbar="base">
	                          <!--   <button type="button" class="btn btn-flex btn-light-info me-1 px-4 callJstree" data-bs-toggle="modal" data-bs-target="#modalMoveList"> -->
	                            <button type="button" class="btn btn-flex btn-light-info me-1 px-4 callJstree" onclick="f_check('move')">
	                                <i class="ki-duotone ki-file-right fs-2"><span class="path1"></span><span class="path2"></span></i>
	                                	이동
	                            </button>
	                        </div>
	                        <div class="d-flex justify-content-end align-items-center" data-kt-filemanager-table-toolbar="selected">
	                            <button type="button" class="btn btn-light-danger px-3" data-kt-filemanager-table-select="delete_selected" onclick="f_check('del')">
	                                <i class="ki-duotone ki-trash-square fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
	                                	삭제
	                            </button>
	                        </div>
	                    </div>
	            
	                </div>
	                <!-- 카드 헤더 끝 -->
	            
	                <!-- 카드 바디 시작-->
	                <div class="card-body pt-0 pb-0">
	            
	            
	                    <!-- 경로 시작-->
	                    <div class="d-flex flex-stack mt-2 mb-3">
	            
	                        <!-- 폴더 경로 시작 -->
	                        <div class="badge badge-lg badge-light-primary px-4 py-2" style="font-size: 1em;">
	                            <div class="d-flex align-items-center flex-wrap">
	                                <i class="ki-duotone ki-abstract-32 fs-2 text-primary me-3">
	                                    <span class="path1"></span><span class="path2"></span> 
	                                </i>  
<%-- 	                                <c:choose>
	                                	<c:when test="${not empty cloudPathList }">
		    	                            <c:forEach items="${cloudPathList }" var="cloudPath" varStatus="i">
				                                <c:if test="${i.index == 0 }">
					                                <a href="#" onclick="f_cloudPathClick('${cloudPath.cloudCd }')">${cloudPath.cloudNm }</a>
				                                </c:if>
			                                </c:forEach>
		    	                            <c:forEach items="${cloudPathList }" var="cloudPath" varStatus="i">
				                                <c:if test="${i.index != 0 }">
					                                <i class="ki-duotone ki-right fs-2 text-primary mx-1"></i> 
					                                <a href="#" onclick="f_cloudPathClick('${cloudPath.cloudCd }')">${cloudPath.cloudNm }</a>
				                                </c:if>
			                                </c:forEach>
	                                	</c:when>
	                                	<c:otherwise>
	                                		<a href="#" onclick="f_cloudPathClick('${parentCloud.cloudCd }')">${parentCloud.cloudNm }</a>
	                                	</c:otherwise>
	                                </c:choose> --%>
	                            </div>
	                        </div>
	                        <!-- 폴더 경로 끝 -->
	            
	                        <!-- 폴더 내부의 폴더 및 파일 갯수 시작 -->
	                        <div class="badge badge-lg badge-light-info px-4 py-3" style="font-size: 1.2em;"> 
	                            <span id="kt_file_manager_items_counter">${pagingVO.totalRecord }개 항목</span>
	                        </div>
	                        <!-- 폴더 내부의 폴더 및 파일 갯수 끝 -->
	            
	                    </div>
	                    <!-- 경로 끝-->
	
						
						<table id="kt_file_manager_list" data-kt-filemanager-table="folders" class="table align-middle table-row-dashed fs-4 gy-3 mb-0" style="width: 98.5%;">

                            <thead>
                                <tr class="text-gray-500 fw-bold fs-5"> 
									<th width="7%" class="pe-2">
										<div class="form-check form-check-sm form-check-custom form-check-solid mt-1" style="display: flex; justify-content: center; margin-right: 0.2em;">
											<input id="checkAll" class="form-check-input" type="checkbox" data-kt-check="true" data-kt-check-target="#kt_file_manager_list .form-check-input" value="">
										</div>
									</th>
                                    <th width="43%" class="text-start ms-3">이름</th>
                                    <th width="10%" class="text-center">크기</th>
                                    <th width="10%" class="text-center">확장자</th>
                                    <th width="20%" class="text-center">마지막 수정일</th>
                                    <th width="10%"></th> 
                                </tr> 
                            </thead>
                          </table>
                           
						  <div class="border-bottom" style="width:100%; height:55em; overflow:auto">
							<table id="kt_file_manager_list" data-kt-filemanager-table="folders" class="table align-middle table-row-dashed fs-4 gy-3 mb-0" style="width: 100%; height: 90%;">
	                            <tbody class="fw-semibold text-gray-600" style="font-size: 1em;">
	                            	<c:set value="${pagingVO.dataList }" var="CloudStrgList"/>
		                            <c:choose>
		                            	<c:when test="${empty CloudStrgList }">
				                            <tr>
					                            <td colspan="6" class="dt-empty">
						                            <div class="d-flex flex-column flex-center mt-20">
									                    <img src="${pageContext.request.contextPath }/resources/file/image/cloudEmpty.png" class="mw-500px">
									                    <div class="fs-1 fw-bolder text-dark">파일이 없습니다.</div>
					              				 	</div> 
				              					 </td> 
			              					 </tr> 
		                            	</c:when>
		                            	<c:otherwise>
		                            
			                            	<!-- 폴더일 때 반복문 시작 -->
			                            	<c:if test="${not empty CloudStrgList }"> 
			                            		<c:forEach items="${CloudStrgList }" var="CloudStrgVO">
			                            				
				        						   <c:set var="cloudStrgFldrList" value="${CloudStrgVO.cloudStrgFldrList}" />	

			                           				  <c:forEach items="${cloudStrgFldrList }" var="cloudStrgFldr">
				                            		  		
						                                 <tr>
						                                    <td width="7%">
														  		<div class="form-check form-check-sm form-check-custom form-check-solid" style="display: flex; justify-content: center;">
														  			<input id="checkList" class="form-check-input" type="checkbox" value="${cloudStrgFldr.cloudStrgFldrCd }" />
														  		</div>
						                                    </td>
						                                    <td width="43%" id="cloudNameTd">
						                                        <div class="d-flex align-items-center">
						                                            <span class="icon-wrapper">
						                                                <i class="ki-duotone ki-folder fs-2x text-primary me-4"><span class="path1"></span><span class="path2"></span></i>
						                                            </span>
						                                            <a href="/company/cloudList.do?selectStrgCd=${cloudStrgFldr.cloudStrgFldrCd }" class="text-gray-800 text-hover-primary">${cloudStrgFldr.cloudStrgFldrNm }</a> 
						                                        </div> 
						                                    </td> 
						                                    <td width="10%" class="text-center">-</td>
						                                    <td width="10%" class="text-center">-</td> 
						                                    <td width="20%" class="text-center">-</td>
						                                    <!-- 더보기 버튼 시작 -->
							                                <td width="10%" class="pe-5" data-kt-filemanager-table="action_dropdown">
							                                    <div class="ms-2">
							                                        <button type="button" class="btn btn-sm btn-icon btn-light btn-active-light-primary me-2" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
							                                            <i class="ki-duotone ki-element-plus fs-3 m-0"> 
							                                            	 <span class="path1"></span> 
													  					 <span class="path2"></span> 
													  					 <span class="path3"></span>
													  					 <span class="path4"></span>
													  					 <span class="path5"></span>
													  				</i>
							                                        </button>
							                                        <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-150px py-4"
							                                            data-kt-menu="true">
							                                            <div class="menu-item px-3">
							                                                <div class="menu-link px-3" onclick="f_fldrNameModify('${cloudStrgFldr.cloudStrgFldrCd }', '${cloudStrgFldr.cloudStrgFldrNm }')">폴더 수정</div>
							                                            </div>
							                                        </div>
							                                    </div>
							                                </td>
						                                    <!-- 더보기 버튼 끝 -->
						                                </tr>
						                                
				                              		  </c:forEach>
			                            		
			                            		</c:forEach>
			                            	</c:if>
			                            	<!-- 폴더일 때 반복문 끝 -->
			                            	
			                            	<!-- 파일일 때 반복문 시작 -->
			                            	<c:if test="${not empty CloudStrgList }">
			                            		<c:forEach items="${CloudStrgList }" var="CloudStrgVO">
				        						   <c:set var="cloudFileList" value="${CloudStrgVO.cloudFileList}" />	
			                            				
			                           				  <c:forEach items="${cloudFileList }" var="cloudFile">
				                            		  		 
							                               <tr>
							                                   <td width="7%">
																	<div class="form-check form-check-sm form-check-custom form-check-solid" style="display: flex; justify-content: center;">
																		<input id="checkList" class="form-check-input" type="checkbox" value="${cloudFile.cloudFileCd }" />
																	</div>
							                                   </td>
							                                   <td width="43%">
							                                       <div class="d-flex align-items-center">
							                                           <a href="/company/imgPreview.do?cloudFileCd=${cloudFile.cloudFileCd }" target="_blank" class="">
							                                              	 ${cloudFile.cloudFileOrgnlNm } 
							                                           </a>
						                                       			<c:if test="${cloudFile.cloudFileExtnNm eq 'jpg' ||
																					  cloudFile.cloudFileExtnNm eq 'jpeg' ||
																					  cloudFile.cloudFileExtnNm eq 'png' ||
																					  cloudFile.cloudFileExtnNm eq 'gif' }">
																			<a href="/company/imgPreview.do?cloudFileCd=${cloudFile.cloudFileCd }" target="_blank" class="ki-duotone ki-magnifier ms-2 imgPreview fs-5"> 
																				<span class="path1"></span>
																				<span class="path2"></span>
																			</a>
																		</c:if>
							                                       </div>
							                                   </td>
							                                   <td width="10%" class="text-center">${cloudFile.cloudFileFancysize }</td>
							                                   <td width="10%" class="text-center">${cloudFile.cloudFileExtnNm }</td> 
							                                   <td width="20%" class="text-center">${cloudFile.cloudFileRegDt }</td>
							                               	   <td width="10%" class="pe-5"></td>
							                               </tr>
						                                
				                              		  </c:forEach>
			                            		
			                            		</c:forEach>
			                            	</c:if>
			                            	<!-- 파일일 때 반복문 끝 -->
			                            	
			                            	
			                            	</c:otherwise>
			                            </c:choose>
	                            	
			                        </tbody>
			                    </table> 
							</div> 
						
						</div>
						
<%-- 						<div class="dt-paging paging_simple_numbers mt-3 mb-3" id="pagingArea">
							${pagingVO.pagingHTML }
						</div> --%>
	
	                </div> 
	                <!-- 카드 바디 끝-->
					
	                
	            </div>
	                              
			</div>
			<!-- 파일 목록 끝 -->


	</div> 
</div>

<script>
let strgSelectCd = null;	// Jstree에서 선택한 저장소의 코드
let strgSelectNm = null;	// Jstree에서 선택한 저장소의 이름

let moveFldrOrFileCd;	// 이동할 폴더 또는 파일 코드
let selectStrgCd = '${selectStrgCd}'; 		// 폴더 이동 후 페이지 이동할 현재 화면의 저장소 코드

let checkArr = new Array();		// 체크박스가 선택된 게시물들을 넣을 공간

let searchWord = '${searchWord}';

$(function() {

	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
	let searchForm = $("#searchForm");		
/* 	let pagingArea = $("#pagingArea");		// 페이징 처리 위한 div
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a 태그의 기본 기능 멈추기
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		
		$('#myInput').val("");
		
		searchForm.submit();
	}); */
	
	// 검색 버튼 눌렀을 때 키워드 검색
	$('#searchBtn').on('click', function() {
		let keyword = $('#myInput').val();
		console.log($('#myInput').val());
		
		if (keyword == null || keyword == "") {
			Swal.fire({
				icon: 'warning',
				title: '검색 키워드가 없습니다.',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}		
		searchForm.attr("action", "/company/cloudListSearch.do?searchWord=" + keyword);
		searchForm.submit();
	});

	// 엔터키를 눌렀을 때 키워드 검색 
	$('#searchForm').on('keydown', function(event) {
		if (event.keyCode == 13) {	// Enter 키를 눌렀을 때 (엔터키 == 13번)
			let keyword = $('#myInput').val();
			console.log($('#myInput').val()); 
			
			if (keyword == null || keyword == "") {
				Swal.fire({
					icon: 'warning',
					title: '검색 키워드가 없습니다.',
					confirmButtonColor: '#4FC9DA',
				});
				return false;
			}	
			searchForm.attr("action", "/company/cloudListSearch.do?searchWord=" + keyword);
			searchForm.submit();
	    }
	});
	
	// 엔터키를 눌렀을 때 폴더 수정
	$('#modifyFldrForm').on('keydown', function(event) {
		if (event.keyCode == 13) {	// Enter 키를 눌렀을 때 (엔터키 == 13번)
			event.preventDefault();
			f_modifyFldr();
		} 
	});
	
	// 체크박스 전체 선택 배열 실시간 생성
	$('#checkAll').on('click', function() {
	 	let checkList = $("tbody .form-check-input"); // 모든 체크박스 가져오기
	 	let allChecked = $(this).is(':checked'); // 전체 체크박스가 체크 되어있는지 여부
	 	
	 	// 배열 초기화
	    checkArr = [];
		
        if (allChecked) {
		// 체크가 된 상태의 게시물만 배열에 넣기
			for (var i = 0; i < checkList.length; i++) {
				checkArr.push(checkList[i].value);
			}
        }
		console.log(checkArr);
	});

	// 체크박스 선택 배열 실시간 생성
	$('tbody ').on('click', '#checkList', function() {
	    const value = this.value; // 클릭한 체크박스의 값
	    const isChecked = this.checked; // 체크박스의 체크 상태
	
	    if (isChecked) {
	        // 체크된 경우 배열에 추가
	        checkArr.push(value);
	    } else {
	        // 체크 해제된 경우 배열에서 제거
	        const index = checkArr.indexOf(value);
	        if (index > -1) {
	            checkArr.splice(index, 1); // 배열에서 해당 값 제거
	        }
	    }
	
	    console.log(checkArr); // 배열 출력
	});
	
	// 커스텀 개인함 + 버튼 눌렀을 때
	$('#cloudStrgPlusBtn').on('click', function () {
		$('#cloudStrgNmDiv').css('display', 'block');
	});
	
	// 파일 선택하면 화면에 띄우기 (Dropzone 설정)
	const id = "#kt_modal_upload_dropzone";
	const dropzoneElement = document.querySelector(id);
	console.log("Dropzone element:", dropzoneElement);

	var previewNode = dropzoneElement.querySelector(".dropzone-item");
	previewNode.id = ""; 
	
	// Dropzone 커스텀 템플릿
	// 원하는 모양으로 만들고 previewTemplate 옵션으로 적용
	var previewTemplate = previewNode.parentNode.innerHTML;
	previewNode.parentNode.removeChild(previewNode); 

	var myDropzone = new Dropzone(dropzoneElement, {
	    url: "https://keenthemes.com/scripts/void.php", // 파일을 업로드할 서버 주소 url
	    method: 'post', // 기본 post로 request 감. put으로도 할수있음
		// 자동으로 보내기. true : 파일 업로드 되자마자 서버로 요청, false : 서버에는 올라가지 않은 상태. 
		// 따로 this.processQueue() 호출시 전송
	    autoProcessQueue: false,
	    maxFiles: 10, // 업로드 파일수
	    parallelUploads: 10, // 동시파일업로드 수(이걸 지정한 수 만큼 여러파일을 한번에 넘긴다.)
	    uploadMultiple: true, // 다중업로드 기능
	    timeout: 300000, //커넥션 타임아웃 설정 -> 데이터가 클 경우 꼭 넉넉히 설정
	    
	    maxFilesize: 2, // 최대 업로드 용량 2MB
	    autoQueue: false, // 드래그 드랍 후 바로 서버로 전송 여부
	    previewTemplate: previewTemplate, // Dropzone 커스텀 템플릿
	    previewsContainer: dropzoneElement.querySelector(".dropzone-items"), // 커스텀 템플릿을 넣을 Container 위치
	    clickable: dropzoneElement.querySelector(".dropzone-select") // 클릭 가능 여부
	});

	console.log("Dropzone instance:", myDropzone);

	// 파일 추가 시 이벤트 (Dropzone 설정)
	myDropzone.on("addedfile", function (file) {
        // 중복된 파일 제거하기
        if (this.files.length) {
           var hasFile = false;
           for (var i = 0; i < this.files.length - 1; i++) {
              if (
                 this.files[i].name === file.name &&
                 this.files[i].size === file.size &&
                 this.files[i].lastModifiedDate.toString() === file.lastModifiedDate.toString()
              ) {
                 hasFile = true; 
                 this.removeFile(file);
              }
           }
        }
		
		file.previewElement.querySelector(id + " .dropzone-start").onclick = function () { myDropzone.enqueueFile(file); };
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
		if (strgSelectCd == "" || strgSelectCd == null) {
			Swal.fire({
				icon: 'warning',
				title: '폴더 위치를 선택해주세요!',
				text: '파일이 저장될 폴더의 위치가 선택되지 않았습니다.',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}
		console.log(myDropzone.files.length);
		if (myDropzone.files.length > 10) {
			Swal.fire({
				icon: 'warning',
				title: '최대 파일 갯수를 초과하였습니다!',
				confirmButtonColor: '#4FC9DA',
			});
			return false;
		}
		
		console.log(myDropzone.files); 
		
		let flag = true;
		myDropzone.files.forEach(files => {
			console.log(files.status);
			
			if (files.status == "error") {
				Swal.fire({
					icon: 'warning',
					title: '최대 파일 크기를 초과한 파일이 있습니다!',
					text: '해당 파일을 제거한 뒤 다시 시도해주세요.',
					confirmButtonColor: '#4FC9DA',
				});
				flag = false;
			}
		});
		
		if (flag == false) {
			return false;
		}
		
		// 모두 통과했을 때 Ajax로 파일 업로드 하기
		let formData = new FormData();
		
		myDropzone.files.forEach(files => {
			formData.append("files", files);
			console.log(files);
		});
		formData.append("strgSelectCd", strgSelectCd);
		
		$.ajax({
			url: "/company/fileUpload.do",
			type: "post",
			data: formData,
			dataType : "text",
			// 파일 전송의 경우 쿼리스트링을 사용하지 않으므로 해당 설정을 false로 비활성화
			processData: false,
			// 파일을 비동기처리를 할 때 false로 해두면 contentType이 'multipart/form-data'로 변경되어 나감
			contentType : false,
			success: function(response) {
				let res = JSON.parse(response);
				console.log(res.result);
				console.log(res.selectStrgCd);  
				
				if (res.result == "OK") {
					$('#kt_modal_upload').modal('hide');
					
					setTimeout(() => {
						location.href = "/company/cloudList.do?selectStrgCd=" + res.selectStrgCd;
					}, 1000);
					const Toast = Swal.mixin({
					    toast: true,
					    position: 'center-center',
					    showConfirmButton: false,
					    timer: 1000,
					    timerProgressBar: true,
					    didOpen: (toast) => {
						        toast.addEventListener('mouseenter', Swal.stopTimer)
						        toast.addEventListener('mouseleave', Swal.resumeTimer)
					    }
				    });

					Toast.fire({
					    icon: 'success',
					    title: '파일이 정상적으로 업로드 되었습니다.'
					});
				} else if (res.result == "LOGOUT") {
					Swal.fire({
						icon: 'warning',
						title: '세션이 종료되었습니다!',
						text: '다시 로그인해주세요!',
						confirmButtonColor: '#4FC9DA',
					});
					location.href = "/login.do";
				} else if (res.result == "EXIST") {
					Swal.fire({
						icon: 'warning',
						title: '해당 폴더에 중복된 파일명이 있습니다!',
						confirmButtonColor: '#4FC9DA',
					});
				}
			}
			
			
		});
		
	});
	 
	// 커스텀 클라우드함 삭제 누를 때
	$('#customCloudStrg').on('click', "#cloudStrgDeleteBtn", function () {
		let cloudStrgDeleteBtn = $(this);
	    let cloudStorageCd = cloudStrgDeleteBtn.data('selectstrgcd');
	    console.log(cloudStorageCd);
	    
		Swal.fire({
			title: '클라우드함을 삭제하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#F06445',
			cancelButtonColor: '#4FC9DA',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false, // 버튼 순서 (기본)
			
		}).then((result) => {	
			if (result.isConfirmed) {
				let data = {
					cloudStrgCd : cloudStorageCd 
				}
				
				$.ajax({
					url: "/company/cloudStrgCustomDelete.do",
					type: "post",
					data: JSON.stringify(data),
					contentType : "application/json; charset=utf-8",
					success: function(res) {
						console.log("res : " + res);
						if (res == "OK") {
							cloudStrgDeleteBtn.closest('.blockHover').remove();
						} else {
							Swal.fire({
								icon: 'warning',
								title: '선택한 폴더 내에 하위 폴더가 존재합니다.',
								text:  '하위 폴더롤 먼저 이동 또는 삭제해주세요.',
								confirmButtonColor: '#4FC9DA',
							});
						}
					}
				});
			}
		});
	    
	});   
 
	// 파일 업로드시 위치를 선택한 후 선택을 누를 때
	$('#strgSelectBtn').on('click', function () {
		$('#kt_modal_scrollable_strgList').modal('hide');
	    console.log(strgSelectNm); 
	    
	    let html = `<div class='position-relative ps-7 pe-7 py-2'>
				        <div class='position-absolute start-0 top-0 w-3px h-100 rounded-2 bg-success'></div>
				        <a href='#' class='mb-1 text-gray-900 text-hover-primary fw-bold fs-4'>\${strgSelectNm}</a>
				    </div>`;
	    
	    $('#selectStrg').html(html);
	});  
	   
    // jstree 자바스크립트에서 사용할 계층형 데이터 가져오기
    $('.callJstree').on('click', function() {
    	$('.treeUl').html("");
        $.ajax({
            type: "get",
            url: "/company/cloudSelectJstree.do",
            success: function(data) { 
                f_createJstree(data);
                console.log(data);
            }
        });
    });  

});


// 클라우드함을 클릭했을 때
function f_cloudStrgClick(cloudStrgCd) {
	let selectStrgCd = cloudStrgCd;
	console.log("클라우드함 번호 : " + cloudStrgCd);  
	
	location.href = "/company/cloudList.do?selectStrgCd=" + selectStrgCd;
}

// 파일 경로에서 클라우드함 또는 폴더를 클릭했을 때
function f_cloudPathClick(strgCd) {
	let cloudStrgCd = strgCd;
	console.log("클라우드함 코드bb : " + cloudStrgCd);  
	
	location.href = "/company/cloudList.do?selectStrgCd=" + cloudStrgCd;
}


//커스텀 개인함 추가 체크버튼 눌렀을 때
function f_cloudStrgAddBtn() {
	let strgNm = $('#cloudStrgNm').val();
	
	console.log("strgNm : " + strgNm);
	
	$('#cloudStrgNmDiv').css('display', 'none');

	if (strgNm == "" || strgNm == null) {
		return false;
	}
	
	let data = {
		cloudStrgNm : strgNm
	}
	
	$.ajax({
		url: "/company/cloudStrgCustomInsert.do",
		type: "post",
		data: JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
		success: function(res) {
			console.log("res.cloudStrgCd : " + res.cloudStrgCd);
			console.log("res.cloudStrgNm : " + res.cloudStrgNm);
			let customDiv = $('#customDiv');
			let html = "";
			html = `<div class='menu-link py-3 divHover blockHover'>
			                <div class='menu-link p-0 ms-2' onclick='f_cloudStrgClick("\${res.cloudStrgCd }")' style='max-width: 7em;'>
			                <span class='menu-bullet'><span class='bullet bullet-dot'></span></span>
			            	<span class='menu-title fs-4'>\${res.cloudStrgNm }</span>
			            </div> 
			            <div id='cloudStrgDeleteBtn' class='ki-outline ki-cross fs-3 none' data-selectstrgCd='\${res.cloudStrgCd}' style="margin-left: 4em;" style='margin-left: 4em;'></div>   
			        </div>`;
			
			customDiv.append(html);
		}
	});
	
	$('#cloudStrgNm').val("");
}

// 체크 여부 확인
function f_check(msg) {
	
	if (checkArr == 0) {
		Swal.fire({
			icon: 'warning',
			title: '선택한 항목이 없습니다.',
			confirmButtonColor: '#4FC9DA',
		});
		return false;
	}
	
	if (msg == "move") {
	    // 체크가 되었을 경우 모달 열기
		f_openMoveListModal();
	}
	if (msg == "del") {
		f_cloudDelListBtn();
	}
}

// 선택 이동 모달 열기
function f_openMoveListModal() {
    const modalElement = document.getElementById('modalMoveList');
    const modal = new bootstrap.Modal(modalElement);
    modal.show();
}

// 게시물 선택 이동 하기
function f_cloudMoveListBtn() {
	console.log("선택 이동");
	
	Swal.fire({
		title: '정말 이동하시겠습니까?',
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#F06445',
		cancelButtonColor: '#4FC9DA',
		confirmButtonText: '예',
		cancelButtonText: '아니요',
		reverseButtons: false, // 버튼 순서 (기본)
		
	}).then((result) => {	
		if (result.isConfirmed) {
			let data = {
				checkArr : checkArr,
				cloudUpCd : strgSelectCd 
			}
			console.log("data : ");
			console.log(data);
			
			$.ajax({
				url: "/company/cloudMoveList.do",
				type: "post",
				data: JSON.stringify(data),
				contentType : "application/json; charset=utf-8",
				success: function(res) {
					if (res == "OK") {
						$('#modalMoveList').modal('hide');
						
						setTimeout(() => {
							location.href = "/company/cloudList.do?selectStrgCd=" + selectStrgCd;
						}, 1000);
						const Toast = Swal.mixin({
						    toast: true,
						    position: 'center-center',
						    showConfirmButton: false,
						    timer: 1000,
						    timerProgressBar: true,
						    didOpen: (toast) => {
							        toast.addEventListener('mouseenter', Swal.stopTimer)
							        toast.addEventListener('mouseleave', Swal.resumeTimer)
						    }
					    });

						Toast.fire({
						    icon: 'success',
						    title: '정상적으로 이동 되었습니다.'
						});
					} else if (res == "FAILED") {
						Swal.fire({
							icon: 'warning',
							title: '선택한 폴더 내에 하위 폴더가 존재합니다.',
							text:  '하위 폴더롤 먼저 이동 또는 삭제해주세요.',
							confirmButtonColor: '#4FC9DA',
						});
					} else if (res == "NOTEXIST") {
						Swal.fire({
							icon: 'warning',
							title: '세션이 종료되었습니다!',
							text: '다시 로그인해주세요!',
							confirmButtonColor: '#4FC9DA',
						});
						location.href = "/login.do";
					}
				}
			});
		}
	});
	
};

//게시물 삭제 하기
function f_cloudDelListBtn() {
	console.log("삭제");
	
	Swal.fire({
		title: '정말 삭제하시겠습니까?',
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#F06445',
		cancelButtonColor: '#4FC9DA',
		confirmButtonText: '예',
		cancelButtonText: '아니요',
		reverseButtons: false, // 버튼 순서 (기본)
		
	}).then((result) => {	
		if (result.isConfirmed) {
			let data = {
				checkArr : checkArr
			}
			
			$.ajax({
				url: "/company/cloudDeleteList.do",
				type: "post",
				data: JSON.stringify(data),
				contentType : "application/json; charset=utf-8",
				success: function(res) {
					if (res == "OK") {
						setTimeout(() => {
							location.href = "/company/cloudList.do?selectStrgCd=" + selectStrgCd;
						}, 1000);
						const Toast = Swal.mixin({
						    toast: true,
						    position: 'center-center',
						    showConfirmButton: false,
						    timer: 1000,
						    timerProgressBar: true,
						    didOpen: (toast) => {
							        toast.addEventListener('mouseenter', Swal.stopTimer)
							        toast.addEventListener('mouseleave', Swal.resumeTimer)
						    }
					    });

						Toast.fire({
						    icon: 'success',
						    title: '정상적으로 삭제 되었습니다.'
						});
					} else if (res == "FAILED") {
						Swal.fire({
							icon: 'warning',
							title: '선택한 폴더 내에 하위 폴더가 존재합니다.',
							text:  '하위 폴더롤 먼저 이동 또는 삭제해주세요.',
							confirmButtonColor: '#4FC9DA',
						});
					} else if (res == "NOTEXIST") {
						Swal.fire({
							icon: 'warning',
							title: '세션이 종료되었습니다!',
							text: '다시 로그인해주세요!',
							confirmButtonColor: '#4FC9DA',
						});
						location.href = "/login.do";
					}
				}
			});
		}
	});
	
};

//폴더명 수정 버튼을 눌렀을 때
function f_fldrNameModify(fldrCd, fldrNm) {
	$('#cloudStrgFldrCd').val(fldrCd);
	
	console.log("cloudFldrUpCdHidden : " + $('#cloudFldrUpCdHidden').val());
	console.log(fldrCd);
	console.log(fldrNm);
	
	let cloudFldrNm = fldrNm;
	let modifyFolderCheckRow = $('#modifyFolderCheckRow');
	
	$('#modifyFldrName').val(fldrNm);
	
	let jbgdArray = [];
	
	// 직급 출력 공간 초기화
	modifyFolderCheckRow.html("");
	
	axios.get("/company/cloudFldrAuthrtListSelect.do?cloudStrgFldrCd=" + fldrCd)
	.then(function (res) {
		console.log(res);
		
		if (res.status == 200) {
			let data = res.data;

			data.forEach(CloudFldrAuthrtVO => {
				
				if (CloudFldrAuthrtVO.cloudFldrAuthrtYn == "Y") {
					let html = "";
					html = `<div class='form-check col-3 mb-5'> 
						    	<input class='form-check-input fldrAuth' type='checkbox' value='\${CloudFldrAuthrtVO.cloudFldrAuthrtNo}' id='flexCheck' name='cloudFldrAuthrtArray' data-jbgdCd='\${CloudFldrAuthrtVO.jbgdCd}' checked>\${CloudFldrAuthrtVO.jbgdNm}
							</div>`;
					modifyFolderCheckRow.append(html);
					
					jbgdArray.push(CloudFldrAuthrtVO.jbgdCd);	// 권한이 있는 직급만 배열에 추가
				} else {
					let html = "";
					html = `<div class='form-check col-3 mb-5'> 
						    	<input class='form-check-input fldrAuth' type='checkbox' value='\${CloudFldrAuthrtVO.cloudFldrAuthrtNo}' id='flexCheck' name='cloudFldrAuthrtArray' data-jbgdCd='\${CloudFldrAuthrtVO.jbgdCd}'>\${CloudFldrAuthrtVO.jbgdNm}
							</div>`;
					modifyFolderCheckRow.append(html);
				}
				
			});
		}
	})
	.catch(function (error) {
    	console.log(error);
		Swal.fire({
			icon: 'warning',
			title: '서버 접속에 실패했습니다.',
			text:  '다시 시도해주세요.',
			confirmButtonColor: '#4FC9DA',
		});
	})
	$('#kt_modal_modify_Folder').modal('show');
	
/* 	 
	console.log("jbgdArray : " + jbgdArray); 
	
	// 수정 권한이 있는지 여부 확인
 	if (jbgdArray.includes(jbgdCd)) {
		console.log("권한 있음 !");
		$('#kt_modal_modify_Folder').modal('show');
	} else {
 		$('#kt_modal_modify_Folder').modal('hide');
		console.log("권한 없음 !"); 
 		
		Swal.fire({
			icon: 'warning',
			title: '폴더 수정 권한이 없습니다!',
			confirmButtonColor: '#4FC9DA',
		});
	}  
	 */
} 

//폴더 수정 저장 버튼을 눌렀을 때
function f_modifyFldr() {
	let modifyFldrForm = $('#modifyFldrForm');
	let modifyFldrName = $('#modifyFldrName').val();
	let cloudStrgFldrCd = $('#cloudStrgFldrCd').val();
	
	console.log("폴더 수정 저장");
	console.log(modifyFldrName);
	console.log(cloudFldrUpCdHidden);
	
	if (modifyFldrName == null || modifyFldrName == "") {
		Swal.fire({
			icon: 'warning',
			title: '폴더 이름이 비어있습니다.',
			confirmButtonColor: '#4FC9DA',
		});
		return false;
	} 
	
	// 폴더명 중복 체크
	axios.get("/company/modifyCloudFldrNameCheck.do?cloudFldrName=" + modifyFldrName + "&cloudFldrCd=" + cloudStrgFldrCd)
	.then(function (res) {
		console.log(res);
		
		if (res.data == "EXIST") {
			Swal.fire({
				icon: 'warning',
				title: '해당 폴더 이름이 이미 있습니다!',
				text:  '다시 입력해주세요.',
				confirmButtonColor: '#4FC9DA',
			});
		} else if (res.data == "NOEXIST") {
			modifyFldrForm.submit();
		} 
	})
	 
}

//파일 다운로드를 눌렀을 때
function f_cloudDownListBtn() {
	console.log(checkArr);
	
	if (checkArr.length == 0) {
		Swal.fire({
			icon: 'warning',
			title: '폴더 또는 파일을 선택해주세요!',
			confirmButtonColor: '#4FC9DA',
		}); 
		return false;
	} 
	
	// map 형식으로 데이터 전송
	axios.post("/company/cloudDownList.do", {
		downList : checkArr
	})
	.then(function (res) {
		console.log(res.data);
		if (res.data == "OK") {
	     	Swal.fire({
				icon: 'success',
			title: '다운로드가 완료되었습니다.',
			text:  '다운로드 폴더를 확인해주세요.',
			confirmButtonColor: '#4FC9DA',
			});
		} else {
			Swal.fire({
				icon: 'warning',
				title: '서버에 오류가 발생했습니다!',
				text:  '다시 시도해주세요.',
				confirmButtonColor: '#4FC9DA',
			});
		}
	})
	.catch(function (error) {
	    console.error("오류 발생:", error);
	});
	
}


//선택 폴더로 이동 버튼을 눌렀을 때
function f_fldrLocateSelectBtn() {
	console.log('f_fldrLocateSelectBtn / strgSelectCd : ' + strgSelectCd);
	
	if (strgSelectCd == null) {
		Swal.fire({
			icon: 'warning',
			title: '이동하려는 폴더를 선택해주세요!',
			confirmButtonColor: '#4FC9DA',
		});
		return false;
	}
	
	location.href="/company/cloudList.do?selectStrgCd=" + strgSelectCd;
	
}

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
	
	 $('.treeUl').html(treeHTML); // treeUl에 jstree HTML을 삽입함
	
	 // 삽입한 HTML을 jstree 형식과 매칭하기
	 $('.strgJstree').jstree({
	     "core": {
	         "themes": {
	             "responsive": false
	         }
	     },
	     "types": {
	         "cloudStrg": {
	             "icon": "ki-outline ki-file text-primary"
	         },
	         "cloudFlrd": {
	             "icon": "ki-outline ki-file text-warning"
	         } 
	     },
	     "plugins": ["types", "dnd"]
	 })
	 
	 // 양식을 선택하면 CKEDITOR에 양식 내용 삽입하기
	 $('.strgJstree').bind('select_node.jstree', function(event, data){
	    // 노드를 선택했을 때 id = docFormNo 가져오기
	    strgSelectCd = data.node.li_attr.value;
	    strgSelectNm = data.node.text;
	    
	    console.log("strgJstree bind");
	    console.log("strgSelectCd : " + strgSelectCd);
	    console.log("strgSelectNm : " + strgSelectNm);
	 });
 
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

</script>
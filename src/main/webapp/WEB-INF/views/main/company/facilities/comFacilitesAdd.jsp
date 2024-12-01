
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/design/plugins/custom/draggable/draggable.bundle.js"></script>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>시설 예약</h3>
		<h6>시설 등록</h6>
	</div>
</div>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content_container" class="app-container container-fluid" style="height: 100%;">
			<div class="row" style="height: 100%;">
	
			<!-- 카테고리 목록 시작 -->
			<div class="col-4 p-0 mb-5">  
                <div class="card card-flush" style="height : 100%;">
	                <!-- 카드 헤더 시작-->
	                <div class="card-header">
	                    <div class="card-title">
	                    	<h3 class="card-title">카테고리</h3>
	                    </div> 
	                    <div class="card-toolbar"> 
	                        <div class="d-flex justify-content-end" data-kt-filemanager-table-toolbar="base">
	                            <button type="button" class="btn btn-flex btn-light-info me-1 px-4 callJstree" id="addCateBtn">
	                                <i class="ki-duotone ki-file-right fs-2"><span class="path1"></span><span class="path2"></span></i>
	                                	카테고리 추가
	                            </button>
	                        </div>
	                        
	                        <!-- 카테고리 추가 -->
	                        <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered mw-650px">
									<div class="modal-content">
										<div class="modal-header" id="kt_modal_add_user_header">
											<h2 class="fw-bold">카테고리 추가</h2>
											<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal" id="">
												<i class="ki-duotone ki-cross fs-1">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
											</div>
										</div>
										<div class="modal-body px-5 my-7">
											<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
												<div class="fv-row mb-7">
													<label class="required fw-semibold fs-6 mb-2">카테고리명</label>
													<input type="text" name="category_nm" id="category_nm" class="form-control form-control-solid mb-3 mb-lg-0"  value="4F" />
													<span id="nm_chk" style="color: red;"></span>
												</div>
												<div class="fv-row mb-7">
													<label class="required fw-semibold fs-6 mb-2">카테고리사진</label>
													<input type="file" name="category_img" id="category_img" multiple="multiple" class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
													<span id="img_chk" style="color: red;"></span>
												</div>
												<div class="fv-row mb-7" id="div_logo">
													<img id="img_logo"  style="height: 300px; width: 550px;">
												</div>
											</div>
											<div class="text-center pt-10">
												<button type="button" class="btn btn-primary" id="setCategoryBtn">
													<span class="indicator-label">등록</span>
													<span class="indicator-progress">Please wait... 
													<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
												</button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 카테고리 추가 끝 -->
							<!-- 카테고리 수정 시작 -->
	                        <div class="modal fade" id="modifyCategoryModal" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered mw-650px">
									<div class="modal-content">
										<div class="modal-header" id="kt_modal_add_user_header">
											<h2 class="fw-bold">카테고리 수정</h2>
											<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal" id="">
												<i class="ki-duotone ki-cross fs-1">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
											</div>
										</div>
										<div class="modal-body px-5 my-7">
											<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
												<div class="fv-row mb-7">
													<label class="required fw-semibold fs-6 mb-2">카테고리명</label>
													<input type="text" name="modify_category_nm" id="modify_category_nm" class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
													<span id="modify_nm_chk" style="color: red;"></span>
												</div>
												<div class="fv-row mb-7">
													<label class="required fw-semibold fs-6 mb-2">카테고리사진</label>
													<input type="file" name="modify_category_img" id="modify_category_img" multiple="multiple" class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
													<span id="modify_img_chk" style="color: red;">이미지 미 선택 시 이전 이미지 파일을 사용합니다.</span>
												</div>
												<div class="fv-row mb-7" id="modify_div_logo">
													<img id="modify_img_logo"  style="height: 300px; width: 550px;">
												</div>
												<input type="hidden" id="modify_ctgr_cd" value="">
 											</div>
											<div class="text-center pt-10">
												<button type="button" class="btn btn-primary" id="modifyCategoryBtn">
													<span class="indicator-label">수정</span>
													<span class="indicator-progress">Please wait... 
													<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
												</button>
												<button type="button" class="btn btn-primary" id="delCategoryBtn">
													<span class="indicator-label">삭제</span>
													<span class="indicator-progress">Please wait... 
													<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
												</button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 카테고리 수정 끝 -->
							
	                    </div>
	                </div>
	                <!-- 카드 헤더 끝 -->
	            
	                <!-- 카드 바디 시작-->
	                <div class="card-body pt-0 pb-0">
						<table id="kt_file_manager_list" data-kt-filemanager-table="folders" class="table align-middle table-row-dashed fs-6 gy-3 mb-0" style="width: 98.5%;">
                            <thead>
                                <tr class="text-gray-500 fw-bold fs-7"> 
                                    <th width="40%" style="text-align: center;">카테고리명</th>
                                    <th width="30%" style="text-align: center;">시설수</th>
                                    <th width="30%"></th> 
                                </tr> 
                            </thead>
                        </table>
                           
						<div style="width:100%; height:33em; overflow:auto">
							<table id="kt_file_manager_list" data-kt-filemanager-table="folders" class="table align-middle table-row-dashed fs-6 gy-3 mb-0" style="width: 100%;">
	                            <tbody class="fw-semibold text-gray-600 container" >
	                            <c:choose>
									<c:when test="${empty fcltCtgrList }">
										<tr>
				                            <td colspan="3" class="dt-empty">
					                            <div class="d-flex flex-column flex-center mt-10">
								                    <img src="${pageContext.request.contextPath }/resources/file/image/cloudEmpty.png" class="mw-300px">
								                    <div class="fs-1 fw-bolder text-dark">카테고리가 없습니다.</div>
			              				 		</div> 
		              						</td> 
	              						</tr>
									</c:when>
									<c:otherwise>
										<div class="container">
										<c:forEach items="${fcltCtgrList }" var="item">
											<div class="border border-gray-300 border-dashed rounded min-w-125px py-3 px-4 me-6 mb-3 draggable" draggable="true">
												<div class="d-flex align-items-center" id="divList">
												    <div class="el" style="display: flex; width: 100%; justify-content: space-between; align-items: center;" onclick="categoryClick('${item.fcltCtgrCd}')">
												        <input type="hidden" id="fcltCtgrCd" value="${item.fcltCtgrCd}">
												        <div style="width: 45%; text-align: left;" id="Nm">${item.fcltCtgrNm}</div>
												        <div style="width: 20%; text-align: center;">시설수</div>
												        <div style="width: 35%; text-align: center;">
												            <button type="button" class="btn btn-light-warning" id="baseworksettingbtn" onclick="modifyCtgrBtn('${item.fcltCtgrCd}')">수정</button>
												        </div>
												    </div>
												</div>
											</div> 
										</c:forEach>
										</div>
									</c:otherwise>                            
	                            </c:choose>
	                        	</tbody>
	                    	</table>  
						</div> 
					</div>
               	</div>
		        
		    </div>
			<!-- 카테고리 목록 끝 -->
			 
			<!-- 카테고리별 시설 목록 시작 -->					
			<div class="col-8 pe-0 mb-5" id="kt_app_root"> 
	            <div class="card card-flush" style="height : 100%;">
					<!-- 카드 헤더 시작-->
	                <div class="card-header">
	                    <div class="card-title">
	                    	<h3 class="card-title"><span id="title_categoryNm"></span> 시설</h3>
	                    	<input type="hidden" id="title_categoryCd" value="">
	                    </div> 
	                    <div class="card-toolbar"> 
	                        <div class="d-flex justify-content-end" data-kt-filemanager-table-toolbar="base">
	                            <button type="button" class="btn btn-flex btn-light-info me-1 px-4 callJstree" id="fcltAddBtn">
	                                <i class="ki-duotone ki-file-right fs-2"><span class="path1"></span><span class="path2"></span></i>
	                                	시설 추가
	                            </button>
	                        </div>
	                        <!-- 시설 추가 모달 시작 -->
	                        <div class="modal fade" id="fcltAddModal" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered mw-650px">
									<div class="modal-content">
										<div class="modal-header" id="kt_modal_add_user_header">
											<h2 class="fw-bold">시설 추가</h2>
											<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal" id="">
												<i class="ki-duotone ki-cross fs-1">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
											</div>
										</div>
										<div class="modal-body px-5 my-7">
												<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">카테고리명</label>
														<input type="text" name="fcltAddModal_category_nm" id="fcltAddModal_category_nm" readonly="readonly" class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
													</div>
													
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">시설명</label>
														<input type="text" name="fcltAddModal_fclt_nm" id="fcltAddModal_fclt_nm"  class="form-control form-control-solid mb-3 mb-lg-0"  value="416" />
													</div>
													
												    <div style="display: flex; align-items: center;">
														<div class="fv-row mb-7" style="width: 50%;">
														    <label class="required fw-semibold fs-6 mb-2">이용 시작 시간</label>
													        <input type="time" name="fcltAddModal_start_tm" id="fcltAddModal_start_tm" class="form-control form-control-solid mb-6 mb-lg-0" style="margin-right: 10px;" value="09:00" />
													    </div>
													    &nbsp;
														<div class="fv-row mb-7" style="width: 50%;">
														    <label class="required fw-semibold fs-6 mb-2">이용 종료 시간</label>
													        <input type="time" name="fcltAddModal_end_tm" id="fcltAddModal_end_tm" class="form-control form-control-solid mb-6 mb-lg-0" style="margin-right: 10px;" value="21:00" />
													    </div>
													</div>
													
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">최대 인원 수</label>
														<input type="number" name="fcltAddModal_fclt_num" id="fcltAddModal_fclt_num"  class="form-control form-control-solid mb-3 mb-lg-0"  value="6" min="0"/>
													</div>
													
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">비품</label>
														<div class="form-check">
														    <input class="form-check-input" type="checkbox" value="프로젝터" id="eq1" checked="checked"/>
														    <label class="form-check-label" for="flexCheckDefault">
														        <i class="bi bi-projector"></i>프로젝터
														    </label>
													    <div class="form-check">
														</div>
														    <input class="form-check-input" type="checkbox" value="화이트보드" id="eq2"  checked="checked"/>
														    <label class="form-check-label" for="flexCheckDefault">
													        	<i class="bi bi-easel2"></i>화이트보드
														    </label>
													   <div class="form-check">
														</div>
														    <input class="form-check-input" type="checkbox" value="PC" id="eq3" checked="checked" />
														    <label class="form-check-label" for="flexCheckDefault">
														        <i class="fa-solid fa-desktop"></i>PC
														    </label>
														<div class="form-check">
														</div>
														    <input class="form-check-input" type="checkbox" value="프린터기" id="eq4" checked="checked" />
														    <label class="form-check-label" for="flexCheckDefault">
														        <i class="fa-solid fa-print"></i>프린터기
														    </label>
														<div class="form-check">
														</div>
														    <input class="form-check-input" type="checkbox" value="소화기" id="eq5" />
														    <label class="form-check-label" for="flexCheckDefault">
														        <i class="fa-solid fa-fire-extinguisher"></i>소화기
														    </label>
														</div>
														
													</div>
													
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">시설 안내</label>
														<textarea rows="5" cols="30" name="fcltAddModal_fclt_info" id="fcltAddModal_fclt_info" class="form-control form-control-solid mb-3 mb-lg-0"  >퇴실 시간 엄수 / 정리 정돈 필수  / 음식물 섭취 불가/ 비품 망실/파손시 배상 </textarea>
													</div>
													
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">시설 사진</label>
														<input type="file" name="fcltAddModal_fclt_img" id="fcltAddModal_fclt_img" class="form-control form-control-solid mb-3 mb-lg-0"  multiple="multiple" />
													</div>
													
												</div>
												<div class="text-center pt-10">
													<button type="button" class="btn btn-primary" id="setFcltBtn">
														<span class="indicator-label">등록</span>
														<span class="indicator-progress">Please wait... 
														<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
													</button>
												</div>
										</div>
									</div>
								</div>
							</div>
	                        <!-- 시설 수정 모달 시작 -->
	                        <div class="modal fade" id="fcltModifyModal" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered mw-650px">
									<div class="modal-content">
										<div class="modal-header" id="kt_modal_add_user_header">
											<h2 class="fw-bold">시설 수정</h2>
											<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal" id="">
												<i class="ki-duotone ki-cross fs-1">
													<span class="path1"></span>
													<span class="path2"></span>
												</i>
											</div>
										</div>
										<div class="modal-body px-5 my-7">
												<input type="hidden" id="fcltModifyModal_fclt_cd">
												<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">시설명</label>
														<input type="text" name="fcltModifyModal_fclt_nm" id="fcltModifyModal_fclt_nm"  class="form-control form-control-solid mb-3 mb-lg-0"  value="" />
													</div>
													
												    <div style="display: flex; align-items: center;">
														<div class="fv-row mb-7" style="width: 50%;">
														    <label class="required fw-semibold fs-6 mb-2">이용 시작 시간</label>
													        <input type="time" name="fcltModifyModal_start_tm" id="fcltModifyModal_start_tm" class="form-control form-control-solid mb-6 mb-lg-0" style="margin-right: 10px;" value="" />
													    </div>
													    &nbsp;
														<div class="fv-row mb-7" style="width: 50%;">
														    <label class="required fw-semibold fs-6 mb-2">이용 종료 시간</label>
													        <input type="time" name="fcltModifyModal_end_tm" id="fcltModifyModal_end_tm" class="form-control form-control-solid mb-6 mb-lg-0" style="margin-right: 10px;" value="" />
													    </div>
													</div>
													
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">최대 인원 수</label>
														<input type="number" name="fcltModifyModal_fclt_num" id="fcltModifyModal_fclt_num"  class="form-control form-control-solid mb-3 mb-lg-0"  value="" min="0"/>
													</div>
													
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">비품</label>
														<div class="form-check">
														    <input class="form-check-input" type="checkbox" value="프로젝터" id="Modifyeq1" />
														    <label class="form-check-label" for="flexCheckDefault">
														        <i class="bi bi-projector"></i>프로젝터
														    </label>
													    <div class="form-check">
														</div>
														    <input class="form-check-input" type="checkbox" value="화이트보드" id="Modifyeq2" />
														    <label class="form-check-label" for="flexCheckDefault">
													        	<i class="bi bi-easel2"></i>화이트보드
														    </label>
													   <div class="form-check">
														</div>
														    <input class="form-check-input" type="checkbox" value="PC" id="Modifyeq3" />
														    <label class="form-check-label" for="flexCheckDefault">
														        <i class="fa-solid fa-desktop"></i>PC
														    </label>
														<div class="form-check">
														</div>
														    <input class="form-check-input" type="checkbox" value="프린터기" id="Modifyeq4" />
														    <label class="form-check-label" for="flexCheckDefault">
														        <i class="fa-solid fa-print"></i>프린터기
														    </label>
														<div class="form-check">
														</div>
														    <input class="form-check-input" type="checkbox" value="소화기" id="Modifyeq5" />
														    <label class="form-check-label" for="flexCheckDefault">
														        <i class="fa-solid fa-fire-extinguisher"></i>소화기
														    </label>
														</div>
														
													</div>
													
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">시설 안내</label>
														<textarea rows="5" cols="30" name="fcltModifyModal_fclt_info" id="fcltModifyModal_fclt_info" class="form-control form-control-solid mb-3 mb-lg-0"  ></textarea>
													</div>
													
													<div class="fv-row mb-7">
														<label class="required fw-semibold fs-6 mb-2">시설 사진</label>
														<input type="file" name="fcltModifyModal_fclt_img" id="fcltModifyModal_fclt_img" class="form-control form-control-solid mb-3 mb-lg-0"  multiple="multiple" />
													</div>
													
												</div>
												<div class="text-center pt-10">
													<button type="button" class="btn btn-warning" id="modifyFcltBtn">
														<span class="indicator-label">수정</span>
														<span class="indicator-progress">Please wait... 
														<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
													</button>
													&nbsp;
													<button type="button" class="btn btn-danger" id="delFcltBtn">
														<span class="indicator-label">삭제</span>
														<span class="indicator-progress">Please wait... 
														<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
													</button>
												</div>
										</div>
									</div>
								</div>
							</div>
							
	                    </div>
	                </div>
	                <!-- 카드 헤더 끝 -->
	            
	                <!-- 카드 바디 시작-->
	                <div class="card-body pt-0 pb-0">
						<table id="kt_file_manager_list" data-kt-filemanager-table="folders" class="table align-middle table-row-dashed fs-6 gy-3 mb-0" style="width: 98.5%;">
                            <thead>
                                <tr class="text-gray-500 fw-bold fs-7"> 
                                    <th width="30%" class="text-start ms-3">시설명</th>
                                    <th width="20%" class="text-center">위치</th>
                                    <th width="20%" class="text-center">이용 가능 시간</th>
                                    <th width="20%" class="text-center">이용 가능 인원수</th>
                                    <th width="10%"></th> 
                                </tr> 
                            </thead>
                          </table>
                           
						<div style="width:100%; height:33em; overflow:auto">
							<table id="kt_file_manager_list" data-kt-filemanager-table="folders" class="table align-middle table-row-dashed fs-6 gy-3 mb-0" style="width: 100%;">
	
	                            <tbody class="fw-semibold text-gray-600" style="font-size: 0.85em;" id="fcltListTable">
		                            
		                            <tr>
		                            	<td colspan="6" class="dt-empty">
				                            <div class="d-flex flex-column flex-center mt-10">
							                    <img src="${pageContext.request.contextPath }/resources/file/image/cloudEmpty.png" class="mw-300px">
							                    <div class="fs-1 fw-bolder text-dark">시설이 없습니다.</div>
		              				 		</div> 
	              						 </td> 
              						 </tr>
              						 
              						  
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


<script>
$(function() {
	
	// 로고 이미지 div
	var div_logo = $("#div_logo");
	//카테고리 버튼
	var addCateBtn = $("#addCateBtn");
	//카테고리 추가 모달
	var addCateModal = $("#addCategoryModal");
	//카테고리 추가 버튼
	var setCategoryBtn = $("#setCategoryBtn");
	
	//카테고리 수정 모달
	var modifyCategoryModal = $("#modifyCategoryModal");
	//카테고리 수정 카테고리 이미지
	var modify_div_logo = $("#modify_div_logo");
	//카테고리 수정 버튼
	var modifyCategoryBtn = $("#modifyCategoryBtn");
	//카테고리 삭제 버튼
	var delCategoryBtn = $("#delCategoryBtn");
	
	//input-카테고리명
	var categoryNm = $("#category_nm"); 	
	//input-카테고리이미지
	var categoryImg = $("#category_img");
	//input-카테고리수정이미지
	var modifyCategoryImg = $("#modify_category_img");
	
	//시설 추가 버튼
	var fcltAddBtn = $("#fcltAddBtn");
	
	//시설 등록 버튼
	var setFcltBtn = $("#setFcltBtn");
	
	addCateBtn.on("click",function(){
		div_logo.hide();
		addCateModal.modal("show");
	});
	
	
	// category_img 파일 유형 체크
	categoryImg.change(function(){
		
	  	let fileVal = $(this).val();
	  	console.log("fileVal ::", fileVal);
	  	let valTypeArr = fileVal.split(".")
		let fileType = valTypeArr.pop().toLowerCase()
	  	let fileTypeArr = ['jpg','jpeg','gif','png'];
		
	  	if($.inArray(fileType,fileTypeArr)==-1){
	    	$("#img_chk").text("이미지 파일만 등록 가능합니다.");
	    	$(this).val("")
	  	}else{
	  		$("#img_chk").text("");
	  		div_logo.show();
	  		var file = event.target.files[0];

	  	    var reader = new FileReader(); 
	  	    reader.onload = function(e) {
	  	        $("#img_logo").attr("src", e.target.result);
	  	    }
	  	    reader.readAsDataURL(file);
	    	
		 }
	});
	
	// 카테고리 추가
	setCategoryBtn.on("click",function(){
		console.log("categoryNm.val() ::: ", categoryNm.val());
		if(categoryNm.val() == "" || categoryNm.val() == null){
			$("#nm_chk").text("카테고리명을 입력해주세요.");
			return false;
		}
		$("#nm_chk").text("");
		
		let file = categoryImg[0].files;
		if (file.length == '' || file == null) {
			$("#img_chk").text("카테고리 이미지를 선택해주세요.");
			return false;	
		}
		$("#img_chk").text("");
		
		let formData = new FormData();
		formData.append("fcltCtgrNm",categoryNm.val());
		formData.append("imgFile",file[0]);

		$.ajax({
			url : "/company/facilties/category/insert.do",
			type : "post",
			dataType : "text",
			processData: false,
	        contentType: false,
	        data: formData,
	        success: function(res) {
	           	Swal.fire({
	  				icon: 'success',
		  			title: '카테고리 등록을 완료되었습니다.',
		  			confirmButtonColor: '#4FC9DA',
				}).then(function(){
					location.reload(true);
				});
	        },
	        error: function(res) {
	        	Swal.fire({
   	  				icon: 'warning',
   		  			title: '카테고리 등록을 실패했습니다. 다시 시도해주세요.',
   		  			confirmButtonColor: '#4FC9DA',
   				});	
	        }
		})
	});
	
	modifyCategoryImg.change(function(){
	  	let fileVal = $(this).val();
	  	console.log("fileVal ::", fileVal);
	  	let valTypeArr = fileVal.split(".")
		let fileType = valTypeArr.pop().toLowerCase()
	  	let fileTypeArr = ['jpg','jpeg','gif','png'];
		
	  	if($.inArray(fileType,fileTypeArr)==-1){
	    	$("#modify_img_chk").text("이미지 파일만 등록 가능합니다.");
	    	$(this).val("")
	  	}else{
	  		$("#modify_img_chk").text("");
	  		div_logo.show();
	  		var file = event.target.files[0];

	  	    var reader = new FileReader(); 
	  	    reader.onload = function(e) {
	  	        $("#modify_img_logo").attr("src", e.target.result);
	  	    }
	  	    reader.readAsDataURL(file);
	    	
		 }
	});
	
	
	//카테고리 수정
	modifyCategoryBtn.on("click",function(){
		if($("#modify_category_nm").val() == "" || $("#modify_category_nm").val() == null){
			$("#modify_nm_chk").text("카테고리명을 입력해주세요.");
			return false;
		}
		$("#modify_nm_chk").text("");
		
		let file = modifyCategoryImg[0].files;
		console.log("file :: ", file.length);
		let formData = new FormData();
		formData.append("fcltCtgrNm",$("#modify_category_nm").val());
		formData.append("fcltCtgrCd",$("#modify_ctgr_cd").val());
		
		if (file.length != 0) {
			console.log("img null chk");
			formData.append("imgFile",file[0]);
		}
		

		$.ajax({
			url : "/company/facilties/category/modify.do",
			type : "post",
			dataType : "text",
			processData: false,
	        contentType: false,
	        data: formData,
	        success: function(res) {
	           	Swal.fire({
	  				icon: 'success',
		  			title: '카테고리 수정을 완료되었습니다.',
		  			confirmButtonColor: '#4FC9DA',
				}).then(function(){
					location.reload(true);
				});
	        },
	        error: function(res) {
	        	Swal.fire({
   	  				icon: 'warning',
   		  			title: '카테고리 수정을 실패했습니다. 다시 시도해주세요.',
   		  			confirmButtonColor: '#4FC9DA',
   				});	
	        }
		})
	});

	delCategoryBtn.on("click", function () {
		console.log("delCategoryBtn Click")
		var fromdata = {
			fcltCtgrCd : $("#modify_ctgr_cd").val()
		};
		
		$.ajax({
			url : "/company/facilties/category/delete.do",
			type : "post",
			contentType: "application/json; charset=utf-8",
	        data: JSON.stringify(fromdata) ,
	        success: function(res) {
	           	Swal.fire({
	  				icon: 'success',
		  			title: '카테고리 삭제를 완료되었습니다.',
		  			confirmButtonColor: '#4FC9DA',
				}).then(function(){
					location.reload(true);
				});
	        },
	        error: function(res) {
	        	Swal.fire({
   	  				icon: 'warning',
   		  			title: '카테고리 삭제를 실패했습니다. 다시 시도해주세요.',
   		  			confirmButtonColor: '#4FC9DA',
   				});	
	        }
		})
		
	});
	
	setFcltBtn.on("click",function(){
		//카테고리 코드
		var ctgrCd = $("#title_categoryCd").val();
		//시설명
		var fcltNm = $("#fcltAddModal_fclt_nm").val();
		//이용 시작 시
		var startTm = $("#fcltAddModal_start_tm").val();		
		//이용 종료 시간
		var endTm = $("#fcltAddModal_end_tm").val();
		//최대 인원수
		var userNum = $("#fcltAddModal_fclt_num").val();
		//비품
		var eq1 = $('#eq1').is(':checked') ? "Y" : "N";
		var eq2 = $('#eq2').is(':checked') ? "Y" : "N";
		var eq3 = $('#eq3').is(':checked') ? "Y" : "N";
		var eq4 = $('#eq4').is(':checked') ? "Y" : "N";
		var eq5 = $('#eq5').is(':checked') ? "Y" : "N";
		//시설 안내
		var fcltInfo = $("#fcltAddModal_fclt_info").val();
		//시설 사진
		let files = $("#fcltAddModal_fclt_img")[0].files; // 모든 파일을 가져옴
		
		console.log("fcltCtgrCd",ctgrCd);
		console.log("fcltNm",fcltNm);
		console.log("fcltStartTm",startTm);
		console.log("fcltEndTm",endTm);
		console.log("fcltNope",userNum);
		console.log("fcltInfo",fcltInfo);
		
		//FormData에 추가
		let formData = new FormData();
		formData.append("fcltCtgrCd",ctgrCd);
		formData.append("fcltNm",fcltNm);
		formData.append("fcltStartTm",startTm);
		formData.append("fcltEndTm",endTm);
		formData.append("fcltNope",userNum);
		formData.append("fcltInfo",fcltInfo);
		formData.append("eq1",eq1);
		formData.append("eq2",eq2);
		formData.append("eq3",eq3);
		formData.append("eq4",eq4);
		formData.append("eq5",eq5); 
		
		// 모든 파일을 FormData에 추가
	    for (let i = 0; i < files.length; i++) {
	        formData.append("atchFiles", files[i]); // 파일 배열로 추가
	    }
	    console.log("formData:::",formData)
		 $.ajax({
	        url: "/company/facilities/add.do",
	        type: "post",
	        processData: false,
	        contentType: false,
	        data: formData,
	        success: function(res) {
	           	Swal.fire({
	  				icon: 'success',
		  			title: '시설 등록을 완료되었습니다.',
		  			confirmButtonColor: '#4FC9DA',
				}).then(function(){
					location.reload(true);
				});
	        },
	        error: function(res) {
	        	Swal.fire({
   	  				icon: 'warning',
   		  			title: '시설 등록을 실패했습니다. 다시 시도해주세요.',
   		  			confirmButtonColor: '#4FC9DA',
   				});	
	        }
		});
	});
	// 수정
	$("#modifyFcltBtn").on("click",function(){
		//카테고리 코드
		var ctgrCd = $("#title_categoryCd").val();
		//시설명
		var fcltNm = $("#fcltAddModal_fclt_nm").val();
		//이용 시작 시
		var startTm = $("#fcltAddModal_start_tm").val();		
		//이용 종료 시간
		var endTm = $("#fcltAddModal_end_tm").val();
		//최대 인원수
		var userNum = $("#fcltAddModal_fclt_num").val();
		//비품
		var eq1 = $('#eq1').is(':checked') ? "Y" : "N";
		var eq2 = $('#eq2').is(':checked') ? "Y" : "N";
		var eq3 = $('#eq3').is(':checked') ? "Y" : "N";
		var eq4 = $('#eq4').is(':checked') ? "Y" : "N";
		var eq5 = $('#eq5').is(':checked') ? "Y" : "N";
		//시설 안내
		var fcltInfo = $("#fcltAddModal_fclt_info").val();
		//시설 사진
		let files = $("#fcltAddModal_fclt_img")[0].files; // 모든 파일을 가져옴
		
		console.log("fcltCtgrCd",ctgrCd);
		console.log("fcltNm",fcltNm);
		console.log("fcltStartTm",startTm);
		console.log("fcltEndTm",endTm);
		console.log("fcltNope",userNum);
		console.log("fcltInfo",fcltInfo);
		
		//FormData에 추가
		let formData = new FormData();
		formData.append("fcltCtgrCd",ctgrCd);
		formData.append("fcltNm",fcltNm);
		formData.append("fcltStartTm",startTm);
		formData.append("fcltEndTm",endTm);
		formData.append("fcltNope",userNum);
		formData.append("fcltInfo",fcltInfo);
		formData.append("eq1",eq1);
		formData.append("eq2",eq2);
		formData.append("eq3",eq3);
		formData.append("eq4",eq4);
		formData.append("eq5",eq5); 
		
		// 모든 파일을 FormData에 추가
	    for (let i = 0; i < files.length; i++) {
	        formData.append("atchFiles", files[i]); // 파일 배열로 추가
	    }
	    console.log("formData:::",formData)
		 $.ajax({
	        url: "/company/facilities/add.do",
	        type: "post",
	        processData: false,
	        contentType: false,
	        data: formData,
	        success: function(res) {
	           	Swal.fire({
	  				icon: 'success',
		  			title: '시설 등록을 완료되었습니다.',
		  			confirmButtonColor: '#4FC9DA',
				}).then(function(){
					location.reload(true);
				});
	        },
	        error: function(res) {
	        	Swal.fire({
   	  				icon: 'warning',
   		  			title: '시설 등록을 실패했습니다. 다시 시도해주세요.',
   		  			confirmButtonColor: '#4FC9DA',
   				});	
	        }
		});
	});
	
	// 시설 삭제
	$("#delFcltBtn").on("click", function() {
		//시설코드
		var fcltCd = $("#fcltModifyModal_fclt_cd").val();
		var formData = {
				fcltCd : fcltCd
		}
		 $.ajax({
		        url: "/company/facilities/del.do",
		        type: "post",
		        contentType: "application/json; charset=utf-8",
		        data: JSON.stringify(formData),
		        success: function(res) {
		           	Swal.fire({
		  				icon: 'success',
			  			title: '시설 삭제를 완료되었습니다.',
			  			confirmButtonColor: '#4FC9DA',
					}).then(function(){
						location.reload(true);
					});
		        },
		        error: function(res) {
		        	Swal.fire({
	   	  				icon: 'warning',
	   		  			title: '시설 삭제를 실패했습니다. 다시 시도해주세요.',
	   		  			confirmButtonColor: '#4FC9DA',
	   				});	
		        }
			});
	}); 
	/////// 카테고리 테이블 이동 ////////
	(() => {
	    const $ = (select) => document.querySelectorAll(select);
	    const draggables = $('.draggable');
	    const containers = $('.container');

	    draggables.forEach(el => {
	        el.addEventListener('dragstart', () => {
	            el.classList.add('dragging');
	        });

	        el.addEventListener('dragend', () => {
				// DB 수정
				const inputs = document.querySelectorAll('input[id="fcltCtgrCd"]');
				const values = Array.from(inputs).map(input => input.value);
				changeTurn(values);
	            el.classList.remove('dragging')
	        });
	    });

	    function getDragAfterElement(container, y) {
	        const draggableElements = [...container.querySelectorAll('.draggable:not(.dragging)')]
	      
	        return draggableElements.reduce((closest, child) => {
	          const box = child.getBoundingClientRect() //해당 엘리먼트에 top값, height값 담겨져 있는 메소드를 호출해 box변수에 할당
	          const offset = y - box.top - box.height / 2 //수직 좌표 - top값 - height값 / 2의 연산을 통해서 offset변수에 할당
	          if (offset < 0 && offset > closest.offset) { // (예외 처리) 0 이하 와, 음의 무한대 사이에 조건
	            
	        	  return { offset: offset, element: child } // Element를 리턴
	            
	          } else {
	            return closest
	          }
	        }, { offset: Number.NEGATIVE_INFINITY }).element
	    };

	    containers.forEach(container => {
	        container.addEventListener('dragover', e => {
	            e.preventDefault()
	            const afterElement = getDragAfterElement(container, e.clientY);
	            const draggable = document.querySelector('.dragging')
	            // container.appendChild(draggable)
	            container.insertBefore(draggable, afterElement)
	        })
	    });
	})();
	
	
	fcltAddBtn.on("click", function() {
		var title_categoryCd =  $("#title_categoryCd").val();
		if (title_categoryCd == '' || title_categoryCd == null) {
			Swal.fire({
 				icon: 'warning',
  				title: '카테고리를 선택 후 시설을 추가해주세요.',
  				confirmButtonColor: '#4FC9DA',
			}).then(function(){
				return false;
			});	
		}else{
			$("#fcltAddModal_category_nm").val() 
			$("#fcltAddModal").modal("show");	
		}
	});
	
	
	
	
	
});

function changeTurn(values) {
	console.log("1 : " , values);
	var value = "";
	for (var i = 0; i < values.length; i++) {
		value += values[i]+",";
	}
	console.log("value", value);
	
	 $.ajax({
		url : '/company/facilties/category/changeTurn.do',
		type : 'post',
		contentType: "application/json; charset=utf-8",
        data: value ,
		success : function(res){
			console.log('success');
		}
	});
}

function modifyCtgrBtn(CtgrCd) {
	$("#modify_div_logo").hide();
	//카테고리 정보 가져오기
	var formData = {
			fcltCtgrCd : CtgrCd
	}
	$.ajax({
		url : '/company/facilties/category/getInfo.do',
		type : 'post',
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify(formData),
		success : function(res) {
			$("#modify_category_nm").val(res.fcltCtgrNm);
			$("#modify_ctgr_cd").val(res.fcltCtgrCd);
		},
		error : function (res) {
			Swal.fire({
 				icon: 'warning',
  				title: '카테고리 정보를 불러오는데 실패했습니다. 다시 시도해주세요.',
  				confirmButtonColor: '#4FC9DA',
			});	
		}
	});
	$("#modifyCategoryModal").modal("show");
}

function categoryClick(CtgrCd) {
	var formData = {
		fcltCtgrCd : CtgrCd
	}
	// ajax 수정 예정
	$.ajax({
		url : '/company/facilties/category/getInfo.do',
		type : 'post',
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify(formData),
		success : function(res) {
			$("#title_categoryNm").text(res.fcltCtgrNm + " - ");
			$("#fcltAddModal_category_nm").val(res.fcltCtgrNm);
			$("#title_categoryCd").val(res.fcltCtgrCd);
			var fcltHtml = "";
			if(res.fcltList.length == 0){
				fcltHtml += `
							<tr>
		                		<td colspan="6" class="dt-empty">
		                        	<div class="d-flex flex-column flex-center mt-10">
				                    	<img src="${pageContext.request.contextPath }/resources/file/image/cloudEmpty.png" class="mw-300px">
				                    	<div class="fs-1 fw-bolder text-dark">시설이 없습니다.</div>
		  				 			</div> 
								 </td> 
							 </tr>
							 `;
			}else{
				for (var i = 0; i < res.fcltList.length; i++) {
					fcltHtml += `
							    <tr class="text-gray-500 fw-bold fs-7"> 
							        <td width="30%" class="text-start ms-3">\${res.fcltList[i].fcltNm}</td>
							        <td width="20%" class="text-center">\${res.fcltCtgrNm }</td>
							        <td width="20%" class="text-center">\${res.fcltList[i].fcltStartTm} ~ \${res.fcltList[i].fcltEndTm}</td>
							        <td width="20%" class="text-center">\${res.fcltList[i].fcltNope}</td>
							        <td width="10%">
							        <button type="button" class="btn btn-light-warning" onclick="modifyFclt(\${res.fcltList[i].fcltCd})">수정</button>
							        </td> 
							    </tr>
								`;
				}	
			}
				
			$("#fcltListTable").html(fcltHtml);
		},
		error : function (res) {
			Swal.fire({
					icon: 'warning',
					title: '카테고리 정보를 불러오는데 실패했습니다. 다시 시도해주세요.',
					confirmButtonColor: '#4FC9DA',
			});	
		}
	});
}
function modifyFclt(fcltCd) {
	var formData = {
		fcltCd : fcltCd
	}
	$.ajax({
		url : '/company/facilties/getInfo.do',
		type : 'post',
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify(formData),
		success : function(res) {
			console.log("success :: ", res);
			console.log("eqlist :: ", res.fclteqList[1]);
			$("#fcltModifyModal_fclt_cd").val(res.fcltCd);
			$("#fcltModifyModal_fclt_nm").val(res.fcltNm);
			$("#fcltModifyModal_start_tm").val(res.fcltStartTm);
			$("#fcltModifyModal_end_tm").val(res.fcltEndTm);
			$("#fcltModifyModal_fclt_num").val(res.fcltNope);
			$("#fcltModifyModal_fclt_info").val(res.fcltInfo);
			for (var i = 0; i < res.fclteqList.length; i++) {
				console.log()
				if(res.fclteqList[i].equipmentCd == 'EQ1'){
					$('#Modifyeq1').prop('checked',true);
				}
				if(res.fclteqList[i].equipmentCd == 'EQ2'){
					$('#Modifyeq2').prop('checked',true);
				}
				if(res.fclteqList[i].equipmentCd == 'EQ3'){
					$('#Modifyeq3').prop('checked',true);
				}
				if(res.fclteqList[i].equipmentCd == 'EQ4'){
					$('#Modifyeq4').prop('checked',true);
				}
				if(res.fclteqList[i].equipmentCd == 'EQ5'){
					$('#Modifyeq5').prop('checked',true);
				}
			}
			$("#fcltModifyModal").modal("show");
		},
		error : function (res) {
			Swal.fire({
					icon: 'warning',
					title: '시설 정보를 불러오는데 실패했습니다. 다시 시도해주세요.',
					confirmButtonColor: '#4FC9DA',
			});	
		}
	});
}
</script>					

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>근태 관리</h3>
		<h6>휴가 승인 내역</h6>
	</div>
</div>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-fluid">	
				<div class="card" id="workCard">
				<div class="card-header border-0 pt-6">
					<div class="card-title">
						<h1>휴가 승인</h1>
					</div>
					
					<div class="card-toolbar">
					<!-- 기본 근무 설정 모달 -->
						<div class="modal fade" id="vct_apr_modal" tabindex="-1" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered mw-650px">
								<div class="modal-content">
									<div class="modal-header" id="kt_modal_add_user_header">
										<h2 class="fw-bold">휴가 승인</h2>
										<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal" id="">
											<i class="ki-duotone ki-cross fs-1">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>
										</div>
									</div>
									<div class="modal-body px-5 my-7">
										<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
											<input type="hidden" id="apr_cd" value="">
											<div class="fv-row mb-7">
												<label class="fw-semibold fs-6 mb-2">이름 : <span id="modal_nm"></span></label>
											</div>
											<div class="fv-row mb-7">
												<label class="fw-semibold fs-6 mb-2">부서 : <span id="modal_dept"></span></label>
											</div>
											<div class="fv-row mb-7">
												<label class="fw-semibold fs-6 mb-2">팀명 : <span id="modal_team"></span> </label>
											</div>
											<div class="fv-row mb-7">
												<label class="fw-semibold fs-6 mb-2">직급 : <span id="modal_jbgd"></span></label>
											</div>
											<div class="fv-row mb-7">
												<label class="fw-semibold fs-6 mb-2">시작일 : <span id="modal_start_dt"></span></label>
											</div>
											<div class="fv-row mb-7">
												<label class="fw-semibold fs-6 mb-2">종료일 : <span id="modal_end_dt"></span></label>
											</div>
											<div class="fv-row mb-7">
												<label class="fw-semibold fs-6 mb-2">일수 : <span id="modal_vct_cnt"></span></label>
											</div>
											<div class="fv-row mb-7">
												<label class="fw-semibold fs-6 mb-2">신청일 : <span id="modal_reg_dt"></span></label>
											</div>
											<div class="fv-row mb-7">
												<label class="fw-semibold fs-6 mb-2">사유 : <span id="modal_rsn"></span></label>
											</div>
										</div>
										<hr>
										<div class="d-flex flex-column scroll-y px-5 px-lg-10" id="kt_modal_add_user_scroll" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-max-height="auto" data-kt-scroll-dependencies="#kt_modal_add_user_header" data-kt-scroll-wrappers="#kt_modal_add_user_scroll" data-kt-scroll-offset="300px">
											<div class="fv-row mb-7">
												<select class="form-select form-select-solid" data-control="select2" data-placeholder="Select an option" id="aprSel" data-allow-clear="true">
												    <option value="0" selected disabled="disabled">선택해주세요.</option>
												    <option value="VAA002">승인</option>
												    <option value="VAA003">반려</option>
												</select>
											</div>
											<div class="fv-row mb-7" id="arp_rsn">
												<label class="fw-semibold fs-6 mb-2">사유</label>
												<textarea class="form-control form-control-solid mb-3 mb-lg-0" id="aprRsn" rows="5" cols="30" placeholder="사유를 입력해주세요." style="border: none; resize: none;"></textarea>
											</div>
										</div>
										<div class="text-center pt-10">
											<button type="button" class="btn btn-primary" id="setVatAprBtn">
												<span class="indicator-label">등록</span>
												<span class="indicator-progress">Please wait... 
												<span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 기본 근무 설정 모달 끝 -->
					</div>
					
					
				</div>
					<div class="card-body py-4" id="workList">
						<table class="table align-middle table-row-dashed fs-6 gy-5" id="kt_table_users">
							<thead>
								<tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
									<th class="min-w" style="9%; text-align: center;">이름</th>
									<th class="min-w" style="9%; text-align: center;">부서</th>
									<th class="min-w" style="9%; text-align: center;">팀명</th>
									<th class="min-w" style="9%; text-align: center;">직급</th>
									<th class="min-w" style="9%; text-align: center;">휴가 시작일</th>
									<th class="min-w" style="9%; text-align: center;">휴가 종료일</th>
									<th class="min-w" style="9%; text-align: center;">휴가일수</th>
									<th class="min-w" style="9%; text-align: center;">신청일</th>
									<th class="min-w" style="9%; text-align: center;">결재일</th>
									<th class="min-w" style="9%; text-align: center;">결재상태</th>
									<th class="min-w" style="10%; text-align: center;"></th>
								</tr>
							</thead>
							<tbody class="text-gray-600 fw-semibold">
							
							<c:choose>
								<c:when test="${empty pagingVO.dataList }">
									<tr style="text-align: center;"> 
										<td colspan="11">휴가 신청 내역이 없습니다.</td>
									</tr>	
								</c:when>
							</c:choose>
							<c:forEach items="${pagingVO.dataList }" var="list">
								<tr>
									<td style="9%; text-align: center;">
										<!-- 이름 -->
										${list.empNm }
									</td>
									<td style="9%; text-align: center;">
										<!-- 부서 -->
										${list.deptNm }
									</td>
									<td style="9%; text-align: center;">
										<!-- 팀명 -->
										${list.teamNm }
									</td>
									<td style="9%; text-align: center;">
										<!-- 직급 -->
										${list.jbgdNm }
									</td>
									<td style="9%; text-align: center;">
										<!-- 휴가 시작일 -->
										${list.vctBgngDt }
									</td>
									<td style="9%; text-align: center;">
										<!-- 휴가 종료일 -->
										${list.vctEndDt }
									</td>
									<td style="9%; text-align: center;">
										<!-- 휴가 일수 -->
										${list.vctUseDayCnt }
									</td>
									<td style="9%; text-align: center;">
										<!-- 신청일 -->
										${list.vctRegDt }
									</td>
									<td style="9%; text-align: center;">
										<!-- 결재일 -->
										${list.vctAplyAprYmd }
									</td>
									<td style="9%; text-align: center;">
										<!-- 결재상태 -->
										<c:choose>
											<c:when test="${list.vctAplyAprStts eq 'vaa001'}">
												대기
											</c:when>
											<c:when test="${list.vctAplyAprStts eq 'VAA002'}">
												승인
											</c:when>
											<c:when test="${list.vctAplyAprStts eq 'VAA003'}">
												반려
											</c:when>	
										</c:choose>
									</td>
									<td style="10%; text-align: center;">
										<button class="btn btn-light-danger" onclick="vctAprBtnVal(${list.vctAplyCd })" value="${list.vctAplyCd }">확인</button>
										
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="dt-paging paging_simple_numbers" id="pagingArea" style="margin-bottom: 10px;">
						${pagingVO.pagingHTML }
					</div>
				</div>
			</div>
		</div>
		</div>
</div>
<script type="text/javascript">
function vctAprBtnVal(vctAplyCd) {
	var formData = {
		vctAplyCd : vctAplyCd
	}
	$.ajax({
		url : "/employee/vacation/approvalInfo.do",
		type : "post",
		contentType: "application/json; charset=utf-8",
		data : JSON.stringify(formData),
		success : function(res) {
			console.log(res);
			$("#apr_cd").val(vctAplyCd);
			$("#modal_nm").text(res.empNm);
			$("#modal_dept").text(res.deptNm);
			$("#modal_team").text(res.teamNm);
			$("#modal_jbgd").text(res.jbgdNm);
			$("#modal_start_dt").text(res.vctBgngDt);
			$("#modal_end_dt").text(res.vctEndDt);
			$("#modal_vct_cnt").text(res.vctUseDayCnt+"일");
			$("#modal_reg_dt").text(res.vctRegDt);
			$("#modal_rsn").text(res.vctRsn);
			$("#arp_rsn").hide();
			if(res.vctAplyAprStts != 'vaa001'){
				$("#aprSel").val(res.vctAplyAprStts).prop("selected", true)
				if(res.vctAplyAprStts == 'VAA003'){
					$("#arp_rsn").show();	
					$("#aprRsn").val(res.vctAplyAprReason);	
				}
			}
			
			$("#vct_apr_modal").modal("show");
		},
		error : function (res) {
			Swal.fire({
				icon: 'warning',
	  			title: '정보를 불러오지 못했습니다. 다시 시도해주세요.',
	  			confirmButtonColor: '#4FC9DA',
			});
		}
	})
	
	
}
$(function() {
	var aprSel = $("#aprSel");
	
	aprSel.on("change",function(){
		var aprSel_val = aprSel.val();
		
		if (aprSel_val == 'VAA003') {
			$("#arp_rsn").show();
		}
		if (aprSel_val == 'VAA002') {
			$("#arp_rsn").hide();
		}
		
		// 이건 등록 버튼으로 이동 할 예정
		
	});
	
	$("#setVatAprBtn").on("click",function(){
		if(aprSel.val() == 0){
			return false;
		}
		var aprRsn = $("#aprRsn").val();
		var formData = {
			vctAplyAprCd : $("#apr_cd").val(),
			vctAplyAprStts : aprSel.val(),
			vctAplyAprReason : aprRsn 
		}
		
		$.ajax({
			url : "/employee/vacataion/aplyapr.do",
			type : "post",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(formData),
			success : function (res) {
				Swal.fire({
					icon: 'success',
		  			title: '처리에 성공했습니다.',
		  			confirmButtonColor: '#4FC9DA',
				}).then(function(){
		      		  location.reload(true);
	 			});
			},
			error : function (res) {
				Swal.fire({
					icon: 'warning',
		  			title: '처리에 실패했습니다. 다시 시도해주세요.',
		  			confirmButtonColor: '#4FC9DA',
				});
			}
		});
		
	});
})




</script>

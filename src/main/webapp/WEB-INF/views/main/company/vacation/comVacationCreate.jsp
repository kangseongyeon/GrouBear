<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>근태 관리</h3>
		<h6>휴가 관리 - 휴가 생성</h6>
	</div>
</div>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-fluid">
				<div class="card mb-5 mb-xxl-8">
					<div class="card-body pt-0 pb-0">
						<!--begin::Navs-->
						<ul
							class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold">
							<li class="nav-item mt-2"><a
								class="nav-link text-active-primary ms-0 me-10 py-5"
								href="/company/vacation/status.do">휴가현황</a></li>
							<li class="nav-item mt-2"><a
								class="nav-link text-active-primary ms-0 me-10 py-5 active"
								href="/company/vacation/create.do">휴가생성</a></li>
							<li class="nav-item mt-2"><a
								class="nav-link text-active-primary ms-0 me-10 py-5"
								href="/company/vacation/setting.do">휴가설정</a></li>
						</ul>
						<!--begin::Navs-->
					</div>
				</div>
				<div class="card" id="workCard">
					<div class="card-header border-0 pt-6">
						<div class="card-title">
						</div>
						<div class="card-toolbar">
							<div class="d-flex justify-content-end" data-kt-user-table-toolbar="base">
								<div class="d-flex align-items-center position-relative">
									<i class="ki-duotone ki-magnifier fs-3 position-absolute ms-4">
										<span class="path1"></span>
										<span class="path2"></span>
									</i>
									<form id="searchForm">
										<input type="hidden" name="page" id="page">
										<input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-12" placeholder="검색" value="${searchWord }"/>
									</form>
								</div>
							</div>
						</div>
					</div>


					<div class="card-body py-4" id="vctList">
						<table class="table align-middle table-row-dashed fs-6 gy-5" id="kt_table_users">
							<thead>
								<tr class="text-center text-muted fw-bold fs-7 text-uppercase gs-0" style="vertical-align: middle;" >
									<th class="min-w-80px">이름</th>
									<th class="min-w-80px">부서명</th>
									<th class="min-w-90px">팀명</th>
									<th class="min-w-90px">직급명</th>
									<th class="min-w-60px">생성일수</th>
									<th class="min-w-60px">사용일수</th>
									<th class="min-w-60px">잔여일수</th>
								</tr>
							</thead>
							<tbody class="text-gray-600 fw-semibold">
							
							<c:if test="${empty pagingVO.dataList }">
								<tr>
									<td colspan="9" style="text-align: center; ">휴가 현황 정보가 없습니다.</td> 
									
								</tr>							
							</c:if>
							<c:forEach items="${pagingVO.dataList }" var="list">
								<tr style="text-align: center; ">
									<td>
										${list.empNm }
									</td>
									<td>
										<c:choose>
											<c:when test="${list.deptNm eq 'NoData' }">
											
											</c:when>
											<c:otherwise>
												${list.deptNm }
											</c:otherwise>
										</c:choose>									
									</td>
									<td>
										<c:choose>
											<c:when test="${list.teamNm eq 'NoData' }">
										
											</c:when>
											<c:otherwise>
												${list.teamNm }
											</c:otherwise>
										</c:choose>									
									</td>
									<td>
										<c:choose>
											<c:when test="${list.jbgdNm eq 'NoData' }">
										
											</c:when>
											<c:otherwise>
												${list.jbgdNm }
											</c:otherwise>
										</c:choose>									
									</td>
									<td>
										${list.vctCnt }
									</td>
									<td>
										${list.vctUseDayCnt }
									</td>
									<td>
										${list.vctRmndDayCnt }
									</td>
									<td>
										<button class="btn btn-primary" onclick="VctCrtModal('${list.empId}')">
											생성 
										</button>
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

<script>
function VctCrtModal(empId) {
	swal({
        title: '추가할 휴가 일수를 입력해주세요.',
        input: 'number',
        inputPlaceholder: '',
        showCancelButton: true,
        cancelButtonText : '취소',
        confirmButtonText: '생성',
        showLoaderOnConfirm: true,
        preConfirm: (number) => {
		  let formData = {
				empId : empId,
				vctCrtCnt : number
		  }

          $.ajax({
				url : "/company/vacation/empOneCrtVct.do",
				type : "post",
				contentType: "application/json; charset=utf-8",
	            data: JSON.stringify(formData),
	            success: function(res){
	            	Swal.fire({
		  				icon: 'success',
			  			title: '등록 성공했습니다.',
			  			confirmButtonColor: '#4FC9DA',
					}).then(function(){
						location.reload(true);	
					});
		      },
		      error: function(){
		      	Swal.fire({
						icon: 'warning',
			  			title: '등록 실패, 다시 시도해주세요.',
			  			confirmButtonColor: '#4FC9DA',
					});        	
	            }
			});
        },
        allowOutsideClick: false
      })
};
$(function() {
	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
	let searchForm = $("#searchForm");		
	let pagingArea = $("#pagingArea");		// 페이징 처리 위한 div
	let VctCrtBtn = $("#VctCrtBtn"); 
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a 태그의 기본 기능 멈추기
		var pageNo = $(this).data("page");
		$("#myInput").val('');
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
});

</script>					

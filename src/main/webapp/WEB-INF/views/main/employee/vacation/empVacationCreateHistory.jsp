<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>근태 관리</h3>
		<h6>휴가 생성 내역</h6>
	</div>
</div>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-fluid">	
				<div class="card" id="workCard">
				
					<div class="card-header border-0 pt-6">
						<div class="card-title">
							<h1>휴가 생성 내역</h1>
						</div>
						
						<div class="card-toolbar">
							
							<div class="d-flex justify-content-end" data-kt-user-table-toolbar="base">
								
							</div>
						</div>
						
					</div>
					
					<div class="card-body py-4" id="workList">
						<table class="table align-middle table-row-dashed fs-6 gy-5" id="kt_table_users">
							<thead>
								<tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
									<th class="min-w" style="20%; text-align: center;">이름</th>
									<th class="min-w" style="20%; text-align: center;">부서명</th>
									<th class="min-w" style="20%; text-align: center;">팀명</th>
									<th class="min-w" style="20%; text-align: center;">일수</th>
									<th class="min-w" style="20%; text-align: center;">생성일</th>
								</tr>
							</thead>
							<tbody class="text-gray-600 fw-semibold">
							
							<c:choose>
								<c:when test="${empty pagingVO.dataList }">
									<tr style="text-align: center;"> 
										<td colspan="5">휴가 생성 내역이 없습니다.</td>
									</tr>	
								</c:when>
							</c:choose>
							<c:forEach items="${pagingVO.dataList }" var="list">
								<tr>
									<td style="20%; text-align: center;">
										${list.empNm }
									</td>
									<td style="20%; text-align: center;">
										${list.deptNm }
									</td>
									<td style="20%; text-align: center;">
										${list.teamNm }
									</td>
									<td style="20%; text-align: center;">
										${list.vctCrtCnt }
									</td>
									<td style="20%; text-align: center;">
										${list.vctCrtYmd }
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
$(function() {
	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
	let searchForm = $("#searchForm");		
	let pagingArea = $("#pagingArea");		// 페이징 처리 위한 div
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a 태그의 기본 기능 멈추기
		var pageNo = $(this).data("page");
		$("#myInput").val('');
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});

});
</script>

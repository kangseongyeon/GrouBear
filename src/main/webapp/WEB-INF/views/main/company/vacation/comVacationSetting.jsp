<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>근태 관리</h3>
		<h6>휴가 관리 - 휴가 설정</h6>
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
								class="nav-link text-active-primary ms-0 me-10 py-5 "
								href="/company/vacation/status.do">휴가현황</a></li>
							<li class="nav-item mt-2"><a
								class="nav-link text-active-primary ms-0 me-10 py-5"
								href="/company/vacation/create.do">휴가생성</a></li>
							<li class="nav-item mt-2"><a
								class="nav-link text-active-primary ms-0 me-10 py-5 active"
								href="/company/vacation/setting.do">휴가설정</a></li>
						</ul>
						<!--begin::Navs-->
					</div>
				</div>
				<div class="card" id="workCard">
					
					<div class="card-header border-0 pt-6">
						<div class="card-title">
							<h2>휴가 생성 조건</h2>
						</div>
						<div class="card-toolbar">
						</div>
					</div>
					<div class="card-body py-4" id="workList">
						<div class="m-5">
							<p>- 설정한 휴가 생성 기준으로 휴가가 자동 생성됩니다.</p>	
							<p>- 조직에 속하지 않거나 입사일이 없는 사용자는 휴가가 생성되지 않습니다.</p>
							<p>- 현재는 1월 1일 기준으로 생성됩니다.</p>
							<p>- 휴가 생성시 전 휴가 일수에 추가됩니다.</p>
						</div>

						<div class="card card-flush">
						   <div class="container">
						      <div class="row mt-5 mb-5"> 
						       <form action="/company/setYearVCT.do" id="yearForm" method="post">
						         <div class="col-12 mb-3" style="display: flex; justify-content: center;">
						         	<c:set value="0" var="cnt"></c:set>
						         	
						         	<c:forEach items="${getvctSettingValList }" var="list"> 
						         		<div class="ms-5" style="width: 40%;"> 
							               <label class="required form-label mt-3">${list.yearCnt }년차</label>
							            </div>  
							            <div data-mdb-input-init class="form-outline" style="width: 60%;">
							                <input type="number" class="form-control" id="year${list.yearCnt }" name="year" value="${list.yearVctCnt }" min="0"/>
							            </div>	
							            <c:set value="${cnt+1}" var="cnt"></c:set>
						         		<c:if test="${cnt % 4 ==0 }">
						         			</div>	
			         			
		 	   						         <div class="col-12 mb-3" style="display: flex; justify-content: center;">
						         		</c:if>
						         		
						         	</c:forEach>
						         	<input type="hidden" id="listLength" value="${cnt}">
						         	</div>
									<div>
							            <br>					          
							            <button type="button" id="vctSetBtn" class="btn btn-flex btn-light-primary mt-2 mb-2" style="float: right;">
						                   <i class="ki-duotone ki-add-folder fs-2"><span class="path1"></span><span class="path2"></span></i>
							                      저장
						                </button>
						         </div>
						        </form>
						      </div>
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
 	let vctSetBtn = $("#vctSetBtn");		
	let yearForm = $("#yearForm");		
	
	vctSetBtn.on("click",function(){
		let arr = "";
		let length = $("#listLength").val();
		console.log(length);
		
		for (var i = 0; i < length; i++) {
			arr += $("#year"+i).val() + ",";	
		}
		
		$.ajax({
			url : "/company/setyearvct.do",
			type : "post",
			contentType: 'application/json; charset=UTF-8',
			data : arr,
			success : function (res) {
				console.log(res);	
			}
		})
		console.log(arr);
		
	});
});

</script>					

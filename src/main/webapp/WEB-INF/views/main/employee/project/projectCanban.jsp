<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<section style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>칸반보드</h3> 
		<h6>프로젝트</h6>
	</div>
</section>
<style>
.dropzone {
  background-color: white;
  border: none;
}
.dropzone.dragover {
  background-color: rgba(149, 230, 255, 0.08);
}
</style>
<section class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<!-- 프로젝트 제목 시작 -->
			<div id="kt_app_content_container" class="app-container container-fluid">
				<div class="card">
					<div class="card-body pt-9 pb-0">
						<div class="d-flex flex-wrap flex-sm-nowrap mb-6">
							<div class="flex-grow-1">
								<div class="d-flex justify-content-between align-items-start flex-wrap mb-2">
									<div class="d-flex flex-column">
										<div class="d-flex align-items-center mb-1">
											<h3 class="me-2">${projectVO.proNm }</h3>
											<c:if test="${projectVO.proSttsCd eq 'PRO001'}">
												<span class="badge badge-light-warning mb-2">진행</span>
											</c:if>
											<c:if test="${projectVO.proSttsCd eq 'PRO002'}">
												<span class="badge badge-light-warning mb-2">진행</span>
											</c:if>
											<c:if test="${projectVO.proSttsCd eq 'PRO003'}">
												<span class="badge badge-light-success mb-2">완료</span>
											</c:if>
										</div>
									</div>
									<div class="d-flex mb-4">
										<button type="button" id="listBtn" class="btn btn-sm btn-light fw-bold btn-active-light-primary me-2">목록</button>
										<sec:authentication property="principal.member" var="emp"/>
										<c:if test="${emp.empId eq projectVO.empId }">
											<button type="button" id="udtBtn" class="btn btn-warning me-2">수정</button>
											<button type="button" id="delBtn" class="btn btn-danger me-2">삭제</button>
										</c:if>
										<button type="button" id="addProBtn" class="btn btn-primary">일감 추가하기</button>
									</div>
								</div>
								
								<div class="col-md-6"></div>
								<form action="/employee/projectDelete.do" method="post" id="delForm">
									<input type="hidden" name="proNo" value="${projectVO.proNo }"/>
									<sec:csrfInput/>
								</form>
								
								
								<div class="d-flex justify-content-between align-items-start flex-wrap mb-2">
									<div class="d-flex flex-column">
										<div class="d-flex align-items-center mb-1">
											<h5>${projectVO.proCn }</h5>
										</div>
									</div>
								</div>
								<div class="d-flex flex-wrap justify-content-start">
									<div class="d-flex flex-wrap">
										<div class="border border-gray-300 border-dashed rounded min-w-125px py-3 px-4 me-6 mb-3">
											<div class="d-flex align-items-center">
												<div class="fs-4 fw-bold">${projectVO.proBgngDt }</div>
											</div>
											<div class="fw-semibold fs-6 text-gray-500">프로젝트 생성일</div>
										</div>
										<div class="border border-gray-300 border-dashed rounded min-w-125px py-3 px-4 me-6 mb-3">
											<div class="d-flex align-items-center">
												<div class="fs-4 fw-bold">${projectVO.proStartDt }</div>
											</div>
											<div class="fw-semibold fs-6 text-gray-500">프로젝트 시작일</div>
										</div>
										<div class="border border-gray-300 border-dashed rounded min-w-125px py-3 px-4 me-6 mb-3">
											<div class="d-flex align-items-center">
												<div class="fs-4 fw-bold">${projectVO.proEndDt }</div>
											</div>
											<div class="fw-semibold fs-6 text-gray-500">프로젝트 종료일</div>
										</div>
									</div>
									<div class="d-flex flex-stack flex-wrap mb-2">
									    <div class="symbol-group symbol-hover my-1">
									        <%-- <c:forEach items="${projectVO.participantImgFileUrlsList}" var="participantImgFileUrl" varStatus="status">
									        	<c:choose>
									        		 <c:when test="${status.index lt projectVO.participantEmpNamesList.size()}">
				 					        			<div class="symbol symbol-35px symbol-circle" data-bs-toggle="tooltip"  title="${projectVO.participantEmpNamesList[status.index] }">
									        				<img alt="${projectVO.participantEmpNamesList[status.index] }" src="/upload/${participantImgFileUrl.trim() }">
									        			</div>
									        		</c:when>
									        	</c:choose>
									        </c:forEach> --%>
									        <c:forEach items="${projectVO.participantImgFileUrlsList }" var="participantImgFileUrl">
									        	<div class="symbol symbol-35px symbol-circle" data-bs-toggle="tooltip">
									        		<img alt="" src="/upload/${participantImgFileUrl.trim() }">
									        	</div>
									        </c:forEach>
									    </div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 프로젝트 제목 종료 -->
			<!-- 내 일감 제목 시작-->
			<!-- <div id="kt_app_content" class="d-flex flex-wrap flex-stack pt-10 pb-8 app-container container-fluid">
				<h3 class="fw-bold my-2">내 일감 </h3>
			</div> -->
			<!-- 내 일감 제목 종료 -->
			<!-- 일감시작 -->
			<div id="kt_app_content" class="app-container container-fluid">
				<div class="tab-content">
					<div id="kt_project_targets_card_pane" class="tab-pane fade show active">
						<div class="row g-9">
						    <!-- 대기 상태 칼럼 -->
						    <div class="col-md-4 col-lg-4 col-xl-4 dropzone" id="waiting-column">
						        <div class="mb-9">
						            <div class="d-flex flex-stack">
						                <div class="fw-bold fs-4">대기</div>
						            </div>
						            <div class="h-3px w-100 bg-primary"></div>
						        </div>
						        <c:forEach items="${proTaskList}" var="projectTaskVO">
						            <c:if test="${projectTaskVO.proTaskSttsCd eq 'TASK001'}">
						                <div class="card mb-6 mb-xl-9 draggable" id="task-${projectTaskVO.proTaskNo}" draggable="true">
            								<div class="card-body">
            									<span class="badge text-bg-primary" style="position:absolute; top:10px; left: 10px; ">${projectTaskVO.proTaskPregrt }%</span>
						                        <div class="mb-2">
						                            <h4>${projectTaskVO.proTaskNm}</h4>
						                        </div>
						                        <div class="fs-6 fw-semibold text-gray-600 mb-5">${projectTaskVO.proTaskCn}</div>
						                        <div class="fs-6 fw-semibold text-gray-600 mb-5">${projectTaskVO.proTaskStartDt} - ${projectTaskVO.proTaskEndDt }</div>
						                        <div class="d-flex flex-stack flex-wrap">
						                            <!-- 참여자 정보 -->
						                            <div class="symbol-group symbol-hover my-1">
						                                <!-- 참여자 아이콘 -->
								                         <div class="symbol symbol-35px symbol-circle" data-bs-toggle="tooltip" >
															<%-- <img alt="${projectTaskVO.empNm }" src="/upload/${projectTaskVO.imgFileUrl }"> --%>
															<img alt="${projectTaskVO.empNm}" src="/upload/${projectTaskVO.imgFileUrl}">
														</div>
						                            </div>
						                        </div>
						                        <div class="d-flex mb-4 flex-end">
						                            <sec:authentication property="principal.member" var="emp"/>
						                            <c:if test="${emp.empId eq projectTaskVO.empId}">
						                                <button type="button" id="udtCanBtn" class="btn btn-warning me-2 udtCanBtn">수정</button>
						                                <button type="button" id="delCanBtn" class="btn btn-danger me-2 delCanBtn">삭제</button>
						                            </c:if>
						                        </div>
						                        <form action="/employee/canbanDelete.do" method="post" id="delCanbanForm">
						                            <input type="hidden" name="proTaskNo" value="${projectTaskVO.proTaskNo}" />
						                            <input type="hidden" name="proNo" value="${projectTaskVO.proNo}" />
						                            <sec:csrfInput/>
						                        </form>
						                    </div>
						                </div>
						            </c:if>
						        </c:forEach>
						    </div>
						
						    <!-- 진행 상태 칼럼 -->
						    <div class="col-md-4 col-lg-4 col-xl-4 dropzone" id="inprogress-column">
						        <div class="mb-9">
						            <div class="d-flex flex-stack">
						                <div class="fw-bold fs-4">진행</div>
						            </div>
						            <div class="h-3px w-100 bg-warning"></div>
						        </div>
						        <c:forEach items="${proTaskList}" var="projectTaskVO">
						            <c:if test="${projectTaskVO.proTaskSttsCd eq 'TASK002'}">
						                <div class="card mb-6 mb-xl-9 draggable" id="task-${projectTaskVO.proTaskNo}" draggable="true">
						                    <div class="card-body">
						                    	<span class="badge text-bg-warning" style="position:absolute; top:10px; left: 10px; ">${projectTaskVO.proTaskPregrt }%</span>
						                        <div class="mb-2">
						                            <h4>${projectTaskVO.proTaskNm}</h4>
						                        </div>
						                        <div class="fs-6 fw-semibold text-gray-600 mb-5">${projectTaskVO.proTaskCn}</div>
						                        <div class="fs-6 fw-semibold text-gray-600 mb-5">${projectTaskVO.proTaskStartDt} - ${projectTaskVO.proTaskEndDt }</div>
						                        <div class="d-flex flex-stack flex-wrap">
						                            <!-- 참여자 정보 -->
						                            <div class="symbol-group symbol-hover my-1">
						                                <!-- 참여자 아이콘 -->
								                         <div class="symbol symbol-35px symbol-circle" data-bs-toggle="tooltip" >
															<img alt="${projectTaskVO.empNm}" src="/upload/${projectTaskVO.imgFileUrl}">
														</div>
						                            </div>
						                        </div>
						                        <div class="d-flex mb-4 flex-end">
						                            <sec:authentication property="principal.member" var="emp"/>
						                            <c:if test="${emp.empId eq projectTaskVO.empId}">
						                                <button type="button" id="udtCanBtn" class="btn btn-warning me-2 udtCanBtn">수정</button>
						                                <button type="button" id="delCanBtn" class="btn btn-danger me-2 delCanBtn">삭제</button>
						                            </c:if>
						                        </div>
						                        <form action="/employee/canbanDelete.do" method="post" id="delCanbanForm">
						                            <input type="hidden" name="proTaskNo" value="${projectTaskVO.proTaskNo}" />
						                            <input type="hidden" name="proNo" value="${projectTaskVO.proNo}" />
						                            <sec:csrfInput/>
						                        </form>
						                    </div>
						                </div>
						            </c:if>
						        </c:forEach>
						    </div>
						    <!-- 진행 상태 칼럼 종료 -->
						
						    <!-- 완료 상태 칼럼 -->
						    <div class="col-md-4 col-lg-4 col-xl-4 dropzone" id="completed-column">
						        <div class="mb-9">
						            <div class="d-flex flex-stack">
						                <div class="fw-bold fs-4">완료</div>
						            </div>
						            <div class="h-3px w-100 bg-success"></div>
						        </div>
						        <c:forEach items="${proTaskList}" var="projectTaskVO">
						            <c:if test="${projectTaskVO.proTaskSttsCd eq 'TASK003'}">
						                <div class="card mb-6 mb-xl-9 draggable" id="task-${projectTaskVO.proTaskNo}" draggable="true">
						                    <div class="card-body">
						                    	<span class="badge text-bg-success" style="position:absolute; top:10px; left: 10px; ">${projectTaskVO.proTaskPregrt }%</span>
						                        <div class="mb-2">
						                            <h4>${projectTaskVO.proTaskNm}</h4>
						                        </div>
						                        <div class="fs-6 fw-semibold text-gray-600 mb-5">${projectTaskVO.proTaskCn}</div>
						                        <div class="fs-6 fw-semibold text-gray-600 mb-5">${projectTaskVO.proTaskStartDt} - ${projectTaskVO.proTaskEndDt }</div>
						                        <div class="d-flex flex-stack flex-wrap">
						                             <!-- 참여자 정보 -->
						                            <div class="symbol-group symbol-hover my-1">
						                                <!-- 참여자 아이콘 -->
								                         <div class="symbol symbol-35px symbol-circle" data-bs-toggle="tooltip" >
								                         	<img alt="${projectTaskVO.empNm}" src="/upload/${projectTaskVO.imgFileUrl}">
														</div>
						                            </div>
						                        </div>
						                        <%-- <div class="d-flex mb-4 flex-end">
						                            <sec:authentication property="principal.member" var="emp"/>
						                            <c:if test="${emp.empId eq projectTaskVO.empId}">
						                                <button type="button" id="udtCanBtn" class="btn btn-warning me-2 udtCanBtn">수정</button>
						                                <button type="button" id="delCanBtn" class="btn btn-danger me-2 delCanBtn">삭제</button>
						                            </c:if>
						                        </div>
						                        <form action="/employee/canbanDelete.do" method="post" id="delCanbanForm">
						                            <input type="hidden" name="proTaskNo" value="${projectTaskVO.proTaskNo}" />
						                            <input type="hidden" name="proNo" value="${projectTaskVO.proNo}" />
						                            <sec:csrfInput/>
						                        </form> --%>
						                    </div>
						                </div>
						            </c:if>
						        </c:forEach>
						    </div>
						    <!-- 완료 상태 컬럼 종료 -->
						</div>
					</div>
				</div>
			</div>
			<!-- 일감 종료 -->
		</div>
	</div>
</section>
<script type="text/javascript">
$(function(){
	var addProBtn = $("#addProBtn");		// 일감 추가
	var listBtn = $("#listBtn");			// 목록 버튼
	var udtBtn = $("#udtBtn");				// 수정 버튼
	var delBtn = $("#delBtn");				// 삭제 버튼
	var delForm = $("#delForm");
	
	
	var detailBtn = $("#detailBtn");
	var udtCanBtn = $(".udtCanBtn");
	var delCanBtn = $(".delCanBtn");
	var delCanbanForm = $("#delCanbanForm");
	

	// 일감 추가
	addProBtn.on("click", function () {
		location.href = "/employee/canbanForm.do?proNo=${projectVO.proNo}";
	});
	
	// 목록 버튼
	listBtn.on("click", function () {
		location.href = "/employee/project.do";
	});
	
	// 수정 버튼
	udtBtn.on("click", function () {
		delForm.attr("action", "/employee/projectUpdate.do");
		delForm.attr("method", "get");
		delForm.submit();
	});
	
	// 삭제 버튼
	 delBtn.on('click', function() {
		Swal.fire({
			title: '프로젝트를 정말 삭제하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#F06445',
			cancelButtonColor: '#4FC9DA',
			confirmButtonText: '예',
			cancelButtonText: '아니요',
			reverseButtons: false, // 버튼 순서 (기본)
	
		}).then((result) => {
			if (result.isConfirmed) {
				delForm.submit();
			}
		})
	});
	
	// ---- 일감 crud 부분 ----
	// 일감 수정
	$(".udtCanBtn").on("click", function () {
	    console.log("udtCanBtn click");
	    delCanbanForm = $(this).closest(".card").find("form");
	    delCanbanForm.attr("action", "/employee/canbanUpdate.do");
	    delCanbanForm.attr("method", "get");
	    delCanbanForm.submit();
	});

	// 일감 삭제
	$(".delCanBtn").on('click', function() {
		console.log("delCanBtn click");
	    delCanbanForm = $(this).closest(".card").find("form");

	    Swal.fire({
	        title: '일감을 정말 삭제하시겠습니까?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#F06445',
	        cancelButtonColor: '#4FC9DA',
	        confirmButtonText: '예',
	        cancelButtonText: '아니요',
	        reverseButtons: false,
	    }).then((result) => {
	        if (result.isConfirmed) {
	            delCanbanForm.submit();
	        }
	    });
	});

	
	// --- 일감 드래그 ---
	let dragged;
	let orgCard;

	// 드래그 가능한 대상에서 발생하는 이벤트
	document.addEventListener("drag", event => {
		console.log("dragging");
	});
	
	// 완료일 경우에는 이동 안됨
	document.addEventListener("dragstart", event => {
		const taskId = event.target.id;
		
		if ($(event.target).find(".badge").hasClass("text-bg-success")) {
			event.preventDefault();
			return;
		}
		
		dragged = event.target;
		orgCard = dragged.parentNode;
		event.target.classList.add("dragging");
	});

	document.addEventListener("dragend", event => {
		event.target.classList.remove("dragging");
	});

	// 드롭 대상에서 발생하는 이벤트
	document.addEventListener("dragover", event => {
		// 드롭을 허용하기 위해 기본 동작 취소
		event.preventDefault();
	}, false);

	document.addEventListener("dragenter", event => {
		// 드래그 가능한 요소가 대상 위로 오면 강조
		if (event.target.classList.contains("dropzone")) {
			event.target.classList.add("dragover");
		}
	});

	document.addEventListener("dragleave", event => {
		const dropzone = event.target.closest(".dropzone");
		if (dropzone) {
			dropzone.classList.remove("dragover");
		}
	});

	document.addEventListener("drop", event => {
	    event.preventDefault();
	    const dropzone = event.target.closest(".dropzone");

	    if (dropzone) {
	        dropzone.classList.remove("dragover");
	        if (dragged && dropzone !== dragged.parentNode) {
	            dropzone.appendChild(dragged);
	            updateTaskStatus(dropzone.id, dragged.id, function(success, newPregrt, badgeColor){
	                if (!success) {
	                    orgCard.appendChild(dragged); // 실패 시 원래 위치로 복구
	                } else {
	                    // 성공 시 진행률과 색상을 업데이트
	                    $(dragged).find(".badge")
	                        .text(newPregrt + '%')
	                        .removeClass("text-bg-primary text-bg-warning text-bg-success")
	                        .addClass(badgeColor);
	                    
	                    // 진행률이 100일 경우 버튼 숨기기
	                    if (newPregrt === 100) {
	                    	$(dragged).find(".udtCanBtn, .delCanBtn").hide();
	                    }
	                }
	            });
	        }
	    }
	});

	function updateTaskStatus(columnId, taskId, callback) {
	    const taskStatusMap = {
	        "waiting-column": { status: "TASK001", pregrt: 0, color: "text-bg-primary" },
	        "inprogress-column": { status: "TASK002", pregrt: 50, color: "text-bg-warning" },
	        "completed-column": { status: "TASK003", pregrt: 100, color: "text-bg-success" }
	    };
	    
	    const { status: newStatus, pregrt: pregrtVal, color: badgeColor } = taskStatusMap[columnId];
	    
	    const data = {
	        proTaskNo: taskId.replace('task-', ''),
	        proTaskSttsCd: newStatus,
	        proTaskPregrt: pregrtVal
	    };
	    
	    $.ajax({
	        url: '/employee/updateTaskStatus.do',
	        type: 'POST',
	        contentType: "application/json; charset=utf-8",
	        data: JSON.stringify(data),
	        success: function(response) {
	            Swal.fire({
	                icon: 'success',
	                title: '상태가 업데이트되었습니다.',
	            });
	            callback(true, pregrtVal, badgeColor);
	        },
	        error: function() {
	            Swal.fire({
	                icon: 'error',
	                title: '오류가 발생했습니다.',
	            });
	            callback(false, pregrtVal, badgeColor);
	        }
	    });
	}

});
</script>
 

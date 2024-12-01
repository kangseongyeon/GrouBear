<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>간트차트</h3> 
		<h6>프로젝트</h6>
	</div>
</div>
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container" class="app-container container-fluid mb-8">
				<div class="card">
					<div class="card-body pt-9 pb-0">
						<div class="d-flex flex-wrap flex-sm-nowrap mb-6">
							<div class="flex-grow-1">
								<div class="d-flex justify-content-between align-items-start flex-wrap mb-2">
									<div class="d-flex flex-column">
										<div class="d-flex align-items-center mb-1">
											<h3 class="me-2">${projectVO.proNm }</h3>
											<c:if test="${projectVO.proSttsCd eq 'PRO001'}">
												<span class="badge text-bg-primary">대기</span>
											</c:if>
											<c:if test="${projectVO.proSttsCd eq 'PRO002'}">
												<span class="badge text-bg-warning">진행</span>
											</c:if>
											<c:if test="${projectVO.proSttsCd eq 'PRO003'}">
												<span class="badge text-bg-success">완료</span>
											</c:if>
										</div>
									</div>
									<div class="d-flex mb-4">
										<button type="button" id="listBtn" class="btn btn-sm btn-light fw-bold btn-active-light-primary me-2">목록</button>
										<button type="button" class="btn btn-primary" onclick="javascript:location.href='/company/canbanList.do?proNo=${projectVO.proNo }'">칸반보드</button>
									</div>
								</div>
								
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
									<div class="symbol-group symbol-hover mb-3">
				                         <div class="symbol symbol-35px symbol-circle" data-bs-toggle="tooltip" title="임윤아">
											<img alt="임윤아" src="https://search.pstatic.net/common/?src=http%3A%2F%2Fimgnews.naver.net%2Fimage%2F5090%2F2022%2F09%2F15%2F0002164136_001_20220915113004061.jpg&type=sc960_832" />
										</div>
				                         <div class="symbol symbol-35px symbol-circle" data-bs-toggle="tooltip" title="김태연">
											<img alt="김태연" src="https://lh3.googleusercontent.com/proxy/fFQCA6eJ35atPiMLgUbdH0vCSNw_dV82N7E0-dlQW_ZRCCDoHYXVaj1jMXc9K1o47txHtJZlFMyrqg47OEvRhiSV6fqPm5H7uRjDFTi50JM6" />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="kt_app_content" class="app-content flex-column-fluid pd-8">
				<div id="kt_app_content_container" class="app-container container-fluid">
					<div id="ganttList"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(function () {
	var listBtn = $("#listBtn");
	
	// 목록 버튼
	listBtn.on("click", function () {
		location.href = "/company/project.do";
	});
});

google.charts.load('current', {'packages':['gantt']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

  var data = new google.visualization.DataTable();
  data.addColumn('string', 'Task No');
  data.addColumn('string', 'Task Name');
  data.addColumn('string', 'Resource');
  data.addColumn('date', 'Start Date');
  data.addColumn('date', 'End Date');
  data.addColumn('number', 'Duration');
  data.addColumn('number', 'Percent Complete');
  data.addColumn('string', 'Dependencies');

  data.addRows([
    <c:forEach var="gantt" items="${ganttList}" varStatus="status">
	[
    	'${gantt.proTaskNo}',
		'${gantt.proTaskNm}',
		'${gantt.proTaskCn}',
		new Date('${gantt.proTaskStartDt}'),
		new Date('${gantt.proTaskEndDt}'),
		null,
		${gantt.proTaskPregrt},
		null
	] <c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ]);

  var options = {
    height: 400,
    gantt: {
      trackHeight: 30
    }
  };

  var chart = new google.visualization.Gantt(document.getElementById('ganttList'));

  chart.draw(data, options);
}

</script>
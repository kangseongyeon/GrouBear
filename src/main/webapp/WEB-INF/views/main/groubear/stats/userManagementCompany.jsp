<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.Calendar"%>

<c:set value="${salesMsg }" var="salesMsg"/>

<div style="margin-bottom: 50px;">
    <div style="margin-top: -32px;">
        <div class="separator border-2 my-10"></div>
    </div>
    <div style="margin-left: 30px; margin-top: -100px;">
        <h3>통계</h3>
        <h6>유저관리</h6>
    </div>
</div>

<div class="card mb-5 mb-xxl-8">
    <div class="card-body pt-0 pb-0">
        <ul class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold">
            <c:if test="${salesMsg eq 'year' }">
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5 active" href="usermanagementYear.do">연간</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="usermanagementMonth.do">월간</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="usermanagementCompany.do">기업간</a>
                </li>
            </c:if>
            <c:if test="${salesMsg eq 'month' }">
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="usermanagementYear.do">연간</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5 active" href="usermanagementMonth.do">월간</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="usermanagementCompany.do">기업간</a>
                </li>
            </c:if>
            <c:if test="${salesMsg eq 'company' }">
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="usermanagementYear.do">연간</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="usermanagementMonth.do">월간</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5 active" href="usermanagementCompany.do">기업간</a>
                </li>
            </c:if>
        </ul>
    </div>
</div>

<div> 
	<div class="d-flex flex-column flex-root app-root" id="kt_app_root">
		<div class="app-page flex-column flex-column-fluid" id="kt_app_page">
			<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
				<div class="d-flex flex-column flex-column-fluid">
					<div id="kt_app_content" class="app-content flex-column-fluid">
						<div id="kt_app_content_container" class="app-container container-fluid">
							<div class="card card-flush">
							<div style="display: flex; flex-direction: row; justify-content: space-between;">
							<form id="searchForm">
                                	<input type="hidden" name="page" id="page"> 
								<div class="card-header align-items-center py-5 gap-2 gap-md-5">
									<div class="card-title">
										<div class="d-flex align-items-center position-relative my-1">
											<input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-12" placeholder="검색" value="${searchWord }"/>
													<button id="searchBtn" type="button"
														class="btn btn-flex btn-light-primary ms-1 py-3 px-3"
														style="margin-top: 0.5em;">
														<i class="ki-duotone ki-magnifier fs-2"> <span
															class="path1" style="height: 1.1em;"></span> <span
															class="path2"></span>
														</i>
													</button>
												</div>
									</div>
								</div>
								</form>
								<div style="display: flex;align-items: center; padding-right: 27px">
									<form id="excelDown" method="POST">
										<div class="card-toolbar flex-row-fluid justify-content-end gap-5">
										</div>
									</form> 
								</div>
								</div>
								<div class="card-body pt-0">
									<table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered" id="kt_ecommerce_products_table">
										<thead>
											<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
												<th class="min-w-150px h4">회사명</th>
												<th class="min-w-100px h4">사업자번호</th>
												<th class="min-w-50px h4">계약인원</th>
												<th class="min-w-50px h4">사원수</th>
												<th class="min-w-100px h4">차트</th>
											</tr>
										</thead>
										<tbody class="fw-semibold text-gray-600">
											<c:choose>
												<c:when test="${empty comInfo }">
													<tr>
														<td class="text-center" colspan="8">기업이 존재하지 않습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach items="${comInfo }" var="item">
														<tr>
															<td>
															<div class="text-center">
														<a href="#" class="text-center" data-bs-toggle="modal" data-bs-target="#comInfo" onclick="f_cominfo('${item.coCd}')">${item.coNm }</a>
															</div>
															</td>
															<td>
																<div class="text-center">${item.coBrno }</div>
															</td>
															<td>
																<div class="text-center">${item.coCnt }</div>
															</td>
															<td>
																<div class="text-center">${item.empCnt }</div>
															</td>
															<td style="text-align: center;">
  															    <div style="display: grid; place-items: center;">
																	<button type="button"  data-bs-toggle="modal" data-bs-target="#statsChart"  class="btn btn-primary" onclick="f_statsChart('${item.coCd}')" >차트보기</button>
																</div>
															</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
								<div class="card-footer clearfix" id="pagingArea">${pagingVO.pagingHTML }
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 모달 시작 -->
<div class="modal fade" tabindex="-1" id="comInfo" >
	<div class="modal-dialog modal-dialog-scrollable" style="margin-left: 25%">
		<div class="modal-content" style="width: 800px;">
			
			<div class="modal-header">
				<h5 class="modal-title">회사정보 상세보기</h5>
				<div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
					<i class="ki-duotone ki-cross fs-2x"> 
						<span class="path1"></span>
						<span class="path2"></span>
					</i>
				</div>
			</div>

			<div class="modal-body" style="min-height: 250px; " >
				<div class="card-toolbar">
					<div class="mb-3" style="display: flex; justify-content: end; align-items: center; ">
						<div class="me-2" style="width: 100%;">
						<h3 id = "comName"> </h3>
						
						</div>
					</div>
				</div>
				<div class="card card-flush" id="formKndList" style="min-height: 300px; ">
					<div class="mt-5 mb-5">
						<div class="container-fluid">
							<div class="row" id="comDetail" >
								

							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer" style="height: 100px">
				<button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 차트보기 모달창 -->
<div class="modal fade" tabindex="-1" id="statsChart" >
	<div class="modal-dialog modal-dialog-scrollable" style="margin-left: 25%">
		<div class="modal-content" style="width: 800px;">
			
			<div class="modal-header">
				<h5 class="modal-title">사원수 상세보기</h5>
				<div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
					<i class="ki-duotone ki-cross fs-2x"> 
						<span class="path1"></span>
						<span class="path2"></span>
					</i>
				</div>
			</div>

		<div class="modal-body" style="min-height: 250px; " >
				<div class="card-toolbar">
					<div class="mb-3" style="display: flex; justify-content: end; align-items: center; ">
						<div class="me-2" style="width: 100%;">
						<h3 id="comName2"> </h3>
						
						</div>
					</div>
				</div>
				
				<div class="card card-flush" id="formKndList" style="min-height: 300px; ">
					<div class="mt-5 mb-5">
						<div class="container-fluid">
							<div class="row" >
								<div id="kt_apexcharts_3" style="height: 350px;"></div>
			
							</div>
						</div>
					</div>
				</div>
				
				 <!-- 월별 데이터 테이블 -->
                <div class="mt-3">
                    <h5>월별 데이터</h5>
                    <table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered" id="monthlyDataTable">
                        <tbody id="monthlyDataBody">
                            <!-- AJAX로 데이터가 추가될 부분 -->
                        </tbody>
                    </table>
                </div>
				
			</div>
			
			<div class="modal-footer" style="height: 100px">
				<button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
function f_cominfo(coCd){
	console.log("coCd : " + coCd);
	
	$.ajax({
		type : "get",
		url : "/groubear/statsdetail.do?coCd="+ coCd,
		success: function(res){
			console.log(res);
			console.log(res.coRegDt); // coRegDt의 값 확인
			
			$('#comName').text(res.coNm);
			
			
			 let formattedDate;

			    // coRegDt가 객체인지 확인
			    if (res.coRegDt && typeof res.coRegDt === 'object') {
			        // 객체에서 년, 월, 일을 추출하여 날짜 문자열 생성
			        const year = res.coRegDt.year;
			        const month = res.coRegDt.month; // 1부터 시작하는 월
			        const day = res.coRegDt.day;

			        // 날짜 문자열 생성 (월은 0부터 시작하므로 -1)
			        formattedDate = new Date(year, month - 1, day).toLocaleDateString();
			    } else {
			        formattedDate = "날짜 형식 오류"; // 객체가 아닌 경우
			    }
			
			
			let html = "";
			
				html +=	`<table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered" id="kt_ecommerce_products_table">`;
				html += `<thead>`;
				html += `<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">`;
				html +=	`<div class="form-check form-check-sm form-check-custom form-check-solid me-3">`;
				html +=	`</div>`;
				html +=	`<th class="min-w-100px h4">기업명</th>`;
				html +=	`<th class="min-w-100px h4">대표자명</th>`;
				html +=	`<th class="min-w-100px h4">가입일시</th>`;
				html +=	`<th class="min-w-100px h4">계약인원</th>`;
				html += `<tr>`;
				html += `<td><div class="text-center">\${res.coNm}</div></td>`;
				html += `<td><div class="text-center">\${res.ceoNm}</div></td>`;
				html += `<td><div class="text-center">\${formattedDate}</div></td>`;
				html += `<td><div class="text-center">\${res.coCnt}</div></td>`;
				html += `</tr>`;
				html += `</tr>`;
				html += `</thead>`;
				html += `</table>`;
				
				html +=	`<table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered" id="kt_ecommerce_products_table">`;
				html += `<thead>`;
				html += `<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">`;
				html +=	`<div class="form-check form-check-sm form-check-custom form-check-solid me-3">`;
				html +=	`</div>`;
				html +=	`<th class="min-w-100px h4">기업주소</th>`;
				html +=	`<th class="min-w-100px h4">상세주소</th>`;
				html +=	`<th class="min-w-100px h4">전화번호</th>`;
				html +=	`<th class="min-w-100px h4">우편번호</th>`;
				html += `<tr>`;
				html += `<td><div class="text-center">\${res.coAddr}</div></td>`;
				html += `<td><div class="text-center">\${res.coDaddr}</div></td>`;
				html += `<td><div class="text-center">\${res.coTel}</div></td>`;
				html += `<td><div class="text-center">\${res.coZip}</div></td>`;
				html += `</tr>`;
				html += `</tr>`;
				html += `</thead>`;
				html += `</table>`;
				
			$('#comDetail').html(html);
			console.log(html);
		}		
	});
	
}



function f_statsChart(coCd) {
    var element = document.getElementById('kt_apexcharts_3');
    var height = parseInt(KTUtil.css(element, 'height'));
    var labelColor = 'black';
    var borderColor = 'black';
    var lightColor = 'skyblue';

    if (!element) {
        console.error("차트 요소가 존재하지 않습니다.");
        return;
    }
    
    var empMonths = [];
    var empCounts = [];

    // AJAX 요청
    $.ajax({
        type: "get",
        url: "/groubear/statschart.do?coCd=" + coCd,
        success: function(res) {
            console.log(res); // 응답 데이터 확인
            
            
            // 응답 데이터 검증
            if (!res || !Array.isArray(res)) {
                console.error("응답 데이터가 유효하지 않습니다.", res);
                return; // 데이터가 없으면 함수 종료
            }
            $('#comName2').text(res[0].coNm);

            res.forEach(item => {
                empCounts.push(parseInt(item.chartData)); // 월별 사원 수 추가
                
                // 올바른 월 카테고리 사용
                empMonths.push(item.categories); // 여기서 item.categories를 사용하여 월 카테고리 추가
            });

            console.log("empCounts:", empCounts); // 사원 수 확인
            console.log("empMonths:", empMonths); // 카테고리 확인


            // 현재 날짜를 기준으로 년도와 월 정보를 가져옴
            var currentDate = new Date();
            var currentYear = currentDate.getFullYear();
            var currentMonth = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 추가

            var filteredMonths = [];
            var filteredCounts = [];
            
            // 월간 데이터 필터링
            for (var i = 1; i <= currentMonth; i++) {
                var monthString = currentYear + '-' + (i < 10 ? '0' + i : i);
                filteredMonths.push(monthString);
                
                var countFound = false;
                for (var j = 0; j < empMonths.length; j++) {
                    if (empMonths[j] === monthString) {
                        filteredCounts.push(empCounts[j]);
                        countFound = true;
                        break;
                    }
                }
                
                if (!countFound) {
                    filteredCounts.push(0); // 데이터가 없으면 0으로 설정
                }
            }

            console.log("filteredCounts:", filteredCounts); // 필터링된 사원 수 확인
            
            // 차트 데이터 및 카테고리 설정
            var options = {
                series: [{
                    name: '사원수',
                    data: filteredCounts
                }],
                chart: {
                    fontFamily: 'inherit',
                    type: 'line',
                    height: height,
                    toolbar: {
                        show: false
                    }
                },
                xaxis: {
                    categories: filteredMonths,
                    axisBorder: {
                        show: false
                    },
                    axisTicks: {
                        show: false
                    },
                    labels: {
                        style: {
                            colors: labelColor,
                            fontSize: '12px'
                        }
                    }
                },
                tooltip: {
                    y: {
                        formatter: function(val) {
                            return val + ' 명';
                        }
                    }
                },
                colors: ['#4fc9da'],
                grid: {
                    borderColor: borderColor,
                    strokeDashArray: 4,
                    yaxis: {
                        lines: {
                            show: true
                        }
                    }
                }
            };

            var chart = new ApexCharts(element, options);
            chart.render();
            

            // 월별 데이터 테이블 생성
            let html = "";
            html += `<table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered" id="monthlyDataTable">`;
            html += `<thead>`;
            html += `<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">`;
            html += `<th class="min-w-100px h4">입사년월</th>`;
            html += `<th class="min-w-100px h4">사원수</th>`;
            html += `</tr>`;
            html += `</thead>`;
            html += `<tbody>`;

            empMonths.forEach((month, index) => {
                html += `<tr>`;
                html += `<td><div class="text-center">\${month}</div></td>`;
                html += `<td><div class="text-center">\${empCounts[index]}</div></td>`;
                html += `</tr>`;
            });

            html += `</tbody>`;
            html += `</table>`;

            // 월별 데이터 추가
            $('#monthlyDataBody').html(html);
            
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", status, error);
        }
    });
}


$(function() {
	let searchForm = $('#searchForm'); // 검색 및 페이징 처리 위한 Form
	let pagingArea = $('#pagingArea'); // 페이징 처리 위한 div

	// 검색 버튼 눌렀을 때 키워드 검색
	$('#searchBtn').on('click', function() {
		searchForm.submit();
	});
	
	
	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
	pagingArea.on('click', 'a', function(event) {
		event.preventDefault();
		let pageNo = $(this).data('page');
		searchForm.find('#page').val(pageNo);
		searchForm.submit();
	});
});
</script>
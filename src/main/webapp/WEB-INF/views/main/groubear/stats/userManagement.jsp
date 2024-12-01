<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.Calendar"%>

<c:set value="${salesMsg }" var="salesMsg" />

<%
	// 현재 날짜를 기준으로 년도와 월 정보를 가져옴
Calendar calendar = Calendar.getInstance();
int currentYear = calendar.get(Calendar.YEAR);
int currentMonth = calendar.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 1을 추가

// 현재 연도와 월을 기준으로 월 리스트 생성
String[] months = new String[currentMonth]; // 현재 월까지만 생성
for (int i = 0; i < currentMonth; i++) {
	months[i] = String.format("%04d-%02d", currentYear, i + 1);
}
request.setAttribute("months", months); // months 배열을 request에 설정
%>

<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>통계</h3>
		<h6>매출/유저관리</h6>
	</div>
</div>

<div class="card mb-5 mb-xxl-8">
	<div class="card-body pt-0 pb-0">
		<ul
			class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold">
			<c:if test="${salesMsg eq 'year' }">
				<li class="nav-item mt-2"><a
					class="wow nav-link text-active-primary ms-0 me-10 py-5 active"
					href="usermanagementYear.do">연도별</a></li>
				<li class="nav-item mt-2"><a
					class="wow nav-link text-active-primary ms-0 me-10 py-5"
					href="usermanagementMonth.do">월별</a></li>
				<li class="nav-item mt-2"><a
					class="wow nav-link text-active-primary ms-0 me-10 py-5"
					href="usermanagementCompany.do">기업별</a></li>
			</c:if>
			<c:if test="${salesMsg eq 'month' }">
				<li class="nav-item mt-2"><a
					class="wow nav-link text-active-primary ms-0 me-10 py-5"
					href="usermanagementYear.do">연도별</a></li>
				<li class="nav-item mt-2"><a
					class="wow nav-link text-active-primary ms-0 me-10 py-5 active"
					href="usermanagementMonth.do">월별</a></li>
				<li class="nav-item mt-2"><a
					class="wow nav-link text-active-primary ms-0 me-10 py-5"
					href="usermanagementCompany.do">기업별</a></li>
			</c:if>
			<c:if test="${salesMsg eq 'company' }">
				<li class="nav-item mt-2"><a
					class="wow nav-link text-active-primary ms-0 me-10 py-5"
					href="usermanagementYear.do">연도별</a></li>
				<li class="nav-item mt-2"><a
					class="wow nav-link text-active-primary ms-0 me-10 py-5"
					href="usermanagementMonth.do">월별</a></li>
				<li class="nav-item mt-2"><a
					class="wow nav-link text-active-primary ms-0 me-10 py-5 active"
					href="usermanagementCompany.do">기업별</a></li>
			</c:if>
		</ul>
	</div>
</div>


<div
	class="d-flex flex-wrap flex-center justify-content-lg-between mx-auto w-xl-900px">
	<!--begin::Item-->
	<div
		class="d-flex flex-column flex-center h-150px w-150px h-lg-200px w-lg-200px m-3 bg-primary-light rounded-circle"
		style="background-color: #B3C8CF;">
		<!--begin::Symbol-->
		<span class="fs-4x text-white mb-3">
			<div class="overlay-wrapper text-gray-600">
				<i class="ki-duotone ki-briefcase fs-5x"><span class="path1"></span><span
					class="path2"></span></i>
			</div>
		</span>
		<!--end::Symbol-->

		<!--begin::Info-->
		<div class="mb-0">
			<!--begin::Value-->
			<div class="fs-lg-2hx fs-2x fw-bold text-white d-flex flex-center">
				<c:set var="companyCount" value="0" />
				<c:forEach var="stat" items="${count}">
					<c:if test="${stat.name == 'CompanyCount'}">
						<c:set var="companyCount" value="${stat.count}" />
					</c:if>
				</c:forEach>
				<div class="min-w-70px" data-kt-countup="true"
					data-kt-countup-value="${companyCount}" data-kt-countup-suffix="+">${companyCount}</div>
			</div>
			<!--end::Value-->

			<!--begin::Label-->
			<span class="text-gray-600 fw-semibold fs-5 lh-0"> 가입 기업 수 </span>
			<!--end::Label-->
		</div>
		<!--end::Info-->
	</div>
	<!--end::Item-->

	<!--begin::Item-->
	<div
		class="d-flex flex-column flex-center h-150px w-150px h-lg-200px w-lg-200px m-3 bg-primary-light rounded-circle"
		style="background-color: #BED7DC;">
		<!--begin::Symbol-->
		<span class="fs-4x text-primary mb-3">
			<div class="overlay-wrapper text-gray-600">
				<i class="ki-duotone ki-profile-user fs-5x"><span class="path1"></span><span
					class="path2"></span><span class="path3"></span><span class="path4"></span></i>
			</div>
		</span>
		<!--end::Symbol-->

		<!--begin::Info-->
		<div class="mb-0">
			<!--begin::Value - 가입 회원 수-->
			<div class="fs-lg-2hx fs-2x fw-bold text-white d-flex flex-center">
				<c:set var="empCount" value="0" />
				<c:forEach var="stat" items="${count}">
					<c:if test="${stat.name == 'EmpCount'}">
						<c:set var="empCount" value="${stat.count}" />
					</c:if>
				</c:forEach>
				<div class="min-w-70px" data-kt-countup="true"
					data-kt-countup-value="${empCount}" data-kt-countup-suffix="+">
					${empCount}</div>
			</div>
			<!--end::Value-->
			<span class="text-gray-600 fw-semibold fs-5 lh-0"> 가입 회원 수 </span>
			<!--end::Label-->
		</div>
		<!--end::Info-->
	</div>
	<!--end::Item-->

	<!--begin::Item-->
	<div
		class="d-flex flex-column flex-center h-150px w-150px h-lg-200px w-lg-200px m-3 bg-primary-light rounded-circle"
		style="background-color: #F1EEDC;">
		<!--begin::Symbol-->
		<span class="fs-4x text-primary mb-3">
			<div class="overlay-wrapper text-gray-600">
				<i class="ki-duotone ki-questionnaire-tablet fs-5x"><span
					class="path1"></span><span class="path2"></span></i>
			</div>
		</span>
		<!--end::Symbol-->

		<!--begin::Info-->
		<div class="mb-0">
			<!--begin::Value - 커뮤니티 수-->
			<div class="fs-lg-2hx fs-2x fw-bold text-white d-flex flex-center">
				<c:set var="communityCount" value="0" />
				<c:forEach var="stat" items="${count}">
					<c:if test="${stat.name == 'CommunityCount'}">
						<c:set var="communityCount" value="${stat.count}" />
					</c:if>
				</c:forEach>
				<div class="min-w-70px" data-kt-countup="true"
					data-kt-countup-value="${communityCount}"
					data-kt-countup-suffix="+">${communityCount}</div>
			</div>
			<!--end::Value-->
			<span class="text-gray-600 fw-semibold fs-5 lh-0"> 커뮤니티 수 </span>
			<!--end::Label-->
		</div>
		<!--end::Info-->
	</div>
	<!--end::Item-->

	<!--begin::Item-->
	<div
		class="d-flex flex-column flex-center h-150px w-150px h-lg-200px w-lg-200px m-3 bg-primary-light rounded-circle"
		style="background-color: #E5DDC5;">
		<!--begin::Symbol-->
		<span class="fs-4x text-primary mb-3">
			<div class="overlay-wrapper text-gray-600">
				<i class="ki-duotone ki-text-align-justify-center fs-5x"><span
					class="path1"></span><span class="path2"></span><span class="path3"></span><span
					class="path4"></span></i>
			</div>
		</span>
		<!--end::Symbol-->

		<!--begin::Info-->
		<div class="mb-0">
			<!--begin::Value - 로그 생성 수-->
			<div class="fs-lg-2hx fs-2x fw-bold text-white d-flex flex-center">
				<c:set var="logCount" value="0" />
				<c:forEach var="stat" items="${count}">
					<c:if test="${stat.name == 'LogCount'}">
						<c:set var="logCount" value="${stat.count}" />
					</c:if>
				</c:forEach>
				<div class="min-w-70px" data-kt-countup="true"
					data-kt-countup-value="${logCount}" data-kt-countup-suffix="+">
					${logCount}</div>
			</div>
			<!--end::Value-->
			<span class="text-gray-600 fw-semibold fs-5 lh-0"> 로그 생성 수 </span>
			<!--end::Label-->
		</div>
		<!--end::Info-->
	</div>
	<!--end::Item-->
</div>






<div class="row">
	<!-- 막대형 차트 -->
	<div class="col-md-6">
		<!-- 6열, 총 12열 중 6열을 사용 -->
		<div class="card card-bordered">
			<div class="card-body">
				<div id="kt_apexcharts_1" style="height: 350px;"></div>
			</div>
		</div>
	</div>

	<!-- 라인 차트 -->
	<div class="col-md-6">
		<!-- 6열, 총 12열 중 6열을 사용 -->
		<div class="card card-bordered">
			<div class="card-body">
				<div id="kt_apexcharts_3" style="height: 350px;"></div>
			</div>
		</div>
	</div>
</div>


<div class="row">
	<!-- 첫 번째 테이블 -->
	<div class="col-md-6">
		<div class="card card-bordered">
			<div class="card-body">
				<table
					class="table align-middle table-row-dashed fs-6 gy-5 table-bordered"
					id="kt_ecommerce_products_table_1">
					<thead>
						<tr
							class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
							<c:if test="${salesMsg eq 'year'}">
								<th class="min-w-100px h4">결제년도</th>
							</c:if>
							<c:if test="${salesMsg eq 'month'}">
								<th class="min-w-100px h4">결제년월</th>
							</c:if>
							<th class="min-w-100px h4">총 매출</th>
							<!--                             <th class="min-w-100px h4">부가세</th> -->
							<!--                             <th class="min-w-100px h4">합계</th> -->
						</tr>
					</thead>
					<tbody class="fw-semibold text-gray-600">
						<c:if test="${salesMsg eq 'month' }">
							<c:forEach var="month" items="${months}">
								<tr>
									<td><div class="text-center">${month}</div></td>
									<td>
										<div class="text-center">
											<c:set var="totalPayment" value="0" />
											<c:forEach var="item" items="${monthlyData}">
												<c:if test="${item.month == month}">
													<c:set var="totalPayment" value="${item.totalPayment}" />
												</c:if>
											</c:forEach>
											<fmt:formatNumber value="${totalPayment}" pattern="#,###" />
											원
										</div>
									</td>
									<!--                                     <td><div class="text-center">부가세 예정</div></td> -->
									<!--                                     <td><div class="text-center">합계 예정</div></td> -->
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${salesMsg eq 'year' }">
							<c:forEach var="yearItem" items="${yearlyData}">
								<tr>
									<td><div class="text-center">${yearItem.year}</div></td>
									<td><div class="text-center">
											<fmt:formatNumber value="${yearItem.totalPayment}"
												pattern="#,###" />
											원
										</div></td>
									<!--                                     <td><div class="text-center">부가세 예정</div></td> -->
									<!--                                     <td><div class="text-center">합계 예정</div></td> -->
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- 두 번째 테이블 -->
	<div class="col-md-6">
		<div class="card card-bordered">
			<div class="card-body">
				<table
					class="table align-middle table-row-dashed fs-6 gy-5 table-bordered"
					id="kt_ecommerce_products_table_2">
					<thead>
						<tr
							class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
							<c:if test="${salesMsg eq 'year'}">
								<th class="min-w-100px h4">입사년도</th>
							</c:if>
							<c:if test="${salesMsg eq 'month'}">
								<th class="min-w-100px h4">입사년월</th>
							</c:if>
							<th class="min-w-100px h4">사원 수</th>
						</tr>
					</thead>
					<tbody class="fw-semibold text-gray-600">
						<c:if test="${salesMsg eq 'month' }">
							<c:forEach var="month" items="${months}">
								<tr>
									<td><div class="text-center">${month}</div></td>
									<td>
										<div class="text-center">
											<c:set var="totalCount" value="0" />
											<c:forEach var="item" items="${monthlyEmp}">
												<c:if test="${item.joinMonth == month}">
													<c:set var="totalCount" value="${item.employeeCount}" />
												</c:if>
											</c:forEach>
											${totalCount}명
										</div>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${salesMsg eq 'year' }">
							<c:forEach var="yearEmp" items="${yearlyEmp}">
								<tr>
									<td><div class="text-center">${yearEmp.joinYear}</div></td>
									<td><div class="text-center">${yearEmp.employeeCount}명</div></td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>



<script type="text/javascript">
$(function() {
    // 라인차트
    var element = document.getElementById('kt_apexcharts_3');
    var height = parseInt(KTUtil.css(element, 'height'));
    var labelColor = 'black';
    var borderColor = 'black';
    var lightColor = 'skyblue';

    if (!element) {
        return;
    }

    var empMonths = [];
    var empCounts = [];
    var comMonths = [];
    var comCounts = [];

    // 월간 데이터 처리
    <c:if test="${salesMsg eq 'month' }">
        <c:forEach var="emp" items="${monthlyEmp}">
            empMonths.push('${emp.joinMonth}'); // YYYY-MM 형식
            empCounts.push(${emp.employeeCount}); // 사원 수
        </c:forEach>
        <c:forEach var="com" items="${monthlyCom}">
            comMonths.push('${com.comMonth}'); // YYYY-MM 형식
            comCounts.push(${com.companyCount}); // 기업 수 추가
        </c:forEach>
    </c:if>

    // 연간 데이터 처리
    <c:if test="${salesMsg eq 'year' }">
        <c:forEach var="yearEmp" items="${yearlyEmp}">
            empMonths.push('${yearEmp.joinYear}'); // YYYY 형식
            empCounts.push(${yearEmp.employeeCount}); // 사원 수
        </c:forEach>
        <c:forEach var="yearCom" items="${yearlyCom}">
        	comMonths.push('${yearCom.comYear}'); // YYYY-MM 형식
            comCounts.push(${yearCom.companyCount}); // 기업 수 추가
        </c:forEach>
    </c:if>
    
    console.log('Emp Months:', empMonths);
    console.log('Emp Counts:', empCounts);
    console.log('Com Months:', comMonths);
    console.log('Com Counts:', comCounts);
    

 // 현재 날짜를 기준으로 년도와 월 정보를 가져옴
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear(); 
    var currentMonth = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 추가

    var filteredMonths = [];
    var filteredCounts = []; // empCounts를 필터링하여 사용할 배열
    var filteredCompanyCounts = []; // 기업 수 필터링 배열

    if ('${salesMsg}' === 'month') {
        // 월간 데이터 필터링
        for (var i = 1; i <= currentMonth; i++) {
            var monthString = currentYear + '-' + (i < 10 ? '0' + i : i);
            filteredMonths.push(monthString);
            
            var countFound = false;
            for (var j = 0; j < empMonths.length; j++) {
                if (empMonths[j] === monthString) {
                    filteredCounts.push(empCounts[j]);
                    countFound = true;
                    break; // empCounts가 존재하면 루프 종료
                }
            }

            // 기업 수 추가
            if (countFound) {
                var companyCountFound = false; // 기업 수 체크를 위한 변수
                for (var j = 0; j < comMonths.length; j++) {
                    if (comMonths[j] === monthString) {
                        filteredCompanyCounts.push(comCounts[j]); // 기업 수 추가
                        companyCountFound = true; // 기업 수가 존재하면 체크
                        break; // 기업 수가 존재하면 루프 종료
                    }
                }
                if (!companyCountFound) {
                    filteredCompanyCounts.push(0); // 기업 수가 없는 경우 0 추가
                }
            } else {
                filteredCounts.push(0); // 데이터가 없으면 0으로 설정
                filteredCompanyCounts.push(0); // 데이터가 없으면 0으로 설정
            }
        }
    } else {
        // 연간 데이터 필터링
        for (var year = 2020; year <= currentYear; year++) {
            filteredMonths.push(year + '년');
            var countFound = false;

            for (var j = 0; j < empMonths.length; j++) {
                if (empMonths[j] === year.toString()) { // 연도 비교
                    filteredCounts.push(empCounts[j]);
                    countFound = true;
                    break; // empCounts가 존재하면 루프 종료
                }
            }

            // 기업 수 추가
            if (countFound) {
                var companyCountFound = false; // 기업 수 체크를 위한 변수
                for (var j = 0; j < comMonths.length; j++) {
                    if (comMonths[j] === year.toString()) { // 연도 비교
                        filteredCompanyCounts.push(comCounts[j]); // 기업 수 추가
                        companyCountFound = true; // 기업 수가 존재하면 체크
                        break; // 기업 수가 존재하면 루프 종료
                    }
                }
                if (!companyCountFound) {
                    filteredCompanyCounts.push(0); // 기업 수가 없는 경우 0 추가
                }
            } else {
                filteredCounts.push(0); // 해당 연도에 데이터가 없으면 0으로 설정
                filteredCompanyCounts.push(0); // 해당 연도에 데이터가 없으면 0으로 설정
            }
        }
    }


    
    console.log('filteredMonths:', filteredMonths);
    console.log('filteredCounts:', filteredCounts);
    console.log('Filtered Company Counts:', filteredCompanyCounts);
    
    
    var options = {
        series: [{
	            name: '사원수',
	            data: filteredCounts 	// 필터링된 사원 수 데이터 사용
        	},
        	{
                name: '기업수', // 기업 수 시리즈 추가
                data: filteredCompanyCounts // 기업 수 데이터 사용

            }
        ],
        chart: {
            fontFamily: 'inherit',
            type: 'line', 			// 라인 차트
            height: height,
            toolbar: {
                show: false
            },
//             background: '#C0EBA6' // 여기에서 차트 배경색을 설정합니다.
        },
        title: {
            text: '연도별 가입 기업, 사원 수', // 차트 제목
            align: 'center', // 제목 정렬, 'left', 'center', 'right' 중 선택
            style: {
                fontSize: '20px', // 제목 폰트 크기
                fontWeight: 'bold', // 제목 두께
                color: '#000B58' // 제목 색상
            }
        },
        xaxis: {
            categories: filteredMonths, // 필터링된 월 또는 연도 데이터 사용
            axisBorder: {
                show: false,
            },
            axisTicks: {
                show: false
            },
            labels: {
                style: {
                    colors: '#000B58',		// 차트 하단 월 색상
                    fontSize: '12px'
                }
            }
        },
        tooltip: {
        	y: {
                formatter: function(val, { seriesIndex }) {
                    if (seriesIndex === 0) {
                        // 사원 수
                        return val + ' 명'; // 사원 수 표시
                    } else if (seriesIndex === 1) {
                        // 기업 수
                        return val + ' 개'; // 기업 수 표시
                    }
                    return val; // 기본 반환
                }
            }
        },
        colors: ['#789DBC', '#FF5733'],		// 곡선 차트 색상
        
//         fill: {
//             type: 'gradient',          // 채우기 타입 설정 (solid, gradient 등)
//             opacity: 0.5,           // 채우기 투명도 (0~1)
//             colors: ['#D2FF72']     // 채우기 색상
//         },
        grid: {
            borderColor: '#15B392',	// 차트 가로줄 색상
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
    

});


$(function() {
    // 막대형 차트
    
    var element = document.getElementById('kt_apexcharts_1');

    if (!element) {
        return;
    }

    var months = [];
    var totalPayments = [];

    <c:if test="${salesMsg eq 'year' }">
        <c:forEach var="yearData" items="${yearlyData}">
            months.push('${yearData.year}년'); // 연도
            totalPayments.push(${yearData.totalPayment}); // 총 결제 금액
        </c:forEach>
    </c:if>

    <c:if test="${salesMsg eq 'month' }">
        <c:forEach var="item" items="${monthlyData}">
            months.push('${item.month}'); // 결제 년월
            totalPayments.push(${item.totalPayment}); // 총 결제 금액
        </c:forEach>
    </c:if>

    console.log('Months:', months);
    console.log('Total Payments:', totalPayments);

    // 현재 날짜를 기준으로 년도와 월 정보를 가져옴
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    var currentMonth = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 추가

    var filteredMonths = [];
    var filteredPayments = [];

    if ('${salesMsg}' === 'month') {
        for (var i = 1; i <= currentMonth; i++) {
            var monthString = currentYear + '-' + (i < 10 ? '0' + i : i);
            filteredMonths.push(monthString);
            
            var paymentFound = false;
            for (var j = 0; j < months.length; j++) {
                if (months[j] === monthString) {
                    filteredPayments.push(totalPayments[j]);
                    paymentFound = true;
                    break;
                }
            }
            
            if (!paymentFound) {
                filteredPayments.push(0);
            }
        }
    } else {
        // 연간일 경우 2020년부터 현재 연도까지 반복하여 필터링
        for (var year = 2020; year <= currentYear; year++) {
            filteredMonths.push(year + '년');
            var paymentFound = false;
            for (var j = 0; j < months.length; j++) {
                if (months[j] === (year + '년')) {
                    filteredPayments.push(totalPayments[j]);
                    paymentFound = true;
                    break;
                }
            }
            if (!paymentFound) {
                filteredPayments.push(0); // 해당 연도에 데이터가 없으면 0으로 설정
            }
        }
    }

    var options = {
        series: [{
            name: '총 결제 금액',
            data: filteredPayments // 총 결제 금액 데이터
        }],
        chart: {
            fontFamily: 'inherit',
            type: 'bar',
            height: element.offsetHeight,
            toolbar: {
                show: false
            }
        },
        title: {
            text: '연도별 총 매출(원)', // 차트 제목
            align: 'center', // 제목 정렬, 'left', 'center', 'right' 중 선택
            style: {
                fontSize: '20px', // 제목 폰트 크기
                fontWeight: 'bold', // 제목 두께
                color: '#000B58' // 제목 색상
            }
        },
        plotOptions: {
            bar: {
                horizontal: false,
                columnWidth: ['30%'],
                endingShape: 'rounded'
            },
        },
        legend: {
            show: false
        },
        dataLabels: {
            enabled: false
        },
        stroke: {
            show: true,
            width: 2,
            colors: ['transparent']
        },
        xaxis: {
            categories: filteredMonths, // 필터링된 결제 년월 데이터
            axisBorder: {
                show: false,
            },
            axisTicks: {
                show: false
            },
            labels: {
                style: {
                    colors: '#000B58',		// 하단 년도 색상
                    fontSize: '12px'
                }
            }
        },
        yaxis: {
            labels: {
                style: {
                    colors: '#000B58', // 값 색상
                    fontSize: '12px'
                },
                formatter: function (value) {
                    return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 천 단위 콤마 추가
                }
            }
        },

        fill: {
            opacity: 1
        },
        tooltip: {
            style: {
                fontSize: '12px'
            },
            y: {
                formatter: function (val) {
                    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' 원'; // 천 단위 콤마 추가
                }
            }
        },
        colors: ['#C1CFA1'],			// 차트 막대 색상
        grid: {
            borderColor: '#C9E9D2',		// 차트 가로줄 색상
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
});
</script>
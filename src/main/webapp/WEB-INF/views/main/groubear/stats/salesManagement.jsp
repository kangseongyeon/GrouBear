<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.Calendar"%>

<c:set value="${salesMsg }" var="salesMsg"/>

<%
    // 현재 날짜를 기준으로 년도와 월 정보를 가져옴
    Calendar calendar = Calendar.getInstance();
    int currentYear = calendar.get(Calendar.YEAR);
    int currentMonth = calendar.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 1을 추가

    // 2024년 1월부터 현재 월까지의 월 리스트 생성
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
        <h6>매출관리</h6>
    </div>
</div>

<div class="card mb-5 mb-xxl-8">
    <div class="card-body pt-0 pb-0">
        <ul class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold">
            <c:if test="${salesMsg eq 'year' }">
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5 active" href="salesmanagementYear.do">연간</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="salesmanagementMonth.do">월간</a>
                </li>
            </c:if>
            <c:if test="${salesMsg eq 'month' }">
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="salesmanagementYear.do">연간</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5 active" href="salesmanagementMonth.do">월간</a>
                </li>
            </c:if>
        </ul>
    </div>
</div>

<!-- 막대형 차트 -->
<div class="card card-bordered">
    <div class="card-body">
        <div id="kt_apexcharts_1" style="height: 350px;"></div>
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
                                        <div class="card-header align-items-center py-5 gap-2 gap-md-5"></div>
                                    </form>
                                    <div style="display: flex; align-items: center; padding-right: 27px"></div>
                                </div>
                                <div class="card-body pt-0">
                                    <table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered" id="kt_ecommerce_products_table">
                                        <thead>
                                            <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
                                                <th class="min-w-100px h4">결제일</th>
                                                <th class="min-w-100px h4">결제금액</th>
                                                <th class="min-w-100px h4">부가세</th>
                                                <th class="min-w-100px h4">합계</th>
                                            </tr>
                                        </thead>
                                        <tbody class="fw-semibold text-gray-600">
											<c:if test="${salesMsg eq 'year' }">
												<c:set var="startYear" value="2020" />
												<c:set var="currentYear" value="${currentYear}" />

												<c:forEach var="year" begin="${startYear}"
													end="${currentYear}">
													<tr>
														<td>
															<div class="text-center">${year}년</div>
														</td>
														<td>
															<div class="text-center">
																<c:set var="totalPayment" value="0" />
																<!-- 기본값 설정 -->
																<c:forEach var="item" items="${yearlyData}">
																	<c:if test="${item.year == year}">
																		<c:set var="totalPayment" value="${item.totalPayment}" />
																	</c:if>
																</c:forEach>
																${totalPayment}
																<!-- 결제 금액 표시 -->
															</div>
														</td>
														<td>
															<div class="text-center">부가세 예정</div>
														</td>
														<td>
															<div class="text-center">합계 예정</div>
														</td>
													</tr>
												</c:forEach>
											</c:if>

											<c:if test="${salesMsg eq 'month' }">
                                                <!-- 월간 데이터 처리 -->
                                                <c:forEach var="month" items="${months}">
                                                    <tr>
                                                        <td>
                                                            <div class="text-center">${month}</div>
                                                        </td>
                                                        <td>
                                                            <div class="text-center">
                                                                <c:set var="totalPayment" value="0" /> <!-- 기본값 설정 -->
                                                                <c:forEach var="item" items="${monthlyData}">
                                                                    <c:if test="${item.month == month}">
                                                                        <c:set var="totalPayment" value="${item.totalPayment}" /> <!-- 값이 있으면 업데이트 -->
                                                                    </c:if>
                                                                </c:forEach>
                                                                ${totalPayment} <!-- 최종 결제금액 표시 -->
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="text-center">부가세 예정</div>
                                                        </td>
                                                        <td>
                                                            <div class="text-center">합계 예정</div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
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
</div>

<script type="text/javascript">
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
                    colors: '#000B58',		// 값 색상
                    fontSize: '12px'
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
                    return val + ' 원'; // 툴팁 포맷
                }
            }
        },
        colors: ['#FF9C73'],			// 차트 막대 색상
        grid: {
            borderColor: '#FCF596',		// 차트 가로줄 색상
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
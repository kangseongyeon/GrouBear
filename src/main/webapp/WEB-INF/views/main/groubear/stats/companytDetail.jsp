<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>



<c:set value="${comMsg}" var="comMsg"/>

<div style="margin-bottom: 50px;">
    <div style="margin-top: -32px;">
        <div class="separator border-2 my-10"></div>
    </div>
    <div style="margin-left: 30px; margin-top: -100px;">
        <h3>통계</h3>
        <h6>기업통계</h6>
    </div>
</div>

<div class="card mb-5 mb-xxl-8">
    <div class="card-body pt-0 pb-0">
        <ul class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold">
            <c:if test="${comMsg eq 'numOfMem' }">
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5 active" href="companydetailnumofmem.do">구성원수</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="companydetailpremium.do">프리미엄</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="companydetailnumofmon.do">계약기간</a>
                </li>
            </c:if>
            <c:if test="${comMsg eq 'premium' }">
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="companydetailnumofmem.do">구성원수</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5 active" href="companydetailpremium.do">프리미엄</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="companydetailnumofmon.do">계약기간</a>
                </li>
            </c:if>
            <c:if test="${comMsg eq 'numOfMon' }">
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="companydetailnumofmem.do">구성원수</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5" href="companydetailpremium.do">프리미엄</a>
                </li>
                <li class="nav-item mt-2">
                    <a class="wow nav-link text-active-primary ms-0 me-10 py-5 active" href="companydetailnumofmon.do">계약기간</a>
                </li>
            </c:if>
        </ul>
    </div>
</div>


<div class="row">
    <div class="col-md-6">
        <canvas id="kt_chartjs" class="mh-400px"></canvas>
    </div>
    <div class="col-md-6">
        <div class="card card-bordered">
            <div class="card-body">
                <!-- 구성원수 표 -->
                <div id="memTable" class="data-table">
                    <table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered">
                       <c:if test="${comMsg eq 'numOfMem' }"> 
                        <thead>
                            <tr>
                                <th><div class="text-center">구성원 구간</div></th>
                                <th><div class="text-center">기업 수</div></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="mem" items="${numOfMem}">
                                <tr>
                                    <td><div class="text-center">50인 이하</div></td>
                                    <td><div class="text-center">${mem.fiftyPeople }</div></td>
                                </tr>
                                <tr>
                                    <td><div class="text-center">51~100인</div></td>
                                    <td><div class="text-center">${mem.hundredPeople }</div></td>
                                </tr>
                                <tr>
                                    <td><div class="text-center">101~150인</div></td>
                                    <td><div class="text-center">${mem.hundredPeopleHalf }</div></td>
                                </tr>
                                <tr>
                                    <td><div class="text-center">151~200인</div></td>
                                    <td><div class="text-center">${mem.twoHundredPeople }</div></td>
                                </tr>
                                <tr>
                                    <td><div class="text-center">201인이상</div></td>
                                    <td><div class="text-center">${mem.twoHundredPeopleHalf }</div></td>
                                </tr>
                                <tr>
                                    <th><div class="text-center">합 계</div></th>
                                    <th><div class="text-center">${mem.totalPeople }</div></th>
                                </tr>
                            </c:forEach>
                        </tbody>
                        </c:if>
                    </table>
                </div>

                <!-- 프리미엄 표 -->
                <div id="premiumTable" class="data-table" style="display:none;">
                    <table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered">
                        <c:if test="${comMsg eq 'premium' }">
                        <thead>
                            <tr>
                                <th><div class="text-center">프리미엄 여부</div></th>
                                <th><div class="text-center">기업 수</div></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prem" items="${premium}">
                                <tr>
                                    <td><div class="text-center">프리미엄</div></td>
                                    <td><div class="text-center">${prem.premium }</div></td>
                                </tr>
                                <tr>
                                    <td><div class="text-center">일반</div></td>
                                    <td><div class="text-center">${prem.normal }</div></td>
                                </tr>
                                 <tr>
                                    <th><div class="text-center">합 계</div></th>
                                    <th><div class="text-center">${prem.totalPremium }</div></th>
                                </tr>
                            </c:forEach>
                        </tbody>
                        </c:if>
                    </table>
                </div>

                <!-- 계약기간 표 -->
                <div id="monTable" class="data-table" style="display:none;">
                    <table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered">
                    <c:if test="${comMsg eq 'numOfMon' }">
                        <thead>
                            <tr>
                                <th><div class="text-center">계약 기간</div></th>
                                <th><div class="text-center">기업 수</div></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="mon" items="${numOfMon}">
                                <tr>
                                    <td><div class="text-center">3개월이하</div></td>
                                    <td><div class="text-center">${mon.threeMon }</div></td>
                                </tr>
                                <tr>
                                    <td><div class="text-center">4~6개월</div></td>
                                    <td><div class="text-center">${mon.sixMon }</div></td>
                                </tr>
                                <tr>
                                    <td><div class="text-center">6~12개월</div></td>
                                    <td><div class="text-center">${mon.oneYear }</div></td>
                                </tr>
                                <tr>
                                    <td><div class="text-center">1년이상</div></td>
                                    <td><div class="text-center">${mon.twoYear }</div></td>
                                </tr>
                                <tr>
                                    <td><div class="text-center">2년이상</div></td>
                                    <td><div class="text-center">${mon.overYear }</div></td>
                                </tr>
                                 <tr>
                                    <th><div class="text-center">합 계</div></th>
                                    <th><div class="text-center">${mon.totalPre }</div></th>
                                </tr>
                            </c:forEach>
                        </tbody>
                        </c:if>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>




<script type="text/javascript">


$(function(){
    var ctx = document.getElementById('kt_chartjs');


    // Chart config
    var config = {
        type: 'pie', // 차트 타입 (pie, bar, line 등)
        data: {
            labels: [],
            datasets: [{
                label: '',
                data: [],
                backgroundColor: ['#B7E0FF', '#FFF5CD', '#FFCFB3', '#E78F81', '#87A2FF'],
            }]
        },
        options: {
            plugins: {
                title: {
                    display: true,
                    text: ''
                },
                datalabels: {
                    color: '#36A2EB',
                    anchor: 'end',
                    align: 'end',
                    formatter: (value, context) => {
                        const total = context.chart._getDatasetMeta(0).data.reduce((acc, point) => acc + point._model.data, 0);
                        const percentage = ((value / total) * 100).toFixed(2) + '%';
                        return percentage;
                    }
                }
            },
            responsive: true,
        }
    };

 // 함수: 차트 업데이트
    function updateChart(statType) {
        // 모든 표 숨기기
        $('#memTable').hide();
        $('#premiumTable').hide();
        $('#monTable').hide();

        if (statType === 'numOfMem') {
            config.data.labels = ['50인이하', '51~100인', '101~150인', '151~200인', '201인이상'];
            config.data.datasets[0].data = [<c:forEach var="mem" items="${numOfMem}">${mem.fiftyPeople},${mem.hundredPeople},${mem.hundredPeopleHalf},${mem.twoHundredPeople},${mem.twoHundredPeopleHalf}</c:forEach>];
            config.options.plugins.title.text = '구성원 수 통계';
            $('#memTable').show(); // 구성원수 표 보이기
        } else if (statType === 'premium') {
            config.data.labels = ['프리미엄', '일반'];
            config.data.datasets[0].data = [<c:forEach var="prem" items="${premium}">${prem.premium},${prem.normal},</c:forEach>];
            config.options.plugins.title.text = '프리미엄 통계';
            $('#premiumTable').show(); // 프리미엄 표 보이기
        } else if (statType === 'numOfMon') {
            config.data.labels = ['3개월이하', '4~6개월', '6~12개월', '1년이상', '2년이상'];
            config.data.datasets[0].data = [<c:forEach var="mon" items="${numOfMon}">${mon.threeMon},${mon.sixMon},${mon.oneYear},${mon.twoYear},${mon.overYear}</c:forEach>];
            config.options.plugins.title.text = '계약 기간 통계';
            $('#monTable').show(); // 계약기간 표 보이기
        }

        // 차트 업데이트
        myChart.update();
    }

    // Init ChartJS
    var myChart = new Chart(ctx, config);

    // 초기 차트 데이터 설정
    updateChart('${comMsg}');
});
</script>

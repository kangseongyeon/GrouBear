<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div style="margin-bottom: 25px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>조직도</h3>
		<h6>조직도</h6>
	</div>
</div>
<div class="row col-12 px-5">
	<div class="col-12 col-xl-7"> 
		<div class="card card-flush h-xl-100 d-flex flex-column">
			<div class="card-header border-0 pt-7">
				<h1>${companyVO.coNm } </h1>
			</div>
			<div class="separator separator-dashed my-0"></div>
			<div class="row card-body pt-5">
				<div class="col-5">
					<div class="bg-gray-100 bg-opacity-70 rounded-2 px-6 pt-5 pb-5" style="height: 650px;">
						<div class="container mt-3 mb-max">
							<div class="d-flex justify-content-between align-items-center">
								<h1>주소록</h1>
								전체 사원 수 : 35 명 
							</div>
				            <div class="separator separator-dashed my-0 pt-3"></div>
							<div class="scrollable-list pb-5" style="max-height: 550px; overflow-y: auto;">
								<div class="d-flex align-items-center collapsible py-1 toggle mb-0" data-bs-toggle="collapse" data-bs-target="#kt_job_all">
							        <div class="btn btn-sm btn-icon mw-20px btn-active-color-primary me-2">
							            <i class="ki-duotone ki-minus-square toggle-on text-primary fs-1">
							                <span class="path1"></span>
							                <span class="path2"></span>
							            </i>
							            <i class="ki-duotone ki-plus-square toggle-off fs-1">
							                <span class="path1"></span>
							                <span class="path2"></span>
							                <span class="path3"></span>
							            </i>
							        </div>
							        <h4 class="text-gray-700 fw-bold cursor-pointer mt-2">전체 부서</h4>
							    </div>
							    <div class="container pl-max">
								    <div id="kt_job_all" class="collapse fs-6">
								        <c:forEach items="${deptTeamList}" var="dept">
									    <div class="d-flex align-items-center collapsible py-1 toggle mb-0" data-bs-toggle="collapse" data-bs-target="#kt_job_${dept.deptCd}">
									        <div class="btn btn-sm btn-icon mw-20px btn-active-color-primary me-2">
									            <i class="ki-duotone ki-minus-square toggle-on text-primary fs-1">
									                <span class="path1"></span>
									                <span class="path2"></span>
									            </i>
									            <i class="ki-duotone ki-plus-square toggle-off fs-1">
									                <span class="path1"></span>
									                <span class="path2"></span>
									                <span class="path3"></span>
									            </i>
									        </div>
									        <h4 class="text-gray-700 fw-bold cursor-pointer mt-2">${dept.deptNm}</h4>
									    </div>
									    <div id="kt_job_${dept.deptCd}" class="collapse fs-6 ml-5">
									        <c:forEach items="${dept.teamVO}" var="team">
									            <div id="team_${team.teamCd }" class="nested-team-list mb-2 text-gray-600 fw-semibold fs-6 ps-10" style="flex-grow: 1; cursor: pointer;"> ㆍ ${team.teamNm}
										        	<input type="hidden" id="teamCdVal" value="${team.teamCd }">
									            </div>
									        </c:forEach>
									    </div>
										</c:forEach>
								    </div>
							    </div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-7">
				    <div class="bg-gray-100 bg-opacity-70 rounded-2 px-6 py-5" style="height: 650px;">
				        <div class="container mt-3">
				            <div class="d-flex justify-content-between align-items-center">
								<h1>사원 목록</h1>
								<i class="ki-duotone ki-abstract-41 fs-5 text-gray-700" id="showAllEmployees" style="cursor: pointer;">
								        <span class="path1"></span>
								        <span class="path2"></span>
								    </i>
								</div>
					            <table class="table">
					                <thead>
					                    <tr>
					                        <th class="align-middle text-gray-600 fw-semibold fs-6">아이디</th>
					                        <th class="align-middle text-gray-600 fw-semibold fs-6">직급</th>
					                        <th class="align-middle text-gray-600 fw-semibold fs-6 d-flex justify-content-center">이름</th>
					                    </tr>
					                </thead>
					            </table>
								<div class="separator separator-dashed"></div>
				            <div class="scrollable-list" style="max-height: 510px; overflow-y: auto;">
				                <table class="table table-borderless" id="addrEmpList">
				                    <tbody>
				                        <c:forEach items="${empAllList}" var="emp">
				                            <tr>
				                                <td class="align-middle">
				                                    <div class="fv-row mb-1 text-gray-600 fw-semibold fs-6" style="width: auto; cursor: pointer;">${emp.empId}</div>
				                                </td>
				                                <td class="align-middle">
				                                    <div class="fv-row mb-1 text-gray-600 fw-semibold fs-6" style="width: auto; cursor: pointer;">${emp.jbgdCd}</div>
				                                </td>
				                                <td class="align-middle">
				                                    <div class="fv-row mb-1 text-gray-600 fw-semibold fs-6 d-flex justify-content-center" style="cursor: pointer;">${emp.empNm}</div>
				                                </td>
				                            </tr>
				                        </c:forEach>
				                    </tbody>
				                </table>
				            </div>
				        </div>
				    </div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-12 col-xl-5">
		<div class="card card-flush h-xl-100 d-flex flex-column" id="empIdChk">
	        <div class="card-header border-0 pt-7">
				<h1>프로필 정보</h1>
			</div>
			<div class="separator separator-dashed my-0"></div>
			<div class="row card-body pt-5">
			   <div class="bg-gray-100 bg-opacity-70 rounded-2 px-6 pt-5 pb-5" style="height: 650px; background-color: #F1E5D1" id="empDetail">
					
				</div>
			</div>
		</div>
	</div>
</div>
<input type="hidden" value="${companyVO.ceoId }" id="ceoIdVal">
<input type="hidden" value="${companyVO.ceoNm }" id="ceoNmVal">

<script type="text/javascript">
$(function () {
    var teamName = $(".nested-team-list");
    var moveData1 = $("#moveData1");
    var card1 = $("#card1");
    var nowCard = "card1";
    var showAllEmployees = $("#showAllEmployees");
    var myArray = [];
    var sendToCeoCard1 = $("#sendToCeoCard1");
    var addrEmpList = $("#addrEmpList");
    var empDetail = $("#empDetail");
    
//     addrEmpList.on("click", ".fv-row.mb-1.text-gray-600.fw-semibold.fs-6", function () {
//         let empId = $(this).text();
//         console.log("empId 찍어보기 : " + empId);
// 	});
    
    
    showAllEmployees.on("click", function () {
        let addrEmpList = $("#addrEmpList");
        console.log("클릭이벤트실행 : ");

        $.ajax({
            url: "/employee/getaddrallemp.do",
            type: 'GET',
            contentType: 'application/json; charset=UTF-8',
            success: function (res) {
            	
                let html = "";

                if (res && res.length > 0) {
                    res.forEach(emp => {
                        html += "<tbody>";
                        html += "<tr><td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6' style='width: 150px; cursor: pointer; '>" + emp.empId + "</div></td>";
                        html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6'style='cursor: pointer;' >" + emp.empNm + "</div></td></tr>";
                        html += "</tbody>";
                    });
                } else {
                    html += "<tr><td colspan='4' class='text-center text-gray-600 fw-semibold fs-6 pt-10'>사원 정보가 없습니다.</td></tr>";
                }

                addrEmpList.empty().append(html);

                // 팀 사원 목록을 불러온 후, 체크된 상태 유지
                $("#addrEmpList .form-check-input").each(function () {
                    let empId = $(this).val();
                    if ($("#moveData1 tr[data-emp-id='" + empId + "']").length > 0) {
                        $(this).prop('checked', true);
                    }
                });
            },
        });
	});
    
    addrEmpList.on("click", "tr", function () {
        let empId = $(this).find("div.fv-row").first().text();
        console.log("empId값입니다 : " + empId);
        
		let html = "";
		empDetail.html(html);
		
        $.ajax({
            url: "/employee/getaddempid.do",
            type: "get",
            contentType: "application/json; charset=UTF-8",
            data: {
                empId: empId
            },
            success: function (emp) {
                html = `
                    <div class="card-body">
                        <div class="d-flex flex-center flex-column py-20">
                            <div class="symbol symbol-200px symbol-circle mb-5">
                                <img src="/upload/\${emp.imgFileUrl}" style="object-fit: cover;"/>
                            </div>
                            <h1 class="text-gray-700 fw-bold py-5">\${emp.empNm}</h1>
                            <table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered">
	    						<thead>
	    							<tr class="text-center" style="background-color: #FFE0B5">
	    								<td>부서</td>
	    								<td>팀</td>
	    								<td>직급</td>
	    								<td>이메일</td>
	    							</tr>
	    						</thead>
	    						<tbody>
	    							<tr class="text-center" style="background-color: #FFF2D7">
	    								<td>\${emp.deptCd}</td>
	    								<td>\${emp.teamCd}</td>
	    								<td>\${emp.jbgdCd}</td>
	    								<td>\${emp.empEmlAddr}</td>
	    							</tr>
	    						</tbody>
	    					</table>
                        </div>
                    </div>
                `;
                empDetail.append(html);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error("AJAX 호출 실패: " + textStatus, errorThrown);
            }
        });
    });


    
    teamName.on("click", function () {
        let teamCd = $(this).find("input[id='teamCdVal']").val(); 
        let addrEmpList = $("#addrEmpList");
        
        $.ajax({
            url: "/employee/getaddremp.do",
            type: 'GET',
            contentType: 'application/json; charset=UTF-8',
            data: { teamCd: teamCd },
            success: function (res) {
                let html = "";

                if (res && res.length > 0) {
                    res.forEach(emp => {
                        html += "<tbody>";
                        html += "<tr><td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6' style='width: 150px; cursor: pointer;'>" + emp.empId + "</div></td>";
                        html += "<td class='align-middle'><div class='fv-row mb-1 text-gray-600 fw-semibold fs-6' style='cursor: pointer;'>" + emp.empNm + "</div></td></tr>";
                        html += "</tbody>";
                    });
                } else {
                    html += "<tr><td colspan='4' class='text-center text-gray-600 fw-semibold fs-6 pt-10'>사원 정보가 없습니다.</td></tr>";
                }

                addrEmpList.empty().append(html);
				
                $("#addrEmpList .form-check-input").each(function () {
                    let empId = $(this).val();
                    if ($("#moveData1 tr[data-emp-id='" + empId + "']").length > 0) {
                        $(this).prop('checked', true);
                    }
                });
            },
        });
    });
});

</script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div style="margin-bottom: 50px;">
    <div style="margin-top: -32px;">
        <div class="separator border-2 my-10"></div>
    </div>
    <div style="margin-left: 30px; margin-top: -100px;">
        <h3>보안</h3>
        <h6>로그</h6>
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
                                                    <button id="searchBtn" type="button" class="btn btn-flex btn-light-primary ms-1 py-3 px-3" style="margin-top: 0.5em;">
                                                        <i class="ki-duotone ki-magnifier fs-2"> <span class="path1"></span> <span class="path2"></span></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <div style="display: flex;align-items: center; padding-right: 27px">
                                        <button type="button" data-bs-toggle="modal" data-bs-target="#dateBtn" class="btn btn-success mx-2">날짜검색하기</button>
                                        <form id="excelDown" method="POST">
                                            <div class="card-toolbar flex-row-fluid justify-content-end gap-5">
                                                <div>
                                                    <button type="button" id="excelBtn" class="btn btn-primary">Excel 저장하기</button>
                                                </div>
                                            </div>
                                        </form> 
                                    </div>
                                </div>
                                <div class="card-body pt-0">
                                    <table class="table align-middle table-row-dashed fs-6 gy-5 table-bordered" id="kt_ecommerce_products_table">
                                        <thead>
                                            <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
                                                <th class="min-w-150px h4">시간</th>
                                                <th class="min-w-100px h4">기업</th>
                                                <th class="min-w-100px h4">부서</th>
                                                <th class="min-w-100px h4">이름</th>
                                                <th class="min-w-100px h4">아이디</th> 
                                                <th class="min-w-100px h4">IP</th> 
                                                <th class="min-w-100px h4">작업내역</th> 
                                            </tr>
                                        </thead>
                                        <tbody class="fw-semibold text-gray-600">
                                            <c:set value="${pagingVO.dataList }" var="logList" />
                                            <c:choose>
                                                <c:when test="${empty logList }">
                                                    <tr>
                                                        <td class="text-center" colspan="8">로그가 존재하지 않습니다.</td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${logList }" var="item">
                                                        <tr>
                                                            <td><div class="text-center">${item.logCrtDt}</div></td>
                                                            <td><div class="text-center">${item.companyName }</div></td>
                                                            <td>
                                                            <c:choose>
                                                            	<c:when test="${empty item.departmentName}">
		                                                            <div class="text-center">대표</div>
                                                            	</c:when>
                                                            	<c:otherwise>
		                                                            <div class="text-center">${item.departmentName} </div>
                                                            	</c:otherwise>
                                                            </c:choose>
                                                            </td>
                                                            <td><div class="text-center">${item.empNm }</div></td>
                                                            <td><div class="text-center">${item.empId }</div></td>
                                                            <td><div class="text-center">${item.logIp }</div></td>
                                                            <td><div class="text-center">${item.logDetail }</div></td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="card-footer clearfix" id="pagingArea">${pagingVO.pagingHTML }</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 날짜 검색 모달 -->
<div class="modal fade" tabindex="-1" id="dateBtn">
    <div class="modal-dialog modal-dialog-scrollable" style="margin-left: 25%">
        <div class="modal-content" style="width: 800px;">
            <div class="modal-header">
                <h5 class="modal-title">날짜 검색</h5>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
                    <i class="ki-duotone ki-cross fs-2x"></i>
                </div>
            </div>
            <div class="modal-body" style="min-height: 250px;">
                <div class="mb-3">
                    <label for="startDate" class="form-label">시작 날짜</label>
                    <input type="date" id="startDate" class="form-control" />
                </div>
                <div class="mb-3">
                    <label for="endDate" class="form-label">종료 날짜</label>
                    <input type="date" id="endDate" class="form-control" />
                </div>
            </div>
            <div class="modal-footer" style="height: 100px">
                <button type="button" class="btn btn-primary" id="searchByDateBtn">검색</button>
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>



<script type="text/javascript">
$(function() {
    let searchForm = $('#searchForm');      // 검색 및 페이징 처리 위한 Form
    let pagingArea = $('#pagingArea');		// 페이징 처리 위한 div
    let excelDown = $('#excelDown');
    let excelBtn = $('#excelBtn');		
    
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
    
    excelBtn.on("click", function () {
        Swal.fire({
            title: '엑셀 파일을 다운로드 하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#F06445',
            cancelButtonColor: '#4FC9DA',
            confirmButtonText: '예',
            cancelButtonText: '아니요',
            reverseButtons: false,
        }).then((result) => {
            if (result.isConfirmed) {
                // 사용자가 '예'를 클릭한 경우
                excelDown.attr("action", "/excel/downExcel");
                excelDown.submit();
            }
        });
    });
    
 // 날짜 검색 버튼 클릭 시 AJAX 요청
    $('#searchByDateBtn').on('click', function() {
        let startDate = $('#startDate').val();
        let endDate = $('#endDate').val();

        // 유효성 검사
        if (!startDate || !endDate) {
            Swal.fire({
                icon: 'error',
                title: '날짜를 입력해주세요!',
                text: '시작 날짜와 종료 날짜를 모두 입력해야 합니다.'
            });
            return;
        }

        // AJAX 요청
        $.ajax({
            url: '/groubear/log/dateSearch',
            type: 'GET',
            data: {
                startDate: startDate,
                endDate: endDate,
                page: 1 // 첫 페이지를 요청
            },
            success: function(data) {
                updateLogTable(data.dataList); // data.dataList 사용
                updatePaging(data.totalPages); // 총 페이지 수 업데이트
                $('#pagingArea').html(data.pagingHTML); // 페이징 HTML 업데이트
            },

            error: function(xhr, status, error) {
                Swal.fire({
                    icon: 'error',
                    title: '오류 발생',
                    text: '로그를 가져오는 데 실패했습니다.'
                });
            }
        });

        // 모달 닫기
        $('#dateBtn').modal('hide');
    });


    // 테이블 업데이트 함수
    function updateLogTable(data) {
        let tableBody = $('#kt_ecommerce_products_table tbody');
        tableBody.empty(); // 기존 데이터 삭제

        // 데이터 추가
        if (data.length === 0) {
            tableBody.append('<tr><td class="text-center" colspan="7">로그가 존재하지 않습니다.</td></tr>');
        } else {
            $.each(data, function(index, item) {
            	let departmentName = item.departmentName ? item.departmentName : '대표'; // null 체크
                let row = `<tr>
                    <td><div class="text-center">\${item.logCrtDt}</div></td>
                    <td><div class="text-center">\${item.companyName}</div></td>
                    <td><div class="text-center">\${departmentName}</div></td>
                    <td><div class="text-center">\${item.empNm}</div></td>
                    <td><div class="text-center">\${item.empId}</div></td>
                    <td><div class="text-center">\${item.logIp}</div></td>
                    <td><div class="text-center">\${item.logDetail}</div></td>
                </tr>`;
                tableBody.append(row);
            });
        }
    }

    // 페이징 업데이트 함수
    function updatePaging(totalPages) {
        let pagingArea = $('#pagingArea');
        pagingArea.empty(); // 기존 페이지 링크 삭제

        for (let i = 1; i <= totalPages; i++) {
            let pageLink = `<a href="#" data-page="${i}" class="page-link">${i}</a>`;
            pagingArea.append(pageLink);
        }

        // 페이지 링크 클릭 이벤트 추가
        pagingArea.off('click', 'a').on('click', 'a', function(event) {
            event.preventDefault(); // 기본 링크 동작 방지
            let pageNo = $(this).data('page');

            // 날짜 검색과 함께 현재 페이지 번호를 포함하여 AJAX 요청
            $.ajax({
                url: '/groubear/log/dateSearch',
                type: 'GET',
                data: {
                    startDate: $('#startDate').val(), // 모달에서 입력된 시작 날짜
                    endDate: $('#endDate').val(),       // 모달에서 입력된 종료 날짜
                    page: pageNo                         // 클릭한 페이지 번호
                },
                success: function(data) {
                    updateLogTable(data.dataList); // 테이블 업데이트
                    updatePaging(data.totalPages); // 페이징 업데이트
                    $('#pagingArea').html(data.pagingHTML); // 페이징 HTML 업데이트
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        icon: 'error',
                        title: '오류 발생',
                        text: '로그를 가져오는 데 실패했습니다.'
                    });
                }
            });
        });
    }
});
</script>









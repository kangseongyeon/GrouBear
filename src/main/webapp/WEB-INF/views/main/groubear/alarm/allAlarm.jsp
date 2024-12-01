<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
.image-input-placeholder {
   background-image: url('assets/media/svg/files/blank-image.svg');
}

[data-bs-theme="dark"] .image-input-placeholder {
   background-image: url('assets/media/svg/files/blank-image-dark.svg');
}
</style>

<c:if test="${not empty message }">
   <script type="text/javascript">
      Swal.fire({
         icon : 'success',
         title : '${message}',
         confirmButtonColor : '#4FC9DA',
      });
   </script>
   <c:remove var="message" scope="request" />
</c:if>

<div style="margin-bottom: 50px;">
   <div style="margin-top: -32px;">
      <div class="separator border-2 my-10"></div>
   </div>
   <div style="margin-left: 30px; margin-top: -100px;">
      <h3>알림</h3>
      <h6>알림 전체</h6>
   </div>
</div>

<div class="card"
   style="background-color: transparent; border: none; box-shadow: none;">
   <div class="card-body py-0">
      <div class="card-header border-0 pt-0"
         style="padding-left: 0px; padding-right: 0px; !important">
         <div class="card-title">
            <div class="d-flex align-items-center position-relative my-1">
               <form id="searchForm" style="display: contents;">
                  <input type="hidden" name="page" id="page"> <input
                     id="myInput" name="searchWord" type="text"
                     data-kt-ecommerce-product-filter="search"
                     class="form-control form-control-solid w-250px ps-5"
                     style="margin-top: 0.5em;" placeholder="검색"
                     value="${searchWord }" />
                  <button id="searchBtn" type="submit"
                     class="btn btn-flex btn-light-success ms-1 py-3 px-3"
                     style="margin-top: 0.5em;">
                     <i class="ki-duotone ki-magnifier fs-2"> <span class="path1"
                        style="height: 1.1em;"></span> <span class="path2"></span>
                     </i>
                  </button>
               </form>
            </div>
         </div>
      </div>
   </div>
</div>


<% 
   Map<String, String> categoryMap = new HashMap<>(); 
   categoryMap.put("QnA", "Q&A"); 

   request.setAttribute("categoryMap", categoryMap); 
%>
 
 
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-fluid">
				<div class="card">
					<div class="card-body py-4">
						<table class="table align-middle table-row-dashed fs-6 gy-5">
							<thead>
								<tr
									class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
									<th class="min-w-100px">카테고리</th>
									<th class="min-w-200px">내용</th>
									<th class="min-w-100px">수신일자</th>
								</tr>
							</thead>
							<tbody class="text-gray-600 fw-semibold"> 
							    <c:set value="${pagingVO.dataList }" var="alarmList" /> 
							    <c:choose> 
							        <c:when test="${empty alarmList }"> 
							            <tr> 
							                <td colspan="5">알림이 없습니다.</td> 
							            </tr> 
							        </c:when> 
							        <c:otherwise> 
							            <c:forEach items="${dataList}" var="alarm"> 
							                    <tr> 
							                        <td>
							                            <input type="hidden" class="alarmNo" value="${alarm.alarmNo }" /> 
							                            <c:choose>
							                                <c:when test="${not empty categoryMap[alarm.alarmCategory]}">
							                                    ${categoryMap[alarm.alarmCategory]}
							                                </c:when>
							                                <c:otherwise>
							                                    ${alarm.alarmCategory} <!-- 기본값 사용 -->
							                                </c:otherwise>
							                            </c:choose>
							                        </td> 
							                        <td>
							                            <a href="${alarm.alarmUrl }"> 
							                                <p class="m-0">${alarm.alarmCn}</p> 
							                            </a>
							                        </td> 
							                        <td>
							                            <p class="m-0">${alarm.alarmCrtDt}</p>
							                        </td> 
							                        <td>
							                            <a href="#" class="btn btn-icon btn-light-youtube me-5 delAlarm" style="width: 20px; height: 20px;">
							                                <i class="fa-solid fa-xmark fs-4"></i>
							                            </a>
							                        </td> 
							                    </tr> 
							            </c:forEach> 
							        </c:otherwise> 
							    </c:choose> 
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="card-footer clearfix"
			style="margin-top: 20px; margin-bottom: 20px;" id="pagingArea">
			${pagingVO.pagingHTML }</div>
	</div>
</div>

<script type="text/javascript">
	$(function() {

		var searchForm = $("#searchForm");
		var pagingArea = $("#pagingArea");

		pagingArea.on("click", "a", function(event) {			
			event.preventDefault();
			var pageNo = $(this).data("page");
			searchForm.find("#page").val(pageNo);
			$("#myInput").val("");
			searchForm.submit();
		});

		$("#delAlarm").on("click", function(e) {
			e.preventDefault();

			let alarmNo = $(".alarmNo").val();
			console.log("hi");

			let data = {
				alarmNo : alarmNo
			}
			
			console.log("alarmNo ::: " + alarmNo);
			
			$.ajax({
				url:"/alarmRemove",
				type:"post",
				data: JSON.stringify(data),
				contentType : "application/json; charset=utf-8",
		        success: function(res) {     
		        	console.log("res ::: " , res);

		        	 location.reload();
		        },
	            error: function(xhr, status, error) {
	                console.error("Error deleting alarm:", error);
	            }
		   });

		});


	});

</script>

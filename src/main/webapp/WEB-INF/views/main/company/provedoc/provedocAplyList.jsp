<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- ckeditor API -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script> 

<!-- sweetalert2 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- jstree -->
<link href="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/design/plugins/custom/jstree/jstree.bundle.js"></script>

<style>
	.expln {
	    margin-left: 0.5em;
	    color: white;
	    background-color: lightslategray;
	    width: 1.1em;
	    height: 1.1em;
	    line-height: 1.1em;
	}
	.fs-2x {
	    font-size: 1.5rem !important;
	}
</style>

<!-- 넘겨받은 메세지가 있을 때만 자바스크립트를 실행-->
<c:if test="${not empty message }">
	<script type="text/javascript">
		Swal.fire({ 
			icon: 'success',
			title: '${message}',
			confirmButtonColor: '#4FC9DA',
		});
	</script>
	<c:remove var="message" scope="request"/>
</c:if>

<div style="margin-bottom: 20px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>증명서 요청관리</h3>
		<h6>증명서 관리</h6>
	</div>
</div>

<div class="kt_app_content_container mx-5 mb-5" class="app-container container-fluid" style="height: 100%"> 
	<div class="card card-flush" style="height: 100%;">
                                
		<div class="card-header align-items-center py-5 gap-2 gap-md-5">
			<div class="card-title" style="width: 100%;">
				<div class="d-flex align-items-center position-relative my-1" style="width: 30%;">
													
					<form id="searchForm" style="display: contents;">
						<input type="hidden" name="page" id="page">
						<input id="myInput" name="searchWord" type="text" data-kt-ecommerce-product-filter="search" class="form-control form-control-solid w-250px ps-5" style="margin-top: 0.5em;" placeholder="증명서 검색" value="${searchWord }"/>
						<button id="searchBtn" type="button" class="btn btn-flex btn-light-success ms-1 py-3 px-3" style="margin-top: 0.5em;">
						<i class="ki-duotone ki-magnifier fs-2x">
							<span class="path1" style="height: 1.1em;"></span> 
							<span class="path2"></span>
						</i>
						</button>
					</form>
	                         
				</div>
				<div class="float-end" style="width: 70%;">
					<span class="badge badge-light-primary badge-lg float-end me-3 fs-2 px-4 py-2">${provedocCount.prdocAprvN } / ${provedocCount.prdocAprvN + provedocCount.prdocAprvY }</span>
				</div>
			</div>
		</div>
	
		<div class="card-body pt-0 pb-0">
			<table class="table align-middle table-row-dashed fs-4" id="kt_ecommerce_products_table">
				<thead>
					<tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
						<th width="18%" class="h4">신청일/발급일</th>  
						<th width="22%" class="h4">분류</th>
						<th width="13%" class="h4">부서</th>
						<th width="13%" class="h4">팀</th> 
						<th width="10%" class="h4">신청자</th>
						<th width="14%" class="h4">수정 및 발급</th>  
						<th width="10%" class="h4">상태</th>   
					</tr> 
				</thead>
				<tbody class="fw-semibold text-gray-600">
					<c:set value="${pagingVO.dataList }" var="provedocList"/>
					<c:choose>
						<c:when test="${empty provedocList }">
							<tr>
								<td colspan="5" class="text-center pt-5">
									<img src="${pageContext.request.contextPath }/resources/file/image/cloudEmpty.png" class="mw-600px">
									<div class="fs-1 fw-bold">신청된 증명서 목록이 없습니다</div> 
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${provedocList }" var="provedocVO">
								<tr>
									<td>  
										<div class="text-center">
											<c:out value="${fn:substring(provedocVO.prdocAplyDt, 0, 16)}" /><br>
											<c:out value="${fn:substring(provedocVO.prdocIsprDt, 0, 16)}" />
										</div>
									</td>
									<td>
										<div class="text-center">
											<c:choose>
												<c:when test="${provedocVO.prdocAprvYn eq 'Y' }">
													<a href="/company/provedocDetailAply.do?prdocNo=${provedocVO.prdocNo }">${provedocVO.docFormNm }</a>
												</c:when>
												<c:otherwise>
													<div class="text-center">${provedocVO.docFormNm }</div>
												</c:otherwise>
											</c:choose>
										</div>
									</td>
									<td>
										<div class="text-center">${provedocVO.deptNm }</div>
									</td>
									<td>
										<div class="text-center">${provedocVO.teamNm }</div>
									</td>
									<td>
										<div class="text-center">${provedocVO.empNm }</div>
									</td>
									<td>
										<div style="display: flex; justify-content: center;">
											<c:choose>
												<c:when test="${provedocVO.prdocAprvYn eq 'N' }">
													<button type="button" id="provedocIsprBtn" class="btn btn-light-danger" value="${provedocVO.prdocNo }" style="width: 95px;">
										                	발급하기
										            </button> 
												</c:when>
												<c:otherwise>
													<div class="text-center">발급완료</div>
												</c:otherwise>
											</c:choose>
										</div>
									</td>
									<td>
										<c:choose>
											<c:when test="${provedocVO.prdocAprvYn eq 'N' }">
												<div class="text-center">대기중</div>
											</c:when>
											<c:otherwise>
												<div class="text-center">완료</div>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach> 
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<!--end::Table-->
		</div>
		<!--end::Card body-->
	
		<div class="dt-paging paging_simple_numbers" id="pagingArea" style="margin-bottom: 10px;">
			${pagingVO.pagingHTML }
		</div>

	</div>
</div>

<script>

$(function() {
	
	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
	let searchForm = $("#searchForm");		
	let pagingArea = $("#pagingArea");		// 페이징 처리 위한 div
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a 태그의 기본 기능 멈추기
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		
		$('#myInput').val("");
		 
		searchForm.submit();
	});
	
	// 검색 버튼 눌렀을 때 키워드 검색
	$('#searchBtn').on('click', function() {
		searchForm.submit();
	});

	// 엔터키를 눌렀을 때 키워드 검색
	$('#searchForm').on('keydown', function(event) {
		if (event.keyCode == 13) {	// Enter 키를 눌렀을 때 (엔터키 == 13번)
			searchForm.submit();
	    }
	});
	
   /* CKEDITOR 자바스크립트 */
   CKEDITOR.replace( 'provedocEditorCK', {
      height: 500,
      width: 740
   });
   
    // jstree 자바스크립트에서 사용할 계층형 데이터 가져오기
    $('#formCallJstree').on('click', function() {
    	$('#treeUl').html("");
       console.log("111");
        $.ajax({
            type: "get",
            url: "/company/provedocSelectJstree.do",
            success: function(data) {
                f_createJstree(data);
                console.log(data);
            }
        });
    });  
    
    
    // 증명서 발급하기 버튼을 눌렀을 떄
	$('tbody').on('click', '#provedocIsprBtn', function() {
		let prdocNo = $(this).val();
		console.log(prdocNo);
		
		location.href= "/company/provedocDetailAply.do?prdocNo=" + prdocNo;
	});
     
});

// jstree용 데이터 가공해서 추가하기
function f_createJstree(treeData) {
    // 트리 구조를 만들기 위한 객체
    const tree = {};

    // 데이터 구조를 트리 형태로 변환
    treeData.forEach(node => {
        tree[node.id] = { ...node, children: [] };
    });
    
    // 자식 노드를 연결
    Object.values(tree).forEach(node => {
        if (node.parent !== "#") {
            tree[node.parent].children.push(node);
        }
        console.log("222");
    });
    
    // 최상위 노드만 추출
    const rootNodes = Object.values(tree).filter(node => node.parent === "#");

    // 정해진 형식으로 HTML 생성하기
    const treeHTML = generateHTML(rootNodes);

    // 결과를 DOM에 삽입하기
    console.log("333");
    console.log(treeHTML);
   
    /* $("#formJstree").jstree(true).refresh(); */
    $('#treeUl').html(treeHTML); // treeUl에 jstree HTML을 삽입함

    // 삽입한 HTML을 jstree 형식과 매칭하기
    $('#formJstree').jstree({
        "core": {
            "themes": {
                "responsive": false
            }
        },
        "types": {
            "default": {
                "icon": "ki-outline ki-file text-warning"
            },
            "file": {
                "icon": "ki-outline ki-notification-status text-danger fs-7"
            }
        },
        "plugins": ["types", "dnd"]
    });
    
    // 양식을 선택하면 CKEDITOR에 양식 내용 삽입하기
    $('#formJstree').bind('select_node.jstree', function(event, data){
       // 노드를 선택했을 때 id = docFormNo 가져오기
       console.log(data.node.li_attr.value);
       let docFormNo = data.node.li_attr.value;
       
       $('#docFormNo').val(docFormNo);
       console.log("docFormNo : " + $('#docFormNo').val());
       
       $.ajax({
          url: "/company/proveSelectForm.do?docFormNo=" + docFormNo,
          type: "get",
          contentType : "application/json; charset=utf-8",
          success: function(res) {
             CKEDITOR.instances.provedocEditorCK.setData(res.docFormCn);
             
             // 회원의 정보를 증명서에 집어넣기
             // employeeVO;
         }
       });
    });
    
}

// HTML 생성 함수
function generateHTML(nodes) { 
    let html = ""; 
    nodes.forEach(node => {
        const isRoot = node.parent === "#";
        html += `<li data-jstree='{"type" : "\${node.type}"` + (', "opened": true') + `}' value='\${node.id}'>\${node.text}`;
        
        // 자식 노드가 있는 경우 
        if (node.children && node.children.length > 0) { 
            html += "<ul>" + generateHTML(node.children) + "</ul>"; // 자식 노드 재귀 호출
        }
        
        html += "</li>";
    });
    return html;
}

</script>
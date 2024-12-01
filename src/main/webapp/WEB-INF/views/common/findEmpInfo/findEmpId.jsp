<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>    
<!DOCTYPE html>
<html>
	<head>
	<base href="../../" />
		<title>GrouBear</title>
		<meta charset="utf-8" />
		<meta name="description" content="Good admin dashboard live demo. Check out all the features of the admin panel. A large number of settings, additional services and widgets." />
		<meta name="keywords" content="Good, bootstrap, bootstrap 5, admin themes, Asp.Net Core & Django starter kits, admin themes, bootstrap admin, bootstrap dashboard, bootstrap dark mode" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta property="og:locale" content="en_US" />
		<meta property="og:type" content="article" />
		<meta property="og:title" content="GrouBear" />
		<meta property="og:url" content="https://themes.getbootstrap.com/product/good-bootstrap-5-admin-dashboard-template" />
		<meta property="og:site_name" content="Good by Keenthemes" />
		<link rel="canonical" href="http://preview.keenthemes.comauthentication/sign-in/basic.html" />
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/design/media/logos/favicon.ico" />
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
		<link href="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/resources/design/css/style.bundle.css" rel="stylesheet" type="text/css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	</head>
	<body id="kt_body" class="app-blank">
		<div class="d-flex flex-column flex-root" id="kt_app_root">
			<div class="d-flex flex-column flex-lg-row flex-column-fluid">
				<div class="d-flex flex-column flex-lg-row-auto w-xl-600px positon-xl-relative" style="background-color: #f8f6f2;">
					<div class="d-flex flex-column position-xl-fixed top-0 bottom-0 w-xl-600px scroll-y">
						<div class="d-flex flex-row-fluid flex-center flex-column text-center p-5 p-lg-20">
							<a href="/groubear.do" class="py-9 pt-lg-20">
								<img alt="Logo" src="${pageContext.request.contextPath}/resources/design/media/logos/GrouBear.png" class="h-200px h-lg-230px" />
							</a>
						</div>
					</div>
				</div>
				<div class="d-flex flex-column flex-lg-row-fluid py-10">
					<div class="d-flex flex-center flex-column flex-column-fluid">
						<div class="w-lg-500px p-10 p-lg-15 mx-auto">
							<div class="text-center mb-10">
								<h1 class="text-gray-900 mb-3">아이디 찾기 </h1>
							</div>
								<div class="fv-row mb-10">
									<div class="d-flex flex-stack mb-2">
										<label class="form-label fw-bold text-gray-900 fs-6 mb-0">이름</label>
									</div>
									<input class="form-control form-control-lg form-control-solid" type="text" name="empNm" id="empNm" autocomplete="off"/>
									<div id="nm_null" style="color: red;"></div>
								</div>
								<div class="fv-row mb-10">
									<div class="d-flex flex-stack mb-2">
										<label class="form-label fw-bold text-gray-900 fs-6 mb-0">이메일</label>
									</div>
									<input class="form-control form-control-lg form-control-solid" type="text" name="empEmail" id="empEmail" autocomplete="off" />
									<div id="email_null" style="color: red;"></div>
								</div>
								<div class="text-center">
									<input type="button" class="btn btn-lg btn-primary w-100 mb-5" value="아이디 찾기" id="findIdBtn">
								</div>
							<div class="text-center text-muted text-uppercase fw-bold mb-5">
								<a href="/login.do" class="link-primary fs-6 fw-bold">로그인</a>
								<a>/</a>
								<a href="/findPw.do" class="link-primary fs-6 fw-bold">비밀번호 찾기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
<script type="text/javascript">
function emailchk() {
	
};
$(function () {
	var findIdBtn = $("#findIdBtn");
	$("#empEmail").focusout(function() {
		var emailCheck = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
	    if(!emailCheck.test($("#empEmail").val())) {
	  	  $("#email_null").text("이메일 형식에 맞춰 정확히 입력해주세요.");
	       return false;
	    }else{
	  	  $("#email_null").text("");
	    }
   	});
	
	findIdBtn.on("click",function(){
		var empNm = $("#empNm").val();
		var empEmail = $("#empEmail").val();
		
		if (empNm == null || empNm == "") {
	 		$("#nm_null").text("이름을 입력해주세요.");
            return false;
        }
		$("#nm_null").text("");
		if (empEmail == null || empEmail == "") {
			$("#email_null").text("이메일을 입력해주세요.");
            return false;
        }
		$("#email_null").text("");
		
		var emailCheck = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
	    if(!emailCheck.test($("#empEmail").val())) {
	  	  $("#email_null").text("이메일 형식에 맞춰 정확히 입력해주세요.");
	       return false;
	    }else{
	  	  $("#email_null").text("");
	    }
		// 아이디 찾기 ajax
		var formData = {
				empNm : empNm,
				empEmlAddr : empEmail
		};
		$.ajax({
			url: "/findId.do",
            type: "post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(formData),
            success: function(res){
            	Swal.fire({
	  				icon: 'success',
		  			title: '아이디 정보를 메일로 전송했습니다.',
		  			confirmButtonColor: '#4FC9DA',
				});
            },
            error: function(res){
            	if(res.responseText == "failed"){
            		Swal.fire({
    	  				icon: 'warning',
    		  			title: '일치하는 정보가 없습니다.',
    		  			confirmButtonColor: '#4FC9DA',
    				});		
            	}else{
            		Swal.fire({
    	  				icon: 'warning',
    		  			title: '메일 전송에 실패했습니다.',
    		  			confirmButtonColor: '#4FC9DA',
    				});
            	}
            }
       });
	});
});

</script>
<script>var hostUrl = "assets/";</script>
<script src="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.js"></script>
<script src="${pageContext.request.contextPath}/resources/design/js/scripts.bundle.js"></script>
<script src="${pageContext.request.contextPath}/resources/design/js/custom/authentication/sign-in/general.js"></script>
	</body>
</html>
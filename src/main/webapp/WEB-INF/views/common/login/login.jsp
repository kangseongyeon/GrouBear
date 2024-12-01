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
								<h1 class="text-gray-900 mb-3">Login </h1>
							</div>
							<form action="/login" method="post" id="loginForm">
								<div class="fv-row mb-10">
									<div class="d-flex flex-stack mb-2">
										<label class="form-label fw-bold text-gray-900 fs-6 mb-0">아이디</label>
									</div>
									<input class="form-control form-control-lg form-control-solid" type="text" name="username" id="empId" autocomplete="off" value="dditgh001"/>
									<div id="id_null" style="color: red;"></div>
								</div>
								<div class="fv-row mb-10">
									<div class="d-flex flex-stack mb-2">
										<label class="form-label fw-bold text-gray-900 fs-6 mb-0">비밀번호</label>
									</div>
									<input class="form-control form-control-lg form-control-solid" type="password" name="password" id="empPw" autocomplete="off"  value="1234"/>
									<div id="pw_null" style="color: red;"></div>
								</div>
								<div class="text-center">
									<input type="button" class="btn btn-lg btn-primary w-100 mb-5" value="로그인" id="loginBtn">
									<sec:csrfInput/>
								</div>
							</form>
							<div class="text-center text-muted text-uppercase fw-bold mb-5">
								<a href="/findId.do" class="link-primary fs-6 fw-bold">아이디 찾기</a>
								<a>/</a>
								<a href="/findPw.do" class="link-primary fs-6 fw-bold">비밀번호 찾기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
<script type="text/javascript">
$(function () {
    var loginBtn = $("#loginBtn");    // 로그인 버튼
    var loginForm = $("#loginForm");   // 로그인 폼
    
    var companyName = $("#companyName").val();
    var companyName = $("#companyName").val();
    var companyName = $("#companyName").val();
    var companyName = $("#companyName").val();
    var companyName = $("#companyName").val();
    var companyName = $("#companyName").val();
    var companyName = $("#companyName").val();
    var companyName = $("#companyName").val();
    var companyName = $("#companyName").val();
    var companyName = $("#companyName").val();
    var companyName = $("#companyName").val();
    
    
    
    
    function handleLogin() {
        let empId = $("#empId").val();
        let empPw = $("#empPw").val();
        console.log("버튼 클릭");
        if (empId == null || empId == "") {
            $("#id_null").text("아이디를 입력해주세요.");
            return false;
        }
        $("#id_null").text("");
        if (empPw == null || empPw == "") {
            $("#pw_null").text("비밀번호를 입력해주세요.");
            return false;
        }
        $("#pw_null").text("");

        var formData = {
            empId: empId,
            empPw: empPw
        };

        $.ajax({
            url: "/idchk",
            type: "post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(formData),
            success: function(res){
                loginForm.submit();            
            },
            error: function(){
                $("#pw_null").text("아이디/비밀번호가 잘못입력되었습니다.");
            }
        });
    }

    loginBtn.on("click", function() {
        handleLogin();
    });

    $(document).on("keydown", function(event) {
        if (event.key === "Enter") {
            event.preventDefault();
            handleLogin();
        }
    });

});

</script>
<script>var hostUrl = "assets/";</script>
<script src="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.js"></script>
<script src="${pageContext.request.contextPath}/resources/design/js/scripts.bundle.js"></script>
<script src="${pageContext.request.contextPath}/resources/design/js/custom/authentication/sign-in/general.js"></script>
	</body>
</html>
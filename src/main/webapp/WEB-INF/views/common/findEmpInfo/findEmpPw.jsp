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
								<h1 class="text-gray-900 mb-3">비밀번호 찾기 </h1>
							</div>
							<div id="sendAuthNum">
								<div class="fv-row mb-10">
									<div class="d-flex flex-stack mb-2">
										<label class="form-label fw-bold text-gray-900 fs-6 mb-0">이름</label>
									</div>
									<input class="form-control form-control-lg form-control-solid" type="text" name="empNm" id="empNm" autocomplete="off"/>
									<div id="id_null" style="color: red;"></div>
								</div>
								<div class="fv-row mb-10">
									<div class="d-flex flex-stack mb-2">
										<label class="form-label fw-bold text-gray-900 fs-6 mb-0">아이디</label>
									</div>
									<input class="form-control form-control-lg form-control-solid" type="text" name="empId" id="empId" autocomplete="off"/>
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
									<input type="button" class="btn btn-lg btn-primary w-100 mb-5" value="인증번호 발송" id="sendAuthNumBtn">
								</div>
							</div>

							<div id="chkAuthNum">
								<div class="fv-row mb-10">
									<div class="d-flex flex-stack mb-2">
										<label class="form-label fw-bold text-gray-900 fs-6 mb-0">인증번호</label>
									</div>
									<input class="form-control form-control-lg form-control-solid" type="text" name="authNum" id="authNum" autocomplete="off"/>
									<div id="authNum_null" style="color: red;"></div>
								</div>
								<div class="text-center">
									<input type="button" class="btn btn-lg btn-primary w-100 mb-5" value="인증번호 확인" id="authNumChkBtn">
								</div>
							</div>

							<div id="pwReset">
								<div class="fv-row mb-10">
									<div class="d-flex flex-stack mb-2">
										<label class="form-label fw-bold text-gray-900 fs-6 mb-0">새로운 비밀번호</label>
									</div>
									<input class="form-control form-control-lg form-control-solid" type="password" name="empPw" id="empPw" autocomplete="off"/>
									<div id="pw_null" style="color: red;"></div>
								</div>
								<div class="fv-row mb-10">
									<div class="d-flex flex-stack mb-2">
										<label class="form-label fw-bold text-gray-900 fs-6 mb-0">새로운 비밀번호 확인</label>
									</div>
									<input class="form-control form-control-lg form-control-solid" type="password" name="empPwChk" id="empPwChk" autocomplete="off"/>
									<div id="pwchk_null" style="color: red;"></div>
								</div>
								<div class="text-center">
									<input type="button" class="btn btn-lg btn-primary w-100 mb-5" value="비밀번호 변경" id="changePwBtn">
								</div>
							</div>
							<div class="text-center text-muted text-uppercase fw-bold mb-5">
								<a href="/login.do" class="link-primary fs-6 fw-bold">로그인</a>
								<a>/</a>
								<a href="/findId.do" class="link-primary fs-6 fw-bold">아이디 찾기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
<script type="text/javascript">
$(function () {
	var sendAuthNumBtn = $("#sendAuthNumBtn");
	var authNumChkBtn = $("#authNumChkBtn");
	var changePwBtn = $("#changePwBtn");
	
	
	var sendAuthNum = $("#sendAuthNum");
	var chkAuthNum = $("#chkAuthNum");
	var pwReset = $("#pwReset");
	
	
	var empNm = $("#empNm");
	var empId = $("#empId");
	var empEmail = $("#empEmail");
	var authNum = $("#authNum");
	var empPw = $("#empPw");
	var empPwChk = $("#empPwChk");
	
	
	
	chkAuthNum.hide();
	pwReset.hide();
	
	sendAuthNumBtn.on("click",function(){
		if (empNm.val() == "" || empNm.val() == null) {
			$("#nm_null").text("이름을 입력해주세요.");
            return false;
		}else{
			$("#nm_null").text("");
		}
		if (empId.val() == "" || empId.val() == null) {
			$("#id_null").text("아이디를 입력해주세요.");
            return false;
		}else{
			$("#nm_null").text("");
		}
		var emailCheck = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
	    if(!emailCheck.test(empEmail.val())) {
	  	  $("#email_null").text("이메일 형식에 맞춰 정확히 입력해주세요.");
	       return false;
	    }else{
	  	  $("#email_null").text("");
	    }
		
		
		var formData = {
				empNm : empNm.val(),
				empId : empId.val(),
				empEmlAddr : empEmail.val()
		}; 
		$.ajax({
			url: "/sendAuthNum.do",
            type: "post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(formData),
            success: function(res){
            	Swal.fire({
	  				icon: 'success',
		  			title: '인증번호를 발송하였습니다.',
		  			confirmButtonColor: '#4FC9DA',
				});
            	
            	sendAuthNum.hide();
            	chkAuthNum.show();
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
	
	authNumChkBtn.on("click",function(){
		if (authNum.val() == "" || authNum.val() == null) {
			$("#authNum_null").text("인증번호를 입력해주세요.");
            return false;
		}else{
			$("#authNum_null").text("");
		}

		var formData = {
				empId : empId.val(),
				authNum : authNum.val(),
		}; 
		$.ajax({
			url: "/chkAuthNum.do",
            type: "post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(formData),
            success: function(res){
            	Swal.fire({
	  				icon: 'success',
		  			title: '인증번호 인증에 성공했습니다.',
		  			confirmButtonColor: '#4FC9DA',
				});
            	chkAuthNum.hide();
            	pwReset.show();
            },
            error: function(res){
            	if(res.responseText == "different"){
            		Swal.fire({
    	  				icon: 'warning',
    		  			title: '인증번호가 일치하지 않습니다.',
    		  			confirmButtonColor: '#4FC9DA',
    				});		
            	}else{
            		Swal.fire({
    	  				icon: 'warning',
    		  			title: '인증번호 인증에 실패했습니다.',
    		  			confirmButtonColor: '#4FC9DA',
    				});
            	}
            }
       });
	});
	
	changePwBtn.on("click",function(){
				
		if (empPw.val() == "" || empPw.val() == null) {
			$("#pw_null").text("비밀번호를 입력해주세요.");
            return false;
		}else{
			$("#pw_null").text("");
		}
      var passwdCheck = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/);

      if(!passwdCheck.test(empPw.val())) {
    	  $("#pw_null").text("8~16자의 영문 대문자와 소문자, 숫자, 특수기호를 하나 이상 포함해야합니다.");
         return false;
      }else{
    	  $("#pw_null").text("");
      }
		if (empPw.val() != empPwChk.val()) {
			$("#pwchk_null").text("입력한 비밀번호가 다릅니다.");
            return false;
		}else{
			$("#pwchk_null").text("");
		}

		
		var formData = {
				empId : empId.val(),
				empPw : empPw.val(),
		}; 
		$.ajax({
			url: "/changePw.do",
            type: "post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(formData),
            success: function(res){
            	Swal.fire({
	  				icon: 'success',
		  			title: '비밀번호 변경에 성공했습니다.',
		  			confirmButtonColor: '#4FC9DA',
				}).then(function(){
					location.href = "/login.do";
				});
            	 
            },
            error: function(res){
           		Swal.fire({
   	  				icon: 'warning',
   		  			title: '비밀번호 변경을 실패했습니다.',
   		  			confirmButtonColor: '#4FC9DA',
   				});		
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
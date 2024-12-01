<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      <meta property="og:site_name" content="GrouBear" />
      <link rel="canonical" href="http://preview.keenthemes.comauthentication/sign-up/basic.html" />
      <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/design/media/logos/favicon.ico" />
      <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
      <link href="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
      <link href="${pageContext.request.contextPath}/resources/design/css/style.bundle.css" rel="stylesheet" type="text/css" />
      <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=loyalty" />
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
      <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
      <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
            
            <!--begin::Body-->
            <div class="d-flex flex-column flex-lg-row-fluid py-10">
               <!--begin::Content-->
               <div class="d-flex flex-center flex-column flex-column-fluid">
                  <!--begin::Wrapper-->
                  <div class="w-lg-600px p-10 p-lg-15 mx-auto">
                     <!--begin::Form-->
                     <form class="form w-100" novalidate="novalidate" data-kt-redirect-url="authentication/sign-in/basic.html" id="kt_sign_up_form">
                        <!--begin::Heading-->
                        <div class="mb-10 text-center">
                           <!--begin::Title-->
                           <h1 class="text-gray-900 mb-3" >기업 회원가입</h1>
                           <h4 id="companyInfo"></h4>
                           <!--end::Title-->
                        </div>
                        <!--end::Heading-->
                        
                        <!--begin::Input group-->
                        <div id="chkBrno">
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">기업명<span style="color: red;">*</span></label>
                              <input class="form-control form-control-lg form-control-solid" type="text" value="미트가이드에프앤비(F&B)" name="companyName" id="companyName" autocomplete="off" />
                              <span id="companyName_chk" style="color: red;"></span>
                           </div>
                           <!--end::Input group-->
                           <!--begin::Input group-->
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">사업자 등록 번호<span style="color: red;">*</span></label>
                              <input class="form-control form-control-lg form-control-solid" type="text" value="704-08-02479" name="companyBrno" id="companyBrno" autocomplete="off" />
                              <span id="companyBrno_chk" style="color: red;"></span>
                           </div>
                           <!--end::Input group-->
                           <!--begin::Input group-->
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">대표자명<span style="color: red;">*</span></label>
                              <input class="form-control form-control-lg form-control-solid" type="text" value="주강수" name="ceoName" id="ceoName" autocomplete="off" />
                              <span id="ceoName_chk" style="color: red;"></span>
                           </div>
                           <!--end::Input group-->
                           <!--begin::Input group-->
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">개업일자<span style="color: red;">*</span></label>
                              <input class="form-control form-control-lg form-control-solid" type="date" value="2023-11-15" name="openDate" id="openDate" autocomplete="off" />
                              <span id="openDate_chk" style="color: red;"></span>
                           </div>
                           <div class="text-center" id="search_bt">
                              <button type="button" id="companyBrno_search" class="btn btn-lg btn-primary">
                                 <span class="indicator-label">조회</span>
                              </button>
                           </div>
                        </div>
                        
                        <div id="addInfo">
                           <div class="fv-row mb-7" >
                              <label class="form-label fw-bold text-gray-900 fs-6">기업관리자 아이디<span style="color: red;">*</span></label>
                              <input class="form-control form-control-lg form-control-solid" type="text" value="meatguide" name="companyid" id="companyid" autocomplete="off" />
                              <span id="companyid_chk" style="color: red;"></span>
                           </div>
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">기업관리자 비밀번호<span style="color: red;">*</span></label>
                              <input class="form-control form-control-lg form-control-solid" type="password" value="Qwe123!@#" name="companypw" id="companypw" autocomplete="off" />
                              <span id="companypw_chk" style="color: red;"></span>
                           </div>
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">기업관리자 비밀번호 확인<span style="color: red;">*</span></label>
                              <input class="form-control form-control-lg form-control-solid" type="password" value="Qwe123!@#" name="companypwchk" id="companypwchk" autocomplete="off" />
                              <span id="companypwchk_chk" style="color: red;"></span>
                           </div>
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">기업관리자 이메일<span style="color: red;">*</span></label>
                              <input class="form-control form-control-lg form-control-solid" type="text" value="meatguide@meatguide.com" name="companyemail" id="companyemail" autocomplete="off" />
                              <span id="companyemail_chk" style="color: red;"></span>
                           </div>
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">기업 전화번호</label>
                              <input class="form-control form-control-lg form-control-solid" type="tel" value="050714558964" name="comTel" id="comTel" autocomplete="off" />
                              <span id="openDate_chk" style="color: red;"></span>
                           </div>
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">기업 우편번호<span style="color: red;">*</span></label>
                              <div class="d-flex align-items-center position-relative my-1">   
                                 <input class="form-control form-control-md form-control-solid" type="text" value="42490" name="companyzip" id="companyzip" autocomplete="off" readonly/>
                                 <input type="button" class="btn btn-primary" value="검색" onclick="DaumPostcode()" >
                              </div>
                              <span id="companyzip_chk" style="color: red;"></span>
                           </div>
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">기업 주소<span style="color: red;">*</span></label>
                              <input class="form-control form-control-lg form-control-solid" type="text" value="대구광역시 남구 대명동 646-26" name="companyaddr" id="companyaddr" autocomplete="off"  readonly/>
                              <span id="companyaddr_chk" style="color: red;"></span>
                           </div>
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">기업 상세주소</label>
                              <input class="form-control form-control-lg form-control-solid" type="text" placeholder="" name="companydaddr" id="companydaddr" autocomplete="off" />
                              <span id="companydaddr_chk" style="color: red;"></span>
                           </div>
                           <div class="text-center" >
                           <button type="button" id="signup_bt" class="btn btn-lg btn-primary">
                              <span class="indicator-label">가입하기</span>
                           </button>
                        </div>
                        </div>
                        <!--end::Input group-->
                        <br>
                        <div id="pay">
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">GROUBEAR를 사용할 구성원은 몇 명인가요?<span style="color: red;">*</span></label>
                              <select class="form-select form-select-solid" data-control="select2" data-placeholder="인원수를 선택해주세요." data-hide-search="true" id="select_Per">
                                  <option></option>
                                  <option value="10" selected="selected">10명</option>
                                  <option value="20">20명</option>
                                  <option value="30">30명</option>
                                  <option value="40">40명</option>
                                  <option value="50">50명</option>
                                  <option value="100">50~100명</option>
                                  <option value="150">100~150명</option>
                                  <option value="200">150~200명</option>
                                  <option value="250">200~250명</option>
                                  <option value="300">250~300명</option>
                                  <option value="etc">직접 입력</option>
                              </select>
                           </div>
                           <div class="fv-row mb-7" id="insertPer">
                              <label class="form-label fw-bold text-gray-900 fs-6">인원수를 입력해주세요.(10단위로 300명이상)<span style="color: red;">*</span></label>
                              <input class="form-control form-control-lg form-control-solid" type="text" placeholder="" name="inputPer" id="inputPer" autocomplete="off" />
                              <span id="inputPer_chk" style="color: red;"></span>
                           </div>
                           <div class="fv-row mb-7">
                              <label class="form-label fw-bold text-gray-900 fs-6">개월 수를 입력해주세요.<span style="color: red;">*</span></label>
                              <input class="form-control form-control-lg form-control-solid" type="number" placeholder="" value="1" name="inputMonth" id="inputMonth" autocomplete="off" />
                              <span id="inputMonth_chk" style="color: red;"></span>
                           </div>
                           <div class="row">
                                 <div class="col-lg-6">
                                    <!--begin::Option-->
                                    <input type="radio" class="btn-check" name="account_type" value="basic" checked="checked" id="kt_create_account_form_account_type_personal" />
                                    <label class="btn btn-outline btn-outline-dashed btn-active-light-primary p-7 d-flex align-items-center mb-10" for="kt_create_account_form_account_type_personal">
                                       <i class="ki-duotone ki-badge fs-3x me-5">
                                          <span class="path1"></span>
                                          <span class="path2"></span>
                                          <span class="path3"></span>
                                          <span class="path4"></span>
                                          <span class="path5"></span>
                                       </i>
                                          <!--begin::Info-->
                                          <span class="d-block fw-semibold text-start">
                                          <span class="text-gray-900 fw-bold d-block fs-4 mb-2">Basic  ₩3,000</span>
                                          <span class="text-muted fw-semibold fs-6">그루베어의 기본기능만 사용 가능</span>
                                       </span>
                                       <!--end::Info-->
                                    </label>
                                    <!--end::Option-->
                                 </div>
                                 <div class="col-lg-6">
                                    <input type="radio" class="btn-check" name="account_type" value="premium" id="kt_create_account_form_account_type_corporate" />
                                       <label class="btn btn-outline btn-outline-dashed btn-active-light-primary p-7 d-flex align-items-center" for="kt_create_account_form_account_type_corporate">
                                       <i class="ki-duotone ki-badge fs-3x me-5">
                                          <span class="material-symbols-outlined">
                                             loyalty
                                          </span>
                                       </i>
                                       <!--begin::Info-->
                                       <span class="d-block fw-semibold text-start">
                                          <span class="text-gray-900 fw-bold d-block fs-4 mb-2">Premium  ₩5,000</span>
                                          <span class="text-muted fw-semibold fs-6">그루베어의 기본기능과 추가기능 사용 가능</span>
                                       </span>
                                       <!--end::Info-->
                                    </label>
                                 <!--end::Option-->
                              </div>
                           </div>
                           <div class="text-center">
                              <button type="button" id="pay_bt" class="btn btn-lg btn-primary">
                                 <span class="indicator-label">결제하기</span>
                              </button>
                           </div>
                        </div>
                     </form>
                  </div>
               </div>
            </div>
         </div>
      </div>
<script type="text/javascript">
$(function () {
   var companyBrno_search = $("#companyBrno_search"); //사업자번호 조회 버튼
   var signup_bt = $("#signup_bt");
   var chkBrno = $("#chkBrno");
   var addInfo = $("#addInfo");
   var pay = $("#pay");
   var insertPer = $("#insertPer");
   var select_Per = $("#select_Per");
   var inputPer = $("#inputPer");
   var inputPer_chk = $("#inputPer_chk");
   
   addInfo.hide();
   pay.hide();
   insertPer.hide();
   
   //아이디
   var companyid = $("#companyid");
   var companyid_chk = $("#companyid_chk");
   
   //비밀번호
   var companypw = $("#companypw");
   var companypw_chk = $("#companypw_chk");
   
   //비밀번호 체크
   var companypwchk = $("#companypwchk");
   var companypwchk_chk = $("#companypwchk_chk");
   
   var companyemail = $("#companyemail");
   var companyemail_chk = $("#companyemail_chk");
   
   $("#companyBrno").focusout(function() {
      var brnoCheck = RegExp(/\d{3}-\d{2}-\d{5}/g);
      var Brno = $("#companyBrno").val();
      if(!brnoCheck.test(Brno)) {
         $("#companyBrno_chk").text("000-00-00000 형식만 입력 가능합니다.");
         signupChk = false;
      }else{
         $("#companyBrno_chk").text("");
         signupChk = true;
      }
      var formData = {
         coBrno : Brno
      };
      $.ajax({
            url: "/brnochk",
            type: "post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(formData),
            success: function(res){
                console.log("success");
                $("#companyBrno_chk").text("");
            },
            error: function(){
               $("#companyBrno_chk").text("이미 등록된 사업자등록번호입니다.");
            }
        });
      
   });
   
   companyBrno_search.on("click", function(){
      var companyName = $("#companyName").val();   //기업명
      var companyBrno = $("#companyBrno").val();   //사용자 등록 번호
      var ceoName = $("#ceoName").val();   //대표자명
      var openDate = $("#openDate").val();   //개업일자
      
      var offset = $("#openDate").offset(); //해당 위치 반환
       
      
      if(companyName == null || companyName == ""){
         console.log("Name_null");
          $("#companyName_chk").text("기업명을 입력해주세요.");
         return false;
      }
      $("#companyName_chk").text("");
      
      if(companyBrno == null || companyBrno == ""){
         console.log("Name_null");
          $("#companyBrno_chk").text("사업자등록번호를 입력해주세요.");
         return false;
      }
      $("#companyBrno_chk").text("");
      
      if(ceoName == null || ceoName == ""){
         console.log("Name_null");
          $("#ceoName_chk").text("대표자명을 입력해주세요.");
         return false;
      }
      $("#ceoName_chk").text("");
      
      if(openDate == null || openDate == ""){
         console.log("Name_null");
          $("#openDate_chk").text("개업일자를 입력해주세요.");
         return false;
      }
      $("#openDate_chk").text("");

      companyBrno = companyBrno.replaceAll("-","");
      
      var data = {
           "b_no": [companyBrno],
           "start_dt": [openDate],
           "p_nm": [ceoName],
           "b_nm": [companyName]
       };
       
       $.ajax({
          url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=TxtZgQC4DDxxTYL3gYdIgmR6WCZQjJ%2F7bdMtgk%2B7WIOh%2FmQLKWRQW707%2BLHV6DfGoPHwkDLFQjp19rPF%2BJc%2FKw%3D%3D",  // serviceKey 값을 xxxxxx에 입력
           type: "POST",
           data: JSON.stringify(data),
           dataType: "JSON",
           traditional: true,
           contentType: "application/json; charset:UTF-8",
           accept: "application/json",
           success: function(result) {
               console.log(result);
               if(result.match_cnt == "1") {
                   console.log("success");
                   $("#companyInfo").text("기업명 : " + companyName + " / 사업자 등록 번호 : " + companyBrno);
                   chkBrno.hide();
                   addInfo.show();
                   $("html, body").animate({scrollTop: offset.top},0);
                   
               } else {
                   Swal.fire({
                    title: '국세청에 등록되지 않은 사업자등록번호입니다.',
                    icon: 'warning',
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: '확인',
                    reverseButtons: false
                 });
                   
               }
           },
           error: function(result) {
               console.log("error");
               console.log(result.responseText); //responseText의 에러메세지 확인
               chkBrno.hide();
                addInfo.show();
                $("html, body").animate({scrollTop: offset.top},400);
                
           }
       });
   });
   
   
   
   var boolid = false;
   var boolpw = false;
   var boolpwchk = false;

   companyid.focusout(function() {
      var userIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/);

      if(!userIdCheck.test(companyid.val())) {
         companyid_chk.text("5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
         boolid = false;
      }else{
         companyid_chk.text("");
         boolid = true;
      }
      var formData = {
            empId : companyid.val()
      };
      $.ajax({
            url: "/signupidchk",
            type: "post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(formData),
            success: function(res){
                console.log("success");
                companyid_chk.text("");
            },
            error: function(){
               companyid_chk.text("이미 등록된 아이디입니다.");
            }
      }); 
   });
   companypw.focusout(function() {
      var passwdCheck = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/);

      if(!passwdCheck.test(companypw.val())) {
         companypw_chk.text("8~16자의 영문 대문자와 소문자, 숫자, 특수기호를 하나 이상 포함해야합니다.");
         boolpw = false;
      }else{
         companypw_chk.text("");
         boolpw = true;
      }
   });
   companypwchk.focusout(function() {
      if(companypwchk.val() != companypw.val()) {
         companypwchk_chk.text("입력한 비밀번호가 틀립니다.");
         boolpwchk = false;
      }else{
         companypwchk_chk.text("");
         boolpwchk = true;
      }
   });
   
   companyemail.focusout(function() {
      var emailCheck = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
      if(!emailCheck.test(companyemail.val())) {
         companyemail_chk.text("이메일 형식에 맞춰 정확히 입력해주세요.");
      }else{
         companyemail_chk.text("");
      }   
   })
   
   
   signup_bt.on("click", function() {
      var companyzip = $("#companyzip").val();
      if (!boolid) {
         companyid.focus();
         return false;
      }
      if (!boolpw) {
         companyid.focus();
         return false;
      }
      if (!boolpwchk) {
         companyid.focus();
         return false;
      }
       if(companyzip == null || companyzip == ""){
          $("#companyzip_chk").text("우편번호를 검색해주세요.");
         return false;
      }
      $("#companyzip_chk").text("");
      
      addInfo.hide();
      pay.show();
   });
   
   select_Per.on("change",function(){
      console.log(select_Per.val());
      if (select_Per.val() == "etc") {
         insertPer.show();
      }else {
         insertPer.hide();
      }
   });
   
   inputPer.focusout(function () {
      var perval = inputPer.val();
      if (perval%10 > 0) {
         inputPer_chk.text("10명 단위로 입력해주세요.");
         return false;
      }
      inputPer_chk.text("");
      if (perval <= 300) {
         inputPer_chk.text("300명 이상 입력해주세요.");
         return false;   
      }
      inputPer_chk.text("");
   })   
   
   var inputMonth = $("#inputMonth");
   inputMonth.focusout(function() {
      var inputMonth_val = $("#inputMonth").val();
      console.log(inputMonth_val);
      if(inputMonth_val < 1){
         $("#inputMonth_chk").text("1개월 이상 입력해주세요.");
         return false;      
      }
      $("#inputMonth_chk").text("");
   });
   
   
   
   //결제
   var pay_bt = $("#pay_bt");
   pay_bt.on("click",function(){
        //merchant_uid
        var today = new Date();
        var year = today.getFullYear();
        var month = ('0' + (today.getMonth() + 1)).slice(-2);
        var day = ('0' + today.getDate()).slice(-2);
        var hours = ('0' + today.getHours()).slice(-2); 
        var minutes = ('0' + today.getMinutes()).slice(-2);
        var seconds = ('0' + today.getSeconds()).slice(-2); 
        var mer_uid = year+month+day+ hours+minutes+ seconds;
      
        // 상품 등급
        var acc_value = $('input:radio[name=account_type]:checked').val();
        
        // 인원수
        var per_val ="";
      	if($("#select_Per").val() != "etc"){
        	per_val = $("#select_Per").val();
      	}else {
        	per_val = inputPer.val();
      	}
           
        // 상품명
        var prod_nm = "GrouBear_"+$("#companyName").val()+"_"+acc_value+"_"+per_val+"_"+month+"월";
        
        // 구매자 이메일
        var email = companyemail.val();
        
        //구매자명
        var buyerName = $("#companyName").val();
        
        //구매자 전화번호 
        var buyerTel = $("#comTel").val();
        
        // 주소
  		var addr = $("#companyaddr").val();      
        
        // 상세주소
        var daddr = $("#companydaddr").val();
        
        // 구매자 주소
      	var buyerAddr = addr + daddr;
        
        // 구매자 우편번호
        var buyerZip = $("#companyzip").val();
        
        // 금액
        var price = 0;
        if(acc_value == "premium"){
           price = per_val*5000; 
        }else {
           price = per_val*3000;
      	}
        
        // 기업명
        var coNm = $("#companyName").val();
       
        // 사업자 등록번호
        var coBrno = $("#companyBrno").val(); 
        
        //대표자명
        var ceoNm = $("#ceoName").val(); 
 		
        
        
        
      var IMP = window.IMP;
        IMP.init("imp66648541");
      
        IMP.request_pay({
        	pg: "kakaopay.TCSUBSCRIP",
            pay_method: "card",
            merchant_uid: mer_uid, 
            name: prod_nm,
            amount: price,
            buyer_email: email,
            buyer_name: buyerName,
            buyer_tel: buyerTel,
            buyer_addr: buyerAddr,
            buyer_postcode: buyerZip,
        },
        function (rsp) {
        	if (rsp.success) {
				var rspData = {
					// 기업
					coNm : 	coNm,
					coBrno : coBrno,
					ceoNm : ceoNm,
					coZip : buyerZip, 
					coAddr : addr,
					coDaddr : daddr,
					coTel : buyerTel,
					coCnt : per_val,
					
					// 사원
					empId : companyid.val(),
					empPw : companypw.val(),
					empEmlAddr : $("#companyemail").val(),
					
					// 정기 결제 정보
					gdsNm : prod_nm,
					rglstlmstplprd : $("#inputMonth").val(),
					stlmdt : day,
					price : price,
					acc_value : acc_value
				};
				 $.ajax({
		            url: "/paymentsuccess",
		            type: "post",
		            contentType: "application/json; charset=utf-8",
		            data: JSON.stringify(rspData),
		            success: function(res){
		            		  Swal.fire({
					  				icon: 'success',
						  			title: '결제 성공했습니다.',
						  			confirmButtonColor: '#4FC9DA',
								}).then(function(){
									location.href = "/login.do";
								});
		            		  
					
		            },
		            error: function(){
		            	Swal.fire({
			  				icon: 'warning',
				  			title: '결제 실패 다시 시도해주세요.',
				  			confirmButtonColor: '#4FC9DA',
						});
		            }
		        });
           	  
			}else{
  				Swal.fire({
	  				icon: 'warning',
		  			title: '결제 실패 다시 시도해주세요.',
		  			confirmButtonColor: '#4FC9DA',
				});
 			}
           }
         );
   });
   
}); 
function DaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('companyzip').value = data.zonecode;
            document.getElementById("companyaddr").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("companydaddr").focus();
        }
    }).open();
}
</script>      

<script>var hostUrl = "assets/";</script>
<script src="${pageContext.request.contextPath}/resources/design/plugins/global/plugins.bundle.js"></script>
<script src="${pageContext.request.contextPath}/resources/design/js/scripts.bundle.js"></script>
<script src="${pageContext.request.contextPath}/resources/design/js/custom/authentication/sign-up/general.js"></script>
<!--end::Custom Javascript-->
<!--end::Javascript-->
</body>
   <!--end::Body-->
</html>
   
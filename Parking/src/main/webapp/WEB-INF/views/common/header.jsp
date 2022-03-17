<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!--jstl 커스텀액션사용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- jstl fmt 날짜시간등포맷 형식 -->
<c:set var="path" value="${pageContext.request.contextPath }"/> <!-- path 경로설정 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${param.title }"/></title>
<link rel="stylesheet" href="${path }/resources/css/parking.css">
<!-- BootStrap -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- jquery -->
<script src="${path }/resources/js/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>
<body>
<div id="full-wrap">
<header>
	<div id="header-wraper">
		<div id="header-wraper2">
			<c:if test="${loginMember==null }">
				<div id="loginbtn">
					<button type="button" id="kakaologinbtn" onclick="kakaoLogin();"><img src="${path }/resources/img/login-icon.png" id="login-img"></button>
					<form action="${path }/car/kakaoLoginCheck.do" method="post" id="kakoLoginCheckform" name="kakoLoginCheckform">
						<!-- <input type="hidden" id="kakao_id" name="kakao_id">
						<input type="hidden" id="kakao_email" name="kakao_email"> -->
						<input type="hidden" id="kakao_name" name="kakao_name">
					</form>
				</div>
			</c:if>
			<c:if test="${loginMember!=null }">
				<div id="loginbtn">
					<span id="loginName"><c:out value="${loginMember }"/></span>
				</div>
			</c:if>
				<br>
				<form action="${path }/car/inputCar.do" method="post">
					<div id="number-input">
						<input type="tel" name="InCarNum1" class="form-control form-control-lg" maxlength="1" min="0" max="9" onlyNember required>
						<input type="tel" name="InCarNum2" class="form-control form-control-lg" maxlength="1" min="0" max="9" onlyNember required>
						<input type="tel" name="InCarNum3" class="form-control form-control-lg" maxlength="1" min="0" max="9" onlyNember required>
						<input type="tel" name="InCarNum4" class="form-control form-control-lg" maxlength="1" min="0" max="9" onlyNember required>
					</div>
					<div id="car-state">
						<label style="font-size: 25pt;"><input class="car-state-input" type="radio" name="state" value="혼주"/>혼주</label>
						<label style="font-size: 25pt;"><input class="car-state-input" type="radio" name="state" value="상담"/>상담</label>
						<label style="font-size: 25pt;"><input class="car-state-input" type="radio" name="state" value="요금X"/>요금X</label>
					</div>
					<div id="input-button">
						<button type="submit" id="car-input-btn" class="btn btn-outline-success">등록</button>
					</div>
						<input type="hidden" name="loginMember" value="${loginMember }">
				</form>
				<%-- <div>
					<button id="greenbtn" onclick="home();"><img src="${path }/resources/img/green.png" class="colorbtn"></button>
					<button id="redbtn"><img src="${path }/resources/img/red.png" class="colorbtn"></button>
				</div> --%>
		</div>
	</div>
</header>
<script>
	Kakao.init('acce3b95b0d2e79d3718ac81746afc76'); //js 인증키 입력
	console.log(Kakao.isInitialized()); //sdk초기화여부판단
	
	//카카오 로그인
	function kakaoLogin() {
		 Kakao.Auth.login({
			 success: function(response) {
				 Kakao.API.request({
					 url:'/v2/user/me',
					 success: function(response){
						 	/* var userId = response.id;
						 	var userEmail = response.kakao_account.email; */
						 	var userName= response.properties.nickname;
						 	
						 	/* console.log(userId);
						 	console.log(userEmail);
						 	console.log(response.kakao_aacount); */
						 	console.log(userName);
						 	
						 	/* kakoLoginCheckform.kakao_id.value=userId;
						 	kakoLoginCheckform.kakao_email.value=userEmail; */
						 	kakoLoginCheckform.kakao_name.value=userName;
						 	kakoLoginCheckform.submit();
					 },
					 fail: function(error){
						 console.log(error)
					 },
				 })
			 },
			 fail: function(error) {
				 console.log(error)
			 },
		 })
	}
	
	//카카오로그아웃  
	function kakaoLogout() {
	    if (Kakao.Auth.getAccessToken()) {
	      Kakao.API.request({
	        url: '/v1/user/unlink',
	        success: function (response) {
	        	console.log(response)
	        },
	        fail: function (error) {
	          console.log(error)
	        },
	      })
	      Kakao.Auth.setAccessToken(undefined)
	    }
	  }
	
	//input 숫자만, 다음 input 넘어가기
	$(function(){
		$(document).on("keypress keyup keydown", "input[onlyNember]", function(e){
			console.log(e.which);
			if(/[a-z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g.test(this.value)){//한글 막기
				e.preventDefault();
				this.value="";
			}else if(e.which != 8 && e.which != 0 //영문 e 막기
					 && e.which < 48 || e.which > 57    //숫자키만 받기
			         && e.which < 96 || e.which > 105){ //텐키 받기
				e.preventDefault();
	            this.value = "";
			}else if (this.value.length >= this.maxLength){ //1자리 이상 입력되면 다음 input으로 이동시키기
	            this.value = this.value.slice(0, this.maxLength);
	            if($(this).next("input").length > 0){
	                $(this).next().focus();
	            }else{
	                $(this).blur();
	            }
	        }
		});
	});
	
	/* //home btn
	function home(){
		location.href="${path}/car/home.do";
	} */
</script>
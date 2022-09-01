<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
	<!-- Font Awesome icons (free version)-->
	<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
 	<!-- Google fonts-->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />

	<!-- Core theme CSS (includes Bootstrap)-->
	<link href="css/styles.css" rel="stylesheet" />
	<link href="css/button.css" rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
	<script src="https://apis.google.com/js/api:client.js"></script>
<script type="text/javascript" src="./js/jquery-3.6.0.js"></script>
<style type="text/css">
.flex-container {
	display: flex;
}

.flex-container>div {
	
	height: 100%;
	width: 50%;
	padding: 20px;
	font-size: 30px;
	text-align: center;
	border: 1px solid;
	border-bottom: 0;
}
#slmpleLog{
border-left: 0;

}

#log{
		border-right: 0;
}
.login-container {
	height: 650px;
	margin: 0 auto;
	padding-top:25px;
	width: 995px;
	font-size: 30px;
}

.buttonResult {
	
	width: 100%;
	height: 550px;
	/*	 padding: 20px; */
	text-align: center;
}

.buttonResult2 {
	
	width: 100%;
	height: 550px;
	/* 	padding: 20px; */
	
	text-align: center;
}

#iframe01 {
	width: 400px;
	height: 75px;
	margin-top: 100px;
}

#iframe02 {
	width: 400px;
	height: 75px;
}

#iframe03 {
	width: 400px;
	height: 75px;
}

#iframe2 {
	height: 500px;
	margin-top: 100px;
}
</style>
<script type="text/javascript">
	$(function() {
		var div1 = document.getElementById('login');
		var div2 = document.getElementById('slmpl');
		$("#log").text("로그인");
		$("#slmpleLog").text("간편로그인");
		div2.style.display = 'none';
		div1.style.display = 'block';
		$("#log").click(function() {
			div2.style.display = 'none';
			div1.style.display = 'block';
			// btn1 숨기기 (display: none)
			if (div2.style.display !== 'none') {
				div2.style.display = 'none';
			}
			// btn` 보이기 (display: block)
			else {
				div1.style.display = 'block';
			}

		});
		$("#slmpleLog").click(function() {
			div1.style.display = 'none';
			div2.style.display = 'block';
			// btn1 숨기기 (display: none)
			if (div1.style.display !== 'none') {
				div1.style.display = 'none';
			}
			// btn` 보이기 (display: block)
			else {
				div2.style.display = 'block';
			}

		});
		// 토글 할 버튼 선택 (btn1)

	});
</script>
</head>
<body>
	<!-- 헤더 들어가는곳 -->
	<jsp:include page="../inc/header.jsp" flush="false" />
	<!-- 헤더 들어가는곳 -->

	<div class="login-container">
		<div class="flex-container">
			<div id="log"></div>
			<div id="slmpleLog"></div>
		</div>
		<div class="buttonResult" id="slmpl">
<!-- 			<iframe name="iframe1" id="iframe01" src="MemberNaverForm.me" -->
<!-- 				frameborder="0" cellspacing="0"></iframe> -->
		    <jsp:include   page="naverlogin.jsp"></jsp:include>
			<br>
<!-- 			<iframe name="iframe1" id="iframe02" src="MemberKakaoForm.me" -->
<!-- 				frameborder="0" cellspacing="0"></iframe> -->
  			<jsp:include  page="kakao.jsp"></jsp:include>
			<br>
<!-- 			<iframe name="iframe1" id="iframe03" src="MemberGoogleForm.me" -->
<!-- 				frameborder="0" cellspacing="0"></iframe> -->
  			<jsp:include  page="google.jsp"></jsp:include>
			<br>
		</div>
		<div class="buttonResult2" id="login">
			<form action="MemberLoginPro.me" method="post"  >
			
				<div class="form-floating mb-3" style="margin-top: 50px;">
					 <input class="form-control" type="text" name="email" placeholder="이메일"
						required="required">
						<label>email</label>
				</div >
				<div class="form-floating mb-3">
					 <input class="form-control"  type="password" name="passwd" placeholder="패스워드"
						required="required"><label>비밀번호</label>
				</div>
		
				<div>
				<input class="w-btn-outline w-btn-green-outline" type="submit" value="로그인" style="">
				<span style="margin: 40px 40px auto"></span>
				<button  class="w-btn-outline w-btn-green-outline"  onclick="">회원가입</button>
				</div> 
			</form>

			<div style="text-align:center;">
			<a href="MemberFindPasswordForm.me" >비밀번호 찾기</a>
			</div>
		</div>
	</div>

	<!-- 푸터 들어가는곳 -->
	<jsp:include page="../inc/footer.jsp" flush="false" />
	<!-- 푸터 들어가는곳 -->
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>

	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>
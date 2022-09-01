<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<style type="text/css">
#container {
/* 	border: 1px solid #ccc; */
	width: 995px;
	margin: 0 auto;
/* 	display: flex; */
	padding-top: 20px;
	padding-bottom: 20px;
	text-align: center;
	
}

</style>
</head>
<body>
	<!-- 헤더 들어가는곳 -->
	<jsp:include page="../inc/header.jsp" flush="false" />
	<!-- 헤더 들어가는곳 -->
	<div id="container">
	
<form action="MemberFindPasswordPro.me" method="get">
<h3>찾으실 이메일을 적어주세요</h3><br>
<div class="form-floating mb-3">
<input class="form-control" type="text" id="email" name="email" placeholder="이메일">
<label>Email</label>
</div>

<input class="w-btn-outline w-btn-green-outline"   type="submit" value="비밀번호 찾기">

</form>

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
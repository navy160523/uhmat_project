<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Luckiest+Guy&family=Poor+Story&display=swap" rel="stylesheet">
<link href="css/adminManageMent.css" rel="stylesheet">
</head>
<body>
<div align="center">
<input type="button" value="홈" onclick="location.href='main.jsp'" class="before_next">
	<a href="" class="before_next">관리자뷰</a>
	<a href="AllBoardList.ad" class="before_next">모든게시물</a>
	<a href="AdminManageMemberList.ad" class="before_next">회원관리</a>
<div>회원정보 수정
<iframe src="AdminManageMemberList.ad" width="100%" height="500"  ></iframe>
</div>

<div>게시글 정보 수정
<iframe src="AllBoardList.ad" width="100%" height="500"></iframe>
</div>
</div>
</body>
</html>
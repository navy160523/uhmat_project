<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="button" value="홈" onclick="location.href='main.jsp'">
	<a href="">관리자뷰</a>
	<a href="AllBoardList.ad">모든게시물</a>
	<a href="AdminManageMemberList.ad">회원관리</a>
<div>회원정보 수정
<iframe src="Admin.ad" width="100%" height="500" ></iframe>
</div>

<div>게시글 정보 수정
<iframe src="AllBoardList.ad" width="100%" height="500"></iframe>
</div>
</body>
</html>
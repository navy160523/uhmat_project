<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>Insert title here</title> 
 <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  <script type="text/javascript" src="../js/jquery-3.6.0.js"></script>
  <style type="text/css">
  iframe {
  border: 1px solid;
  width: 150px; 
  height:70px;
  }
  </style>
</head>
<body>


<div>
<iframe name="iframe1" id="iframe1" src="MemberNaverForm.me"  frameborder="0" cellspacing="0"></iframe>
<iframe name="iframe1" id="iframe1" src="MemberKakaoForm.me"  frameborder="0" cellspacing="0"></iframe>
<iframe name="iframe1" id="iframe1" src="MemberGoogleForm.me"  frameborder="0" cellspacing="0"></iframe>
</div>


<c:choose>
			<c:when test="${empty sessionScope.sEmail}">
				<a href="MemberLoginForm.me">로그인</a> | <a href="MemberJoinForm.me">회원가입</a>
			</c:when>
			<c:otherwise>
				<%-- 하이퍼링크에 자바스크립트 함수 연결 시 href 속성에 아무 경로도 지정하지 않는 방법 --%>
				<a href="MemberDetailForm.me?email=${sessionScope.sEmail }">${sessionScope.sEmail } 님 </a>  | <a href="MemberLogout.me" >로그아웃</a>
				<%-- 세션 아이디가 "admin" 일 때만 관리자페이지 링크("AdminMain.me") 표시 --%>
				<c:if test="${sessionScope.sEmail eq 'admin'}"> | <a href="AdminMain.me">관리자페이지</a></c:if>
			</c:otherwise>
</c:choose>
<hr>
 <nav>
 	<details> <!-- 음식카테고리 리스트 -->
 		<summary>음식카테고리</summary>
 		<a href="RestaurantInfo.re">음식으로 보기</a>
 		<a href="ReviewList.re">리뷰로 보기</a>
 		<a href="#">지도로 보기</a>
 	</details>
 </nav>




<h3> <a href="NoticeList.sc">Notice</a></h3>
<h3> <a href="FAQList.sc">FAQ</a></h3>
 <h3><a href="MateWriteForm.co">글쓰기</a></h3>
<h3><a href="MateList.co">글목록</a></h3>




</body>
</html>   
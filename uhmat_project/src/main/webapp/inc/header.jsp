<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/header.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/5382a0d7e0.js" crossorigin="anonymous"></script>

<script type="text/javascript">
	function confirmLogout() {
		if(confirm("로그아웃 하시겠습니까?")) { // 확인 : true, 취소 : false 리턴됨
			// MemberLogout.me 포워딩
			location.href = "MemberLogout.me";
		}
	}
</script> 
</head>
<body>
<div id="container">
	<header>
		<!-- 로고 들어가는 곳 -->
    	<div class="mainLogo">
    		<a href="main.jsp"><img src="img/uhmatMainLogo.jpg"></a>
    	</div>
		<!-- 로고 들어가는 곳 -->
		
		<!-- 로그인 및 회원가입 부분 -->
		<div class="loginPart">
		<c:choose>
			<c:when test="${empty sessionScope.sId}">
				<a href="MemberLoginForm.me">로그인</a> &nbsp;<a href="MemberJoinForm.me">회원가입</a>
			</c:when>
			<c:otherwise>
				${sessionScope.sId } 님 &nbsp;<a href="javascript:void(0)" onclick="confirmLogout()">로그아웃</a>
				<%-- 세션 아이디가 "admin" 일 때만 관리자페이지 링크("AdminMain.me") 표시 --%>
				<c:if test="${sessionScope.sId eq 'admin'}"><a href="AdminMain.me">| 관리자페이지</a></c:if>
			</c:otherwise>
		</c:choose>
		</div>
		<!-- 로그인 및 회원가입 부분 -->
		
	<!-- 탑 메뉴 부분 -->
	<div class="topMenu">
    <ul>
    	<li>
    	<div class="dropdown">
    		<a href="./company/companyModify.jsp">회사소개</a>
    			<div class="dropdownContent">
				<ul>
					<li><a href="./company/companyModify.jsp">About Us</a></li>
				</ul>	
				</div>
  	  	</div>
  	  	</li>
  	  	
  	  	<li>
  	  	<div class="dropdown">
    		<a href="#">어맛리뷰</a>
    			<div class="dropdownContent">
				<ul>
					<li><a href="#">link2</a></li>
					<li><a href="#">link2</a></li>
					<li><a href="#">link2</a></li>
					<li><a href="#">link2</a></li>
					<li><a href="#">link2</a></li>
				</ul>	
				</div>
  	  	</div>
  	  	</li>
  	  	
  	  	<li>
  	  	<div class="dropdown">
    		<a href="./community/mate_list.jsp">커뮤니티</a>
    			<div class="dropdownContent">
				<ul>
					<li><a href="./community/mate_list.jsp">어맛 메이트</a></li>
					<li><a href="./community/tmiList.jsp">어맛인들의 tmi</a></li>
					<li><a href="./community/mate_recipe.jsp">어맛 레시피</a></li>
				</ul>	
				</div>
  	  	</div>
  	  	</li>
  	  	
  	  	<li>
  	  	<div class="dropdown">
    		<a href="./event/NewFile.jsp">이벤트</a>
    			<div class="dropdownContent">
				<ul>
					<li><a href="./event/NewFile.jsp">이벤트</a></li>
					<li><a href="#">어맛 MBTI</a></li>
					<li><a href="#">어맛룰렛/사다리</a></li>
				</ul>	
				</div>
  	  	</div>
  	  	</li>	
  	  	
  	  	<li>
  	  	<div class="dropdown">
    		<a href="./serviceCenter/faq/faqlist.jsp">고객센터</a>
    			<div class="dropdownContent">
				<ul>
					<li><a href="#">1 대 1 라이브 채팅</a></li>
					<li><a href="./serviceCenter/faq/faqlist.jsp">FAQ</a></li>
					<li><a href="./serviceCenter/notice/noticelist.jsp">공지사항</a></li>
				</ul>	
				</div>
  	  	</div>
  	  	</li> 
	  		
  	</ul>
    </div>
   
	<!-- 탑 메뉴 부분 -->
	
	
	<!-- 검색 창 부분 -->
	<div class="searchContainer">
		<div class="row">
		<!-- 검색 버튼 눌렀을 때 mainController 로 통해 uhmatSearch 페이지로 가게끔 구현해야함 -->
			<form method="post" name="search" action="uhmatSearch.jsp">
				<table class="pullRight">
					<tr>
						<td>
							<i class="fa-solid fa-magnifying-glass" style="font-size: 1.1em">
							<input type="search" id="searchControl"
								placeholder="검색할 음식명이나 음식점명" name="searchText" value="" maxlength="100" autocomplete="off">
							</i>	
						</td>
						<td><button id="searchBtn" type="submit" title="검색"
							 class="submitBtn">
								<span class="blind">검색</span>
								<span class="searchIconSubmit"></span>
							</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 검색 창 부분 -->
	</header>
</div>
</body>
</html>   
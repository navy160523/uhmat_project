<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/main.css" rel="stylesheet" type="text/css">
<link href="css/header.css" rel="stylesheet" type="text/css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
</head>
<body>
	<!-- 헤더 들어가는곳 -->
		<jsp:include page="inc/header.jsp" flush="false" />
	<!-- 헤더 들어가는곳 -->
	
	<!-- 사이드바 들어가는곳 -->
<%-- 		<jsp:include page="inc/sidebar.jsp" flush="false" /> --%>
	<!-- 사이드바 들어가는곳 -->
<!-- 	<hr>		 -->
			
	<!-- 메인페이지 영역 시작 -->
	<div class="mainContainer">	
	<!-- 본문들어가는 곳 시작 -->
		<!-- 리뷰 순위 창 시작 -->
			<div class="rankContainer">
				<div class = "imgContainer">
					<div class = "mainView">
						<ul>
						<c:forEach var="board" items="${reviewList}" varStatus="state">
							<li><img src="upload/${board.photo }" width="100%" height="100%"/>${board.res_name }</li>
						</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		<!-- 리뷰 순위 창 끝 -->
		
		<!-- 맛집 영역 시작 -->
			<div class="rankReview">
				<div class = "imgContainer">
					<div class = "mainView">
						<ul>
							<li><img src="image/sample1.jpg" width="100%" /></li>
							<li><img src="image/sample2.jpg" width="100%" /></li>
							<li><img src="image/sample3.jpg" width="100%" /></li>
							<li><img src="image/sample4.jpg" width="100%" /></li>
							<li><img src="image/sample5.jpg" width="100%" /></li>
						</ul>
					</div>
				</div>
			</div>
		<!-- 맛집 리뷰 영역 끝 -->
		
	</div>
<!-- 메인페이지 영역 끝 -->		
<hr>
		
	<!-- 푸터 들어가는곳 시작 -->
		<jsp:include page="inc/footer.jsp" flush="false" />
	<!-- 푸터 들어가는곳 끝 -->		

</body>
</html>   
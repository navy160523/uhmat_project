<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/main.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.6.0.js"></script>
<!-- <link href="css/header.css" rel="stylesheet" type="text/css"> -->
<!-- <link href="css/footer.css" rel="stylesheet" type="text/css"> -->
<script type="text/javascript">
	
	//content 글자 수 제한 코드 
	$(document).ready(function(){
	    $('p[id^=content]').each(function(){
	        if ($(this).text().length > 120) {
	        $(this).html($(this).text().substr(0,120)+"<br>" +"<span id='highlight' onclick='more()'>...더보기</span>");
	        }
	    });
	    
	  window.onload = function(){
	   	   $.ajax({
	   			type: "post",
	   			url: "ReviewBest.ma",	//리뷰를 좋아요 순으로 가져오는 요청
	   		
	   			dataType: "text",
	   			async : false,
	   			success: function(response) {
  					var content = $("#bestReview").html(response).find("#list");
//   					alert(response);
  					$("#bestReview").html(content);
	   		   }
	   		});
	  }
	
	});
	
</script>
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
	<!-- 검색창 시작 -->
	<div class="mainImageContainer">
		<img class="mainImage" src="image/mainSample3.jpg">
	</div>
	<!-- 검색창 끝 -->
	
	<!-- 본문들어가는 곳 시작 -->
	

	
		<!-- 최고의 리뷰 순위 시작 -->
		<div class="mainViewContainer">	
			<div class="rankContainer">
				<div class = "imgContainer" ><h2>최다 좋아요 리뷰</h2>
						<div id="bestReview">
						
						</div>
				</div>
			</div>
		<!-- 최고의 리뷰 순위 끝 -->
		
		<!-- 최신 리뷰 시작 -->
			<div class="rankReview" id="recentReview">
				<div class = "imgContainer"><h2>어맛 최신 리뷰</h2>
					<div id="bestResList">
						<img src="image/sample1.jpg" width="200" height="100">
						<img src="image/sample2.jpg" width="200" height="100">
						<img src="image/sample3.jpg" width="200" height="100">
					</div>
				</div>
			</div>
		<!-- 최신 리뷰 끝 -->
		
		<!-- 어맛 추천 리뷰 시작 -->
			<div class="rankReview" id="bestRes">
				<div class = "imgContainer"><h2>어맛 추천 식당</h2>
					<!-- 별점, 댓글의 개수 순으로 내림차순 정렬된 식당의 값 -->
					
				</div>
			</div>
		<!-- 어맛 추천 리뷰 끝 -->
		
		<!-- 리뷰어 창 시작 -->
			<div class="reviewer">
				<div class = "imgContainer"><h2>어맛 리뷰어</h2>
					<div class = "mainView" >
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
		</div>	
		<!-- 리뷰어 창 끝 -->
		
		
		
	</div>
<!-- 메인페이지 영역 끝 -->		
<!-- <hr> -->
	
	<!-- 식당 카테고리 페이지 추가 -->
		<jsp:include page="food/restaurant/category_page.jsp" />
	<!-- 푸터 들어가는곳 시작 -->
		<jsp:include page="inc/footer.jsp" flush="false" />
	<!-- 푸터 들어가는곳 끝 -->		

</body>
</html>   
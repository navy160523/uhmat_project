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
//	    $('p[id^=content]').each(function(){
//	        if ($(this).text().length > 120) {
//	        $(this).html($(this).text().substr(0,120)+"<br>" +"<span id='highlight' onclick='more()'>...더보기</span>");
//	        }
//	    });
    
    $("#nextBestReview").on("click",function(){
    	 $.ajax({
	   			type: "post",
	   			url: "ReviewBest.ma",	//리뷰를 좋아요 순으로 가져오는 요청
	   			data:{
	   				pageNum: ${pageInfo.pageNum}+1
	   			},
	   			dataType: "text",
	   			async : false,
	   			success: function(response) {
  					var content = $("#bestReview").html(response).find("#list");
//   					alert(response);
  					$("#bestReview").html(content);
	   		   }
	   		});
    });
    
  window.onload = function(){
	   $.ajax({
			type: "post",
			url: "ReviewBest.ma",	//리뷰를 좋아요 순으로 가져오는 요청
		
			dataType: "text",
			async : false,
			success: function(response) {
					var content = $("#bestReview").html(response).find("#list");
					$("#bestReview").html(content);
		   }
		});
   	   
   	$.ajax({
			type: "post",
			url: "ReviewRecent.ma",	//리뷰를 좋아요 순으로 가져오는 요청

			dataType: "text",
			async : false,
			success: function(response) {
				var content = $("#recentReview").html(response).find("#list");
//				alert(response);
				$("#recentReview").html(content);
		   }
		});
   	   
   	$.ajax({
			type: "post",
			url: "restaurantList.re",	//식당을 가져오는 요청
			data: {
				bestRes : true
			},
			dataType: "text",
			async : false,
			success: function(response) {
//				alert($(response).find("#repeat").html());
			var table = $(response).find("#repeat");
			var td = table.find("td:eq(0)");
			var td2 = table.find("tr:eq(0) td:eq(3) img").prop('src');
			var inputTd = $("#bestRes td:eq(0)").text();
			$("#bestRes td").eq(0).text(td.text());
			$("#bestRes img").eq(0).attr('src',td2);
			
			for(var i=0;i<3;i++){
				var td = table.find("tr:eq("+i+") td:eq(0)");
				var td2 = table.find("tr:eq("+i+") td:eq(3) img").prop('src');
				var inputTd = $("#bestRes td:eq("+i+")").text();
				$("#bestRes td").eq(i).text(td.text());
				$("#bestRes img").eq(i).attr('src',td2);
			}
				
		   }
		});
   	
	   
  }

});
	
</script>
</head>
<body>
	<!-- 헤더 들어가는곳 -->
	<header id="header">	
		<jsp:include page="inc/header.jsp" flush="false" />
	</header>	
	<!-- 헤더 들어가는곳 -->
	
	
<!-- 	<hr>		 -->
			 
	<!-- 메인페이지 영역 시작 -->
	<div class="mainContainer">	
	<!-- 검색창 시작 -->
	
<!-- 	<section id="sec01"></section> -->
<!-- 	<div id="mainImageContainer"> -->
<!-- 		<img class="mainImage" src="image/mainSample3.jpg"> -->
<!-- 	</div> -->
	<!-- 검색창 끝 -->
	
	<!-- 본문들어가는 곳 시작 -->
	<section id="mainSec01">
		<div class="mainSec01"></div>
	</section>

	
		<!-- 최고의 리뷰 순위 시작 -->
		<div class="mainViewContainer">	
			<div class="rankContainer">
				<div class = "imgContainer" ><h2>최다 좋아요 리뷰</h2>
						<div id="bestReview">
							<button id="nextBestReview">다음</button>
						</div>
				</div>
			</div>
		<!-- 최고의 리뷰 순위 끝 -->
		<div class="clear"></div>
		<!-- 최신 리뷰 시작 -->
			<div class="rankReview" id="recentReview">
				<div class = "imgContainer"><h2>어맛 최신 리뷰</h2>
					<div id="recentReview">
						
					</div>
				</div>
			</div>
		<!-- 최신 리뷰 끝 -->
		
		<!-- 어맛 추천 리뷰 시작 -->
			<div class="rankReview" id="bestRes">
				<div class = "imgContainer"><h2>어맛 추천 식당</h2>
					<!-- 별점, 댓글의 개수 순으로 내림차순 정렬된 식당의 값 -->
					<div id="bestRes">
						<table>
							<tr>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td><img src="#" width="300" height="200"></td>
								<td><img src="#" width="300" height="200"></td>
								<td><img src="#" width="300" height="200"></td>
							</tr>
						</table>						
					</div>
				</div>
			</div>
		<!-- 어맛 추천 리뷰 끝 -->
		</div>
		<!-- 사이드바 들어가는곳 -->
			<jsp:include page="inc/sidebar.jsp" flush="false" />
		<!-- 사이드바 들어가는곳 -->
		
	</div>
<!-- 메인페이지 영역 끝 -->		
<!-- <hr> -->
	
	<section id="mainSec02">
		<div class="categoryImageContainer">
			
		</div>
	</section>
	
	<!-- 식당 카테고리 페이지 시작 -->
	<div class="restaurantCategory">
		<jsp:include page="food/restaurant/category_page.jsp" />
	</div>	
	<!-- 식당 카테고리 페이지 끝 -->
	
	<!-- 푸터 들어가는곳 시작 -->
	<footer id="footer">
		<jsp:include page="inc/footer.jsp" flush="false" />
	</footer>	
	<!-- 푸터 들어가는곳 끝 -->		

</body>
</html>   
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
<link href="${pageContext.request.contextPath}css/reviewList.css" rel="stylesheet" type="text/css">
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
	
	});
	
	
	// 해쉬 태그 클릭시 내용 조회 코드
	$(document).ready(function() {
		
		$('button[id^=targetTag]').each(function() {
			
		
			$(this).on("click", function() {
			
				var targetTag = $(this).text();
				targetTag = targetTag.replaceAll("#", "");
				location.href="ReviewList.re?targetTag="+targetTag +"&pageNum=${pageInfo.pageNum}"
			});
		});
	});
</script>
<style>
	.star-rating {width:205px; }
	.star-rating,.star-rating span {display:inline-block; height:39px; overflow:hidden; background:url(image/star3.png)no-repeat; }
	.star-rating span{background-position:left bottom; line-height:0; vertical-align:top; }
</style>
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
						<section id="mother">
	<section id="list" >
		<c:choose>
			<c:when test="${not empty reviewBestLikeList and pageInfo.listCount gt 0}">
				<c:forEach var="board" items="${reviewBestLikeList}" varStatus="state">
					<!--  -->
					<section id="listView">
						<p id="subject" class="tdName">${board.subject }</p>
						<section id="photo">
						<p><img src="upload/${board.photo }" width="400px" height="250px"alt="파일" ></p>
						
						</section>
						<section id="tdName">

						
						<p class="tdName">
					
						</p>
						<p class="tdName"><div class='star-rating'><span style ="width:${board.rating*20}%"></span></div>(${board.rating }) <span><span id="heart">❤</span>${board.likes}</span></p>
						</section>
						
						<section id="cnt">
						<p id="content${state.count }"onclick="location.href='ReviewDetail.re?idx=' + ${board.idx}+'&pageNum=' +${pageInfo.pageNum}">${board.content}</p> <!-- 이부분에서 나중에 댓글 항목 추가, 더보기 란 할 수 있도록 해야함 -->
						</section>
					</section>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="8">게시글이 존재하지 않습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</section>
	</section>
	<section id="append" style="display:none;">
	</section>
				</div>
			</div>
		<!-- 최고의 리뷰 순위 끝 -->
		
		<!-- 최신 리뷰 시작 -->
			<div class="rankReview">
				<div class = "imgContainer"><h2>어맛 최신 리뷰</h2>
					
				</div>
			</div>
		<!-- 최신 리뷰 끝 -->
		
		<!-- 어맛 추천 리뷰 시작 -->
			<div class="rankReview">
				<div class = "imgContainer"><h2>어맛 추천 리뷰</h2>
					
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
		
	<!-- 푸터 들어가는곳 시작 -->
		<jsp:include page="inc/footer.jsp" flush="false" />
	<!-- 푸터 들어가는곳 끝 -->		

</body>
</html>   
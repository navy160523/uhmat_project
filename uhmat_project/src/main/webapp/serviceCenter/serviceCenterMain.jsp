<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ServiceCenter</title>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script> 
<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
<link href="https://fonts.googleapis.com/css2?family=Luckiest+Guy&family=Poor+Story&display=swap" rel="stylesheet"> 
<link href="css/serviceCenterMain.css" rel="stylesheet">


<!-- 사이드 바 관련 태그 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body style="width:100%;">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		
		<h1 style="text-align: center; font-size: 50px">고객센터</h1>
		
		

	<div class="clear"></div>

	<article id="front" style="margin-left: 23%;">
		<section>
			<section id="search">
				<div>
					<span>FAQ</span> 검색하기
				</div>

				<form name="qna_board_search_frm" method="post" action="FAQList.sc">
					<input type="text" name="keyword" value="" placeholder="검색어를 입력하세요">
					<input type="submit" name="search_type" value="검색">
				</form>
			</section>
			
			
		<!-- 왼쪽 사이드바 -->
		<div class="wrapper">
        <!--Top menu -->
        <div class="sidebar">
           <!--profile image & text-->
            <!--menu item-->
        </div>

    </div>
		

		<!-- 최근 게시글 -->
			<section>
			
				<div class="sidebar" style="padding:30px;">
					<ul>
		                <li>
		                    <a href="NoticeList.sc" class="active">
		                        <span class="icon"><i class="fa-solid fa-keyboard"></i></span>
		                        <span class="item"> 공지사항</span>
		                    </a>
		                </li>
		                
		                <li>
		                    <a href="FAQList.sc">
		                        <span class="icon"><i class="fas fa-desktop"></i></span>
		                        <span class="item"> FAQ</span>
		                    </a>
		                </li>
               		</ul>
				</div>
				
				<div id="FAQ">
					<h3 class="brown">최근 신고 글</h3>
					<table class="faqList">
						<c:forEach var="faq" items="${faq5 }">
							<tr>
								<td><a href="FAQDetail.sc?idx=${faq.idx}&pageNum=1&keyword=">${faq.subject }</a></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</section>
			<section>
				<div id="notice">
					<h3 class="brown">최근 공지사항</h3>
					<c:forEach var="notice" items="${notice5 }">
						<table class="noticeList">
							<tr>
								<td>
								<a href="NoticeDetail.sc?idx=${notice.idx}&pageNum=1&keyword=">${notice.subject }</a></td>
							</tr>
						</table>
					</c:forEach>
				</div>
			</section>
		</section>
	</article>
	<div class="clear"></div>  
	
	<!-- 푸터 들어가는곳 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	<!-- 푸터 들어가는곳 -->

	
</body>
</html>
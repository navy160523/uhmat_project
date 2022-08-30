<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MainSearch</title>
</head>
<body>	
		<!-- header -->
		<header>
			<jsp:include page="inc/header.jsp"></jsp:include>
		</header>
		
		<!--tmiBoard  -->
		<h1>tmiBoard</h1>
		<table border="1">
		<c:choose>
			<c:when test="${not empty tmiBoard  }">
						<c:forEach var="tmi" items="${tmiBoard }">
							<tr>
								<td width="800" height="50"><a href="TmiDetail.co?idx=${tmi.idx }&pageNum=${pageInfo.pageNum}">${tmi.subject }</a> <br> 
									${tmi.nickname } | ${tmi.readcount } | ${tmi.datetime }</td>
							</tr>
								
						</c:forEach>
			</c:when>
		</c:choose>
		</table>
		
		<!--mateBoard  -->
		<h1>mateBoard</h1>
		<table border="1">
		<c:choose>
	 			<c:when test="${not empty mateBoard  }">
					
						<c:forEach var="mate" items="${mateBoard }">
							<tr>
								<td width="800" height="50"><a href="MateDetail.co?idx=${mate.idx }&pageNum=${pageInfo.pageNum}">${mate.subject }</a> <br> 
											${mate.content } <br>
									${mate.nickname } | ${mate.readcount } | <img src="img/시계.jpg" width="20"> ${mate.datetime }</td>
							</tr>
						</c:forEach>
					
				</c:when>
		</c:choose>	
		</table>
		<!-- restaurantBoard -->
		<h1>restaurantBoard</h1>
		<table border="1">
			<c:choose>
				<c:when test="${not empty restaurantBoard  }">
					<c:forEach  var="resInfo" items="${restaurantBoard }">
								<tr onclick="location.href='restaurantDetail.re?resName=${resInfo.resName}'">
									<td>${resInfo.resName }</td>
									<td>${resInfo.rating }</td>
									<td>${resInfo.reviewCount }</td>
									<td><img width="200" src="upload/${resInfo.photo }"></td>
								</tr>
					</c:forEach>
				</c:when>
			</c:choose>	
		</table>
		<!-- reviewBoard -->
		<h1>ReviewBoard</h1>
		
		
		<!-- FAQ -->
		<h1>FAQ</h1>
		<table border="1">
		<c:choose>
	 			<c:when test="${not empty FAQ  }">
						<c:forEach var="FAQ" items="${FAQ}"> 
							<tr>
								<td>${FAQ.category }</td>
								<td>${FAQ.idx }</td>
								<td id="subject">
									<a href="FAQDetail.sc?idx=${FAQ.idx}&pageNum=${pageInfo.pageNum}&keyword=${param.keyword}">
										${FAQ.subject }
									</a>
								</td>
								<td>${FAQ.nickname }</td>
								<td>${FAQ.date }</td>
								<td>${FAQ.readcount }</td>
							</tr>
						</c:forEach>
			</c:when>
		</c:choose>
		</table>
		<!-- Notice -->
		<h1>Notice</h1>
		<table border="1">
		<c:choose>
	 			<c:when test="${not empty notice  }">
						<c:forEach var="notice" items="${notice}"> 
							<tr>
							 	<td>${notice.category }</td>
								<td>${notice.idx }</td>
								<td id="subject">
									<a href="NoticeDetail.sc?idx=${notice.idx}&pageNum=${pageInfo.pageNum}">
										${notice.subject }
									</a>
								</td>
								<td>${notice.nickname }</td>
								<td>${notice.date }</td>
							</tr>
						</c:forEach>
				</c:when>
		</c:choose>
		</table>
		
		<!-- Footer 부분 -->
		<footer>
			<jsp:include page="inc/footer.jsp"></jsp:include>
		</footer>
</body>
</html>
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

<h1>mainresult</h1>
		<!-- header -->
			<jsp:include page="inc/header.jsp"></jsp:include>
		
		<!-- restaurantBoard -->
		<c:choose>
		<c:when test="${not empty restaurantBoard  }">
		<h1>RestaurantBoard</h1>
			<table >
				<c:forEach  var="resInfo" items="${restaurantBoard }">
						<tr onclick="location.href='restaurantDetail.re?resName=${resInfo.res_name}'">
							<td><h1 style="color:blue">${resInfo.res_name }</h1></td>
						</tr>
				</c:forEach>
			</table>
		</c:when>
		<c:otherwise>
		<h1>RestaurantBoard - 게시물이 존재하지 않습니다.</h1>
		</c:otherwise>
		</c:choose>	
		<!-- reviewBoard -->
			<c:choose>
				<c:when test="${not empty reviewBoard  }">
					<h1>ReviewBoard</h1>
					<table>
							<c:forEach  var="review" items="${reviewBoard }">
								<tr onclick="location.href='restaurantDetail.re?resName=${review.res_name}'">
									<td><h1 style="color:blue">${review.res_name }</h1></td>
								</tr>
							</c:forEach>
					</table>
				</c:when>
				<c:otherwise>
				<h1>ReviewBoard - 게시물이 존재하지 않습니다.</h1>
				</c:otherwise>
			</c:choose>	
		
		<!-- Footer 부분 -->
			<jsp:include page="inc/footer.jsp"></jsp:include>
</body>
</html>
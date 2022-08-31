<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.js"></script>
<script>
	var isRun = false;
	//스크롤 이벤트 발생
	window.onscroll = function() {
		if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
// 			alert("바닥에 닿음");
			if(${pageInfo.endPage} >= ${pageInfo.pageNum + 1}){
				$.ajax({
					type: "post",
					url: "restaurantList.re",
					data: {
						pageNum : ${pageInfo.pageNum +1},
						<%if(request.getParameter("category")!=null){ %>
						category : "${param.category}",
						<%} 
						if(request.getParameter("keyword")!=null){%>
						keyword : "${param.keyword}"
						<%} %>
					},
					dataType: "text",
					async : false,
					success: function(response) {
						isRun  = false;
// 						alert("실행됨");
						var content = $("#append").html(response).find(".append");
						if(content !=null)
// 						alert(content);
						if(${pageInfo.endPage} >= ${pageInfo.pageNum + 1}) {
							$("#repeat").append(content);
						}		
					},
				});
			}
		} 
	}
	
	$(function(){
		$("#keywordSelect").on("click",function(){
			location.href="restaurantList.re?keyword="+$("#keyword").val();
		});
	});
</script>
</head>
<body>
	<jsp:include page="../../inc/header.jsp"></jsp:include>
	<h1>restaurantList Page</h1>
	<input type="text" placeholder="음식점을 검색하세요" id="keyword" name="keyword" size="15"> 
	<input type="button" value="검색" id="keywordSelect">
	<table border="1">
		<tr>
			<th> 식당이름 </th>
			<th> 별점 </th>
			<th> 리뷰 개수</th>
			<th> 사진 </th>
		</tr>
	</table>
	<table border="1" id="repeat">
		<c:choose>
			<c:when test="${empty restaurantInfo }">
<!-- 				<tr> -->
<!-- 					<td colspan="4"> -->
<!-- 						게시된 식당이 없습니다. -->
<!-- 					</td> -->
<!-- 				</tr> -->
			</c:when>
			<c:otherwise>
				<c:forEach items="${restaurantInfo }" var="resInfo">
					<tr onclick="location.href='restaurantDetail.re?resName=${resInfo.resName}'" class="append">
						<td>${resInfo.resName }</td>
						<td>${resInfo.rating }</td>
						<td>${resInfo.reviewCount }</td>
						<td><img width="200" src="upload/${resInfo.photo }"></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	<section id="append" style="display: none;">
	
	</section>
	<section id="buttons">
	<button onclick="location.href='restaurantWriteForm.re'">글쓰기</button>
	<button onclick="location.href='resCategory.re'">카테고리 보기</button>
	<button onclick="location.href='index.jsp'">홈으로</button>
	</section>
	
	<jsp:include page="../../inc/footer.jsp"></jsp:include>
</body>
</html>
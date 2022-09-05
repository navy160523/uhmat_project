<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Luckiest+Guy&family=Poor+Story&display=swap" rel="stylesheet">
<link href="css/recipe/recipeList.css" rel="stylesheet">
</head>
<body>
	<!-- 		헤더 들어가는 곳 -->
		<jsp:include page="../../inc/header.jsp"/>
	<!-- 		헤더 들어가는 곳 -->
	
	<div align="center" class="recipeBanner">
		<img alt="recipe 배너" src="./image/recipe/recipe_banner.png">
		
	</div>
	
	<div align="center" id="menuBar">
		<button onclick="location.href='MateList.co'">mate</button>
		<button onclick="location.href='TmiList.co'">tmi</button>
		<button onclick="location.href='RecipeList.co'">recipe</button>
		<br>
	</div>
	
	
	<table class="recipeList">
		<tr>
			<td></td>
			<td>제목</td>
			<td>닉네임</td>
			<td>조회수</td>
			<td>작성일</td>
		
		</tr>
		<!-- 게시물 목록 출력(단, 게시물이 하나라도 존재할 경우에만 출력) -->
		<!-- 조건 : recipeList 객체가 비어있지 않고 pageInfo 객체의 listCount 가 0보다 클 경우 -->
		<c:choose>
			<c:when test="${not empty recipeList and pageInfo.listCount gt 0 and empty recipeSearchPageInfo.listCount}">
				<c:forEach var="recipe" items="${recipeList }">
					<tr class="recipeListTable">
						<td><img src="recipe_upload/${recipe.real_File1 }" onerror="this.onerror=null; this.src='image/recipe/recipe_default_img.png';" width="100" ></td>
						<td class="link" width="350" height="50"><a href="RecipeDetail.co?idx=${recipe.idx }&pageNum=${pageInfo.pageNum}">${recipe.subject }</a></td>
						<td>${recipe.nickname }</td>
						<td>${recipe.readcount }</td>  
						<td>${recipe.date }</td>
					</tr>
					
				</c:forEach>
			</c:when>
			<c:when test="${not empty recipeSearchPageInfo.listCount }">
	 			<c:forEach var="recipe" items="${recipeSearchList}"> 
					<tr class="recipeListTable">
						<td><img src="recipe_upload/${recipe.real_File1 }" onerror="this.onerror=null; this.src='img/recipe_default_img/레시피디폴트.png';" width="100" ></td>
						<td class="link" width="350" height="50"><a href="RecipeDetail.co?idx=${recipe.idx }&pageNum=${pageInfo.pageNum}">${recipe.subject }</a></td>
						<td>${recipe.nickname }</td>
						<td>${recipe.readcount }</td>  
						<td>${recipe.date }</td>
					</tr>
				</c:forEach>
	 		</c:when>
			<c:otherwise>
				<tr><td colspan="5">게시물이 존재하지 않습니다.</td></tr>
			</c:otherwise>
		</c:choose>
		<tr>
			<td id="plus"><i class='fas fa-plus-circle' style='position:static; font-size:48px;color:#AAAAAA' onclick="location.href='RecipeWriteForm.co'"/></i></td>
		</tr>
	</table>
	
	<!-- 	레시피 검색 -->
	<div align="center">
		<form action="RecipeSearch.co" method="get" class="search">
			<input type="text" placeholder="search" name="keyword" value=${param.keyword }>
			<input type="submit" value="검색">
    	</form>
	</div>
	&nbsp;
	<!-- 글쓰기 버튼 클릭 시 글쓰기 페이지로 이동 -->
<!-- 	<div style="position: relative; right: -1210px; top:35px;"> -->
<!-- 		<i class='fas fa-plus-circle' style='position:static; font-size:48px;color:#7FB77E' onclick="location.href='RecipeWriteForm.co'"/></i> -->
<!-- <!-- 		<input type="button" value="글쓰기" onclick="location.href='RecipeWriteForm.co'"/> --> 
<!-- 	</div> -->
	
	<!-- 
		현재 페이지 번호(pageNum)가 1보다 클 경우에만 [이전] 링크 동작
		=> 클릭 시 mateList.mate 서블릿 주소 요청하면서 
		   현재 페이지 번호(pageNum) - 1 값을 page 파라미터로 전달
	-->
	<div align="center">
		<c:choose>
			<c:when test="${pageInfo.pageNum > 1}">
				<input type="button" class="before_next" value="이전" onclick="location.href='RecipeList.co?pageNum=${pageInfo.pageNum - 1}'">
			</c:when>
			<c:when test="${recipeSearchPageInfo.pageNum > 1}">
					<input type="button" class="before_next" value="이전" onclick="location.href='RecipeSearch.co?pageNum=${recipeSearchPageInfo.pageNum - 1}&keyword=${param.keyword }'">
				</c:when>
			<c:otherwise>
				<input type="button" class="before_next" value="이전">
			</c:otherwise>
		</c:choose>
		
		<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
	<c:choose>
		<c:when test="${empty recipeSearchPageInfo }">
			<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
				<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
				<c:choose>
					<c:when test="${pageInfo.pageNum eq i}">
						${i }
					</c:when>
					<c:otherwise>
						<a href="RecipeList.co?pageNum=${i }">${i }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:when>
		<c:otherwise>
					<c:forEach var="i" begin="${recipeSearchPageInfo.startPage }" end="${recipeSearchPageInfo.endPage }" >
						<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
						<c:choose>
							<c:when test="${recipeSearchPageInfo.pageNum eq i}">
								${i}
							</c:when>
							<c:otherwise>
								<a href="RecipeSearch.co?pageNum=${i}&keyword=${param.keyword }">${i} &nbsp;</a>
			
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
		</c:choose>	
	<!-- 현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 [다음] 링크 동작 -->
	<c:choose>
		<c:when test="${pageInfo.pageNum < pageInfo.maxPage}">
			<input type="button" class="before_next" value="다음" onclick="location.href='RecipeList.co?pageNum=${pageInfo.pageNum + 1}'">
		</c:when>
		<c:when test="${recipeSearchPageInfo.pageNum lt recipeSearchPageInfo.maxPage}">
			<input type="button" class="before_next" value="다음" onclick="location.href='RecipeSearch.co?pageNum=${recipeSearchPageInfo.pageNum + 1}&keyword=${param.keyword }'">
		</c:when>
		<c:otherwise>
			<input type="button" class="before_next" value="다음">
		</c:otherwise>
	</c:choose>
		
	</div>
	
	<!-- 		푸터 들어가는 곳 -->
		<jsp:include page="../../inc/footer.jsp"/>
	<!-- 		푸터 들어가는 곳 -->
</body>
</html>
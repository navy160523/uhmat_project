<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<title>Insert title here</title>
<link href="css/recipe/recipeView.css" rel="stylesheet">
</head>
<body>
	<!-- 		헤더 들어가는 곳 -->
		<jsp:include page="../../inc/header.jsp"/>
	<!-- 		헤더 들어가는 곳 -->
	<div class="view">
		<table>
			<tr>
				<td class="subject">${recipe.subject }</td> 
			</tr>
			<tr>
				<td class="nickname_time_readcount"><i class='fas fa-user-alt'></i> ${recipe.nickname } | <i class="fa fa-clock-o"></i> ${recipe.datetime } | <i class='far fa-eye'></i> ${recipe.readcount }</td> 
			</tr>
			</table>
				<div>
<!-- 				onerror="this.style.display='none';" img alt 아이콘 없애는 기능 -->
					<img src="./upload/recipe_upload/${recipe.real_File1 }" width="150" onerror="this.style.display='none';">
	               	<img src="./upload/recipe_upload/${recipe.real_File2 }" width="150" onerror="this.style.display='none';">
	              	<img src="./upload/recipe_upload/${recipe.real_File3 }" width="150" onerror="this.style.display='none';">
	             	<img src="./upload/recipe_upload/${recipe.real_File4 }" width="150" onerror="this.style.display='none';">
	              	<img src="./upload/recipe_upload/${recipe.real_File5 }" width="150" onerror="this.style.display='none';">
				</div>
			<table>
			<tr>
				<td>${recipe.content }</td> 
			</tr>
		</table>
	
	&nbsp;
	
	<div class="btn">
		<input type="button" value="댓글" onclick="location.href='RecipeReplyForm.co?idx=${param.idx}&pageNum=${param.pageNum}'">
		<c:if test="${sessionScope.sNickName == recipe.nickname }">
			<input type="button" value="수정" onclick="location.href='RecipeModifyForm.co?idx=${recipe.idx}&pageNum=${param.pageNum}'">
			<input type="button" value="삭제" onclick="location.href='RecipeDeleteForm.co?idx=${recipe.idx}&pageNum=${param.pageNum}&nickname=${recipe.nickname}&file1=${recipe.real_File1 }&file2=${recipe.real_File2 }&file3=${recipe.real_File3 }&file4=${recipe.real_File4 }&file5=${recipe.real_File5 }'">
		</c:if>
		<input type="button" value="목록" onclick="location.href='RecipeList.co?pageNum=${param.pageNum}'">
	</div>
	&nbsp;
		<table>
		<c:forEach items="${recipeReplyList }" var="recipeReplyList">
			<tr>
				<td>
					<c:forEach begin="1" end="${recipeReplyList.re_lev }">
						&nbsp;&nbsp;<i class="material-icons" style="font-size:20px;color:#FF1818">subdirectory_arrow_right</i>
					</c:forEach>
					${recipeReplyList.nickname } | ${recipeReplyList.date }
				</td>
			</tr>
			<tr>
				<td width="500" class="reply"> ${recipeReplyList.content } </td>
				<td class="btn"><input type="button" value="대댓글" onclick="location.href='RecipeRereplyForm.co?idx=${param.idx}&pageNum=${param.pageNum}&reply_idx=${recipeReplyList.idx} '"></td>
				<c:if test="${sessionScope.sNickName == recipeReplyList.nickname }">
					<td class="btn"><input type="button" value="댓글삭제" onclick="location.href='RecipeReplyDeleteForm.co?idx=${recipe.idx}&pageNum=${param.pageNum}&reply_idx=${recipeReplyList.idx}&nickname=${recipeReplyList.nickname}'"> </td>
					<td class="btn"><input type="button" value="댓글수정" onclick="location.href='RecipeReplyModifyForm.co?idx=${recipe.idx}&pageNum=${param.pageNum}&reply_idx=${recipeReplyList.idx}&nickname=${recipeReplyList.nickname}'"></td>
				</c:if>
			</tr>
		</c:forEach>
		</table>
	</div>

	<!-- 		푸터 들어가는 곳 -->
	<jsp:include page="../../inc/footer.jsp"/>
	<!-- 		푸터 들어가는 곳 -->
	
</body>
</html>
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
<link href="css/mate/mateList.css" rel="stylesheet">
<style type="text/css">

 #detail{
 border: 0px;
 text-align: center;
 
 }
 #selectBox {
  width: 100px;
  padding: .2em .1em;
  font-family: inherit;
  background: url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  font-family: 'Poor Story', cursive;
  font-size: 20px;
  border: 1px solid #999;
  border-radius: 0px;
}

#selectBox::-ms-expand {
  /* for IE 11 */
  display: none;
}
</style>
 <script src="./js/jquery-3.6.0.js"></script>
 
 <script type="text/javascript">

	


$(function(){
	$("#selectBox").val("${param.title}").attr("selected", "selected");
	
	
	$("input[name^=detail]").on("click",function(){
		var title = "";
		var url="";
		if($("#selectBox").val()=='Notice'){
			title="Notice";
			url="NoticeDetail.ad";
		}
		if($("#selectBox").val()=='FAQ'){
			title="FAQ";
			url="FAQDetail.ad";
		}
		if($("#selectBox").val()=='Mate'){
			title="Mate";
			url="MateDetail.ad";
		}
		if($("#selectBox").val()=='Tmi'){
			title="Tmi";
			url="TmiDetail.ad";
		}
		if($("#selectBox").val()=='Recipe'){
			title="Recipe";
			url="RecipeDetail.ad";
		}
		
		
			 
		$.ajax({
			url : "http://localhost:8080/uhmat_project/"+url,  // ./ 현재경로표시
			type : "get",
			data :  {
				idx: $(this).val(),
				title: title,
				pageNum : ${pageInfo.pageNum},
					},
					
			dataType: "text",
			success : function(data) {
			            $('#div').html(data);
				
			

			},
			errer : function() {
				alert('errer');
			}
	
		 });
		
	});
	
	
});


</script>
</head>
<body>

	
	<form action="AllBoardList.ad"  id="fr" method="get"  >
	<div align="center">
				<select id="selectBox" name="title" onchange="this.form.submit()" >
					<option value="Notice" selected="selected">Notice</option>
					<option value="FAQ" >FAQ</option>
					<option value="Mate">Mate</option>
					<option value="Tmi">Tmi</option>
					<option value="Recipe">Recipe</option>
				</select>
				<!-- 검색하기 기능 -->
			
				<input class="search"  type="text" placeholder="검색어를 입력하세요" id="keyword" name="keyword" value=${param.keyword }>
				<input class="search" type="submit" id="submit1" value="검색">
	</div>
			
		
			
			</form>
			<br>
	<table class="mateList">
		<tr id="font_front">
				<td >카테고리</td>
				<td >번호</td>
				<td>제목</td>
				<td >작성자</td>
				<td >날짜</td>
		
		</tr>
		<!-- 게시물 목록 출력(단, 게시물이 하나라도 존재할 경우에만 출력) -->
		<!-- 조건 : boardList 객체가 비어있지 않고 pageInfo 객체의 listCount 가 0보다 클 경우 -->
		<c:choose>
			<c:when test="${not empty list and pageInfo.listCount gt 0 }">
				<c:forEach var="AllList" items="${list }">
					<tr class="mateListTable">
						<tr>
							<td id="category">${(empty AllList.category && AllList.category==null)?param.title:AllList.category}</td>
							<td ><input type="text" id="detail" name="detail${status.count}" value="${AllList.idx }"></td>
							<td>${AllList.subject }</td>
							<td>${AllList.nickname }</td>
							<td>${AllList.date }</td>
						</tr>
				
					
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr><td colspan="5">게시물이 존재하지 않습니다.</td></tr>
			</c:otherwise>
		</c:choose>
	
	</table>
	
	&nbsp;

	<div align="center">
			<c:choose>
				<c:when test="${pageInfo.pageNum > 1}">
					<input class="before_next" type="button" value="이전" onclick="location.href='AllBoardList.ad?pageNum=${pageInfo.pageNum - 1}&keyword=${param.keyword }'">
				</c:when>
				<c:otherwise>
					<input class="before_next" type="button" value="이전" disabled="disabled">
				</c:otherwise>
			</c:choose>
				
			<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
					<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }" >
						<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
						<c:choose>
							<c:when test="${pageInfo.pageNum eq i}">
								${i}
							</c:when>
							<c:otherwise>
								<a href="AllBoardList.ad?pageNum=${i}&keyword=${param.keyword }">${i} &nbsp;</a>
			
							</c:otherwise>
						</c:choose>
					</c:forEach>
				
			<!-- 현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 [다음] 링크 동작 -->
			<c:choose>
				<c:when test="${pageInfo.pageNum lt pageInfo.maxPage}">
					<input class="before_next" type="button" value="다음" onclick="location.href='AllBoardList.ad?pageNum=${pageInfo.pageNum + 1}&keyword=${param.keyword }'">
				</c:when>
				<c:otherwise>
					<input class="before_next" type="button" value="다음" disabled="disabled">
				</c:otherwise>
			</c:choose>
		
		
	</div>
	<div id="div"></div>
</body>
</html>

























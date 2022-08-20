<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>mate_list.jsp</h1>
	<table border="1">
		<!-- 게시물 목록 출력(단, 게시물이 하나라도 존재할 경우에만 출력) -->
		<!-- 조건 : boardList 객체가 비어있지 않고 pageInfo 객체의 listCount 가 0보다 클 경우 -->
		<c:choose>
			<c:when test="${not empty mateList and pageInfo.listCount gt 0 }">
				<c:forEach var="mate" items="${mateList }">
					<tr>
						<td width="800" height="50"><a href="MateDetail.co?idx=${mate.idx }&pageNum=${pageInfo.pageNum}">${mate.subject }</a> <br> 
<%-- 							${mate.content } <br> --%>
							${mate.nickname } | ${mate.readcount } | <img src="img/시계.jpg" width="20"> ${mate.datetime }</td>
					</tr>
					
				</c:forEach>
			</c:when>
			
			<c:when test="${not empty pageInfo.listCount }">
				<c:forEach var="mate" items="${mateList }"> 
				<tr>
					<td>${mate.idx }</td>
					<td id="subject">
						<a href="MateDetail.co?idx=${mate.idx }&pageNum=${pageInfo.pageNum}&keyword=${param.keyword }">
							${mate.subject }
						</a>
					</td>
					<td>${mate.nickname }</td>
					<td>${mate.datetime }</td>
				</tr>
			</c:forEach>
		</c:when>
			<c:otherwise>
				<tr><td colspan="5">게시물이 존재하지 않습니다.</td></tr>
			</c:otherwise>
		</c:choose>
	</table>
	
	<!-- 검색 -->
	<form action="MateList.co" method="get">
		<input type="text" name="keyword" value="${param.keyword }" placeholder="검색어를 입력하세요">
		<input type="submit" value="검색">
	</form>
	
	<!-- 글쓰기 버튼 클릭 시 글쓰기 페이지로 이동 -->
	<section>
	<input type="button" value="글쓰기" onclick="location.href='MateWriteForm.co'"/>
	</section>
	
	<!-- 
		현재 페이지 번호(pageNum)가 1보다 클 경우에만 [이전] 링크 동작
		=> 클릭 시 mateList.mate 서블릿 주소 요청하면서 
		   현재 페이지 번호(pageNum) - 1 값을 page 파라미터로 전달
	-->
	<section>
		
		<c:choose>
			<c:when test="${pageInfo.pageNum > 1}">
				<input type="button" value="이전" onclick="location.href='MateList.co?pageNum=${pageInfo.pageNum - 1}&keyword=${param.keyword }'">
			</c:when>
			<c:otherwise>
				<input type="button" value="이전" disabled="disabled">
			</c:otherwise>
		</c:choose>
		
		<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
		<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
			<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
			<c:choose>
				<c:when test="${pageInfo.pageNum eq i}">
					${i }
				</c:when>
				<c:otherwise>
					<a href="MateList.co?pageNum=${i }&keyword=${param.keyword }">${i } &nbsp;</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 [다음] 링크 동작 -->
		<c:choose>
			<c:when test="${pageInfo.pageNum lt pageInfo.maxPage}">
				<input type="button" value="다음" onclick="location.href='MateList.co?pageNum=${pageInfo.pageNum + 1}&keyword=${param.keyword }'">
			</c:when>
			<c:otherwise>
				<input type="button" value="다음" disabled="disabled">
			</c:otherwise>
		</c:choose>
		
	</section>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice 게시판</title>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Luckiest+Guy&family=Poor+Story&display=swap" rel="stylesheet">
<link href="css/notice/noticelist.css" rel="stylesheet">
<style type="text/css">
	
</style>
</head>
<body>
		<jsp:include page="../../inc/header.jsp"></jsp:include>
			
		<section id="listForm">
		
		<h2>Notice</h2>
		
		<div id="topButton">
			<br>
				<input type="button" class="topButton c1" value="전체" name="" onclick="location.href='NoticelistCategory.sc?name='+name">
				<input type="button" class="topButton c2" value="알림" name="알림" onclick="location.href='NoticelistCategory.sc?name='+name">
				<input type="button" class="topButton c3" value="보도기사" name="보도기사" onclick="location.href='NoticelistCategory.sc?name='+name">
<!-- 				<section style="clear: both;"></section> -->
			<br>
		
		<!-- 검색하기 기능 -->
		<form action="NoticeList.sc" method="get" id="keyword">
			<input type="text" placeholder="검색어를 입력하세요" name="keyword" value=${param.keyword }>
			<input type="submit" value="검색" id="bt">
		</form>
		
		</div>
		
		<table border="1">
			<tr id="tr_top">
				<td width="150px">카테고리</td>
				<td width="100px">번호</td>
				<td>제목</td>
				<td width="150px">작성자</td>
				<td width="150px">날짜</td>
				<td width="100px">첨부파일</td>
			</tr>
			<!-- 게시물 목록 출력(단, 게시물이 하나라도 존재할 경우에만 출력) -> JSTL과 EL 활용-->
			<!-- JSTL의 c:choose 태그를 사용하여 게시물 존재 여부 판별 -->
			<!--  조건 : boardList 객체가 비어있지 않고 pageInfo 객체의 listCount가 0보다 클 경우 -->
				
	 		<c:choose>
	 			<c:when test="${not empty list and pageInfo.listCount gt 0 }">
					<!-- c:foreach 태그를 사용하여 boardList 객체의 BoardDTO 객체를 꺼내서 출력 --> 				
					<c:forEach var="notice" items="${list}"> 
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
							<c:if test="${not empty notice.real_File  }">
							<td><i class='fas fa-link' style='font-size:20px;color:blue'></i></td>
							</c:if>
						</tr>
					</c:forEach>
	 			</c:when>
	 			<c:otherwise>
					<tr><td colspan="5"> 게시물이 존재하지 않습니다</td></tr> 			
	 			</c:otherwise>
	 		</c:choose>
			
		</table>
		</section>
		
		
		
		<section id="pageList">
		<!-- 
		현재 페이지 번호(pageNum)가 1보다 클 경우에만 [이전] 링크 동작
		=> 클릭 시 BoardList.bo 서블릿 주소 요청하면서 
		   현재 페이지 번호(pageNum) - 1 값을 page 파라미터로 전달
		-->
			<c:choose>
				<c:when test="${pageInfo.pageNum > 1}">
	
					<input type="button" value="이전" onclick="location.href='NoticeList.sc?pageNum=${pageInfo.pageNum - 1}&keyword=${param.keyword }'" id="bt">
				</c:when>
				<c:otherwise>
					<input type="button" value="이전" disabled="disabled" id="bt">
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
								<a href="NoticeList.sc?pageNum=${i}&keyword=${param.keyword }">${i} &nbsp;</a>
			
							</c:otherwise>
						</c:choose>
					</c:forEach>
			<!-- 현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 [다음] 링크 동작 -->
			<c:choose>
				<c:when test="${pageInfo.pageNum lt pageInfo.maxPage }">
					<input type="button" value="다음" onclick="location.href='NoticeList.sc?pageNum=${pageInfo.pageNum + 1}&keyword=${param.keyword }'" id="bt">
				</c:when>
				<c:otherwise>
					<input type="button" value="다음" disabled="disabled" id="bt">
				</c:otherwise>
			</c:choose>
		</section>
		<c:if test="${sessionScope.sNickName eq 'admin'}"> 
			<section id="buttonArea">
				<input type="button" value="글쓰기" onclick="location.href='NoticeWriteForm.sc'" id="bt" />
			</section>
		</c:if>
		
		<jsp:include page="../../inc/footer.jsp"/>
</body>
</html>














<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 게시판</title>
<style type="text/css">
	#listForm {
		width: 1024px;
		max-height: 610px;
		margin: auto;
	}
	
	h2 {
		text-align: center;
	}
	
	table {
		margin: auto;
		width: 1024px;
	}
	
	#tr_top {
		background: orange;
		text-align: center;
	}
	
	table td {
		text-align: center;
	}
	
	#subject {
		text-align: left;
		padding-left: 20px;
	}
	
	#pageList {
		margin: auto;
		width: 1024px;
		text-align: center;
	}
	
	#emptyArea {
		margin: auto;
		width: 1024px;
		text-align: center;
	}
	
	#buttonArea {
		margin: auto;
		width: 1024px;
		text-align: right;
	}
	
</style>


</head>
<body>
		<header>
			<jsp:include page="../../inc/header.jsp"></jsp:include>
		</header>
		<!-- 게시판 리스트 -->
		<section id="listForm">
		<h2>FAQ</h2>
		<input type="button" value="홈" onclick="location.href='index.jsp'">

		
			<input type="button" value="오류신고" name="오류신고" onclick="location.href='FAQlistCategory.sc?name='+name">
			<input type="button" value="음식점등록" name="음식점등록" onclick="location.href='FAQlistCategory.sc?name='+name">
			<input type="button" value="지도 오류" name="지도 오류" onclick="location.href='FAQlistCategory.sc?name='+name">
			
			<!-- 검색하기 기능 -->
			<form action="FAQList.sc" method="get">
				<input type="text" placeholder="검색어를 입력하세요" name="ment" value=${param.ment }>
				<input type="submit" value="검색">
			</form>
<!-- 		<select id="selectBox"> -->
<!-- <!-- 			<option value="전체">전체</option> -->
<!-- 			<option value="오류신고">오류신고</option> -->
<!-- 			<option value="음식점등록">음식점등록</option> -->
<!-- 			<option value="지도 오류">지도 오류</option> -->
<!-- 		</select> -->

		<table>
			<tr id="tr_top">
				<td width="150px">카테고리</td>
				<td width="100px">번호</td>
				<td>제목</td>
				<td width="150px">작성자</td>
				<td width="150px">날짜</td>
				<td width="100px">조회수</td>


			</tr>
			<!-- 게시물 목록 출력(단, 게시물이 하나라도 존재할 경우에만 출력) -> JSTL과 EL 활용-->
			<!-- JSTL의 c:choose 태그를 사용하여 게시물 존재 여부 판별 -->
			<!--  조건 : boardList 객체가 비어있지 않고 pageInfo 객체의 listCount가 0보다 클 경우 -->
	 		<c:choose>
	 			<c:when test="${not empty list  }">
					<!-- c:foreach 태그를 사용하여 boardList 객체의 BoardDTO 객체를 꺼내서 출력 --> 				
					<c:forEach var="FAQ" items="${list}"> 
						<tr>
							<td>${FAQ.category }</td>
							<td>${FAQ.idx }</td>
							<td id="subject">
								<a href="FAQDetail.sc?idx=${FAQ.idx}&pageNum=${pageInfo.pageNum}&ment=${param.ment}">
									${FAQ.subject }
								</a>
							</td>
							<td>${FAQ.nickname }</td>
							<td>${FAQ.date }</td>
							<td>${FAQ.readcount }</td>
						</tr>
						</c:forEach>
	 			</c:when>
	 			<c:otherwise>
					<tr><td colspan="5"> 게시물이 존재하지 않습니다</td></tr> 			
	 			</c:otherwise>
	 		</c:choose>
			
		</table>
		</section>
		
		<section id="buttonArea">
			<input type="button" value="글쓰기" onclick="location.href='FAQWriteForm.sc'" />
		</section>
		<section id="pageList">
		<!-- 
		현재 페이지 번호(pageNum)가 1보다 클 경우에만 [이전] 링크 동작
		=> 클릭 시 BoardList.bo 서블릿 주소 요청하면서 
		   현재 페이지 번호(pageNum) - 1 값을 page 파라미터로 전달
		-->
			<c:choose>
				<c:when test="${pageInfo.pageNum > 1}">
					<input type="button" value="이전" onclick="location.href='FAQList.sc?pageNum=${pageInfo.pageNum - 1}&ment=${param.ment }'">
				</c:when>
				<c:otherwise>
					<input type="button" value="이전" disabled="disabled">
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
								<a href="FAQList.sc?pageNum=${i}&ment=${param.ment }">${i} &nbsp;</a>
			
							</c:otherwise>
						</c:choose>
					</c:forEach>
				
			<!-- 현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 [다음] 링크 동작 -->
			<c:choose>
				<c:when test="${pageInfo.pageNum lt pageInfo.maxPage}">
					<input type="button" value="다음" onclick="location.href='FAQList.sc?pageNum=${pageInfo.pageNum + 1}&ment=${param.ment }'">
				</c:when>
				<c:otherwise>
					<input type="button" value="다음" disabled="disabled">
				</c:otherwise>
			</c:choose>
		</section>
		<footer>
			<jsp:include page="../../inc/footer.jsp"></jsp:include>
		</footer>
</body>
</html>














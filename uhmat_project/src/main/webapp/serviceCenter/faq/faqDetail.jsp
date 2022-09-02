<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 글 보기</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<link href="css/faq/faqDetail.css" rel="stylesheet">
<style type="text/css">

</style>
</head>
<body>
	<jsp:include page="../../inc/header.jsp"></jsp:include>

	<!-- 게시판 상세내용 보기 -->
	<section id="articleForm">
		<h2>글 상세내용 보기</h2>
		<section id="basicInfoArea">
				<table border="1">
					<tr><th width="70">제 목</th><td colspan="3" >${faq.subject }</td></tr>
					<tr>
						<th width="70">작성자</th><td>${faq.nickname }</td>
						<th width="70">작성일</th><td>${faq.date }</td>
					</tr>
					<tr>
						<th>조회수</th><th>${faq.readcount }</th>
					<tr>
						<th width="70">첨부파일</th>
						<td>
						<!-- 
						파일명은 원본 파일명을 표시하고, 다운로드 파일 대상은 실제 업로드 파일명,
						실제 다운로드 되는 파일명은 원본 파일명으로 변경하여 다운로드
						-->
							<a href="upload/${faq.real_File }" download="${faq.original_File }">
							${faq.original_File }
							</a>
						</td>
					</tr>
				</table>
		</section>
		<br><br>
		<section id="articleContentArea">
			${faq.content }
		</section>
	</section>
	
		<section id="replyArea">
	<c:if test="${sessionScope.sNickName eq 'admin' and empty reply}"> 
			<section id="insertForm">
						<form action="FAQDetailReply.sc" style="position: relative; left: 40%; top:50%;">
							<!-- 댓글 전송 시 현재 게시물 글번호(idx)도 함께 전송 -->
							<input type="hidden" name="idx" value="${param.idx }">
							<!-- 댓글 전송 시 현재 게시물 닉네임(nickname) 함께 전송 -->
							<input type="hidden" name="nickname" value="${faq.nickname }">
							<!-- 페이지번호도 함께 전송 -->
							<input type="hidden" name="pageNum" value="${param.pageNum}">
							<textarea rows="3" cols="50" name="answer"></textarea>
							<input type="submit" value="등록">
						</form>
			</section>
	</c:if>
			<section id="replyViewArea" style="position: relative; left: 40%; top:50%;">
					<!-- ArrayList(replyList) 객체 크기만큼 for문 반복 -->
					<br>
					     <table>
			<c:if test="${ not empty reply }">
					     	<tr>
						     	<td>관리자 답변 : </td><td> ${reply.answer }</td>
						     </tr>
		    </c:if>
			<c:if test="${sessionScope.sNickName eq 'admin' }">
						     <tr>	
						     	<td><input type="button" value="삭제" onclick="location.href='FAQDetailReplyDelete.sc?idx=${faq.idx}&pageNum=${param.pageNum}'"></td>
					     	</tr>
			</c:if>
					     </table>
					<br>
			</section>
		</section>
		<section id="commandList" >
	<c:if test="${sessionScope.sNickName eq faq.nickname or sessionScope.sNickName eq faq.nickname or sessionScope.sNickName eq 'admin'}">
			<input type="button" value="수정" onclick="location.href='FAQModifyForm.sc?idx=${faq.idx}&pageNum=${param.pageNum}'">
			<input type="button" value="삭제" onclick="location.href='FAQDelete.sc?idx=${faq.idx}&pageNum=${param.pageNum}'">
	</c:if>
			<input type="button" value="목록" onclick="location.href='FAQList.sc?pageNum=${param.pageNum}&keyword=${param.keyword }'">
		</section>
		
		<jsp:include page="../../inc/footer.jsp"></jsp:include>
</body>
</html>

















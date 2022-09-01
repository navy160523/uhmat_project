<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice 글 보기</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
					<tr><th width="70">제 목</th><td colspan="3" >${notice.subject }</td></tr>
					<tr>
						<th width="70">작성자</th><td>${notice.nickname }</td>
						<th width="70">작성일</th><td>${notice.date }</td>
					</tr>
					<tr>
						<th width="70">첨부파일</th>
						<td>
						<!-- 
						파일명은 원본 파일명을 표시하고, 다운로드 파일 대상은 실제 업로드 파일명,
						실제 다운로드 되는 파일명은 원본 파일명으로 변경하여 다운로드
						-->
							<a href="upload/${notice.real_File }" download="${notice.original_File }">
							${notice.real_File }
							</a>
						</td>
					</tr>
				</table>
		</section>
		<section id="articleContentArea">
			${notice.content }
		</section>
	</section>
	<section id="commandList">
		<c:if test="${not empty sessionScope.sNickName and sessionScope.sNickName eq FAQ.nickname }">
		<input type="button" value="수정" onclick="location.href='NoticeModifyForm.sc?idx=${notice.idx}&pageNum=${param.pageNum}'">
			<input type="button" value="삭제" onclick="location.href='NoticeDelete.sc?idx=${notice.idx}&pageNum=${param.pageNum}'">
		</c:if>
		<input type="button" value="목록" onclick="location.href='NoticeList.sc?pageNum=${param.pageNum}'">
	</section>
	<jsp:include page="../../inc/footer.jsp"></jsp:include>
</body>
</html>

















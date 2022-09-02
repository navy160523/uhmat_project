<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 글 수정</title>
<style type="text/css">
	#modifyForm {
		width: 500px;
		height: 450px;
		border: 1px solid red;
		margin: auto;
	}
	
	h1 {
		text-align: center;
	}
	
	table {
		margin: auto;
		width: 450px;
	}
	
	.td_left {
		width: 150px;
		background: orange;
		text-align: center;
	}
	
	.td_right {
		width: 300px;
		background: skyblue;
	}
	
	#commandCell {
		text-align: center;
	}
</style>
</head>
<body>
	<jsp:include page="../../inc/header.jsp"></jsp:include>
	<!-- 게시판 글 수정 -->
	<section id="modifyForm">
		<h1>게시판 글 수정</h1>
		<form action="NoticeModify.sc" name="noticeModifyForm" method="post" enctype="multipart/form-data">
		<!-- 게시물 수정에 필요한 글번호와 페이징 처리에 필요한 페이지번호도 함께 전달 -->
		<input type="hidden" name="idx" value="${notice.idx }">
		<input type="hidden" name="pageNum" value="${param.pageNum }">
		<input type="hidden" name="real_File" value="${notice.real_File }">
			<table>
				<tr>
					<td class="td_left"><label for="name">글쓴이</label></td>
					<td class="td_right"><input type="text" name="nickname" value="${sessionScope.sNickName}" required="required" readonly="readonly" ></td>
				</tr>
				<tr>
					<td class="td_left"><label for="subject">제목</label></td>
					<td class="td_right"><input type="text" name="subject" value="${notice.subject}" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="content">내용</label></td>
					<td class="td_right"><textarea id="content" name="content" cols="40" rows="15" required="required" >${notice.content }</textarea></td>
				</tr>
				<tr>
					<td class="td_left"><label for="file">파일 첨부</label></td>
					<td class="td_right"><input name="file" type="file"> ${notice.original_File }</td>
				</tr>
				<tr>
					<td class="td_left"><label for="category">카테고리</label></td>
					<td colspan="3">
						<select id="selectBox" name="category">
							<option value="알림">알림</option>
							<option value="보도기사">보도기사</option>
						</select>
					</td>
				</tr>
			</table>
			<section id="commandCell">
				<input type="submit" value="수정">&nbsp;&nbsp;
				<input type="reset" value="다시쓰기">&nbsp;&nbsp;
				<input type="button" value="취소" onclick="history.back()">
			</section>
		</form>
	</section>
	<jsp:include page="../../inc/footer.jsp"></jsp:include>
</body>
</html>









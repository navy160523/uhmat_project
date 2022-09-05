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
<style type="text/css">
	.view {
		padding: 20px 20px 20px 20px;
		border-left: 1px solid #ccc;
		border-right: 1px solid #ccc;
		margin: auto;
		width: 800px;
		text-align: left;
	}
	
	
	.subject {
		font-size: x-large;
	}
	
	.nickname_time_readcount {
		font-size: small;
	}
	
	.btn input {
		border: 2px solid #FF1818;
		background-color: white;
		color: #FF1818;
		padding: 5px;
		border-radius: 5px
	}
	
	.btn input:hover {
		background-color: #FF1818;
		color: white;
	}
	
	.reply {
		border-bottom: 2px solid #FF1818;
	}
	
	.section input {
		border: 2px solid #FF1818;
		background-color: white;
		color: #FF1818;
		padding: 5px;
		border-radius: 5px
	}
	
	.section input:hover {
		background-color: #FF1818;
		color: white;
	}
	.nickname_time_readcount>i{
 		position: static;
	}
	
	.material-icons {
		position: static;
	}

	
</style>
<title>TMI 글 상세내용</title>
</head>
<body>

	&nbsp;
	<div class="view">
		<table width="800">
			<tr>
				<td class="subject">${tmiBoard.subject }</td> 
			</tr>
			<tr>
				<td class="nickname_time_readcount"><i class='fas fa-user-alt'></i> ${tmiBoard.nickname } | <i class="fa fa-clock-o"></i> ${tmiBoard.date } | <i class='far fa-eye'></i> ${tmiBoard.readcount }
				</td> 
			</tr>
			<tr>
				<td>${tmiBoard.content }</td>
			</tr>
	
		</table>
	&nbsp;
	
	<div class="btn">
		<c:if test="${sessionScope.sNickName == tmiBoard.nickname }">	
			<input type="button" value="수정" onclick="location.href='TmiModifyForm.co?idx=${tmiBoard.idx}&pageNum=${param.pageNum}'">
			<input type="button" value="삭제" onclick="location.href='TmiDeleteForm.co?idx=${tmiBoard.idx}&pageNum=${param.pageNum}'">
		</c:if>
			<input type="button" value="목록" onclick="location.href='TmiList.co?pageNum=${param.pageNum}'">
	</div>
	
	&nbsp;
	
	<table>
		<c:forEach items="${tmiReplyList }" var="tmiReply">
			<tr>
				<td>
					<c:forEach begin="1" end="${tmiReply.re_lev }">
						<i class="material-icons" style="font-size:20px;color:#F0A500">subdirectory_arrow_right</i>
					</c:forEach>
					${tmiReply.nickname } | ${tmiReply.date }
				</td>
				
			</tr>
			<tr>
			<td width="500" class="reply"> ${tmiReply.content } </td>
				<td class="btn"><input type="button" value="답글" onclick="location.href='TmiRereplyWriteForm.co?idx=${tmiReply.idx }&board_idx=${tmiReply.board_idx }&pageNum=${param.pageNum}'">
				</td>
				<c:if test="${sessionScope.sNickName == tmiReply.nickname }">
				<td class="btn"><input type="button" value="댓글수정" onclick="location.href='TmiReplyModifyForm.co?idx=${tmiReply.idx }&pageNum=${param.pageNum }'">
				</td>
				<td class="btn"><input type="button" value="댓글삭제" onclick="location.href='TmiReplyDeleteForm.co?idx=${tmiReply.idx }&board_idx=${tmiReply.board_idx }&nickname=${tmiReply.nickname }&pageNum=${param.pageNum }'">
				</td>
				</c:if>
			</tr>
		</c:forEach>
		</table>
		<br>
	<!-- 댓글 작성 -->
	<section class="section">
		<!-- insertForm 섹션(댓글 작성 영역)은 세션 아이디가 존재할 경우에만 출력 -->
		<section>
			<form action="TmiReplyWrite.co" style="position: relative; left:20%; top:50%;">
				<!-- 댓글 전송 시 현재 게시물 글번호(idx)도 함께 전송 -->
				<input type="hidden" name="idx" value="${param.idx }">
				<!-- 댓글 전송 시 현재 게시물 닉네임(nickname) 함께 전송 -->
				<input type="hidden" name="nickname" value="${sessionScope.sNickName }">
				<!-- 페이지번호도 함께 전송 -->
				<input type="hidden" name="pageNum" value="${param.pageNum}"> 
			
				<textarea rows="3" cols="50" name="content"></textarea>
				<br>
				<input type="submit" class="section" value="등록" style="position: relative; left:20%;">
			</form>
		</section>
	</section>
		
	</div>
	


</body>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	#articleForm {
		width: 500px;
		height: 550px;
		border: 1px solid red;
		margin: auto;
	}
	
	h2 {
		text-align: center;
	}
	
	table {
		border: 1px solid black;
		border-collapse: collapse; 
	 	width: 500px;
	}
	
	th {
		text-align: center;
	}
	
	td {
		width: 150px;
		text-align: center;
	}
	
	#basicInfoArea {
		height: 70px;
		text-align: center;
	}
	
	#articleContentArea {
		background: Lightcoral;
		margin-top: 20px;
		height: 350px;
		text-align: center;
		overflow: auto;
		white-space: pre-line;
	}
	
	#commandList {
		margin: auto;
		width: 500px;
		text-align: center;
	}
</style>
<title>TMI 글 상세내용</title>
</head>
<body>
	<section id="articleForm">
		<h2>TMI 끄적임 상세 내용</h2>
		<section id="basicInfoArea">
		<table border="1">
			<tr><th width="70">제 목</th><td colspan="3" >${tmiBoard.subject }</td></tr>
			<tr>
				<th width="70">작성자</th><td>${tmiBoard.nickname }</td>
				<th width="70">작성일</th><td>${tmiBoard.datetime }</td>
			<tr>
				<th width="70">조회수</th>
				<td>${tmiBoard.readcount }</td>
			</tr>
			
		</table>
	</section>
	<section id="articleContentArea">
		${tmiBoard.content }
		</section>
	</section>
	
	<hr>
	<section>
		<input type="button" value="수정" onclick="location.href='TmiModifyForm.co?idx=${tmiBoard.idx}&pageNum=${param.pageNum}'">
		<input type="button" value="삭제" onclick="location.href='TmiDeleteForm.co?idx=${tmiBoard.idx}&pageNum=${param.pageNum}'">
		<input type="button" value="목록" onclick="location.href='TmiList.co?pageNum=${param.pageNum}'">
	</section>
	<hr>
	<!-- 댓글 리스트 -->
		<table border="1">
      		<c:forEach var="tmiReply" items="${tmiReplyList }">
        	 <tr>
				<td>닉네임 : ${tmiReply.nickname } | ${tmiReply.content } 
					<br>
				${tmiReply.date }
				</td> 
			</tr>
			<tr>
				<td><input type="button" value="수정" onclick="location.href='TmiReplyModifyForm.co?idx=${tmiReply.idx}&pageNum=${param.pageNum }'"></td>
				<td><input type="button" value="삭제" onclick="location.href='TmiReplyDeleteForm.co?idx=${tmiReply.idx}&board_idx=${tmiReply.board_idx }&nickname=${tmiReply.nickname }&pageNum=${param.pageNum }'"></td>
				<td>
				<input type="button" value="답글" onclick="location.href='TmiRereplyWriteForm.co?idx=${tmiReply.idx }&board_idx=${tmiReply.board_idx }&nickname=${tmiReply.nickname }&pageNum=${param.pageNum}'">
				</td>
			</tr>
     		</c:forEach>
     		
     		<!-- 답글 리스트 -->
     		<c:choose>
     			<c:when test="${not empty tmiRereplyList }">
     				<c:forEach var="tmiRereply" items="${tmiRereplyList }">
     					<tr>
     						<td>
     							<c:forEach var="tmiRereply" begin="1" end="${tmiRereply.re_lev }">
     								&nbsp;&nbsp;
     							</c:forEach>
     							${tmiRereply.content }
     						 </td>
     					</tr>
     				</c:forEach>
     			</c:when>
     			<c:otherwise>
				<tr><td colspan="5">게시물이 존재하지 않습니다.</td></tr>
			</c:otherwise>
     		</c:choose>

      </table>
	<br>
	
	<!-- 댓글 작성 -->
	<section id="replyArea">
		<!-- insertForm 섹션(댓글 작성 영역)은 세션 아이디가 존재할 경우에만 출력 -->
		<section id="insertForm">
			<form action="TmiReplyWrite.co" style="position: relative; left: 40%; top:50%;">
				<!-- 댓글 전송 시 현재 게시물 글번호(idx)도 함께 전송 -->
				<input type="hidden" name="idx" value="${param.idx }">
				<!-- 댓글 전송 시 현재 게시물 닉네임(nickname) 함께 전송 -->
				
				<!-- 페이지번호도 함께 전송 -->
				<input type="hidden" name="pageNum" value="${param.pageNum}">
				<textarea rows="3" cols="50" name="content"></textarea>
				<input type="submit" value="등록">
			</form>
		</section>
	</section>
</body>
</html>
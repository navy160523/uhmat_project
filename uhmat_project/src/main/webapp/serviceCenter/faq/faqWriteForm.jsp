<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 글 등록</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
	<!-- Font Awesome icons (free version)-->
	<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
 	<!-- Google fonts-->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />

	<!-- Core theme CSS (includes Bootstrap)-->
	<link href="css/styles.css" rel="stylesheet" />
<style type="text/css">
</style>
</head>
<body>
	<jsp:include page="../../inc/header.jsp"></jsp:include>
	
	<section id="writeForm">
	<h2>FAQ게시판 글 등록</h2>
		<form action="FAQWritePro.sc" method="post" enctype="multipart/form-data" name="boardform">
			<table border="1">
				<tr>
					<td class="td_left"><label for="nickname">글쓴이</label></td>
					<td class="td_right"><input type="text" name="nickname" id="nickname" required="required" value="${sessionScope.sNickName }"/></td>
				</tr>
				<tr>
					<td class="td_left"><label for="subject">제목</label></td>
					<td class="td_right"><input name="subject" type="text" id="subject" required="required" /></td>
				</tr>
				<tr>
					<td class="td_left"><label for="content">내용</label></td>
					<td><textarea id="content" name="content" cols="40"	rows="15" required="required"></textarea></td>
				</tr>
				<tr>
					<td class="td_left"><label for="file">파일 첨부</label></td>
					<td class="td_right"><input name="file" type="file" id="file" /></td>
				</tr>
				<tr>
					<td class="td_left"><label for="category">카테고리</label></td>
					<td colspan="3">
						<select id="selectBox" name="category">
							<option value="오류신고">오류신고</option>
							<option value="음식점등록">음식점등록</option>
							<option value="자도 오류">지도 오류</option>
						</select>
					</td>
				</tr>
			</table>
			<section id="commandCell">
				<input type="submit" value="등록"> &nbsp;&nbsp;
				<input type="reset" value="다시쓰기" /> &nbsp;&nbsp;
				<input type="button" value="취소" onclick="history.back()">
			</section>
		</form>
	</section>
	<jsp:include page="../../inc/footer.jsp"></jsp:include>
</body>
</html>
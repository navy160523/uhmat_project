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
	<h1>ReviewModifyForm</h1>
	<section>
		<form  action="ReviewModifyProAction.re" method="post" enctype="multipart/form-data">
			<input type="hidden" name="idx" value="${dto.idx }">
			<input type="hidden" name="originPath" value="${orginPath }">
			<table border="1">

				<tr>
					<td>작성자&nbsp;<input type="text" name="nickname" value="${dto.nickname }" readonly="readonly"></td>
					<!--  회원가입 로그인이 연동되면 nickname을 세션값으로받습니다. -->
				</tr>
				<tr>
					<td><input type="text" name="subject" placeholder="${dto.subject }" required="required"></td>
				</tr>
				<tr>
					<td><input type="text" name="Tag" value="tag"></td> 
					<!-- select box 를 통한 추가 조사 
						DB에 추가해야함
					-->
				</tr>
				<tr>
					<td><input type="text" name="res_name" placeholder="${dto.res_name }" required="required">&nbsp;<button>찾기</button></td>
					
					<!-- 지도 api와 연동 -->
				</tr>
				<tr>
					<td><input type="text" name="rating" placeholder="${dto.rating }" required="required"></td>
				</tr>
				<tr>
					<td><textarea rows="20" cols="100" name="content" placeholder="${dto.content }" required="required"></textarea></td>
				</tr>
				<tr>
					<!-- 파일 첨부 형식은 input 태그의 type="file" 속성 사용 -->
					<td>이전 파일 : ${dto.photo }<input type="file" name="photo" required="required" /></td>
				</tr>
			</table>
		<section>
			<input type="submit" value="수정해버렷">
		</section>
		</form>
	</section>
</body>
</html>
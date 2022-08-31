<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<<<<<<< HEAD:uhmat_project/src/main/webapp/food/review/reviewDetailView.jsp

</head>
<body>
	<h1>ReviewDetailView.jsp</h1>
	<nav>
		<details>
			<summary>∙∙∙(more button)</summary> <!-- 이 부분은 로그인 되어 있는 경우에만 사용 가능  세션이 없을 경우
			alert("로그인이 필요합니다") 처리-->
			<a href="ReviewModifyForm.re?idx=${dto.idx }">수정</a>
			<a href="ReviewDelete.re">삭제</a>
		</details>
	</nav>
	<section>
		<table border ="2">
			<tr>
				<th>작성자</th><td >${dto.nickname }</td>
				<!--  회원가입 로그인이 연동되면 nickname을 세션값으로받습니다. -->
			</tr>
			<tr>
				<th>주제</th><td>${dto.subject }</td>
			</tr>
			<tr>
				<th>Tag</th><td>#해쉬 #태그 #구현 #드가자</td> 
				<!-- select box 해쉬태그 제시를 통한 추가 조사 selectbox를DB에 추가해야함?
					
				-->
			</tr>
			<tr>
				<th>음식점정보</th><td>${dto.res_name }</td>
				<!-- 지도 api와 연동 -->
			</tr>
			<tr>
				<th>별점</th><td>${dto.rating }</td> <!--  CSS 로 구현 -->
			</tr>
			<tr>
				<th>내용</th><td><textarea rows="20" cols="100">${dto.content }</textarea></td>
			</tr>
			<tr>
				<th></th><td><input type="button" value="좋아요">&nbsp;<input type="button" value="댓글작성버튼">&nbsp;<input type="button" value="공유버튼"></td>				</tr>
			<tr>
				<!-- 파일 첨부 형식은 input 태그의 type="file" 속성 사용 -->
				<th>이미지</th><td width="200" height="300"><img width="90%" src="upload/${dto.photo }" alt="파일"></td>
			</tr>
=======
</head>
<body>
	<h1>ReviewDetailView.jsp</h1>
	<section>
		<table border ="2">
			<tr>
				<th>작성자</th><td>${dto.nickname }</td>
					<!--  회원가입 로그인이 연동되면 nickname을 세션값으로받습니다. -->
				</tr>
				<tr>
					<th>주제</th><td>${dto.subject }</td>
				</tr>
				<tr>
					<th>Tag</th><td>#....</td> 
					<!-- select box 를 통한 추가 조사 
						DB에 추가해야함
					-->
				</tr>
				<tr>
					<th>음식점정보</th><td>${dto.res_name }</td>
					
					<!-- 지도 api와 연동 -->
				</tr>
				<tr>
					<th>별점</th><td>${dto.rating }</td>
				</tr>
				<tr>
					<th>내용</th><td><textarea rows="20" cols="100">${dto.content }</textarea></td>
				</tr>
				<tr>
					<!-- 파일 첨부 형식은 input 태그의 type="file" 속성 사용 -->
					<th>이미지</th><td width="200" height="300"><img src="upload/${dto.photo }" alt="파일"></td>
				</tr>
			
>>>>>>> master:uhmat_project/src/main/webapp/RestaurantCategory/reviewDetailView.jsp
		</table>
	</section>
</body>
</html>
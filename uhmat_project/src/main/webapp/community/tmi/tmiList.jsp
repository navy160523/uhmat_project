<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	
	<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
	<!-- Font Awesome icons (free version)-->
	<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
 	<!-- Google fonts-->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />

	<!-- Core theme CSS (includes Bootstrap)-->
	<link href="css/styles.css" rel="stylesheet" />


<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>

<style type="text/css">
	#menuBar button {
		border: 2px solid #7FB77E;
		background-color: white;
		color: #7FB77E;
		padding: 5px;
		border-radius: 5px
	
	}
	
	#menuBar button:hover {
		background-color: #7FB77E;
		color: white;
	}
	
	h2 {
		text-align: center;
	}

	.tmiList {
		margin: auto;
		width: 800px;
		text-align: center;
		
	}
	
	.tmiList td {
		border-bottom: 2px solid #ccc;
	}
	
	.link a {
		text-decoration: none; 
		color: black; 
	}
	
	.search {
 		padding: 3px; 
		border: 2px solid #7FB77E;
		background-color:white;
		border-radius: 5px;
	}
	
	.searchIcon {
		padding: 2px; 
		border: 2px solid #7FB77E;
		background-color: white;
		border-radius: 5px;
		color: #717171;
	}
	
	
	.before_next {
		border: 2px solid #7FB77E;
		background-color: white;
		border-radius: 5px;
		color: #717171;
	}
	
</style>
</head>
<body>

	<!-- 헤더 들어가는 곳 -->
	<jsp:include page="../../inc/header.jsp"/>
	<!-- 헤더 들어가는 곳 -->
	
	<!-- 배너, 메뉴바 -->
	<div align="center">
		<img alt="TMI 배너" src="./image/tmi/tmi_banner.PNG">
	</div>
	
	<div align="center" id="menuBar" style="position: relative; right: 0px; top:-40px;">
		<button onclick="location.href='MateList.co'">mate_list</button>
		<button onclick="location.href='TmiList.co'">tmi_list</button>
		<button onclick="location.href='RecipeList.co'">recipte_list</button>
		<br>
	</div>
	<!-- 배너, 메뉴바 끝 -->
	
	
	<!-- 게시판리스트 -->
   <table class="tmiList">
 	 <thead>
    	<tr>
	      <th scope="col">작성자</th>
	      <th scope="col">제목</th>
	      <th scope="col">조회수</th>
	      <th scope="col">등록일</th>
   		</tr>
 	 </thead>

		<tbody>
		 <c:choose>
			<c:when test="${not empty tmiBoardList and tmiPageInfo.listCount gt 0 }">
					<c:forEach var="tmi" items="${tmiBoardList }">
						<tr>
							<td>${tmi.nickname }</td>
							<td class="link" width="350" height="50">
							<a href="TmiDetail.co?idx=${tmi.idx }&pageNum=${tmiPageInfo.pageNum}">${tmi.subject }</a> 
							</td>
							<td>${tmi.readcount }</td>
							<td>${tmi.date }</td>
						</tr>
	
					</c:forEach>
			</c:when>
		
			<c:when test="${not empty tmiPageInfo.listCount }">
				<c:forEach var="tmiBoardList" items="${tmiBoardList }"> 
					<tr>
						<td>${tmiBoardList.idx }</td>
						<td class="link" width="350" height="50">
							<a href="TmiDetail.co?idx=${tmiBoardList.idx }&pageNum=${tmiPageInfo.pageNum}&keyword=${param.keyword }">
								${tmiBoardList.subject }
							</a>
						</td>
						<td>${tmiBoardList.nickname }</td>
						<td>${tmiBoardList.date }</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr><td colspan="5"> 게시물이 존재하지 않습니다</td></tr> 			
			</c:otherwise>
 		</c:choose>	 
  		</tbody>
	</table>
	<br>
	<!-- 검색 창 -->
		<div align="center">
			<form>
				<input type="text" class="search" placeholder="Search" name="keyword" value="${param.keyword }">
				<input class="searchIcon" type="submit" value="검색">
			</form>
		</div>

      
	<!-- 버튼 창 -->
	<div align="right" >
		<button type="button" class="btn btn-primary" onclick="location.href='TmiWriteForm.co'">글쓰기</button>
		<button type="button" class="btn btn-primary" onclick="location.href='./'">메인</button>
	</div>
	
	<!-- 
	현재 페이지 번호(pageNum)가 1보다 클 경우에만 [이전] 링크 동작
	=> 클릭 시 TmiList.jsp 로 이동하면서 
	   현재 페이지 번호(pageNum) - 1 값을 page 파라미터로 전달
	-->
	<div align="center">
   			<c:choose>
				<c:when test="${tmiPageInfo.pageNum > 1 }">
					<input type="button" value="이전" class="before_next" onclick="location.href='TmiList.co?pageNum=${tmiPageInfo.pageNum - 1}&keyword=${param.keyword }'">
				</c:when>
				<c:otherwise>
					<input type="button" value="이전" class="before_next" disabled="disabled">
				</c:otherwise>
			</c:choose>
   		
   		
   		<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
   		
   			<c:forEach var="i" begin="${tmiPageInfo.startPage }" end="${tmiPageInfo.endPage }" >
			<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
			<c:choose>
				<c:when test="${tmiPageInfo.pageNum eq i}">
   					${i }
   				</c:when>
				<c:otherwise>
					<a href="TmiList.co?pageNum=${i}&keyword=${param.keyword }">${i}</a>
				</c:otherwise>
			</c:choose>
			</c:forEach>
   		
   		
    <!-- 현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 [다음] 링크 동작 -->
		
			<c:choose>
				<c:when test="${tmiPageInfo.pageNum lt tmiPageInfo.maxPage}">
					<input type="button" value="다음" class="before_next" onclick="location.href='TmiList.co?pageNum=${tmiPageInfo.pageNum + 1}&keyword=${param.keyword }'">
				</c:when>
			<c:otherwise>
				<input type="button" value="다음" class="before_next" disabled="disabled">
			</c:otherwise>
			</c:choose>
	</div>

	<!-- 푸터 들어가는 곳 -->
	<jsp:include page="../../inc/footer.jsp"/>
	<!-- 푸터 들어가는 곳 -->
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<!-- * *                               SB Forms JS                               * *-->
	<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>
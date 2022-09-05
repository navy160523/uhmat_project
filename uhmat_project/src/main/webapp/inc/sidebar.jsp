<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var currentPosition = parseInt($(".quickmenu").css("top"));
	  	$(window).scroll(function() {
	    	var position = $(window).scrollTop(); 
	    	$(".quickmenu").stop().animate({"top":position+currentPosition+"px"},1000);
	  	});
	});
</script>
<link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet" type="text/css">
</head>
<body>
	<section id="secSide">
		<div class="quickmenu">
	 		<ul>
		    	<li><a href="#header">TOP</a></li>
			    <li><a href="NoticeList.sc">공지사항</a></li>
			    <li><a href="#footer">DOWN</a></li>
	  		</ul>
		</div>
	</section>	
</body>
</html>
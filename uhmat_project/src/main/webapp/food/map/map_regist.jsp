<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="MapRegist.map" method="get">
		<table border="1">
			<tr>
				<th>음식점이름 : </th><td><input type="text" name="resName"></td>
			</tr>
			<tr>				
				<th>위도 : </th><td><input type="text" name="latitude"></td>
			</tr>
			<tr>			
				<th>경도 : </th><td><input type="text" name="logitude"></td>
				<td><input type="submit" value="등록"></td>
			</tr>
		</table>
	</form>
</body>
</html>
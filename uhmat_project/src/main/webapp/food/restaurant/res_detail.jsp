<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <h2>${resInfo.resName } <small style="font-size: 0.5em">${resInfo.rating } <a href="#">${resInfo.reviewCount }개의 리뷰</a></small></h2>
	<img src="upload/${resInfo.photo }" width="200">
        <table>
            <tr>
       			<th><i class="fa fa-phone-square" style="font-size:48px;color:red"></i> </th>
       			<td>${resInfo.phoneNumber }</td>
            </tr>
            <tr>
       			<th>월요일 </th>
       			<td>${mon } </td>
            </tr>
            <tr>
       			<th>화요일 </th>
       			<td>${tue } </td>
            </tr>
            <tr>
       			<th>수요일 </th>
       			<td>${wed } </td>
            </tr>
            <tr>
       			<th>목요일 </th>
       			<td>${thu } </td>
            </tr>
            <tr>
       			<th>금요일 </th>
       			<td>${fri } </td>
            </tr>
            <tr>
       			<th>토요일 </th>
       			<td>${sat } </td>
            </tr>
            <tr>
       			<th>일요일 </th>
       			<td>${sun } </td>
            </tr>
            <tr>
       			<th>식당 상세정보: </th>
       			<td>${resInfo.resInfo } </td>
            </tr>
            <tr>
       			<th><a href="${resInfo.resLink }">식당링크 </a></th>
       			<td> </td>
            </tr>
            <tr>
                <td colspan="4"></td>
            </tr>
        </table>
</body>
</html>
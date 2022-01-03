<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CoCoa</title>
<link href="resources/css/styles.css" rel="stylesheet" />
</head>
<body>

	<br>
	<br>
	<br>
	<!-- 사이드 메뉴 -->
	<h2>
		<input type="button" class="btn btn-primary" name="side_profile"
			id="profile" value="프로필"
			onClick="location.href='/cocoa/view_myPageProfile'"
			style="text-align: center; color: white; background-color: #333333; font-size: 25px; border: 0; width: 100%;"><br>

		<br> <br> <input type="button" class="btn btn-primary"
			name="side_send" id="sendReq" value="보낸 요청"
			onClick="location.href='/cocoa/view_sendReq'"
			style="text-align: center; color: white; background-color: #333333; font-size: 25px; border: 0; width: 100%;"><br>

		<br> <br> <input type="button" class="btn btn-primary"
			name="side_get" id="receiveReq" value="받은 요청"
			onClick="location.href='/cocoa/view_receiveReq'"
			style="text-align: center; color: white; background-color: #333333; font-size: 25px; border: 0; width: 100%;"><br>

		<br> <br> <input type="button" class="btn btn-primary"
			name="side_info" id="memberInfo" value="회원 정보"
			onClick="location.href='/cocoa/view_memberInfo'"
			style="text-align: center; color: white; background-color: #333333; font-size: 25px; border: 0; width: 100%;"><br>
		<br> <br>
	</h2>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" />
<link href="resources/css/styles.css" rel="stylesheet" />
<script type="text/javascript" src="resources/js/jquery-3.6.0.min.js"></script>
<title>CoCoa</title>
</head>
<body>

	<!-- 상단바 -->
	<nav class="navbar navbar-expand-lg"
		style="background-color: #663333; width: 100%;">

		<!-- 로고 -->
		<span style="margin: 0 auto; padding-left: 430px; height: 100%;">
			<a class="navbar-brand" href="/cocoa/"
			style="color: #CFFFE5; font-size: 40px;"
			onmouseover="this.style.color='black';"
			onmouseout="this.style.color='#CFFFE5';"><b>CoCoa</b></a>
		</span>

		<!-- 사용자 환영합니다. -->
		<c:choose>
			<c:when test="${isLogOn == true && member != null}">
				<div style="font-size: 15px; color: #CFFFE5;">
					<b>${member.id}님 환영합니다.</b>&nbsp;&nbsp;&nbsp;
				</div>
			</c:when>
			<c:otherwise>
				<div style="font-size: 15px; color: white;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			</c:otherwise>
		</c:choose>

		<!-- 우측 상단 변경 -->
		<span style="padding-right: 80px;"> <c:choose>
				<c:when test="${isLogOn == true && member != null}">
					<form action="/cocoa/logout" method="get" class="d-flex">
						<input name="My Page" class="btn btn-outline-dark" type="button"
							value="My Page"
							onClick="location.href='/cocoa/view_myPageProfile'" />&nbsp;<input
							name="logout" class="btn btn-outline-dark" type="submit"
							value="Logout" />
					</form>
				</c:when>
				<c:otherwise>
					<form action="/cocoa/view_login" method="get" class="d-flex">
						<c:set var="path"
							value="${requestScope['javax.servlet.forward.servlet_path']}" />
						<c:choose>
							<c:when test="${path.contains('coach') }">
								<input type="hidden" name="view" value="view_coachCate">
							</c:when>
							<c:when test="${path.contains('project') }">
								<input type="hidden" name="view" value="view_projectCate">
							</c:when>
							<c:otherwise>
								<input type="hidden" name="view" value="">
							</c:otherwise>
						</c:choose>
						<input name="login" class="btn btn-outline-dark" type="submit"
							value="Login" />&nbsp; <input name="join"
							class="btn btn-outline-dark" type="button" value="Sign in"
							onClick="location.href='/cocoa/view_join'" />
					</form>
				</c:otherwise>
			</c:choose>
		</span>
	</nav>

</body>
</html>
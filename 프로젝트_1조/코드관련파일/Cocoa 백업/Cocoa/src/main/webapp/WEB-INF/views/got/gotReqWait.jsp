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
<script type="text/javascript">
	$(document).ready(function() {
		$('#receiveReq').css('background-color', 'black');
	});
</script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD; font-family: none;">

	<!-- 상단바 -->
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- 받은 요청 클릭 (대기) -->
	<div class="row" style="flex-wrap: unset; width: 80%;">

		<!-- 좌측 메뉴 -->
		<div class="col-sm-2 side"
			style="background-color: #333333; text-align: center; width: auto;">
			<jsp:include page="../myPage/side.jsp"></jsp:include>
		</div>

		<!-- 우측 내용 -->
		<div class="col-sm-10" style="min-height: 80.7vh;">
			<c:if test="${requestInfo.status == 'status2'}">
				<div id="main"><jsp:include page="gotYes.jsp"></jsp:include></div>
			</c:if>
			<c:if test="${requestInfo.status == 'status1'}">
				<div id="main"><jsp:include page="gotWait.jsp"></jsp:include></div>
			</c:if>
			<c:if test="${requestInfo.status == 'status3'}">
				<div id="main"><jsp:include page="gotNo.jsp"></jsp:include></div>
			</c:if>
			<c:if test="${requestInfo.status == 'status4'}">
				<div id="main"><jsp:include page="gotFin.jsp"></jsp:include></div>
			</c:if>
		</div>

	</div>

	<!-- 하단바 -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>
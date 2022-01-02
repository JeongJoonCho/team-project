<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/styles.css" rel="stylesheet" />
<script type="text/javascript" src="resources/js/jquery-3.6.0.min.js"></script>
<style type="text/css">
th, td {
	padding: 6px;
	color: black;
}
</style>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD">

	<!-- 받은 요청 (수락) -->
	<div class="card rcol my-5"
		style="text-align: center; background-color: #FFEBCD; border: none; width: 80vw; height: 90vh;">
		<form action="${contextPath}/submitReqYes" method="post">
			<table
				style="width: 80%; margin: 0 auto; border: 1px solid black; background-color: #FFCC99; color: black;">
				<tr>
					<td colspan="2"
						style="text-align: center; border: 1px solid black; background-color: #CFFFE5;"><b>수락한
							${requestInfo.req}의 요청서</b></td>
				</tr>

				<!-- rTitle -->
				<tr>
					<td style="text-align: center; width: 15%;"><br> <b>제
							목</b></td>
					<td style=""><br> <input type="text" id="" name="rTitle"
						class="form-control" value="${requestInfo.rTitle}" readonly
						style="width: 95%; background-color: #FFCC99; border: 1px solid grey; color: black;">
						<input type="hidden" name="req" value="${requestInfo.req}">
						<input type="hidden" name="res" value="${requestInfo.res}">
						<input type="hidden" name="reqNO" value="${requestInfo.reqNO}">
						<input type="hidden" name="status" value="${requestInfo.status}">
					</td>
				</tr>

				<!-- rContents -->
				<tr>
					<td style="text-align: center; vertical-align: top;" class="pt-1">
						<b>내 용</b>
					</td>
					<td style="text-align: left; vertical-align: top;"><textarea
							rows="10" cols="20" class="form-control" id="" name="rContents"
							readonly
							style="width: 95%; resize: none; background-color: #FFCC99; border: 1px solid grey; color: black;">${requestInfo.rContents}</textarea></td>
				</tr>

				<!-- 첨부파일 다운로드 -->
				<tr>
					<td style="text-align: center;"><b>첨부파일</b><br> <br></td>
					<td style="float: left;"><a
						href="${contextPath}/downloadGotImg?reqNO=${requestInfo.reqNO}">${requestInfo.rImg}</a><br>
						<br></td>
				</tr>

				<!-- 수락정보 -->
				<tr>
					<td colspan="2"
						style="text-align: center; border: 1px solid black; background-color: #CFFFE5;"><b>수락
							정보</b></td>
				</tr>

				<!-- contact -->
				<tr>
					<td style="text-align: center; width: 15%;"><br> <b>연결수단</b></td>
					<td style=""><br> <input type="text" id="" name="contact"
						class="form-control" value="${requestInfo.contact}"
						placeholder="${requestInfo.contact}"
						style="width: 30%; background-color: #FFCC99; border: 1px solid black; color: black;">
					</td>
				</tr>

				<!-- realPrice -->
				<tr>
					<td style="text-align: center; width: 15%;"><b>요 금</b></td>
					<td style=""><input type="number" id="" name="realPrice"
						class="form-control" value="${requestInfo.realPrice}"
						style="width: 30%; background-color: #FFCC99; border: 1px solid black; color: black; float: left;"><b
						style="float: left; padding-top: 7px; margin-left: 3px;">원</b></td>
				</tr>

				<!-- 공지사항 -->
				<tr>
					<td style="text-align: center; width: 15%; vertical-align: top;"><b>공지사항</b></td>
					<td style=""><textarea id="" name="reason" rows=3
							class="form-control" placeholder="${requestInfo.reason}"
							style="width: 95%; background-color: #FFCC99; border: 1px solid black; color: black; resize: none;">${requestInfo.reason}</textarea>
					</td>
				</tr>

				<!-- 재전송, 취소 -->
				<tr>
					<td align="center" colspan="2"><br> <input type="submit"
						id="" class="btn btn-outline-dark mt-1"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						value="재 전 송" />&nbsp;&nbsp;&nbsp; <input type="button" id=""
						class="btn btn-outline-dark mt-1"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						onclick="history.back()" value="취 소" /><br> <br>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>
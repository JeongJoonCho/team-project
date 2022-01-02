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
<script type="text/javascript">
	function nullCheck() {
		var _contact = $('#contact').val();
		var _realPrice = $("#realPrice").val();
		var _reason = $("#reason").val();
		if (_contact == "" || _realPrice == "" || _reason == "") {
			alert("빈칸 없이 입력하세요");
			$('#submitReqYes').attr('onSubmit', "return false;");
		} else {
			$('#submitReqYes').removeAttr('onSubmit');
		}
	}
</script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD">

	<!-- 받은 요청 대기 (수락 전송) -->
	<div class="card rcol my-5"
		style="text-align: center; background-color: #FFEBCD; border: none; width: 80vw; height: 90vh;">
		<form action="${contextPath}/submitReqYes" method="post"
			id="submitReqYes">
			<table
				style="width: 80%; margin: 0 auto; border: 1px solid black; background-color: #FFCC99; color: black;">
				<tr>
					<td colspan="2"
						style="text-align: center; border: 1px solid black; background-color: #CFFFE5;"><b>요청서
							수락</b></td>
				</tr>

				<!-- contact -->
				<tr>
					<td style="text-align: center; width: 15%;"><br> <b>연결수단</b></td>
					<td style=""><br> <input type="text" id="contact"
						name="contact" class="form-control" value=""
						placeholder="연결수단의 링크를 입력하세요."
						style="width: 95%; background-color: #FFCC99; border: 1px solid black; color: black;">
						<input type="hidden" name="reqNO" value="${requestInfo.reqNO}">
						<input type="hidden" name="status" value="status2"></td>
				</tr>

				<!-- realPrice -->
				<tr>
					<td style="text-align: center; width: 15%;"><b>요 금</b></td>
					<td style=""><input type="number" id="realPrice"
						name="realPrice" class="form-control"
						value="${requestInfo.realPrice}"
						style="width: 95%; background-color: #FFCC99; border: 1px solid black; color: black;">
					</td>
				</tr>

				<!-- 공지사항 -->
				<tr>
					<td style="text-align: center; width: 15%;"><b>공지사항</b></td>
					<td style=""><textarea id="reason" name="reason" rows=3
							class="form-control" placeholder="요청자에게 알릴 공지사항을 입력하세요."
							style="width: 95%; background-color: #FFCC99; border: 1px solid black; color: black; resize: none;"></textarea>
					</td>
				</tr>

				<!-- 전송, 취소 -->
				<tr>
					<td align="center" colspan="2"><input type="submit" id=""
						onclick="nullCheck()" class="btn btn-outline-dark mt-1"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						value="전 송" />&nbsp;&nbsp;&nbsp; <input type="button" id=""
						class="btn btn-outline-dark mt-1"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						onclick="history.back()" value="취 소" />
				</tr>
			</table>
		</form>
	</div>

</body>
</html>
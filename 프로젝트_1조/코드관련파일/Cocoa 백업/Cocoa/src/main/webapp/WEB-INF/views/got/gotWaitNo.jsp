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
		var _reason = $("#reason").val();
		if (_reason == "") {
			alert("거절 사유를 작성해주세요");
			$('#submitNoReason').attr('onSubmit', "return false;");
		} else {
			$('#submitNoReason').removeAttr('onSubmit');
		}
	}
</script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD">

	<!-- 받은 요청 대기 (거절 전송) -->
	<div class="card rcol my-5"
		style="text-align: center; background-color: #FFEBCD; border: none; width: 80vw; height: 90vh;">
		<form action="${contextPath}/submitNoReason" method="post" id="submitNoReason">
			<table
				style="width: 80%; margin: 0 auto; border: 1px solid grey; background-color: #FFCC99; color: black;">
				<tr>
					<td colspan="2"
						style="text-align: center; border: 1px solid black; background-color: #CFFFE5;"><b>요청서
							거절</b></td>
				</tr>

				<!-- reason -->
				<tr>
					<td style="text-align: center; width: 15%;"><br> <b>거절사유</b></td>
					<td style=""><br> <input type="text" id="reason" name="reason"
						class="form-control" value="" placeholder="거절사유를 입력하세요."
						style="width: 95%; background-color: #FFCC99; border: 1px solid grey; color: black;">
						<input type="hidden" name="reqNO" value="${reqNO}" /> <input
						type="hidden" name="status" value="status3"></td>
				</tr>

				<!-- 전송, 취소 -->
				<tr>
					<td align="center" colspan="2"><input type="submit" onclick="nullCheck()"
						class="btn btn-outline-dark mt-1"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						value="전 송" /> <input type="button" value="취 소"
						onclick="history.back()" class="btn btn-outline-dark mt-1"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';">
				</tr>
			</table>
		</form>
	</div>

</body>
</html>
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
	function yesOrNo() {
		if (confirm("철회하시겠습니까?")) {
			location.href = '/cocoa/removeRequest?reqNO=${requestInfo.reqNO}'// Yes click
		} else {
			// no click
		}
	}
</script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD">

	<!-- 보낸 요청 (거절) -->
	<div class="card rcol my-5"
		style="text-align: center; background-color: #FFEBCD; border: none; width: 80vw; height: 90vh;">
		<table
			style="width: 80%; margin: 0 auto; border: 1px solid grey; background-color: #FFCC99; color: black;">
			<tr>
				<td colspan="2"
					style="text-align: center; border: 1px solid black; background-color: #CFFFE5;"><b>거절된
						나의 요청서</b></td>
			</tr>

			<!-- rTitle -->
			<tr>
				<td style="text-align: center; width: 15%;"><br> <b>제
						목</b></td>
				<td style=""><br> <input type="text" id="rTitle"
					name="rTitle" class="form-control" value="${requestInfo.rTitle}"
					disabled
					style="width: 95%; background-color: #FFCC99; border: 1px solid grey; color: black;">
					<input type="hidden" name="req" value="${requestInfo.req}">
					<input type="hidden" name="res" value="${requestInfo.res}">
					<input type="hidden" name="reqNO" value="${requestInfo.reqNO}">
				</td>
			</tr>

			<!-- rContents -->
			<tr>
				<td style="text-align: center; vertical-align: top;" class="pt-1">
					<b>내 용</b>
				</td>
				<td style="text-align: left; vertical-align: top;"><textarea
						rows="10" cols="20" class="form-control" id="rContents"
						name="rContents" disabled
						style="width: 95%; resize: none; background-color: #FFCC99; border: 1px solid grey; color: black;">${requestInfo.rContents}</textarea></td>
			</tr>

			<!-- 첨부파일 다운로드 -->
			<tr>
				<td style="text-align: center;"><b>첨부파일</b><br> <br></td>
				<td style="float: left;"><a
					href="${contextPath}/downloadGotImg?reqNO=${requestInfo.reqNO}">${requestInfo.rImg}</a>
				</td>
			</tr>

			<!-- 거절 사유 -->
			<tr>
				<td colspan="2"
					style="text-align: center; border: 1px solid black; background-color: #CFFFE5;"><b>거절
						사유</b></td>
			</tr>

			<!-- 거절사유 -->
			<tr>
				<td style="text-align: center; width: 15%;"><br> <b>거절사유</b></td>
				<td style=""><br> <input type="text" id="" name="reason"
					class="form-control" value="${requestInfo.reason}" readonly
					style="width: 95%; background-color: #FFCC99; border: 1px solid grey; color: black;">
					<input type="hidden" name="reqNO" value="${reqNO}" /> <input
					type="hidden" name="status" value="status3"></td>
			</tr>

			<!-- 목록으로 -->
			<tr>
				<td align="center" colspan="2"><br> <input type="button"
					onclick="yesOrNo()" id="del" class="btn btn-outline-dark"
					style="background-color: white; color: black;"
					onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
					onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
					value="철 회" />&nbsp;&nbsp;&nbsp;<input type="button" id="to_list"
					class="btn btn-outline-dark"
					style="background-color: white; color: black;"
					onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
					onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
					value="목록으로" onclick="location.href='/cocoa/view_sendReq'" /> <br>
					<br></td>
			</tr>
		</table>
	</div>

</body>
</html>
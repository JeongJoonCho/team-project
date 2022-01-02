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
	function readURL(input) {

		if (input.files && input.files[0]) {

			var reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
</script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD">

	<!-- 받은 요청 (대기) -->
	<div class="card rcol my-5"
		style="text-align: center; background-color: #FFEBCD; border: none; width: 80vw; height: 90vh;">
		<form action="" method="post">
			<table
				style="width: 80%; margin: 0 auto; border: 1px solid grey; background-color: #FFCC99; color: black;">
				<tr>
					<td colspan="2"
						style="text-align: center; border: 1px solid black; background-color: #CFFFE5;"><b>${requestInfo.req}의
							요청서</b></td>
				</tr>

				<!-- rTitle -->
				<tr>
					<td style="text-align: center; width: 15%;"><br>
					<b>제 목</b></td>
					<td style=""><br>
					<input type="text" id="" name="rTitle" class="form-control"
						value="${requestInfo.rTitle}" readonly
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
							rows="10" cols="20" class="form-control" id="" name="rContents"
							readonly
							style="width: 95%; resize: none; background-color: #FFCC99; border: 1px solid grey; color: black;">${requestInfo.rContents}</textarea></td>
				</tr>

				<%-- <!-- rImg -->
				<tr>
					<td style="text-align: center; vertical-align: top;"><b>미리보기</b></td>
					<td style="text-align: left;"><img id="preview"
						src="${contextPath}/downRImg?reqNO=${requestInfo.reqNO}&rImg=${requestInfo.rImg}"
						width=95% height=300 style="border: 1px solid;" onerror="" /></td>
				</tr> --%>

				<!-- 첨부파일 다운로드 -->
				<tr>
					<td style="text-align: center;"><b>첨부파일</b></td>
					<td style="float: left;"><a
						href="${contextPath}/downloadGotImg?reqNO=${requestInfo.reqNO}">${requestInfo.rImg}</a></td>
				</tr>

				<!-- 수락, 거절, 목록으로 -->
				<tr>
					<td align="center" colspan="2"><br> <input type="button"
						id="" class="btn btn-outline-dark"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						onclick="location.href='/cocoa/gotWaitYes?reqNO=${requestInfo.reqNO}'"
						value="수 락" />&nbsp;&nbsp;&nbsp; <input type="button" id=""
						class="btn btn-outline-dark"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						onclick="location.href='/cocoa/gotWaitNo?reqNO=${requestInfo.reqNO}'"
						value="거 절" />&nbsp;&nbsp;&nbsp; <input type="button" id=""
						class="btn btn-outline-dark"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						onclick="location.href='/cocoa/view_receiveReq'" value="목록으로" />
						<br> <br></td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>
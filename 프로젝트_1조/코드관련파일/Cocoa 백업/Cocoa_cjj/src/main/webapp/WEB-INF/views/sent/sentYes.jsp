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
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style type="text/css">
th, td {
	padding: 6px;
	color: black;
}
</style>
<script>
	function requestPay() {
		IMP.init("iamport");
		IMP.request_pay({
			pg : "html5_inicis", //이니시스 웹표준 결제창
			pay_method : "card", //결제방법
			merchant_uid : "ORD20211216-0000001", //주문번호
			name : "${requestInfo.res}'s coaching", //상품명
			amount : "${requestInfo.realPrice}", //가격
			buyer_email : "gildong@gmail.com", //이메일
			buyer_name : "홍길동", //이름
			buyer_tel : "010-1234-5678", //연락처
			buyer_addr : "서울특별시 강남구 신사동", //주소
			buyer_postcode : "00001" //상품코드
		}, function(rsp) {
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
			} else {
				var msg = '결제에 실패하였습니다.';
			}
		});
	}
</script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD">

	<!-- 보낸 요청 (수락) -->
	<div class="card rcol my-5"
		style="text-align: center; background-color: #FFEBCD; border: none; width: 80vw; height: 90vh;">
		<table
			style="width: 80%; margin: 0 auto; border: 1px solid grey; background-color: #FFCC99; color: black;">
			<tr>
				<td colspan="2"
					style="text-align: center; border: 1px solid black; background-color: #CFFFE5;"><b>수락된
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

			<!-- 수락 정보 -->
			<tr>
				<td colspan="2"
					style="text-align: center; border: 1px solid black; background-color: #CFFFE5;"><b>수락정보</b></td>
			</tr>

			<!-- contact -->
			<tr>
				<td style="text-align: center; width: 15%;"><br> <b>연결수단</b></td>
				<td style=""><br> <input type="text" id="" name="contact"
					class="form-control" value="${requestInfo.contact}"
					placeholder="${requestInfo.contact}" readonly
					style="width: 30%; background-color: #FFCC99; border: 1px solid black; color: black;">
				</td>
			</tr>

			<!-- realPrice -->
			<tr>
				<td style="text-align: center; width: 15%;"><b>요 금</b></td>
				<td style=""><input type="number" id="" name="realPrice"
					class="form-control" value="${requestInfo.realPrice}" readonly
					style="width: 30%; background-color: #FFCC99; border: 1px solid black; color: black; float: left;"><b
					style="float: left; padding-top: 7px; margin-left: 3px;">원</b>
					<button onclick="requestPay()"
						style="float: left; margin-left: 10px; margin-top: 5px;">결
						제</button></td>
			</tr>

			<!-- 공지사항(reason) -->
			<tr>
				<td style="text-align: center; width: 15%; vertical-align: top;"><b>공지사항</b></td>
				<td style=""><textarea id="" name="reason" rows=3
						class="form-control" readonly
						style="width: 95%; background-color: #FFCC99; border: 1px solid black; color: black; resize: none;">${requestInfo.reason}</textarea>
				</td>
			</tr>

			<!-- 후기작성, 목록으로 -->
			<tr>
				<td align="center" colspan="2"><br> <input type="button"
					onclick="location.href='/cocoa/view_coachRateForm?target=${requestInfo.res}&writer=${requestInfo.req}&reqNO=${requestInfo.reqNO}'"
					id="del" class="btn btn-outline-dark"
					style="background-color: white; color: black;"
					onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
					onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
					value="후기작성" />&nbsp;&nbsp;&nbsp; <input type="button"
					id="to_list" class="btn btn-outline-dark"
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
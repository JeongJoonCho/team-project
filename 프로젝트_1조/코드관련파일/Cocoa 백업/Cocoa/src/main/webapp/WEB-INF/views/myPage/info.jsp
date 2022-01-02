<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<link href='https://use.fontawesome.com/releases/v5.7.2/css/all.css'
	rel='stylesheet'>
<link href="resources/css/join-styles.css" rel="stylesheet" />
<script type="text/javascript" src="resources/js/ajax.js"></script>
<script type="text/javascript">
	function yesOrNo() {
		if (confirm("탈퇴하시겠습니까?")) {
			location.href = '/cocoa/dropMember?id=${member.id }'// Yes click
		} else {
			// no click
		}
	}

	function nullCheck() {
		var _pwd1 = $("#pwd1").val();
		var _pwd2 = $("#pwd2").val();
		var _name = $("#name").val();
		var _phone = $("#phone").val();

		if (_pwd1 == "" || _pwd2 == "") {
			alert("비밀번호를 입력하세요");
			$('#updateInfo').attr('onSubmit', "return false;");
		} else if (_pwd1 != _pwd2) {
			alert("비밀번호가 일치하지 않습니다");
			$('#updateInfo').attr('onSubmit', "return false;");
		} else if (_name == "") {
			alert("이름(별명)을 입력하세요");
			$('#updateInfo').attr('onSubmit', "return false;");
		} else if (_phone == "") {
			alert("전화번호를 입력하세요");
			$('#updateInfo').attr('onSubmit', "return false;");
		} else {
			$('#updateInfo').removeAttr('onSubmit');
		}
	}
</script>
<title>CoCoa</title>
</head>
<body>

	<!-- 회원 정보 수정 -->
	<div class="container"
		style="text-align: center; padding-top: 100px; padding-left: 100px; width: 35vw;">
		<div class="card mt-3 px-2 pt-3 pb-3 mb-3"
			style="width: 100%; height: 100%; background-color: #FFCC99; border: 1px solid black;">

			<h5 class="mb-2">
				<b>회 원 정 보 &nbsp;&nbsp;수 정</b>
			</h5>
			<br>
			<form id="updateInfo" action="${contextPath}/updateInfo"
				method="post">
				<table
					style="width: 80%; background-color: #FFCC99; margin: 0 auto; color: black;">
					<tr>
						<td>
							<div class="fone">
								<i class="fas fa-id-card"
									style="color: black; padding-left: 10px;"></i> <input
									type="text" name="id" id="id" class="form-control"
									style="border: 1px solid grey; padding-left: 30px; font-weight: 700; color: black;"
									value=${member.id } readonly>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="fone mt-2">
								<i class="fas fa-lock" style="color: black; padding-left: 10px;"></i>
								<input type="password" name="pwd" class="form-control" id="pwd1"
									style="border: 1px solid grey; padding-left: 30px; color: black;"
									placeholder="비밀번호(Password)">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="fone mt-2">
								<i class="fas fa-lock" style="color: black; padding-left: 10px;"></i><input
									type="password" class="form-control" id="pwd2"
									style="border: 1px solid grey; padding-left: 30px; color: black;"
									placeholder="비밀번호 확인(Password Check)">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="ml-3" style="float: left;">
								<span id="alert-success" style="display: none; font-size: 13px;"><b>비밀번호가
										일치합니다.</b></span> <span id="alert-danger"
									style="display: none; color: #d92742; font-size: 13px;"><b>비밀번호가
										일치하지 않습니다.</b></span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="fone mt-2">
								<i class="fas fa-user" style="color: black; padding-left: 10px;"></i>
								<input type="text" name="name" id="name" class="form-control"
									style="border: 1px solid grey; padding-left: 30px; color: black;"
									placeholder="이름(Name) 또는 별명(Nickname)">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="fone mt-2">
								<i class="fas fa-phone"
									style="color: black; padding-left: 10px;"></i> <input
									type="text" name="phone" id="phone" class="form-control"
									style="border: 1px solid grey; padding-left: 30px; color: black;"
									placeholder="전화번호( '-' 제외하고 입력 )">
							</div>
						</td>
					</tr>
					<tr>
						<td align="center"><button type="submit" id="modInfo"
								onclick="nullCheck()" class="btn btn-outline-dark mt-5">수
								정</button>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="delInfo"
							class="btn btn-outline-dark mt-5" value="탈 퇴" onClick="yesOrNo()"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>

</body>
</html>
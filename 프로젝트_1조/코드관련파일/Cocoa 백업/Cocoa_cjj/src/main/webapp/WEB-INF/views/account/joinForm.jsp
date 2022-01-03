<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<link
	href='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css'
	rel='stylesheet'>
<link href='https://use.fontawesome.com/releases/v5.7.2/css/all.css'
	rel='stylesheet'>
<script type='text/javascript'
	src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
<script type='text/javascript'
	src='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js'></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<link href="resources/css/join-styles.css" rel="stylesheet" />
<script type="text/javascript" src="resources/js/ajax.js?ver=1"></script>
<script type="text/javascript" src="resources/js/jquery-3.6.0.min.js"></script>
<title>CoCoa</title>
</head>
<body>

	<!-- 회원 가입 -->
	<div class="container">
		<div class="card rcol">
			<h2 class="heading mt-3 mb-4" align="center">
				<a href="/cocoa/">CoCoa</a>
			</h2>
			<h5 class="mb-2">
				<b>회원가입</b>
			</h5>
			<br>
			<form action="${contextPath}/join" method="post" id="join">
				<table style="width: 100%;">
					<tr>
						<td><div class="fone">
								<i class="fas fa-id-card"
									style="color: black; padding-left: 10px;"></i> <input
									type="text" name="id" id="id" class="form-control"
									style="padding-left: 30px;" placeholder="아이디(ID)">
							</div></td>

						<td align="center"><input type="button" id="idCheck"
							style="color: white; padding: 7px; font-size: 12px;"
							class="btn btn-success" value="중복확인"></td>
					</tr>
					<tr>
						<td colspan="2"><div class="fone mt-2">
								<i class="fas fa-lock" style="color: black; padding-left: 10px;"></i>
								<input type="password" name="pwd" class="form-control"
									style="padding-left: 30px;" id="pwd1"
									placeholder="비밀번호(Password)">
							</div></td>
					</tr>
					<tr>
						<td colspan="2"><div class="fone mt-2">
								<i class="fas fa-lock" style="color: black; padding-left: 10px;"></i><input
									type="password" class="form-control"
									style="padding-left: 30px;" id="pwd2"
									placeholder="비밀번호 확인(Password Check)">
							</div></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="ml-3">
								<span id="alert-success" style="display: none; font-size: 13px;"><b>비밀번호가
										일치합니다.</b></span> <span id="alert-danger"
									style="display: none; color: #d92742; font-size: 13px;"><b>비밀번호가
										일치하지 않습니다.</b></span>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2"><div class="fone mt-2">
								<i class="fas fa-user" style="color: black; padding-left: 10px;"></i>
								<input type="text" name="name" id="name" class="form-control"
									style="padding-left: 30px;"
									placeholder="이름(Name) 또는 별명(Nickname)">
							</div></td>
					</tr>
					<tr>
						<td colspan="2"><div class="fone mt-2">
								<i class="fas fa-phone"
									style="color: black; padding-left: 10px;"></i> <input
									type="text" name="phone" id="phone" class="form-control"
									style="padding-left: 30px;" placeholder="전화번호( '-' 제외하고 입력 )">
							</div></td>
					</tr>
					<tr>
						<td align="center" colspan="2"><button type="submit"
								id="validate" class="btn btn-success mt-5">회원가입</button></td>
					</tr>
				</table>
			</form>
			<p class="exist mt-2">
				have an account? <a class="warning" href="view_login?view=">Login</a>
			</p>
			<br>
		</div>
	</div>

</body>
</html>
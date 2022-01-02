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

	$(document).ready(function() {
		//페이지를 로드할 때 숨길 요소
		$('#c_cImgMod').hide();
		$('#c_modBtn').hide();
		$('#c_mod').show();
		$('#c_rmv').show();
		$('#requestForm').hide();

		$('#c_mod').click(function() {
			$('#c_mod').hide(); //클릭 시 첫 번째 요소 숨김
			$('#c_rmv').hide(); //클릭 시 첫 번째 요소 숨김
			$('#c_cImgMod').show(); //클릭 시 두 번째 요소 표시
			$('#c_modBtn').show();
			$('#c_cTitle').prop('disabled', false);
			$('#c_basicPrice').prop('disabled', false);
			$('#cField').prop('disabled', false);
			$('#tool').prop('disabled', false);
			$('#c_cContents').prop('disabled', false);
			$('#getcField').attr('hidden', '');
			return false;
		});

	});

	// 삭제 액션
	function fn_remove_coach(obj) {
		obj.action = "${contextPath}/removeCoach";
		obj.submit();
	}

	// 영역 변경시 개발툴 초기화 셋팅
	function categoryChange(e) {
		var tool_cField1_value = [ "tool", "tool1", "tool2" ];
		var tool_cField2_value = [ "tool", "tool3", "tool4" ];
		var tool_cField3_value = [ "tool", "tool5", "tool6" ];

		var tool_cField1_out = [ "-- 선택 --", "Spring", "Django" ];
		var tool_cField2_out = [ "-- 선택 --", "Android Studio", "Xcode" ];
		var tool_cField3_out = [ "-- 선택 --", "Arduino", "Rasberry Pi" ];
		var target = document.getElementById("tool");

		if (e.value == "cField1") {
			var v = tool_cField1_value;
			var o = tool_cField1_out;
		} else if (e.value == "cField2") {
			var v = tool_cField2_value;
			var o = tool_cField2_out;
		} else if (e.value == "cField3") {
			var v = tool_cField3_value;
			var o = tool_cField3_out;
		}

		target.options.length = 0;

		for (x in v, o) {
			var opt = document.createElement("option");
			opt.value = v[x];
			opt.innerHTML = o[x];
			target.appendChild(opt);
		}
	}

	function nullCheck() {
		var _cTitle = $("#c_cTitle").val();
		var _basicPrice = $("#c_basicPrice").val();
		var _tool = $("#tool").val();
		var _cContents = $("#c_cContents").val();

		if (_cTitle == "" || _basicPrice == "" || _tool == "tool"
				|| _cContents == "") {
			alert("빈칸없이 입력하세요");
			$('#coachInfo').attr('onSubmit', "return false;");
		} else {
			$('#coachInfo').removeAttr('onSubmit');
		}
	}
</script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD">

	<!-- 상단바 -->
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- 코치 글 구간 -->
	<form method="post" enctype="multipart/form-data" name="frmCoach"
		id="coachInfo" action="${contextPath}/modCoach">
		<section class="py-5">
			<div class="container main-secction">
				<div class="row" style="flex-wrap: unset;">

					<!-- 좌측 프로필 : coach~proImg / coach~name-->
					<div class="col-md-3 col-sm-3 col-xs-12 user-profil-part pull-left">
						<div class="row">
							<div
								class="col-md-12 col-md-12-sm-12 col-xs-12 user-image text-center"
								style="width: 80%; height: 100%; border: 2px solid; background-color: #FFCCCC;">

								<!-- 프로필 조회 이동 -->
								<br> <br> <a
									href="/cocoa/view_profileInfo?profileId=${coach.coach}"> <img
									name="proImg"
									src="${contextPath}/downProfileImg?id=${coach.coach}"
									onerror="this.src='resources/image/onerror.png'"
									style="border: 1px solid black;" width="50%" height="120px"><br>
									<br>
								</a>

								<!-- coach -->
								<input type="text" name="coach" value="${coach.coach}" readonly
									style="outline: none; text-align: center; border: 0; font-weight: 700; background-color: #FFCCCC; width: 70%;">
								<input type="hidden" name="coachNO" value="${coach.coachNO}" />
								<br>

								<!-- 후기 조회 이동 -->
								<br> <span style="text-align: center;"><a
									href="/cocoa/view_reviewInfo?target=${coach.coach}"> <input
										type="button" name="view_reviewInfo" value="후기보기"
										class="btn btn-third-dark"
										style="font-size: 15px; border-radius: 12px; width: 50%;">
								</a> </span><br> <br>

								<!-- 요청서 작성 -->
								<c:if test="${isLogOn == true && member.id !=coach.coach}">
									<a
										href="/cocoa/view_reqWriteForm?coachId=${coach.coach}&basicPrice=${coach.basicPrice}">
										<input type="button" name="requestForm" value="   요청서 작성   "
										class="btn btn-third-dark"
										style="text-align: center; border: 1; border-radius: 12px; width: 70%;">
									</a>
								</c:if>
								<br> <br>

								<!-- 본인이면 수정(submit) / 삭제(버튼) 표시 -->
								<c:if test="${member.id == coach.coach}">
									<input type="button" class="btn btn-third-dark" value="수정"
										onClick="fn_enable(frmCoach)" id="c_mod"> &nbsp;
								<input type="button" class="btn btn-third-dark" value="삭제"
										onClick="fn_remove_coach(frmCoach)" id="c_rmv">
								</c:if>
								<br> <br>
							</div>
						</div>
					</div>

					<!-- 우측 내용 : cImg / cTitle / basicPrice / tool / cContents -->
					<div class="card px-3"
						style="width: 50rem; border: 1px solid; background-color: #FFCC99">

						<!-- cImg -->
						<div align="center">
							<input type="hidden" name="originalFileName"
								value="${coach.cImg }" /> <br> <img id="preview"
								src="${contextPath}/coachImgDownload?coach=${coach.coach }&coachNO=${coach.coachNO}&cImg=${coach.cImg}"
								width=100% height=300 style="border: 1px solid;"
								onerror="this.src='resources/image/onerror.png'" /> <br> <br>

							<!-- 수정 누르면 활성화 -->
							<label class="btn btn-outline-dark" for="c_cImg" id="c_cImgMod">
								대표 이미지 변경 </label><input type="file" id="c_cImg" name="cImg"
								onchange="readURL(this);" style="display: none;" /> <br>
						</div>

						<!-- cTitle / basicPrice / tool / cContents 조회 -->
						<div class="coach">

							<!-- cTitle 표시 -->
							<hr>
							<input name="cTitle" type="text" value="${coach.cTitle}"
								id="c_cTitle" disabled
								style="border: 0; text-align: center; width: 100%; background-color: #FFCC99; font-weight: 700; color: black;">
							<hr>

							<!-- basicPrice 표시 -->
							요금 : <input name="basicPrice" type="text"
								value="${coach.basicPrice}" id="c_basicPrice" disabled
								style="border: 0; width: 10%; text-align: center; background-color: #FFCC99; font-weight: 700; color: black;">
							<b>원</b>
							<hr>

							<!-- cField 표시 -->
							영역 : <select
								style="border: 0; text-align: center; width: 15%; background-color: #FFCC99; font-weight: 700; color: black;"
								name="cField" disabled id="cField"
								onchange="categoryChange(this)">
								<option id="getcField" value="${coach.cField}">
									<c:choose>
										<c:when test="${coach.cField == 'cField1'}">Web</c:when>
										<c:when test="${coach.cField == 'cField2'}">Mobile App</c:when>
										<c:when test="${coach.cField == 'cField3'}">Embedded</c:when>
									</c:choose>
								</option>
								<option id="cfield1" value="cField1">Web</option>
								<option id="cfield2" value="cField2">Mobile App</option>
								<option id="cfield3" value="cField3">Embedded</option>
							</select>
							<hr>

							<!-- tool 표시 -->
							개발툴 : <select
								style="border: 0; text-align: center; width: 15%; background-color: #FFCC99; font-weight: 700; color: black;"
								name="tool" disabled id="tool">
								<option id="default" value="${coach.tool}">
									<c:choose>
										<c:when test="${coach.tool == 'tool1'}">Spring</c:when>
										<c:when test="${coach.tool == 'tool2'}">Django</c:when>
										<c:when test="${coach.tool == 'tool3'}">Android Studio</c:when>
										<c:when test="${coach.tool == 'tool4'}">Xcode</c:when>
										<c:when test="${coach.tool == 'tool5'}">Arduino</c:when>
										<c:when test="${coach.tool == 'tool6'}">Raspberry Pi</c:when>
									</c:choose>
								</option>
							</select>
							<hr>

							<!-- cContents 표시 -->
							<!-- textarea 닫아주는거 붙여써야함 -->
							세부 내용 : <br> <br>
							<textarea name="cContents" rows="10" cols="20" disabled
								id="c_cContents"
								style="border: 1; width: 100%; background-color: #FFCC99; font-weight: 700; color: black; resize: none;">${coach.cContents}</textarea>
							<hr>

							<div align="center">
								<input type="submit" onclick="nullCheck()" value="확 인"
									class="btn btn-outline-dark" id="c_modBtn">&nbsp;&nbsp;<input
									type=button value="목록으로" class="btn btn-outline-dark"
									onClick="history.back()" id="goBack"><br> <br>
							</div>
						</div>
					</div>

				</div>
			</div>
		</section>
	</form>

	<!-- 하단바 -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>
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

	// 유효성 검증
	function nullCheck() {
		var _cTitle = $("#cTitle").val();
		var _basicPrice = $("#basicPrice").val();
		var _cField = $("#cField").val();
		var _tool = $("#tool").val();
		var _cContents = $("#cContents").val();

		if (_cTitle == "" || _basicPrice == "" || _cField == "empty"
				|| _tool == "tool" || _cContents == "") {
			alert("빈칸없이 입력하세요");
			$('#coachWrite').attr('onSubmit', "return false;");
		} else {
			$('#coachWrite').removeAttr('onSubmit');
		}
	}
</script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD">

	<!-- 상단바 -->
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- 코칭 글 작성 -->
	<form name="coachWriteForm" method="post" id="coachWrite"
		action="${contextPath}/coachWrite" enctype="multipart/form-data">
		<section class="py-5">
			<div class="container main-secction">
				<div class="row" style="flex-wrap: unset;">

					<!-- 좌측 프로필 : coach~proImg / coach~name -->
					<div class="col-md-3 col-sm-3 col-xs-12 user-profil-part pull-left">
						<div class="row">
							<div
								class="col-md-12 col-md-12-sm-12 col-xs-12 user-image text-center"
								style="width: 80%; height: 100%; border: 2px solid; background-color: #FFCCCC;">

								<!-- 프로필 조회 이동 -->
								<br> <br> <img name="proImg"
									src="${contextPath}/downProfileImg?id=${member.id}"
									style="border: 1px solid;" width="50%" height="120px"
									onerror="this.src='resources/image/onerror.png'"><br>
								<br>

								<!-- coach -->
								<input type="text" name="coach" value="${member.id}" readonly
									style="text-align: center; border: 0; font-weight: 700; background-color: #FFCCCC; width: 70%;"><br>
								<br>
							</div>
						</div>
					</div>

					<!-- 우측 내용 : cImg / cTitle / basicPrice / cContents -->
					<div class="card px-3"
						style="width: 50rem; border: 1px solid; background-color: #FFCC99">

						<!-- cImg -->
						<div align="center">
							<br> <img id="preview" src="resources/image/onerror.png"
								width=100% height=300 style="border: 1px solid;" /><br> <br>
							<label class="btn btn-outline-dark" for="cImg"> 대표 이미지 변경
							</label><input type="file" id="cImg" name="cImg"
								onchange="readURL(this);" style="display: none;" />
						</div>

						<!-- cTitle / basicPrice / cContents 입력 -->
						<div class="coach">

							<!-- cTitle 입력 -->
							<hr>
							<input name="cTitle" type="text" placeholder="제목을 입력하세요."
								id="cTitle" style="border: 1; text-align: center; width: 100%;">
							<hr>

							<!-- basicPrice 입력 -->
							요금 : <input name="basicPrice" type="number" id="basicPrice"
								placeholder="요금을 입력하세요." style="border: 1; width: 30%;">&nbsp;<b>원</b>
							<hr>

							<!-- cField 선택 -->
							영역 : <select style="text-align: center; width: 30%;" id="cField"
								name="cField" onchange="categoryChange(this)">
								<option id="empty" value="empty">-- 선택 --</option>
								<option id="cField1" value="cField1">Web</option>
								<option id="cField2" value="cField2">Mobile App</option>
								<option id="cField3" value="cField3">Embedded</option>
							</select>
							<hr>

							<!-- tool 선택 -->
							개발툴 : <select style="text-align: center; width: 30%;" name="tool"
								id="tool">
								<option id="empty" value="empty">-- 선택 --</option>

								<option id="tool1" value="tool1" hidden>Spring</option>
								<option id="tool2" value="tool2" hidden>Django</option>

								<option id="tool3" value="tool3" hidden>Android Studio</option>
								<option id="tool4" value="tool4" hidden>Xcode</option>

								<option id="tool5" value="tool5" hidden>Arduino</option>
								<option id="tool6" value="tool6" hidden>Raspberry Pi</option>
							</select>
							<hr>

							<!-- cContents 입력 -->
							<!-- textarea 닫아주는거 붙여써야함 -->
							세부 내용 : <br>
							<textarea name="cContents" rows="10" cols="20" id="cContents"
								placeholder="요금 측정 기준 및 본인 PR을 해주세요. (공백 포함 2000자 이내)"
								style="border: 1; width: 100%; resize: none;"></textarea>
							<hr>
						</div>

						<!-- 작성(submit) + 취소(버튼) -->
						<div class="card-body" style="text-align: center">
							<input type="submit" class="btn btn-outline-dark"
								onClick="nullCheck()" value="등록" /> &nbsp; <a
								href="/cocoa/view_coachCate" class="btn btn-outline-dark">취소</a>
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
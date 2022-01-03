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
	padding: 10px;
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

	function nullCheck() {
		var _rTitle = $("#rTitle").val().replace(/\s/g, "");
		var _rContents = $("#rContents").val().replace(/\s/g, "");

		if (_rTitle == "" || _rTitle == "") {
			alert("제목을 입력하세요");
			$('#requestWrite').attr('onSubmit', "return false;");
		} else if (_rContents == "") {
			alert("내용을 입력하세요");
			$('#requestWrite').attr('onSubmit', "return false;");
		} else {
			$('#requestWrite').removeAttr('onSubmit');
		}
	}
</script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD;">

	<!-- 상단바 -->
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- 요청서 작성 -->
	<div class="card rcol my-4"
		style="margin: 0 auto; width: 60%; background-color: #FFEBCD; border: none;">
		<form id="requestWrite" name="coachWriteForm"
			action="${contextPath}/requestWrite" enctype="multipart/form-data"
			method="post">
			<table
				style="width: 80%; margin: 0 auto; border: 1px solid grey; background-color: #FFCC99;">
				<tr>
					<!-- 요청성 작성할 때 코치의 id가 있으면 좋을거 같아서 to.${res}로 나타냄 -->
					<th colspan="2" style="text-align: center; font-size: 20px;">${res}
						코치에게 요청서 작성</th>

					<!-- form을 submit 할 때 요청자의 아이디(${member.id})와 
					응답하는 코치(${res})의 아이디가 있어야해서 hidden으로 함 -->
					<td><input type="hidden" name="res" value="${res}" /> <input
						type="hidden" name="req" value="${member.id}" /><input
						type="hidden" name="realPrice" value="${basicPrice}" /></td>
				</tr>

				<!-- rTitle -->
				<tr>
					<td style="text-align: center; width: 15%;"><b>제 목</b></td>
					<td style=""><input type="text" id="rTitle" name="rTitle"
						class="form-control" style="width: 95%; border: 1px solid;"
						placeholder="에러의 유형을 제목으로 적어주세요."></td>
				</tr>

				<!-- rContents -->
				<tr>
					<td style="text-align: center; vertical-align: top;" class="pt-1"><br>
						<b>내 용</b></td>
					<td style="text-align: left; vertical-align: top;"><textarea
							rows="10" cols="20" class="form-control" id="rContents"
							name="rContents"
							placeholder="현재 본인의 개발환경과 에러 내용을 최대한 자세하게 적어주세요."
							style="width: 95%; resize: none; border: 1px solid;"></textarea></td>
				</tr>

				<!-- rImg -->
				<tr>
					<td style="text-align: center;"><b>파일첨부</b></td>
					<td><label class="btn btn-outline-dark" for="file">
							찾아보기 </label><input type="file" id="file" name="rImg"
						onchange="readURL(this);" style="display: none;" /></td>
				</tr>

				<!-- 사진 미리보기 -->
				<tr>
					<td style="text-align: center;"></td>
					<td><img id="preview" src="resources/image/onerror.png"
						width=95% height=300 style="border: 1px solid;" /></td>
				</tr>

				<!-- submit, 취소 -->
				<tr>
					<td align="center" colspan="2"><br> <input type="submit"
						id="" onclick="nullCheck()" class="btn btn-outline-dark"
						value="요 청" />&nbsp;&nbsp;&nbsp;<input type="button" id="cancel"
						onclick="history.go(-1)" class="btn btn-outline-dark" value="취 소" /><br>
						<br></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- 하단바 -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>
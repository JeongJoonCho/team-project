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

	$(document)
			.ready(
					function() {
						$('#mod_finish').hide();
						$('#cancel').hide();
						$('#findImg').hide();
						$('#space').hide();

						$('#mod_start').click(function() {
							$('#space').show();
							$('#del').hide();
							$('#mod_start').hide();
							$('#to_list').hide();
							$('#findImg').show();
							$('#mod_finish').show();
							$('#cancel').show();
							$('#rTitle').prop('disabled', false);
							$('#rContents').prop('disabled', false);
							return false;
						});

						$('#cancel')
								.click(
										function() {
											$('#space').hide();
											$('#del').show();
											$('#mod_start').show();
											$('#to_list').show();
											$('#findImg').hide();
											$('#mod_finish').hide();
											$('#cancel').hide();
											$('#rTitle').prop('disabled', true);
											$('#rContents').prop('disabled',
													true);
											$('#preview')
													.attr('src',
															'${contextPath}/downRImg?reqNO=${requestInfo.reqNO}');
											return false;
										});

					});

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

	<!-- 보낸 요청 (대기) -->
	<div class="card rcol my-5"
		style="text-align: center; background-color: #FFEBCD; border: none; width: 80vw; height: 90vh;">
		<form action="${contextPath}/modRequest" method="post"
			enctype="multipart/form-data">
			<table
				style="width: 80%; margin: 0 auto; border: 1px solid grey; background-color: #FFCC99; color: black;">
				<tr>
					<td colspan="2"
						style="text-align: center; border: 1px solid black; background-color: #CFFFE5;"><b>${requestInfo.res}에게
							보낸 요청서</b></td>
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

				<!-- rImg -->
				<tr>
					<td style="text-align: center;"><b>파일첨부</b></td>
					<td style="text-align: left;"><label
						class="btn btn-outline-dark" id="findImg"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						for="file"> 찾아보기 </label><input type="file" id="file" name="rImg"
						onchange="readURL(this);" style="display: none;" /></td>
				</tr>

				<!-- 사진 미리보기 -->
				<tr>
					<td style="text-align: center;"></td>
					<td style="text-align: left;"><input type="hidden"
						name="originalFileName" value="${requestInfo.rImg }" /> <img
						id="preview"
						src="${contextPath}/downRImg?reqNO=${requestInfo.reqNO}" width=95%
						height=300 style="border: 1px solid;"
						onerror="this.src='resources/image/onerror.png'" /></td>
				</tr>

				<!-- 수정, 철회, 목록으로 -->
				<tr>
					<td align="center" colspan="2"><br> <input type="button"
						id="mod_start" class="btn btn-outline-dark"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						value="수 정" />&nbsp;&nbsp;&nbsp; <input type="submit"
						id="mod_finish" class="btn btn-outline-dark"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						value="확 인" /> <span id="space">&nbsp;&nbsp;&nbsp;</span> <input
						type="button" id="cancel" class="btn btn-outline-dark"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						onclick="reload()" value="취 소" /> <input type="button"
						onclick="yesOrNo()" id="del" class="btn btn-outline-dark"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						value="철 회" />&nbsp;&nbsp;&nbsp; <input type="button"
						id="to_list" class="btn btn-outline-dark"
						style="background-color: white; color: black;"
						onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
						onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
						value="목록으로" onclick="location.href='/cocoa/view_sendReq'" /> <br>
						<br></td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>
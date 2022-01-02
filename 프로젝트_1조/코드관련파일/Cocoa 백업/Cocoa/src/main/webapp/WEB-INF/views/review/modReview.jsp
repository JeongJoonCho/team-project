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
	function fn_modify_review(obj) {
		obj.action = "${contextPath}/modReview";
		obj.submit();
	}
</script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD">

	<!-- 상단바 -->
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- 코치 글 구간 -->
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
								href="/cocoa/view_profileInfo?profileId=${reviewVO.target}">
								<img name="proImg"
								src="${contextPath}/downProfileImg?id=${reviewVO.target}"
								onerror="this.src='resources/image/onerror.png'"
								style="border: 1px solid black;" width="50%" height="120px"><br>
								<br>
							</a>

							<!-- coach -->
							<input type="text" name="coach" value="${reviewVO.target}"
								readonly
								style="text-align: center; border: 0; font-weight: 700; background-color: #FFCCCC; width: 70%;">
							<br> <br> <br>
						</div>
					</div>
				</div>

				<!-- 우측 내용 : writer, rate, review, 수정, 삭제 -->
				<div class="card rcol my-3"
					style="text-align: center; background-color: #FFEBCD; border: none; width: 60vw; height: 60vh;">
					<form action="${contextPath}" method="post" name="frmReview">
						<table
							style="width: 80%; margin: 0 auto; border: 1px solid gray; background-color: #FFCC99; color: black;">
							<tr>
								<th colspan="2"
									style="vertical-align: middle; text-align: center; font-size: 20px;">후기수정</th>
							</tr>

							<!-- rate -->
							<tr>
								<td style="text-align: center; width: 15%; vertical-align: top;"><br>
									<b>평 점</b></td>
								<td style="text-align: left; font-size: 30px;"><c:choose>
										<c:when test="${reviewVO.rate == 1}">
											<input type="radio" name="rate" value=5> ★ ★ ★ ★ ★ <br>
											<input type="radio" name="rate" value=4> ★ ★ ★ ★ <br>
											<input type="radio" name="rate" value=3> ★ ★ ★ <br>
											<input type="radio" name="rate" value=2> ★ ★ <br>
											<input type="radio" name="rate" value=1 checked="checked"> ★ <br>
										</c:when>
										<c:when test="${reviewVO.rate == 2}">
											<input type="radio" name="rate" value=5> ★ ★ ★ ★ ★ <br>
											<input type="radio" name="rate" value=4> ★ ★ ★ ★ <br>
											<input type="radio" name="rate" value=3> ★ ★ ★ <br>
											<input type="radio" name="rate" value=2 checked="checked"> ★ ★ <br>
											<input type="radio" name="rate" value=1> ★ <br>
										</c:when>
										<c:when test="${reviewVO.rate == 3}">
											<input type="radio" name="rate" value=5> ★ ★ ★ ★ ★ <br>
											<input type="radio" name="rate" value=4> ★ ★ ★ ★ <br>
											<input type="radio" name="rate" value=3 checked="checked"> ★ ★ ★ <br>
											<input type="radio" name="rate" value=2> ★ ★ <br>
											<input type="radio" name="rate" value=1> ★ <br>
										</c:when>
										<c:when test="${reviewVO.rate == 4}">
											<input type="radio" name="rate" value=5> ★ ★ ★ ★ ★ <br>
											<input type="radio" name="rate" value=4 checked="checked"> ★ ★ ★ ★ <br>
											<input type="radio" name="rate" value=3> ★ ★ ★ <br>
											<input type="radio" name="rate" value=2> ★ ★ <br>
											<input type="radio" name="rate" value=1> ★ <br>
										</c:when>
										<c:when test="${reviewVO.rate == 5}">
											<input type="radio" name="rate" value=5 checked="checked"> ★ ★ ★ ★ ★ <br>
											<input type="radio" name="rate" value=4> ★ ★ ★ ★ <br>
											<input type="radio" name="rate" value=3> ★ ★ ★ <br>
											<input type="radio" name="rate" value=2> ★ ★ <br>
											<input type="radio" name="rate" value=1> ★ <br>
										</c:when>
									</c:choose></td>
							</tr>

							<!-- review -->
							<tr>
								<td style="text-align: center; vertical-align: top;"
									class="pt-1"><br> <b>한 줄 평</b></td>
								<td style="text-align: left; vertical-align: top;"><textarea
										rows="3" cols="20" class="form-control" id="rContents"
										name="review"
										style="width: 95%; resize: none; background-color: #FFCC99; border: 1px solid grey; color: black;">${reviewVO.review}</textarea></td>
							</tr>

							<!-- 히든요소 -->
							<tr>
								<td><input type="hidden" name="target"
									value="${reviewVO.target}"> <input type="hidden"
									name="writer" value="${reviewVO.writer}"> <input
									type="hidden" name="reviewNO" value="${reviewVO.reviewNO}"></td>
							</tr>

							<!-- 수정, 취소 -->
							<tr>
								<td align="center" colspan="2"><br> <input
									type="button" id="del" class="btn btn-outline-dark"
									style="background-color: white; color: black;"
									onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
									onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
									value="수 정" onClick="fn_modify_review(frmReview)" />&nbsp;&nbsp;&nbsp;
									<input type="button" id="to_list" class="btn btn-outline-dark"
									style="background-color: white; color: black;"
									onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
									onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
									value="취 소" onclick="history.back(0)" /> <br> <br></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</section>

	<!-- 하단바 -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>
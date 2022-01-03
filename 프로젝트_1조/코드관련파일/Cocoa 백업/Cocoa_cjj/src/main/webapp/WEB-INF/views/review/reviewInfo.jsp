<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/styles.css" rel="stylesheet" />
<script type="text/javascript" src="resources/js/jquery-3.6.0.min.js"></script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD">

	<!-- 상단바 -->
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- 타인 후기 구간 -->
	<section class="py-5" style="min-height: 80.7vh;">
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
								href="/cocoa/view_profileInfo?profileId=${target}"> <img
								name="proImg" src="${contextPath}/downProfileImg?id=${target}"
								onerror="this.src='resources/image/onerror.png'"
								style="border: 1px solid black;" width="50%" height="120px"><br>
								<br>
							</a>

							<!-- coach -->
							<b>${target}</b> <br> <br> <br>
						</div>
					</div>
				</div>

				<!-- 우측 내용 : writer, rate, review, 수정, 삭제 -->
				<div class="card"
					style="width: 50rem; border: 1px solid; background-color: #FFCC99">
					<div class="card rcol my-5"
						style="text-align: center; background-color: #FFEBCD; border: none; width: 100%; height: 100%;">
						<div style="border: 1px solid grey;">
							<table style="margin: 0px auto;">
								<tr>
									<th colspan="6" style="text-align: center;"><b>${target}의
											후기</b>
									<hr></th>
								</tr>

								<!-- 후기 한 줄 -->
								<c:forEach var="reviewInfo" items="${reviewList}">
									<tr style="width: 100%;">
										<td style="float: left;">작성자 : ${reviewInfo.writer} <input
											type="hidden" name="reviewNO" value="${reviewInfo.reviewNO }" />
										</td>
										<td colspan="3" style="text-align: left; width: 250px">평점
											: <c:choose>
												<c:when test="${reviewInfo.rate == 1}">★</c:when>
												<c:when test="${reviewInfo.rate == 2}">★★</c:when>
												<c:when test="${reviewInfo.rate == 3}">★★★</c:when>
												<c:when test="${reviewInfo.rate == 4}">★★★★</c:when>
												<c:when test="${reviewInfo.rate == 5}">★★★★★</c:when>
											</c:choose>
										</td>

										<!-- 작성시간 -->
										<td><fmt:parseDate var="dateFmt"
												pattern="yyyy-MM-dd HH:mm:ss" value="${reviewInfo.reDate}" />
											<fmt:formatDate var="dateTempParse" pattern="yyyy-MM-dd"
												value="${dateFmt}" />작성일 : ${dateTempParse}</td>

										<!-- 본인이면 수정 및 삭제 가능 -->
										<c:if
											test="${isLogOn == true && member.id == reviewInfo.writer}">
											<td style="float: right;"><span><a
													style="text-decoration-line: none;"
													href="${contextPath}/view_modReview?reviewNO=${reviewInfo.reviewNO}">
														<input type="button" name="view_modReview" value="수 정">
												</a> </span>&nbsp;&nbsp;<input type="button" id="r_rmv" value="삭 제"
												onClick="location.href='/cocoa/removeReview?reviewNO=${reviewInfo.reviewNO}'" /></td>
										</c:if>
									</tr>
									<tr>
										<td colspan="6"><textarea rows="2" cols="99" disabled
												name="review" id="r_review"
												style="border: 1px solid grey; margin: 0px auto; text-align: left; resize: none; color: black; background-color: #FFEBCD;">${reviewInfo.review }</textarea></td>
									</tr>
									<tr>
										<!-- 후기 한 줄 사이의 간격 -->
										<td colspan="6" style="float: right;"></td>
									</tr>
								</c:forEach>

							</table>
						</div>

						<!-- 쪽 번호 구간 -->
						<div style="margin: 0 auto; font-size: 30px;">

							<c:if test="${pageMaker.prev }">
								<a style="text-decoration: none; color: black; font-size: 15pt;"
									href='<c:url value="/view_reviewInfo?target=${target}&page=${pageMaker.startPage-1 }"/>'>이전</a>
							</c:if>

							<c:forEach begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }" var="pageNum">
								<c:choose>
									<c:when test="${cri.page == pageNum}">
										<a style="text-decoration: none; color: red; font-size: 15pt;"
											href='<c:url value="/view_reviewInfo?target=${target}&page=${pageNum }"/>'>${pageNum }</a>
									</c:when>
									<c:when test="${cri.page != pageNum}">
										<a
											style="text-decoration: none; color: black; font-size: 15pt;"
											href='<c:url value="/view_reviewInfo?target=${target}&page=${pageNum }"/>'>${pageNum }</a>
									</c:when>
								</c:choose>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
								<a style="text-decoration: none; color: black; font-size: 15pt;"
									href='<c:url value="/view_reviewInfo?target=${target}&page=${pageMaker.endPage+1 }"/>'>다음</a>
							</c:if>

						</div>
					</div>

					<!-- 뒤로가기 -->
					<div style="text-align: center; padding-bottom: 10px;">
						<input type="button" id="" class="btn btn-outline-dark"
							style="background-color: white; color: black;"
							onmouseover="this.style.color='white'; this.style.backgroundColor='black';"
							onmouseout="this.style.color='black'; this.style.backgroundColor='white';"
							onclick="history.back()" value="뒤로가기" />
					</div>

				</div>
			</div>
		</div>
	</section>

	<!-- 하단바 -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>
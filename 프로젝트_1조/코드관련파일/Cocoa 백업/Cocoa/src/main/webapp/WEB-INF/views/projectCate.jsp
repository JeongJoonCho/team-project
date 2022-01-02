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
	// 정렬 기준 동적으로 변경
	function selChange() {
		var sel = document.getElementById('projectOrder').value;
		location.href = "view_projectCate?pField=${cri.pField }&level=${cri.level }&projectOrder="
				+ sel;
	}
</script>
<title>CoCoa</title>
</head>
<body style="background-color: #FFEBCD">

	<!-- 상단바 -->
	<jsp:include page="header.jsp"></jsp:include>

	<!-- 카테고리 구간 -->
	<header class="py-5"
		style="background-color: #663333; text-align: center;">
		<div class="row">

			<!-- 분류 -->
			<div class="col-sm-4">
				<div id="class" class="d gap-3">
					<div style="color: #CFFFE5; font-size: 25px;">분류</div>
					<br> <input id="project" type="button"
						class="btn btn-primary btn-lg px-4"
						onClick="location.href='/cocoa/view_projectCate'" value="Project">
					<br> <br> <input id="project" type="button"
						class="btn btn-primary btn-lg px-4"
						onClick="location.href='/cocoa/view_coachCate'" value="Coaching">

				</div>
			</div>

			<!-- 영역 -->
			<div class="col-sm-4">
				<div id="cFields" class="d gap-3">
					<div style="color: #CFFFE5; font-size: 25px; text-align: center;">영역</div>
					<br> <input id="Web" type="button"
						class="btn btn-primary btn-lg px-4"
						onClick="location.href='/cocoa/view_projectCate?pField=pField1'"
						value="Web"> <br> <br> <input id="Mobile App"
						type="button" class="btn btn-primary btn-lg px-4"
						onClick="location.href='/cocoa/view_projectCate?pField=pField2'"
						value="Mobile App"> <br> <br> <input
						id="Embedded" type="button" class="btn btn-primary btn-lg px-4"
						onClick="location.href='/cocoa/view_projectCate?pField=pField3'"
						value="Embedded">
				</div>
			</div>

			<!-- 등급 -->
			<div class="col-sm-4">
				<div id="levels" class="d gap-3">
					<div style="color: #CFFFE5; font-size: 25px; text-align: center;">등급</div>
					<br> <input id="Basic" type="button"
						class="btn btn-primary btn-lg px-4"
						onClick="location.href='/cocoa/view_projectCate?pField=${cri.pField}&level=level1'"
						value="Basic" /><br> <br> <input id="Intermediate"
						type="button" class="btn btn-primary btn-lg px-4"
						onClick="location.href='/cocoa/view_projectCate?pField=${cri.pField}&level=level2'"
						value="Intemediate" /><br> <br> <input id="Advanced"
						type="button" class="btn btn-primary btn-lg px-4"
						onClick="location.href='/cocoa/view_projectCate?pField=${cri.pField}&level=level3'"
						value="Advanced" />
				</div>
			</div>

		</div>
	</header>

	<!-- 프로젝트 카탈로그 구간 -->
	<section style="min-height: 50vh;">

		<!-- 선택된 카테고리 표시 -->
		<div style="text-align: center;">
			<c:choose>
				<c:when test="${cri.pField == 'pField' && cri.level == 'level'}">
					<div style="padding: 10px; background-color: orange;">
						<h3 style="color: black; font-weight: 1000; font-size: 30px;">Project</h3>
					</div>
				</c:when>
				<c:when test="${cri.pField != 'pField' || cri.level != 'level'}">
					<div style="padding: 10px; background-color: orange;">
						<h3 style="color: black; font-weight: 1000; font-size: 30px;">
							Project
							<c:choose>
								<c:when test="${cri.pField == 'pField' }"></c:when>
								<c:when test="${cri.pField == 'pField1' }"> - WEB</c:when>
								<c:when test="${cri.pField == 'pField2' }"> - Mobile App</c:when>
								<c:when test="${cri.pField == 'pField3'}"> - Embedded</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${cri.level == 'level' }"></c:when>
								<c:when test="${cri.level == 'level1' }"> - Basic</c:when>
								<c:when test="${cri.level == 'level2' }"> - Intermediate</c:when>
								<c:when test="${cri.level == 'level3'}"> - Advanced</c:when>
							</c:choose>
						</h3>
					</div>
				</c:when>

			</c:choose>
		</div>

		<div class="container px-4 px-lg-5 mt-5">

			<div class="row">
				<table style="float: right;">
					<tr>
						<td>
							<!-- 글 주제별 이동 --> <!-- 로그인 여부에따라 숨김 / 표시 --> <c:choose>
								<c:when test="${isLogOn == true && member != null}">
									<a id="cwrite_btn" class="btn btn-primary px-auto me-sm-3"
										href="/cocoa/view_projectWrite" style="float: right">프로젝트
										모집</a>
									<br>
									<br>
								</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td style="vertical-align: middle;">
							<!-- 정렬 버튼 --> <select class="me-sm-3 py-auto"
							style="float: right; text-align: center; width: auto;"
							id="projectOrder" onchange="selChange()">
								<option value="order by reviewRate desc"
									<c:if test="${cri.projectOrder == 'order by reviewRate desc' }">selected</c:if>>평점높은순</option>
								<option value="order by projectNO desc"
									<c:if test="${cri.projectOrder == 'order by projectNO desc' }">selected</c:if>>최신순</option>
								<option value="order by projectNO"
									<c:if test="${cri.projectOrder == 'order by projectNO' }">selected</c:if>>오래된순</option>
								<c:choose>
									<c:when test="${isLogOn == true && member != null}">
										<option value="and leader like"
											<c:if test="${cri.projectOrder == 'and leader like' }">selected</c:if>>내가
											쓴 글</option>
									</c:when>
								</c:choose>
						</select><br> <br>
						</td>
					</tr>
				</table>
			</div>

			<!-- 생성된 코칭 카탈로그 표시 -->
			<div
				class="row gx-5 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

				<!-- 반복문 시작 컨트롤러에서 addObject한 projectList를 가져와서 project라고 저장 -->
				<c:forEach var="project" items="${projectList}">

					<!-- 카탈로그 틀 -->
					<div class="col mb-5"
						style="padding-left: 30px; padding-right: 30px;">
						<div class="card h-100"
							style="width: 110%; border: 1px solid black;">

							<!-- 개발툴 표시 -->
							<div class="badge bg-dark text-white position-absolute"
								style="top: 0.5rem; right: 0.5rem; background-color: black;">
								<c:choose>
									<c:when test="${project.level == 'level1'}">Basic</c:when>
									<c:when test="${project.level == 'level2'}">Intermediate</c:when>
									<c:when test="${project.level == 'level3'}">Advanced</c:when>
								</c:choose>
							</div>

							<!-- 간판 이미지 (src=경로) thumbnails로 보내면서 쿼리스트링을 사용 -->
							<img class="card-img-top" alt="" height=200
								onerror=" this.src='resources/image/onerror.png'"
								src="${contextPath}/pthumbnails?leader=${project.leader}&pImg=${project.pImg}&projectNO=${project.projectNO}" />

							<!-- 간판이미지 아래 정보 -->
							<div class="card-body" style="background-color: #FFCCCC;">
								<div class="text-center">

									<!-- 리더 -->
									<b style="font-size: 15px; float: left; color: grey;">${project.leader}</b>

									<!-- 후기 개수 (없을시 0개) -->
									<a href="/cocoa/view_reviewInfo?target=${project.leader}">
										<div style="font-size: 13px; float: right;">
											<c:if test="${reCount[project.leader] eq null}">
												<b>0개의 후기</b>
											</c:if>
											<c:if test="${reCount[project.leader] ne null}">
												<b>${reCount[project.leader]}개의 후기</b>
											</c:if>
										</div> <!-- 평점 평균 (없을시 0.0) -->
										<div style="font-size: 13px; float: right;">
											<c:if test="${reAvg[project.leader] eq null}">
												<b
													style="text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black; color: yellow;">
													★&nbsp;</b>
												<b>0.0</b>&nbsp;|&nbsp;</c:if>
											<c:if test="${reAvg[project.leader] ne null}">
												<b
													style="text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black; color: yellow;">
													★&nbsp;</b>
												<b>${reAvg[project.leader]}</b>&nbsp;|&nbsp;</c:if>
										</div>
									</a> <br> <br>

									<!-- 제목 -->
									<b style="font-size: 15px; color: black;">${project.pTitle}</b><br>
									<br>

									<!-- 인원수 -->
									<b style="font-size: 15px; color: #333333; float: right;">${project.memberCount}명
										모집중</b>
								</div>
							</div>

							<!-- projectInfo 이동 -->
							<div class="card-footer pt-2 border-top-0"
								style="background-color: #FFCCCC;">
								<div class="text-center">
									<a class="btn btn-outline-dark mt-auto"
										href="${contextPath}/view_projectInfo?id=${project.leader}&projectNO=${project.projectNO}">Get
										in</a>
								</div>
							</div>
						</div>
					</div>

				</c:forEach>
				<!-- project 반복문 끝 -->
			</div>
			<!-- 쪽 번호 구간 -->
			<div class="pb-3"
				style="text-align: center; font-size: 30px; width: 100%;">

				<c:if test="${pageMaker.prev }">
					<a style="text-decoration: none; color: black; font-size: 15pt;"
						href='<c:url value="/view_projectCate?pField=${cri.pField }&level=${cri.level }&projectOrder=${cri.projectOrder}&page=${pageMaker.startPage-1 }"/>'>이전</a>
				</c:if>

				<c:forEach begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }" var="pageNum">
					<c:choose>
						<c:when test="${cri.page == pageNum }">
							<a style="text-decoration: none; color: red; font-size: 15pt;"
								href='<c:url value="/view_projectCate?pField=${cri.pField }&level=${cri.level }&projectOrder=${cri.projectOrder}&page=${pageNum }"/>'>${pageNum }</a>
						</c:when>
						<c:when test="${cri.page != pageNum }">
							<a style="text-decoration: none; color: black; font-size: 15pt;"
								href='<c:url value="/view_projectCate?pField=${cri.pField }&level=${cri.level }&projectOrder=${cri.projectOrder}&page=${pageNum }"/>'>${pageNum }</a>
						</c:when>
					</c:choose>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
					<a style="text-decoration: none; color: black; font-size: 15pt;"
						href='<c:url value="/view_projectCate?pField=${cri.pField }&level=${cri.level }&projectOrder=${cri.projectOrder}&page=${pageMaker.endPage+1 }"/>'>다음</a>
				</c:if>
			</div>
		</div>
		<!-- 위의 카탈로그 틀이 반복 생성 및 표시 -->

	</section>

	<!-- 하단바 -->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>
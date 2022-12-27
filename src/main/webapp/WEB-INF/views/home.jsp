<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/main.css"/>
	</head>
<%@ include file="/WEB-INF/views/common/header-main.jsp" %>

<div class="main-first-row">
	<div class="main-first-row-btn first-btn"><a href="<c:url value='/course/regularlist'/>">과정목록</a></div>
	<div class="main-first-row-btn second-btn"><a href="<c:url value='/register/list'/>">수강목록</a></div>
	<div class="main-first-row-btn third-btn"><a href="<c:url value='/student/list'/>">수강생목록</a></div>
	<div class="main-first-row-btn fourth-btn"><a href="<c:url value='/survey/list'/>">강의 만족도 조사 목록</a></div>
	<div class="main-first-row-btn fifth-btn"><a href="<c:url value='/data/download'/>">연계 자료 다운</a></div>
</div>

<div class="main-second-row">
	<div class="main-second-row-btn level">
		<div class="title">강좌분류</div>
		<div class="level-content">
			<div class="level-content-item">프론트엔드</div>
			<div class="level-content-item">백엔드</div>
			<div class="level-content-item">데브옵스</div>
		</div>
	</div>
	<div class="main-second-row-btn regular">
		<div class="title">추천과정</div>
		<div class="regular-content">
			<div class="regular-content-item">웹 개발자 과정</div>
			<div class="regular-content-item">웹 개발자 과정</div>
			<div class="regular-content-item">웹 개발자 과정</div>
			<div class="regular-content-item">웹 개발자 과정</div>
			<div class="regular-content-item">웹 개발자 과정</div>
			<div class="regular-content-item">웹 개발자 과정</div>
			<div class="regular-content-item">웹 개발자 과정</div>
		</div>		
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>



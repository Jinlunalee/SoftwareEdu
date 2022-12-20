<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="card m-2">
	<div class="card-header">
		Home
	</div>
	<div class="card-body">
		Content
		<img src="<c:url value='/resources/images/test/home.png'/>" alt="main img"><br>
		<a href="<c:url value='/course/list'/>">강좌</a>
		<a href="<c:url value='/register/list'/>">수강</a>
		<a href="<c:url value='/student/list'/>">수강생</a>
		<a href="<c:url value='/survey/list'/>">강의 만족도 조사</a>
		<a href="">연계 자료 다운</a>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>



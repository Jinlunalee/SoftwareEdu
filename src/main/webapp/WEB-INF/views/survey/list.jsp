<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="card m-2">
	<div class="card-header">
		Home
	</div>
	<div class="card-body">
		Content<br>
		만족도 조사 목록<br>
		<a href="<c:url value='/survey/details/1'/>">1.만족도조사명</a><br>
		<a href="<c:url value='/survey/insert'/>">새 만족도 조사 입력</a><br>
		<a href="<c:url value='/survey/summary/1'/>">1번 강좌 만족도 조사 통계</a><br>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
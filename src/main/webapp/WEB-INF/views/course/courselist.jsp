<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="card m-2">
	<div class="card-header">
		Home
	</div>
	<div class="card-body">
		Content<br>
		강좌 목록 <br>
		<a href="<c:url value='/course/details/1'/>">1번강좌명</a>
		강좌명 <br>
		강좌명 <br>
		강좌명 <br>
		<a href="<c:url value='/course/insert'/>">새 강좌 입력</a>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
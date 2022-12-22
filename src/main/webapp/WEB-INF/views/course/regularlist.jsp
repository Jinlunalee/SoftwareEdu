<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="card m-2">
	<div class="card-header">
		Home
	</div>
	<div class="card-body">
		Content<br>
		과정목록 <br>
		<a href="<c:url value='/course/courselist'/>">1.과정명</a>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="card m-2">
	<div class="card-header">
		Home
	</div>
	<div class="card-body">
		Content<br>
		수강목록<br>
		<a href="<c:url value='/register/details/1'/>">1.수강생명  강좌명</a><br>
		승인 반려 삭제는 팝업 <br>
		<a href="<c:url value='/register/update/1'/>">수정</a>
		<br>
		
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
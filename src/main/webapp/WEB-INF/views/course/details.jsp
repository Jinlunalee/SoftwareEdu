<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="card m-2">
	<div class="card-header">
		Home
	</div>
	<div class="card-body">
		Content<br>
		강좌 상세보기<br>
		내용내용내용 <br>
		<a href="<c:url value='/course/update/1'/>">수정</a>
		(삭제는 팝업으로) 
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
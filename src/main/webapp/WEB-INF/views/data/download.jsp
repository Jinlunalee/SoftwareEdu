<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<style>
img {
    vertical-align: middle;
    border-style: none;
    width: 35px;
    height: 30px;
}
</style> 

<div class="card m-2">
	<div class="card-header">연계 자료 관리  > 연계 자료 조회 
		
	</div>
	<div class="card-body">
		<br>
	<button type="button" class="btn btn-outline-secondary">연계 정보 출력  <img src="<c:url value='/resources/images/download.png'/>" /></button>
	
	</div>
</div>



<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="<c:url value='/resources/css/survey/summary.css'/>" />
<script type="text/javascript">
</script>

<div class="card m-2">
	<div class="card-header">만족도 조사 관리 > 만족도 조사 통계</div>
	<div class="card-body">
	
		<div class="course-id-select">
			<select class="course-id-select" name="serveyqn-select" onchange="changeSelect(this.value)">
				<c:forEach var="i" begin="1" end="5" step="1">
					<option value="${surveyqn}">문항${i}</option>
				</c:forEach>
			</select>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
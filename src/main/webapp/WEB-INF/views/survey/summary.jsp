<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="<c:url value='/resources/css/survey/summary.css'/>" />
<script type="text/javascript">
const changeSelect = function(value){
	
}

</script>
<div class="card m-2">
	<div class="card-header">
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div>> 만족도 조사 관리 > <span class="submenu-title">만족도 조사 통계</span></div>
	</div>
	<div class="card-body">
		<div class="content-grid">
			<div class="course-id-dropdown">
				<select class="course-id-select" name="serveyqn-select" onchange="changeSelect(this.value)">
					<c:forEach var="i" begin="1" end="5" step="1">
						<option value="${courseId}">강좌아이디${i}</option>
					</c:forEach>
				</select>
			</div>
			<div class="charts">
				<div class="charts-grid">
					<div id="chart-table" class="chart-item chart-table">
						<div class="chart-item-title">
							<img class="title-img" src="<c:url value='/resources/images/survey/survey_summary.png'/>"/>
							강좌 전체 만족도
						</div>
					</div>
					<div id="chart-bar" class="chart-item chart-bar">
						<div class="chart-item-title">
							<img class="title-img" src="<c:url value='/resources/images/survey/survey_summary.png'/>"/>
							강좌 문항별 만족도
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/summary.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
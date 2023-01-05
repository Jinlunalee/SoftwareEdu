<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="<c:url value='/resources/css/survey/summary.css'/>" />
<div class="card m-2">
	<div class="card-header">
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div>> 만족도 조사 관리 > <span class="submenu-title">만족도 조사 통계</span></div>
	</div>
	<div class="card-body">
		<div class="content-grid">
			<div class="course-id-dropdown">
				<select class="course-id-select" name="serveyqn-select" onchange="changeSelect(this.value)">
					<c:forEach var="subjectList" items="${subjectList}">
						<option value="${subjectList.subjectId}/${subjectList.subjectSeq}">강좌명  : ${subjectList.subjectTitle} | 강좌순번 : ${subjectList.subjectSeq}</option>
					</c:forEach>
				</select>
				<div>
				test : ${answerVo.countAnswerValue}
				</div>
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
<script>
	$(document).ready(function() {
	});
	const changeSelect = function(subject){ // subject : 화면에서 select로 고른 개설된 강좌의 정보
		let subjectArr = subject.split('/');
		let subjectId = subjectArr[0];
		let subjectSeq = subjectArr[1];
		console.log("subjectId : " + subjectId);
		console.log("subjectSeq : " + subjectSeq);
		console.log(typeof subjectSeq);
		$.ajax({
			url : "getjson?subjectId=" + subjectId + "&subjectSeq=" + subjectSeq,
			type : "GET",
			success : function(data){
				showTableChart(data); // subject에 따른 table chart 보여주기
				showBarChart(data); // subject에 따른 bar chart 보여주기
			},
			// success : function() {
			// 	alert("good");
			// },
			error:function(data){
				alert("error");
			}
		});
	}
	</script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/summary.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
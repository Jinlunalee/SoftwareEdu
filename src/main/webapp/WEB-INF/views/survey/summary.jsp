<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="<c:url value='/resources/css/survey/summary.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/common/searchpop.css'/>" />

<div class="card m-2">
	<div class="card-header">
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div>> 만족도 조사 관리 > <span class="submenu-title">만족도 조사 통계</span></div>
	</div>
	<div class="card-body">
		<div class="content-grid">
			<div class="course-id-dropdown">
				<select class="course-id-select" name="serveyqn-select" onchange="changeSelect(this.value)">
					<option value="">완료된 강좌명 및 강좌순번을 선택하세요.</option>
					<c:forEach var="subjectList" items="${subjectList}">
						<option value="${subjectList.subjectId}/${subjectList.subjectSeq}">강좌명  : ${subjectList.subjectTitle} | 강좌순번 : ${subjectList.subjectSeq}</option>
					</c:forEach>
				</select>

				<!-- 검색 팝업 입력창 및 버튼 -->
				<div class="search-popup">
					<input id="subjectName-input" type="readonly" placeholder="검색 버튼을 눌러 완료된 강좌를 검색하세요.">
					<input id="subjectId-input" name="subjectId" type="hidden">
					<input id="subjectSeq-input" name="subjectSeq" type="hidden">
					<button class="open-subject-popup-btn">검색</button>
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
		if(subject){
			let subjectArr = subject.split('/');
			let subjectId = subjectArr[0];
			let subjectSeq = subjectArr[1];
			$.ajax({
				url : "getjson?subjectId=" + subjectId + "&subjectSeq=" + subjectSeq,
				type : "GET",
				success : function(data){
					console.log(data);
					showTableChart(data); // subject에 따른 table chart 보여주기
					showBarChart(data); // subject에 따른 bar chart 보여주기
				},
				error:function(){
					alert("well well well");
				}
			});
		} else {
			// subject가 비어있을 때, 즉 "선택하세요."를 선택했을 때
		}
	}
	</script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/summary.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/searchpop.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
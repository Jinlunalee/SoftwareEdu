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
				<!-- 검색 팝업 입력창 및 버튼 -->
				<div class="search-popup">
					<input id="subjectTitle-input" readonly placeholder="검색 버튼을 눌러 완료된 강좌를 검색하세요.">
					<input id="subject-input" name="subject" type="hidden">
					<input id="state-input" name="state" type="hidden">
					<button class="open-subject-done-popup-btn btn btn-outline-secondary">검색</button>
					<button type="button" id="summary-btn" class="btn btn-outline-secondary" onclick="viewSummary()">통계 조회하기</button>
				</div>
			</div>

			<!-- 차트 테이블 -->
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
				<div class="down">
					<button class="downBtn" type="button" onclick="downloadExcel()">
						<img class="excelimg" src="<c:url value='/resources/images/register/exceldown.png'/>" />
					</button>
				</div>		
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
	});
	/* 통계 조회 버튼 누를 시 통계 테이블 보여주기 */
	const viewSummary = function() {
		let subject = document.getElementById('subject-input').value;
		console.log(subject);
		if(subject){
			let subjectArr = subject.split('/');
			let subjectId = subjectArr[0];
			let subjectSeq = subjectArr[1];
			let openDt = subjectArr[4];
			let state = subjectArr[5];
			if(state==='OPN05'){
				$.ajax({
					url : "getjson?subjectId=" + subjectId + "&subjectSeq=" + subjectSeq,
					type : "GET",
					success : function(data){
						console.log(data);
						showTableChart(data); // subject에 따른 table chart 보여주기
						showBarChart(data); // subject에 따른 bar chart 보여주기
					},
					error:function(){
						alert("요청에 실패했습니다. 관리자에게 문의하세요.");
					}
				});
			} else {
				alert("완료된 강의를 선택해주세요.");
			}
		} else {
			alert("강의를 선택해주세요.");
		}
	}
	/*버튼 누르면 엑셀 다운로드 받기*/
	function downloadExcel(){
		let subject = document.getElementById('subject-input').value;
		console.log(subject);
		if(subject){
			let subjectArr = subject.split('/');
			let subjectId = subjectArr[0];
			let subjectSeq = subjectArr[1];
			let openDt = subjectArr[3];
			location.href = '<c:url value="/survey/downloadexcel?subjectId='+ subjectId + '&subjectSeq=' + subjectSeq + '&openDt=' + openDt+'"/>';
		}else{
			alert('강의를 선택해주세요');
		}
	}
	</script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opensearchpop.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/summary.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
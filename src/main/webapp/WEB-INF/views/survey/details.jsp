<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/survey/details.css'/>" />

<div class="card m-2">
	<div class="card-header">만족도 조사 관리 > 만족도 조사 양식 목록 조회 > 만족도 조사 양식 상세 조회 </div>
	<div class="card-body">
		<div class="survey_top"><span class="survey_id">만족도 조사 아이디1</span><span class="survey_title">만족도 조사 제목</span></div>
		<div class="survey_content">
		<c:forEach var="i" begin="1" end="5" step="1">
		<ul class="question-set">
			<div class="question">
				<img class="surveyqn" src="<c:url value='/resources/images/survey/survey_question.png'/>"/>
				수업 진도가 적당하였습니까?
			</div>
			<div class="answer">
				<input class="answer-item answer-5" type="radio" name="check${i}" checked="checked" value="5">매우 만족
				<input class="answer-item answer-4" type="radio" name="check${i}" value="4">만족
				<input class="answer-item answer-3" type="radio" name="check${i}" value="3">보통
				<input class="answer-item answer-2" type="radio" name="check${i}" value="2">불만족
				<input class="answer-item answer-1" type="radio" name="check${i}" value="1">매우 불만족
			</div>
		</ul>
		</c:forEach>
		</div>
		<div class="buttons">
			<button type="button" class="button-item survey-btn" onclick="location.href ='<c:url value="/survey/update"/>'">수정</button>
			<button type="button" class="button-item delete-btn" onclick="location.href ='<c:url value="/survey/delete"/>'">삭제</button>
		</div>
	</div>
	
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
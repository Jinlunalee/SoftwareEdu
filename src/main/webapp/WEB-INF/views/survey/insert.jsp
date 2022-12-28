<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="<c:url value='/resources/css/survey/insert.css'/>" />
<script type="text/javascript">
const changeSelect = function(value){
	if(value == "add") {
		console.log("새 문항 추가");
/* 		document.querySelector(".surveyqn-input").innerHTML = `<input type="text" placeholder="새로운 문항을 입력해주세요."`; */
		const addInput = '<input class="surveyqn-inputbox" type="text" placeholder="새로운 문항을 입력해주세요.">';
		// 클래스 명 추가 ex. .surveyqn-input-1
		$(".surveyqn-input-1").append(addInput);
	} else {
		console.log("기존 항목 선택");
		$(".surveyqn-input-1 *").remove();
	}
}
</script>

<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	 <div> > 만족도 조사 관리 > <span class="submenu-title">만족도 조사 양식 추가</span></div>
	</div>
	<div class="card-body">
	
	<c:url value="/servey/insert" var="actionURL" scope="page"/>
	<form:form class="" action="${actionURL}" modelAttribute="survey">
		<div class="survey_top">
			<input class="survey_title_input" type="text" placeholder="만족도 조사 제목을 입력해주세요."/>
		</div>
		
		<div class="survey_content">
		<ul class="question-set">
			<div class="question">
				<img class="surveyqn-img" src="<c:url value='/resources/images/survey/survey_question.png'/>"/>
				<select class="serveyqn-select" name="serveyqn-select" onchange="changeSelect(this.value)">
					<c:forEach var="i" begin="1" end="5" step="1">
						<option value="${surveyqn}">문항${i}</option>
					</c:forEach>
					<option value="add">새 문항 추가</option>
				</select>
				<!-- select option의 value가 "add"일 때 if문 실행 -->
				<div class="surveyqn-input-1"></div>
			</div>
			<div class="answer">
				<input class="answer-item answer-5" type="radio" name="check${i}" value="5" onclick="return(false)">매우 만족
				<input class="answer-item answer-4" type="radio" name="check${i}" value="4" onclick="return(false)">만족
				<input class="answer-item answer-3" type="radio" name="check${i}" value="3" onclick="return(false)">보통
				<input class="answer-item answer-2" type="radio" name="check${i}" value="2" onclick="return(false)">불만족
				<input class="answer-item answer-1" type="radio" name="check${i}" value="1" onclick="return(false)">매우 불만족
			</div>
		</ul>
		<ul class="question-set">
			<div class="question">
				<img class="surveyqn-img" src="<c:url value='/resources/images/survey/survey_question.png'/>"/>
				<select class="serveyqn-select" name="serveyqn-select" onchange="changeSelect(this.value)">
					<c:forEach var="i" begin="1" end="5" step="1">
						<option value="${surveyqn}">문항${i}</option>
					</c:forEach>
					<option value="add">새 문항 추가</option>
				</select>
				<!-- select option의 value가 "add"일 때 if문 실행 -->
				<div class="surveyqn-input-2"></div>
			</div>
			<div class="answer">
				<input class="answer-item answer-5" type="radio" name="check${i}" value="5" onclick="return(false)">매우 만족
				<input class="answer-item answer-4" type="radio" name="check${i}" value="4" onclick="return(false)">만족
				<input class="answer-item answer-3" type="radio" name="check${i}" value="3" onclick="return(false)">보통
				<input class="answer-item answer-2" type="radio" name="check${i}" value="2" onclick="return(false)">불만족
				<input class="answer-item answer-1" type="radio" name="check${i}" value="1" onclick="return(false)">매우 불만족
			</div>
		</ul>
		<ul class="question-set">
			<div class="question">
				<img class="surveyqn-img" src="<c:url value='/resources/images/survey/survey_question.png'/>"/>
				<select class="serveyqn-select" name="serveyqn-select" onchange="changeSelect(this.value)">
					<c:forEach var="i" begin="1" end="5" step="1">
						<option value="${surveyqn}">문항${i}</option>
					</c:forEach>
					<option value="add">새 문항 추가</option>
				</select>
				<!-- select option의 value가 "add"일 때 if문 실행 -->
				<div class="surveyqn-input-3"></div>
			</div>
			<div class="answer">
				<input class="answer-item answer-5" type="radio" name="check${i}" value="5" onclick="return(false)">매우 만족
				<input class="answer-item answer-4" type="radio" name="check${i}" value="4" onclick="return(false)">만족
				<input class="answer-item answer-3" type="radio" name="check${i}" value="3" onclick="return(false)">보통
				<input class="answer-item answer-2" type="radio" name="check${i}" value="2" onclick="return(false)">불만족
				<input class="answer-item answer-1" type="radio" name="check${i}" value="1" onclick="return(false)">매우 불만족
			</div>
		</ul>
		<ul class="question-set">
			<div class="question">
				<img class="surveyqn-img" src="<c:url value='/resources/images/survey/survey_question.png'/>"/>
				<select class="serveyqn-select" name="serveyqn-select" onchange="changeSelect(this.value)">
					<c:forEach var="i" begin="1" end="5" step="1">
						<option value="${surveyqn}">문항${i}</option>
					</c:forEach>
					<option value="add">새 문항 추가</option>
				</select>
				<!-- select option의 value가 "add"일 때 if문 실행 -->
				<div class="surveyqn-input-4"></div>
			</div>
			<div class="answer">
				<input class="answer-item answer-5" type="radio" name="check${i}" value="5" onclick="return(false)">매우 만족
				<input class="answer-item answer-4" type="radio" name="check${i}" value="4" onclick="return(false)">만족
				<input class="answer-item answer-3" type="radio" name="check${i}" value="3" onclick="return(false)">보통
				<input class="answer-item answer-2" type="radio" name="check${i}" value="2" onclick="return(false)">불만족
				<input class="answer-item answer-1" type="radio" name="check${i}" value="1" onclick="return(false)">매우 불만족
			</div>
		</ul>
		<ul class="question-set">
			<div class="question">
				<img class="surveyqn-img" src="<c:url value='/resources/images/survey/survey_question.png'/>"/>
				<select class="serveyqn-select" name="serveyqn-select" onchange="changeSelect(this.value)">
					<c:forEach var="i" begin="1" end="5" step="1">
						<option value="${surveyqn}">문항${i}</option>
					</c:forEach>
					<option value="add">새 문항 추가</option>
				</select>
				<!-- select option의 value가 "add"일 때 if문 실행 -->
				<div class="surveyqn-input-5"></div>
			</div>
			<div class="answer">
				<input class="answer-item answer-5" type="radio" name="check${i}" value="5" onclick="return(false)">매우 만족
				<input class="answer-item answer-4" type="radio" name="check${i}" value="4" onclick="return(false)">만족
				<input class="answer-item answer-3" type="radio" name="check${i}" value="3" onclick="return(false)">보통
				<input class="answer-item answer-2" type="radio" name="check${i}" value="2" onclick="return(false)">불만족
				<input class="answer-item answer-1" type="radio" name="check${i}" value="1" onclick="return(false)">매우 불만족
			</div>
		</ul>
		</div>
		<div class="buttons">
			<button type="button" class="button-item survey-btn" onclick="location.href ='<c:url value="/survey/update"/>'">저장</button>
			<button type="button" class="button-item delete-btn" onclick="history.back();">뒤로가기</button>
		</div>
	</form:form>
	</div>
	
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
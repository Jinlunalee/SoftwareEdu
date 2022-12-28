<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="<c:url value='/resources/css/survey/details.css'/>" />
<script type="text/javascript">
/* 문항 개수를 입력 받아 추가 */
const changeQuestionNumber = function(value) {
	let questionNumber = value;
	console.log(questionNumber);
	const questionSet = document.querySelector("#question-set-3");
 		$("#new-questions").empty();
	for(let i=0, max = questionNumber; i<max-3; i++){
		$(questionSet).clone().appendTo('#new-questions');
		/* 아이디명 바꾸기 */
		changeId(i);
	};
};
/* 아이디 명 바꾸기 */
function changeId(i) {
	let number = (i+4).toString();
	console.log(number);
	document.querySelector("#new-questions #question-set-3").setAttribute("id", 'question-set-' + number);
	console.log(document.querySelector("#new-questions .question-set-3"));
};
/* 문항 추가 버튼 클릭하여 추가 */
/* $(document).ready(function () {
	console.log("ready");
	$('#btnAction').on("click",function(e){
		console.log("clicked");
		const questionSet = document.querySelector("#question-set-3");
		console.log(questionSet);
		$(questionSet).clone().appendTo('#new-questions');
 	});
}); */

/* 문항 종류 dropdown에서  "새 문항 입력" select시 입력 창 출력 */
const changeQuestionAddSelect = (value, event) => {
	if(value == "add") {
		console.log("새 문항 추가");
/* 		document.querySelector(".surveyqn-input").innerHTML = `<input type="text" placeholder="새로운 문항을 입력해주세요."`; */
/* 		셀렉트가 있는 아이디 찾아서 변수에 저장
		해당 셀렉트 하단에 추가하기 */
		let eventParentElement = (event.target.parentElement);
		console.log(event.target.parentElement);
		const addInput = '<input class="surveyqn-inputbox" type="text" placeholder="새로운 문항을 입력해주세요.">';
		$(eventParentElement).append(addInput);
	} else {
		console.log("기존 항목 선택");
/* 		셀렉트가 있는 아이디 찾아서 변수에 저장
		해당 셀렉트 추가 내용 지우기 */ 
		$(".surveyqn-input *").remove();
	}
}
</script>
<div class="card m-2">

	<div class="card-header"> 
		<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
		<div> > 만족도 조사 관리 > <span class="submenu-title">만족도 조사 양식 추가</span></div>
	</div>
	<div class="card-body">
		<div class="content-grid">
		<c:url value="/servey/insert" var="actionURL" scope="page"/>
		<form:form class="" action="${actionURL}" modelAttribute="survey">
			<div class="survey_top">
				<input class="survey_title_input" type="text" placeholder="만족도 조사 제목을 입력해주세요."/>
				<div class="question-number">
					<div class="question-number-upper-row">
						<div class="question-number-text">문항 개수</div>
						<span><select class="question-number-dropdown" onchange="changeQuestionNumber(this.value)">
							<option value=3>3개</option>
							<option value=4>4개</option>
							<option value=5>5개</option>
							<option value=6>6개</option>
							<option value=7>7개</option>
							<option value=8>8개</option>
							<option value=9>9개</option>
							<option value=10>10개</option>
						</select></span>
					</div>
					<div class="question-number-lower-row">
						<div class="question-number-warning">*문항은 최소 3개부터 최대 10개까지 입력 가능합니다.</div>
					</div>
				</div>
			</div>
			
			<div class="survey_content">
				<div id="question-grid" class="question-grid">
					<c:forEach var="i" begin="1" end="3" step="1">
						<div id="question-set-${i}" class="question-set">
							<div class="question">
								<img class="surveyqn-img" src="<c:url value='/resources/images/survey/survey_question.png'/>"/>
								<select class="serveyqn-select" name="serveyqn-select" onchange="changeQuestionAddSelect(this.value)">
									<c:forEach var="i" begin="1" end="5" step="1">
										<option value="${surveyqn}">문항${i}</option>
									</c:forEach>
									<option value="add">새 문항 입력</option>
								</select>
								<span id="surveyqn-input" class="serveyqn-input"></span>
							</div>
							<div class="answer">
								<input class="answer-item answer-5" type="radio" name="check${i}" value="5" onclick="return(false)">매우 만족
								<input class="answer-item answer-4" type="radio" name="check${i}" value="4" onclick="return(false)">만족
								<input class="answer-item answer-3" type="radio" name="check${i}" value="3" onclick="return(false)">보통
								<input class="answer-item answer-2" type="radio" name="check${i}" value="2" onclick="return(false)">불만족
								<input class="answer-item answer-1" type="radio" name="check${i}" value="1" onclick="return(false)">매우 불만족
							</div>
						</div>
					</c:forEach>
				</div>
				<div id="new-questions" class="new-questions"></div>
			</div>
<!-- 			<span id="spantag" class="spantag"><button type="button" class="add-question-btn" value="문항 추가" id="btnAction">+문항 추가</button></span> -->
			<div class="buttons">
				<button type="button" class="button-item survey-btn" onclick="location.href ='<c:url value="/survey/update"/>'">저장</button>
				<button type="button" class="button-item delete-btn" onclick="history.back();">뒤로가기</button>
			</div>
			</div>
		</form:form>
		</div>
	</div>
	
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
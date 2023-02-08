<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/course/details.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/form.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />
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
</script>

<div class="card">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	 <div><span> > 강좌 관리 ></span> <span class="submenu-title">강좌 개설</span> </div>
	</div>
	<div class="card-body">
	
		<div class="modal">
			<div class="modal_body">
				<div class="content-grid">
					<c:url value="/servey/insert" var="actionURL" scope="page"/>
					<form:form class="" action="${actionURL}" modelAttribute="survey">
						<div class="survey_top">
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
											<input class="serveyqn-input" type="text" placeholder="문항을 입력해주세요.">
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
					</form:form>
				</div>
			</div>
		</div>
	
	</div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
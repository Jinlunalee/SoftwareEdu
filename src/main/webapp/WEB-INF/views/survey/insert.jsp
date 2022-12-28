<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="<c:url value='/resources/css/survey/details.css'/>" />
<script type="text/javascript">
const changeSelect = function(value){
	if(value == "add") {
		console.log("새 문항 추가");
/* 		document.querySelector(".surveyqn-input").innerHTML = `<input type="text" placeholder="새로운 문항을 입력해주세요."`; */
/* 		버튼이 있는 클래스 찾아서 변수에 저장
		해당 클래스 하단에 추가하기 */
		document.querySelector();
		const addInput = '<input class="surveyqn-inputbox" type="text" placeholder="새로운 문항을 입력해주세요.">';
		$(".surveyqn-input").append(addInput);
	} else {
		console.log("기존 항목 선택");
/* 		버튼이 있는 클래스 찾아서 변수에 저장
		해당 클래스 추가 내용 지우기 */ 
		$(".surveyqn-input *").remove();
	}
}
$(document).ready(function () {
	console.log("ready");
	$('#btnAction').on("click",function(e){
		console.log("clicked");
		$('#question-set').clone().insertBefore('.spantag');
/*  	   var c1 = $('.question-set tr:eq(0)').clone(true); 
 	   $(".survey_content").append(c1); */
 	});
});
</script>

<div class="card m-2">
	<div class="card-header"> 
		<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
		 <div> > 만족도 조사 관리 > 만족도 조사 양식 목록 조회 > 만족도 조사 양식 상세 조회 </div>
	</div>
	
	<div class="card-body">
		<div class="content-grid">
		<c:url value="/servey/insert" var="actionURL" scope="page"/>
		<form:form class="" action="${actionURL}" modelAttribute="survey">
			<div class="survey_top">
				<input class="survey_title_input" type="text" placeholder="만족도 조사 제목을 입력해주세요."/>
			</div>
			
			<div class="survey_content">
			<div id="question-set" class="question-set">
				<div class="question">
					<img class="surveyqn-img" src="<c:url value='/resources/images/survey/survey_question.png'/>"/>
					<select class="serveyqn-select" name="serveyqn-select" onchange="changeSelect(this.value)">
						<c:forEach var="i" begin="1" end="5" step="1">
							<option value="${surveyqn}">문항${i}</option>
						</c:forEach>
						<option value="add">새 문항 추가</option>
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
			<span class="spantag"><button type="button" class="add-question-btn" value="문항 추가" id="btnAction">+문항 추가</button></span>
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
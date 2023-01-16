<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="<c:url value='/resources/css/course/details.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/form.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/survey/details.css'/>" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">

<script type="text/javascript">
/* 문항 개수를 입력 받아 추가 */
const changeQuestionNumber = function(value) {
	let questionNumber = value;
	const questionSet = document.querySelector("#question-set-3");
	$("#new-questions").empty();
	for(let i=0, max = questionNumber; i<max-3; i++){
		$(questionSet).clone().appendTo('#new-questions');
		changeClassId(i);
		changeEverything(i);
	};
};
/* Modal 클래스 id 바꾸기 */
function changeClassId(i) {
	let number = (i+4).toString();
	document.querySelector("#new-questions #question-set-3").setAttribute("id", 'question-set-' + number);
};
/* Modal input 클래스 id, Num value, Set name 바꾸기  */
function changeEverything(i) {
	let number = (i+4).toString();
	let numberMinusOne = (i+3).toString();
	document.querySelector("#new-questions #question-inputNum-3").setAttribute("value", number); // questionNum 값 넣기
	document.querySelector("#new-questions #question-inputNum-3").setAttribute("name", 'questionSet[' + numberMinusOne + '].questionNum'); // questionNum name값 넣기 (매핑을 위함)
	document.querySelector("#new-questions #question-inputSet-3").setAttribute("name", 'questionSet[' + numberMinusOne + '].questionContent'); // questionContent name값 넣기 (매핑을 위함)
	document.querySelector("#new-questions #question-inputNum-3").setAttribute("id", 'question-inputNum-' + number); // questionNum 아이디 바꾸기
	document.querySelector("#new-questions #question-inputSet-3").setAttribute("id", 'question-inputSet-' + number); // questionContent 아이디 바꾸기
}
</script>
<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div><span> > 강좌 관리 ></span> <span class="submenu-title">강좌 개설</span> </div>
	</div>
	<div class="card-body">
		<form class="insert_form" action="<c:url value='/subject/insert'/>" method="post" enctype="multipart/form-data">
			<div class="sub_title">정기과정명 | 
				<select class="select_course" name="courseId" id="courseId">
					<option value="">선택안함</option>
					<c:forEach var="course" items="${allCourseList}">
						<option value="${course.courseId}">${course.courseTitle}</option>
					</c:forEach>
				</select>
			</div>
		
			<div class="course_title">
				<div class="main_title"><b>강좌명</b> 
					<div class="search-popup">
						<input id="subjectTitle-input" readonly placeholder="검색 버튼을 눌러 강좌를 검색하세요.">
						<input id="subject-input" name="subject" type="hidden">
						<button class="subject-popup-btn btn btn-outline-secondary">검색</button>
						<!-- <button type="button" id="summary-btn" class="btn btn-outline-secondary" onclick="viewSummary()">통계 조회하기</button> -->
					</div>
					<!-- <select class="select_smallCourse" name="subjectId" id="subjectId">
						<option value="">선택안함</option>
						<c:forEach var="subject" items="${allSubjectList}">
							<option value="${subject.subjectId}">${subject.subjectTitle}</option>
						</c:forEach>
					</select> -->
				</div>
			</div>
			<table class="list">
				<colgroup>
					<col width="40%">
					<col width="15%">
					<col width="45%">
				</colgroup>
			<thead>
			<tr>
				<th></th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td rowspan="8">
					<img class="detail_img" src="<c:url value='/resources/images/subject/no_image.png'/>"/>
				</td>
				<td> 연수기간(시수)</td>
				<td> 
					<input type="hidden" name="hours" id="hours" value="">
					<input type="date" name="startDay" id="startDay" min="" onchange="selectRecruitDay()">
					~ 
					<input type="date" name="endDay" id="endDay" readonly>
					<span id="printDay"></span>
					<span id="printHours"></span>
				</td>
			</tr>
			<tr>
				<td> 연수시간</td>
				<td> <!-- 30분단위로 입력(초) -->
					<input class="timepicker" name="startTime" id="startTime"> 
					~ 
					<input class="timepicker" name="endTime" id="endTime">
				</td>
			</tr>
			<tr>
				<td> 신청기간 </td>
				<td> 
					<input type="date" name="recruitStartDay" id="recruitStartDay" onchange="inputState()"> 
					~ 
					<input type="date" name="recruitEndDay" id="recruitEndDay" onchange="inputState()"> 
				</td>
			</tr>
			<tr>
				<td> 난이도 </td>
				<td><span name="level" id="level"></span></td>
			</tr>
			<tr>
				<td> 모집인원</td>
				<td> <input type="text" name="recruitPeople"> 명 </td>
			</tr>
			<tr>
				<td> 교육비</td>
				<td><span name="cost" id="cost"></span>  
					<span class="support"></span>
				</td>
			</tr>
			<tr>
				<td> 만족도 조사</td>
				<td> <button type="button" class="btn-open-popup btn btn-secondary" style="height:35px;">입력</button> </td>
			</tr>
			<tr>
				<td> 첨부파일 </td>
				<td class="filebox"> 
					<input class="insert_FileUpload" placeholder="업로드 파일의 최대 크기는 50MB 입니다.">
					<span><label for="file">파일찾기</label></span>
					<input type="file" name="file" id="file" onchange="previewImg(this);">
				</td>
			</tr>
			</tbody>
		</table>
		
		<div class="hidden-inputs" style="display: none;">
		</div>
		
		<!-- modal -->
		<div class="modal">
			<div class="modal_body">
				<div class="content-grid">
					<div class="survey_top">
						<div class="question-number">
							<div class="question-number-upper-row">
								<div class="question-number-text">문항 개수</div>
								<span><select class="question-number-dropdown" id="question-number-dropdown" onchange="changeQuestionNumber(this.value)">
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
										<input id="question-inputNum-${i}" class="questionNum" name="questionSet[${i-1}].questionNum" value="${i}" type="hidden" placeholder="문항을 입력해주세요.">
										<input id="question-inputSet-${i}" class="questionSet serveyqn-input" name="questionSet[${i-1}].questionContent" type="text" required placeholder="문항을 입력해주세요.">
										<span id="surveyqn-input" class="serveyqn-input"></span>
									</div>
								</div>
							</c:forEach>
						</div>
						<div id="new-questions" class="new-questions"></div>
					</div>
					<div class="buttons">
						<button type="button" class="button-item close-btn" onclick="">입력완료</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="course_intro">
			<img src="<c:url value='/resources/images/subject/subject_intro.png'/>"/>
			<p class="txt"> <textarea name="content" id="content" cols="60" rows="10"></textarea> </p>
		</div>
		<div class="submit-btn">
			<input type="hidden" name="state" id="state" value="">
			<input type="submit" class="btn-submit-open-popup" value="저장">
		</div>
		</form>		
	</div>
</div>

	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/subject.js'/>"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opensearchpop.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/summary.js"></script>
	<script type="text/javascript">
	
	/* 모달창 열기 */
	const body = document.querySelector('body');
	const modal = document.querySelector('.modal');
	const btnOpenPopup = document.querySelector('.btn-open-popup');

	btnOpenPopup.addEventListener('click', () => {
		modal.classList.toggle('show'); // class를 이용한 모달 on

		if (modal.classList.contains('show')) { // 모달이 on일 때
		body.style.overflow = 'hidden'; // body의 스크롤을 막음
		}
	});

	modal.addEventListener('click', (event) => {
		if (event.target === modal) {
		modal.classList.toggle('show'); // class를 이용한 모달 on

			if (!modal.classList.contains('show')) { // 모달이 off일 때
			body.style.overflow = 'auto';  // body의 스크롤을 풂
			}
		}
	});

	/* closeBtn 눌렀을 때 - 모달창 닫기, Modal 입력값 부모창에 저장*/
	const closeBtn = modal.querySelector(".close-btn");

	$(closeBtn).click(function(){
		modal.classList.remove('show'); // 모달창 닫기
		saveInputQuestions(); // Modal 입력값을 부모창에 저장  
	});

	/* Modal 입력값을 부모창에 저장 */
	function saveInputQuestions() {
		console.log("connected!");
		const hiddenInputs = document.getElementsByClassName("hidden-inputs"); // Modal에서 받은 항목명이 들어갈 hidden div
		var questionNumber = $("#question-number-dropdown option:selected").val(); // 항목 개수
		$(hiddenInputs).empty(); // 중복 방지
		/* Modal에서 받은 항목명을 hidden div에 저장  */
		for(var k=1; k<=questionNumber; k++) {
			let questionInputNum = "#question-inputNum-" + k; // 가져올 Modal에 있는 항목순번 아이디 저장
			let questionInputSet = "#question-inputSet-" + k; // 가져올 Modal에 있는 항목명 아이디 저장
			let hiddenQuestionInputSet = ".hidden-inputs #question-inputSet-" + k; // 붙여넣은 hidden div아래에 있는 항목명 아이디 저장
			let hiddenInputNum = document.querySelector(questionInputNum); // Modal에서 저장한 항목순번 가져오기
			let hiddenInputSet = document.querySelector(questionInputSet); // Modal에서 저장한 항목명 가져오기
			$(hiddenInputNum).clone().appendTo(hiddenInputs); // 복제해서 hidden div에 추가하기
			$(hiddenInputSet).clone().appendTo(hiddenInputs); // 복제해서 hidden div에 추가하기
			console.log(questionInputSet);
			document.querySelector(hiddenQuestionInputSet).setAttribute("value", $(questionInputSet).val()); // Modal의 항목명에서 받은 value를 hidden div의 항목명에 넣기
		};
	}

	/* Submit버튼 클릭 시, Question 3개 이상 입력하지 않았으면 alert */
	const submitBtn = document.querySelector(".btn-submit-open-popup"); // submit 버튼 저장
	submitBtn.addEventListener("click", checkInputMoreThanThree); // submit 버튼 클릭 시 checkInputMoreThanThree 함수 실행

	function checkInputMoreThanThree() { // Question Input Null 확인해서 alert 해줌
		const hiddenInputs = document.getElementsByClassName("hidden-inputs");

		// hidden div 아래에 추가된 .serveyqn-input 개수 및 value 확인
		let hiddenQnInputsCount = hiddenInputs[0].childElementCount/2;  // .serveyqn-input 개수
		for (var i=1; i<=hiddenQnInputsCount; i++) { // .serveyqn-input 개수만큼 반복
			if(!hiddenInputs[0].childNodes[i*2-1].value) { // hidden div 아래에 추가된 .serveqn-input의 value가 없다면
				alert("만족도 조사는 필수 항목이며, 입력을 위해 문항을 최소 3개 이상 입력 후 \"입력완료\" 버튼을 클릭해야 합니다."); // alert
			}
		}
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
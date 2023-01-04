<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="<c:url value='/resources/css/course/details.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/form.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/survey/details.css'/>" />
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
	document.querySelector("#new-questions #question-inputNum-3").setAttribute("value", number); // questionNum 값 넣기
	document.querySelector("#new-questions #question-inputNum-3").setAttribute("name", 'questionSet[' + number + '].questionNum'); // questionNum name값 넣기 (매핑을 위함)
	document.querySelector("#new-questions #question-inputSet-3").setAttribute("name", 'questionSet[' + number + '].questionContent'); // questionContent name값 넣기 (매핑을 위함)
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
					<c:forEach var="course" items="${allCourseList}">
						<option value="${course.courseId}">${course.courseTitle}</option>
					</c:forEach>
				</select> 
			</div>
		
			<div class="course_title">
			<div class="main_title"><b>강좌명</b> 
				<select class="select_smallCourse" name="subjectId" id="subjectId">
					<c:forEach var="subject" items="${allSubjectList}">
						<option value="${subject.subjectId}">${subject.subjectTitle}</option>
					</c:forEach>
				</select>
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
				<td> 연수기간(일수)</td>
				<td> 
					<input type="date" name="startDay" id="startDay">
					~ 
					<input type="date" name="endDay" id="endDay" readonly>
					<input type="hidden" name="hours" id="hours" value=720>
				</td>
			</tr>
			<tr>
				<td> 연수시간</td>
				<td> <!-- 30분단위로 입력(초) -->
					<input type="time" name="startTime" id="startTime" min="9:00" max="21:00" step="1800"> 
					~ 
					<input type="time" name="endTime" id="endTime" onchange="changeDay()"> 
				</td>
			</tr>
			<tr>
				<td> 신청기간 </td>
				<td> 
					<input type="date" name="recruitStartDay" id="recruitStartDay"> 
					~ 
					<input type="date" name="recruitEndDay" id="recruitEndDay" onchange="inputState()"> 
				</td>
			</tr>
			<tr>
				<td> 난이도 </td>
				<td></td>
			</tr>
			<tr>
				<td> 모집인원</td>
				<td> <input type="text" name="recruitPeople"> 명 </td>
			</tr>
			<tr>
				<td> 교육비</td>
				<td> <input type="text" name="cost"> 원  
					<c:if test="${subject.supportYn eq 'Y'}"><span class="support">※교육비 지원을 받는 강좌입니다.</span></c:if>
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
										<input id="question-inputNum-${i}" class="questionNum" name="questionSet[${i}].questionNum" value="${i}" type="hidden" placeholder="문항을 입력해주세요.">
										<input id="question-inputSet-${i}" class="questionSet serveyqn-input" name="questionSet[${i}].questionContent" type="text" placeholder="문항을 입력해주세요.">
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
					<div class="buttons">
						<button type="button" class="button-item close-btn" onclick="">입력완료</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="course_intro">
			<img src="<c:url value='/resources/images/subject/subject_intro.png'/>"/>
			<p class="txt"> <textarea name="content" cols="60" rows="10"></textarea></p>
		</div>
		<div class="submit-btn">
			<input type="hidden" name="state" id="state" value="모집중">
			<input type="submit" class="btn-submit-open-popup" value="저장">
		</div>
		</form>		
	</div>
</div>

	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	<script type="text/javascript">
	/*파일 누르면 이름 들어가게*/
	$(function(){
		$("#file").on('change',function(){
			console.log("change");
			  var fileName = $("#file").val();
			  $(".insert_FileUpload").val(fileName);
		});
	});
	
	/*첨부파일 이미지 미리보기*/
	function previewImg(input) {
		if(input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e) {
				document.querySelector('.detail_img').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		}else {
			document.querySelector('.detail_img').src = "";
		}
	}
	
	function courseChange(e){
		var course1 = ["AI가 대신 만들어주는 앱", "자바 기초"];
		var course2 = ["한번에 끝내는 HTML","두번만에 끝내는 CSS", "세번해도 안끝나는 JS"];
		var target = document.querySelector(".select_smallCourse");
		
		if(e.value == "a") var d = course1;
		else if(e.value == "b") var d = course2;
		
		target.options.length = 0;
		
		for(x in d) {
			var opt = document.createElement("option");
			console.log(d[x]);
			opt.value = d[x];
			opt.innerHTML = d[x];
			target.appendChild(opt);
		}
	}
	
	/*시수에 맞춰 endDay 설정해주기 (아직 날짜가 다름;;)*/
	function changeDay(){
		const startDay = document.getElementById("startDay").value;

		const startTime = document.getElementById("startTime").value;
		const endTime = document.getElementById("endTime").value;
		let hours = document.getElementById("hours").value;

		let startHour = parseInt(startTime.substring(0,2));
		let startMin = parseInt(startTime.substring(3))
		let endHour = parseInt(endTime.substring(0,2));
		let endMin = parseInt(endTime.substring(3));

		let diffHour = endHour - startHour;
		let diffMin
		if(endMin < startMin){
			diffMin = (endMin - startMin) + 60;
			diffHour = diffHour - 1;
		}else{
			diffMin = endMin - startMin;
		}
		diffMin = (diffMin/60).toFixed(2); // 소수점으로 변환

		let diffTime = diffHour+diffMin; // 시작시간과 끝시간 계산

		console.log(diffHour);
		console.log(diffMin);
		console.log(diffTime);

		hours = (hours / diffTime).toFixed();
		console.log(hours);

		let startDay2 = new Date(startDay);
		startDay2.setDate(startDay2.getDate() + hours);

		let endDay = document.getElementById("endDay");
		endDay.value = startDay2.toJSON().substring(0,10);
	}
	

	/*오늘날짜와 기간들 비교해서 상태 입력*/
	function inputState(){
		const date = new Date();
		const today = date.toJSON().substring(0,10).replaceAll('-','');

		const recruitStartDay = document.getElementById('recruitStartDay').value;
		const recruitEndDay = document.getElementById('recruitEndDay').value;

		console.log(today);
		console.log(recruitStartDay);
		console.log(recruitEndDay);

		let parseStartDay = recruitStartDay.replaceAll('-','');
		let parseEndDay = recruitEndDay.replaceAll('-','');

		let state = document.getElementById('state');
		if(today < parseStartDay) { //현재날짜가 모집시작일 보다 작으면
			state.value = 'OPN01'; //모집예정
		}else if(parseStartDay <= today && today <= parseEndDay){
			state.value = 'OPN02'; //모집중
		}else{
			state.value = 'OPN01'; //경우의 수 더 없을가?
		}
		console.log(state);
		console.log(state.value);
	}
	

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
			document.querySelector(hiddenQuestionInputSet).setAttribute("value", $(questionInputSet).val()); // Modal의 항목명에서 받은 value를 hidden div의 항목명에 넣기
		};
    }
	</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
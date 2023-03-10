<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/register/insert.css'/>"/>
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>"/>

<div class="card">
	<div class="card-header"> 
		<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
		<div> > 수강 관리 > <span class="submenu-title">수강 추가</span></div>
	</div>

	<div class="card-body">
		<div class="wrap">
			<div class="search-box">
				<div class="search-content">
					<span class="name">수강생</span>
					<form id="form" name="search-form" class="search">
						<input id="studentTitle-input" class="title-input" readonly placeholder="검색 버튼을 눌러 수강생을 검색하세요.">
						<input id="student-input" name="student" type="hidden">
						<input id="studentId-input" name="studentId" type="hidden">
						<input type="button" class="student-popup-btn btn btn-secondary" value="검색">
					</form>
				</div>
			</div>
			<!-- 수강생이 들었던/듣고 있는 개설 강좌 넘어온 값 -->
			<div>
				<input type="hidden" id="subjectId-string">
				<input type="hidden" id="subjectSeq-string">
				<input type="hidden" id="courseId-string">
				<input type="hidden" id="courseOpenYear-string">
			</div>
			<div id="student-list" class="insert-list"></div>
			
		</div>
	
		<div class="wrap">
			<div class="search-box">
				<div class="search-content">
					<select name="subCor" class="sc2" onchange="changeSubCor(this.value);">
						<option selected value="subject">강좌</option>
						<option value="course">과정</option>
					</select>
					<div class="search-popup" id="search-popup-subject">
						<input id="subjectTitle-input" class="title-input" readonly placeholder="검색 버튼을 눌러 강좌/과정을 검색하세요.">
						<input id="subject-input" name="subject" type="hidden">
						<!-- <input id="state-input" name="state" type="hidden"> -->
						<button id="subject-btn" class="open-subject-popup-btn btn btn-secondary" disabled>검색</button>
					</div>
					<div class="search-popup" id="search-popup-course" style="display:none;">
						<input id="courseTitle-input" class="title-input" readonly placeholder="검색 버튼을 눌러 강좌/과정을 검색하세요.">
						<input id="course-input" name="subject" type="hidden">
						<input id="courseYear-input" name="openYear" type="hidden">
						<!-- <input id="state-input" name="state" type="hidden"> -->
						<button id="course-btn" class="open-course-popup-btn btn btn-secondary" disabled>검색</button>
					</div>
					
				</div>
			</div>
			<div id="subject-list" class="insert-list"></div>
		</div>
		<div class="submit-btn">
				<input type="reset" onclick="history.back();" value="◀ 이전">
				<input type="submit" onclick="addEnroll()" value="저장">
				<!-- <input type="reset" onclick="location.href='<c:url value="/enroll/searchlist"/>'" value="취 소" class="btn"> -->

		</div>
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/opensearchpop.js"></script>
</div>
<script>

	var studentId;
	var subjectId;
	var subjectSeq;
	var courseId;
	
	/* 강좌/과정 선택에 따른 검색창 보여주기 */
	function changeSubCor(value) {
		const searchPopupSubject = document.getElementById('search-popup-subject');
		const searchPopupCourse = document.getElementById('search-popup-course');
		const subjectTitleInput = document.getElementById('subjectTitle-input');
		const courseTitleInput = document.getElementById('courseTitle-input');
		
		if(value==='subject') {
			searchPopupSubject.removeAttribute("style");
			searchPopupCourse.setAttribute("style", "display:none;");
			subjectTitleInput.value = null;
			courseTitleInput.value = null;
		}else if(value==='course') {
			searchPopupCourse.removeAttribute("style");
			searchPopupSubject.setAttribute("style", "display:none;");
			subjectTitleInput.value = null;
			courseTitleInput.value = null;
		}
	}

	/*검색 팝업에 맞춰 수강 추가 처리하기*/
	function addEnroll(){
		let studentInput = $("#student-input").val();
		let studentArr = studentInput.split('/');
		let studentId = studentArr[0];

		// 강좌/과정 선택 값 확인
		let selected = $("select[name=subCor]").val();

		if ((selected === 'subject') || !selected) { //강좌인 경우 (기본, selected = subject)
			let subjectInput = $("#subject-input").val();
			let subjectArr = subjectInput.split('/');
			let subjectId = subjectArr[0];
			let subjectSeq = subjectArr[1];

			$.ajax({
				type : 'POST',
				url : 'addenroll/' + studentId + '/' + subjectId + '/' + subjectSeq,
				success : function(result){
					location.replace('searchlist');
				}
			})
		} else if(selected === "course") { //과정인 경우

			let courseInput = $("#course-input").val();
			let courseArr = courseInput.split('/');
			let courseId = courseArr[0];
			let courseOpenYear = courseArr[3];
	
			$.ajax({
				type : 'POST',
				url : 'addcourse/' + studentId + '/' + courseId + '/' + courseOpenYear,
				success : function(result){
					location.replace('searchlist');
				}
			})
		}
	}
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
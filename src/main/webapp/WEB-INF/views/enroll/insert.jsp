<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/register/insert.css'/>"/>

<div class="card m-2">
	<div class="card-header"> 
		<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
		<div> > 수강 관리 > <span class="submenu-title">수강 추가</span></div>
	</div>

	<div class="card-body">
		<div class="wrap">
			<div class="search-box">
				<div class="search-content">
					<span class="name">수강생</span> &nbsp; &nbsp;
					
					<form id="form" name="search-form" class="search">
						<input id="studentTitle-input" class="title-input" readonly placeholder="검색 버튼을 눌러 수강생을 검색하세요.">
						<input id="student-input" name="student" type="hidden">
						<input id="studentId-input" name="studentId" type="hidden">
						<input type="button" class="student-popup-btn btn btn2" value="검색">
					</form>
				</div>
			</div>
			<div class="student-result"></div>
		</div>
	
		<div class="wrap">
			<div class="search-box">
				<div class="search2">
					<span class="name2">강좌 / 과정</span> &nbsp; &nbsp;
					<select name="subCor" class="sc2" onchange="changeSubCor(this.value);">
						<option selected value="">강좌/과정</option>
						<option value="subject">강좌</option>
						<option value="course">과정</option>
					</select>
					<div class="search-popup" id="search-popup-subject">
						<input id="subjectTitle-input" readonly placeholder="검색 버튼을 눌러 강좌를 검색하세요.">
						<input id="subject-input" name="subject" type="hidden">
						<!-- <input id="state-input" name="state" type="hidden"> -->
						<button class="open-subject-popup-btn btn3 btn-outline-secondary">검색</button>
					</div>
					<div class="search-popup" id="search-popup-course" style="display:none;">
						<input id="courseTitle-input" readonly placeholder="검색 버튼을 눌러 과정을 검색하세요.">
						<input id="course-input" name="subject" type="hidden">
						<input id="courseYear-input" name="openYear" type="hidden">
						<!-- <input id="state-input" name="state" type="hidden"> -->
						<button class="open-course-popup-btn btn3 btn-outline-secondary">검색</button>
					</div>
					<div class="submit-btn">
						<form action="<c:url value='/enroll/boardlist'/>">
							<input type="submit" onclick="addEnroll2()" value="저 장" class="btn">
							<input type="reset" onclick="location.href='<c:url value="/enroll/boardlist"/>'" value="취 소" class="btn">
						</form>
					</div>
				</div>
			</div>
				<!-- <div class="search-content">
				<span class="name">강좌 / 과정</span> &nbsp; &nbsp;
				<form id="form" name="search-subject-course" class="search2">
					<select name="openState" class="sc2">
						<option selected value="">개설상태</option>
						<option value="recruitExpecting">모집예정</option>
						<option value="recruitOngoing">모집중</option>
						<option value="recruitEnd">모집마감</option>
						<option value="ongoing">진행중</option>
						<option value="completion">진행완료</option>
					</select>
					<select name="subCor" class="sc2">
						<option selected value="">강좌/과정</option>
						<option value="subject">강좌</option>
						<option value="course">과정</option>
					</select>
					<input type="text" name="kw" class="search-in">
					<input type="button" onclick="getOpenList()" class="btn btn2" value="검색">
				</form>
				</div> -->
			

			<div class="subject-result"></div>
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
		if(value==='subject') {
			searchPopupSubject.removeAttribute("style");
			searchPopupCourse.setAttribute("style", "display:none;");
		} else if (value==='course') {
			searchPopupCourse.removeAttribute("style");
			searchPopupSubject.setAttribute("style", "display:none;");
		} else {

		}
	}

	// student 정보 가져오기
	function getStudentList() {
		$.ajax({
			type : 'GET',
			url : 'studentlist',
			data : $("form[name=search-form]").serialize(),
			async : false,
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
			success : function(result){
				// add Enroll에서 쓰기 위해 포맷 맞춰줌
				studentId = JSON.stringify(result[0].studentId);
				studentId = studentId.replace(/\"/gi, "");
				
				$(".student-result").empty();
				if(result.length > 0) {
					var ul = $("<ul/>");
					for(var i in result) {
						var $studentId = result[i].studentId;
						var $name = result[i].name;
						var $genderTitle = result[i].genderTitle;
						var $birth = result[i].birth;
						var $email = result[i].email;
						var $phone = result[i].phone;
						var $addDoTitle = result[i].addDoTitle;
						var $addEtc = result[i].addEtc;
						var $positionTitle = result[i].positionTitle;
						
						var li = $("<ul class='stu'/>").append(
								$("<li/>").text(' ' + '이름 : ' + $name),
								$("<li/>").text(' ' + '성별 : ' + $genderTitle),
								$("<li/>").text(' ' + '생년월일 : ' + $birth),
								$("<li/>").text(' ' + '이메일 : ' + $email),
								$("<li/>").text(' ' + '전화번호 : ' + $phone),
								$("<li/>").text(' ' + '주소 : ' + $addDoTitle + ' ' + $addEtc),
								$("<li/>").text(' ' + '직위 : ' + $positionTitle)
						);
						ul.append(li);
					}
					$(".student-result").append(ul);
				}
				
			}
		})
	}

	// // subject/course 정보 가져오기
	// function getOpenList() {
	// 	$.ajax({
	// 		type : 'GET',
	// 		url : 'openlist', 
	// 		dataType : 'json',
	// 		data : $("form[name=search-subject-course]").serialize(),
	// 		async : false,
	// 		contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	// 		success : function(result){
				
	// 			$(".subject-result").empty();
				
	// 			// 강좌/과정 선택 값 확인
	// 			var selected = $("select[name=subCor]").val();

	// 			// 강좌를 선택했을 때
	// 			if(selected==='subject') {
	// 				// 테이블 태그 만들기
	// 				var td = $("<table border = '1' class='tb'/>");
	// 				// 컬럼명 만들기
	// 				var rowTitle = $("<tr/>").append(
	// 						$("<td/>").text("선택"),
	// 						$("<td/>").text("강좌 명 (아이디)"),
	// 						$("<td/>").text("강좌 기간"),
	// 						$("<td/>").text("모집 기간"),
	// 						$("<td/>").text("모집 인원")
	// 						)
	// 					td.append(rowTitle);
	// 				// result에 담긴만큼 객체 만들어서 추가하기
	// 				for(var i in result) {
	// 					var $check = `<input class="check-subject" name="check-subject" type="checkbox" value="` + result[i].subjectId + `/` + result[i].subjectSeq + `" onclick='checkOnlyOne(this); saveCheckSubject(this.value);'>`;
	// 					var $subjectId = result[i].subjectId;
	// 					var $subjectTitle = result[i].subjectTitle;
	// 					var $startDay = result[i].startDay;
	// 					var $endDay = result[i].endDay;
	// 					var $recruitStartDay = result[i].recruitStartDay;
	// 					var $recruitEndDay = result[i].recruitEndDay;
	// 					var $recruitPeople = result[i].recruitPeople;
													
	// 					var row = $("<tr/>").append(
	// 							$("<td/>").append($check),
	// 							$("<td/>").text($subjectTitle + ' (' + $subjectId + ')'),
	// 							$("<td/>").text($startDay + ' ~ ' + $endDay),
	// 							$("<td/>").text($recruitStartDay + ' ~ ' + $recruitEndDay),
	// 							$("<td/>").text($recruitPeople)
	// 						);
	// 					td.append(row);
	// 					$(".subject-result").append(td);
	// 				};

	// 			// 과정을 선택했을 때
	// 			} else if(selected==='course'){
	// 				// 테이블 태그 만들기
	// 				var td = $("<table border = '1' class='tb'/>");
	// 				// 컬럼명 만들기
	// 				var rowTitle = $("<tr/>").append(
	// 						$("<td/>").text("선택"),
	// 						$("<td/>").text("과정명 (아이디)"),
	// 						$("<td/>").text("과정 기간"),
	// 						$("<td/>").text("모집 기간"),
	// 						$("<td/>").text("모집 인원")
	// 						)
	// 					td.append(rowTitle);
	// 				// result에 담긴만큼 객체 만들어서 추가하기
	// 				for(var i in result) {
	// 					var $check = `<input class="check-subject" name="check-subject" type="checkbox" value="` + result[i].courseId + `" onclick='checkOnlyOne(this); saveCheckCourse(this.value);'>`;
	// 					var $courseId = result[i].courseId;
	// 					var $courseTitle = result[i].courseTitle;
	// 					var $startDay = result[i].startDay;
	// 					var $endDay = result[i].endDay;
	// 					var $recruitStartDay = result[i].recruitStartDay;
	// 					var $recruitEndDay = result[i].recruitEndDay;
	// 					var $recruitPeople = result[i].recruitPeople;
													
	// 					var row = $("<tr/>").append(
	// 							$("<td/>").append($check),
	// 							$("<td/>").text($courseTitle + ' (' + $courseId + ')'),
	// 							$("<td/>").text($startDay + ' ~ ' + $endDay),
	// 							$("<td/>").text($recruitStartDay + ' ~ ' + $recruitEndDay),
	// 							$("<td/>").text($recruitPeople)
	// 						);
	// 					td.append(row);
	// 					$(".subject-result").append(td);
	// 				};
	// 			}
	// 		}
	// 	}) // ajax 끝
	// }
	
	// // 하나만 선택하기
	// function checkOnlyOne(target) {
	// 	document.querySelectorAll(`input[type=checkbox]`).forEach(el => el.checked = false);
	// 	target.checked = true;
	// }

	// // 체크된 강좌 저장
	// function saveCheckSubject(value) {
	// 	let checkSubjectArr = value.split('/');
	// 	let checkSubjectId = checkSubjectArr[0];
	// 	let checkSubjectSeq = checkSubjectArr[1];
	// 	subjectId = checkSubjectId;
	// 	subjectSeq = checkSubjectSeq;
	// }
	
	// // 체크된 과정 저장
	// function saveCheckCourse(value) {
	// 	courseId = value;
	// }

	/*검색 팝업에 맞춰 수강 추가 처리하기*/
	function addEnroll2(){
		alert(studentId);

		// 강좌/과정 선택 값 확인
		let selected = $("select[name=subCor]").val();

		if(selected === "subject"){ //강좌인 경우
			alert(selected);
			let subjectInput = $("#subject-input").val();
			let subjectArr = subjectInput.split('/');
			let subjectId = subjectArr[0];
			let subjectSeq = subjectArr[1];
			console.log(subjectInput);
			console.log(subjectId);
			console.log(subjectSeq);
	
			$.ajax({
				type : 'POST',
				url : 'addenroll/' + studentId + '/' + subjectId + '/' + subjectSeq,
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success : function(result){
					alert("subject success");
				},
				error : function(result) {
					alert(result);
				}
			})
		}else if(selected === "course") { //과정인 경우
			alert(selected);

			let courseInput = $("#course-input").val();
			let courseArr = courseInput.split('/');
			let courseId = courseArr[0];
			let courseOpenYear = courseArr[3];
			console.log(courseInput);
			console.log(courseId);
			console.log(courseOpenYear);
	
			$.ajax({
				type : 'POST',
				url : 'addcourse/' + studentId + '/' + courseId + '/' + courseOpenYear,
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success : function(result){
					alert("course success");
				},
				error : function(result) {
					alert(result);
				}
			})
		}

	}

	// 수강 추가 처리하기
	// function addEnroll(){
	// 	// 강좌일 경우
	// 	if(studentId && subjectId && subjectSeq) {
	// 		console.log(studentId, subjectId, subjectSeq);
	// 		$.ajax({
	// 			type : 'POST',
	// 			url : 'addenroll/' + studentId + '/' + subjectId + '/' + subjectSeq,
	// 			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
	// 			success : function(result){
	// 			}
	// 		})
	// 	}
	// 	// 과정일 경우
	// 	else if(studentId && courseId){
	// 		console.log(studentId, courseId);
	// 		$.ajax({
	// 			type : 'POST',
	// 			url : 'addcourse/' + studentId + '/' + courseId,
	// 			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
	// 			success : function(result){
	// 				console.log("course is in process")
	// 			}
	// 		})
	// 	}
	// }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
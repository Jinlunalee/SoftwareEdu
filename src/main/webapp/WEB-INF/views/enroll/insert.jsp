<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/register/insert.css'/>" />
<div class="card m-2">
	<div class="card-header"> 
		<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
		<div> > 수강 관리 > <span class="submenu-title">수강 추가</span></div>
	</div>

	<div class="card-body">
		<div class="wrap">
			<div class="search-box">
				<div class="search-content">
					<span class="name">수강생 명</span> &nbsp; &nbsp;
					
					<form id="form" name="search-form" class="search">
						<select name="type" class="sc">
							<option selected value="">수강생 명 / 아이디</option>
							<option value="name">수강생 명</option>
							<option value="studentId">아이디 </option>
						</select>
						<input type="text" name="keyword" class="search-in">
						<input type="button" onclick="getStudentList()" class="btn btn2" value="검색">
					</form>
				</div>
			</div>
			
			<div class="student-result"></div>
		</div>
	
		<div class="wrap">
			<div class="search-box">
				<div class="search-content">
				<span class="name">강좌 / 과정</span> &nbsp; &nbsp;
				<form id="form" name="search-subject-course" class="search2">
					<select name="subcor" class="sc2">
						<option selected value="">강좌 / 과정</option>
						<option value="subject">강좌</option>
						<option value="course">과정</option>
					</select>
					<input type="text" name="kw" class="search-in">
					<input type="button" onclick="getOpenList()" class="btn btn2" value="검색">
				</form>
				</div>
			</div>

			<div class="subject-result"></div>
		</div>
	
		<div class="submit-btn">
			<form>
				<input type="submit" onclick="addEnroll()" value="저 장" class="btn">
				<input type="reset" onclick="location.href='<c:url value="/enroll/list"/>'" value="취 소" class="btn">
			</form>
		</div>
	</div>
</div>

<script>
	var studentId;
	var subjectId;
	var subjectSeq;
	var courseId;
		
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
						var $birth = result[i].birth;
						var $email = result[i].email;
						var $phone = result[i].phone;
						
						var li = $("<ul class='stu'/>").append(
								$("<li/>").text(' ' + '이름 : ' + $name),
								$("<li/>").text(' ' + '생년월일 : ' + $birth),
								$("<li/>").text(' ' + '이메일 : ' + $email),
								$("<li/>").text(' ' + '전화번호 : ' + $phone)
						);
						ul.append(li);
					}
					$(".student-result").append(ul);
				}
				
			}
		})
	}

	// subject/course 정보 가져오기
	function getOpenList() {
		$.ajax({
			type : 'GET',
			url : 'openlist', 
			dataType : 'json',
			data : $("form[name=search-subject-course]").serialize(),
			async : false,
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
			success : function(result){
				
				$(".subject-result").empty();
				
				// 강좌/과정 선택 값 확인
				var selected = $("select[name=subcor]").val();

				// 강좌를 선택했을 때
				if(selected==='subject') {
					// 테이블 태그 만들기
					var td = $("<table class='tb'/>");
					// 컬럼명 만들기
					var rowTitle = $("<tr/>").append(
							$("<td/>").text("선택"),
							$("<td/>").text("강좌 아이디"),
							$("<td/>").text("강좌 시퀀스 "),
							$("<td/>").text("강좌 제목"),
							$("<td/>").text("시작 일자"),
							$("<td/>").text("종료 일자"),
							$("<td/>").text("모집 시작일"),
							$("<td/>").text("모집 마감일"),
							$("<td/>").text("모집 인원")
							)
						td.append(rowTitle);
					// result에 담긴만큼 객체 만들어서 추가하기
					for(var i in result) {
						var $check = `<input class="check-subject" name="check-subject" type="checkbox" value="` + result[i].subjectId + `/` + result[i].subjectSeq + `" onclick='checkOnlyOne(this); saveCheckSubject(this.value);'>`;
						var $subjectId = result[i].subjectId;
						var $subjectSeq = result[i].subjectSeq;
						var $subjectTitle = result[i].subjectTitle;
						var $startDay = result[i].startDay;
						var $endDay = result[i].endDay;
						var $recruitStartDay = result[i].recruitStartDay;
						var $recruitEndDay = result[i].recruitEndDay;
						var $recruitPeople = result[i].recruitPeople;
													
						var row = $("<tr/>").append(
								$("<td/>").append($check),
								$("<td/>").text($subjectId),
								$("<td/>").text($subjectSeq),
								$("<td/>").text($subjectTitle),
								$("<td/>").text($startDay),
								$("<td/>").text($endDay),
								$("<td/>").text($recruitStartDay),
								$("<td/>").text($recruitEndDay),
								$("<td/>").text($recruitPeople)
							);
						td.append(row);
						$(".subject-result").append(td);
					};

				// 과정을 선택했을 때
				} else if(selected==='course'){
					// 테이블 태그 만들기
					var td = $("<table class='tb'/>");
					// 컬럼명 만들기
					var rowTitle = $("<tr/>").append(
							$("<td/>").text("선택"),
							$("<td/>").text("과정 아이디"),
							$("<td/>").text("과정 제목"),
							$("<td/>").text("시작 일자"),
							$("<td/>").text("종료 일자"),
							$("<td/>").text("모집 시작일"),
							$("<td/>").text("모집 마감일"),
							$("<td/>").text("모집 인원")
							)
						td.append(rowTitle);
					// result에 담긴만큼 객체 만들어서 추가하기
					for(var i in result) {
						var $check = `<input class="check-subject" name="check-subject" type="checkbox" value="` + result[i].courseId + `" onclick='checkOnlyOne(this); saveCheckCourse(this.value);'>`;
						var $courseId = result[i].courseId;
						var $courseTitle = result[i].courseTitle;
						var $startDay = result[i].startDay;
						var $endDay = result[i].endDay;
						var $recruitStartDay = result[i].recruitStartDay;
						var $recruitEndDay = result[i].recruitEndDay;
						var $recruitPeople = result[i].recruitPeople;
													
						var row = $("<tr/>").append(
								$("<td/>").append($check),
								$("<td/>").text($courseId),
								$("<td/>").text($courseTitle),
								$("<td/>").text($startDay),
								$("<td/>").text($endDay),
								$("<td/>").text($recruitStartDay),
								$("<td/>").text($recruitEndDay),
								$("<td/>").text($recruitPeople)
							);
						td.append(row);
						$(".subject-result").append(td);
					};
				}
			}
		}) // ajax 끝
	}
	
	// 하나만 선택하기
	function checkOnlyOne(target) {
		document.querySelectorAll(`input[type=checkbox]`).forEach(el => el.checked = false);
		target.checked = true;
	}

	// 체크된 강좌 저장
	function saveCheckSubject(value) {
		let checkSubjectArr = value.split('/');
		let checkSubjectId = checkSubjectArr[0];
		let checkSubjectSeq = checkSubjectArr[1];
		subjectId = checkSubjectId;
		subjectSeq = checkSubjectSeq;
	}
	
	// 체크된 과정 저장
	function saveCheckCourse(value) {
		courseId = value;
	}

	// 수강 추가 처리하기
	function addEnroll(){
		
		// 강좌일 경우
		if(studentId && subjectId && subjectSeq) {
			console.log(studentId, subjectId, subjectSeq);
			$.ajax({
				type : 'POST',
				url : 'addenroll/' + studentId + '/' + subjectId + '/' + subjectSeq,
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success : function(result){
				}
			})
		}
		// 과정일 경우
		else if(studentId && courseId){
			console.log(studentId, courseId);
			$.ajax({
				type : 'POST',
				url : 'addcourse/' + studentId + '/' + courseId,
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success : function(result){
					console.log("course is in process")
				}
			})
		}
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
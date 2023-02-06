<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<link rel="stylesheet" href="<c:url value='/resources/css/register/details.css'/>"/>

<div class="card m-2">
	<div class="card-header"> 
		<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
		<div> > 수강 관리 > <span class="submenu-title">수강 목록 조회 > 수강 상세 페이지</span></div>
	</div>
	
	<div class="card-body">
		<table class="enroll-detail-table student-table all-table">
			<tr>
				<th class="info open-info" colspan='8'>수강 정보</th>
			</tr>
			
			<tr>
				<th>수강 아이디</th>
				<td>${enroll.enrollId}</td>
				<th>수강 등록일</th>
				<td>${enroll.enrollDt}</td>
				<th>수강 상태</th>
				<td id="stateCdTitle">${enroll.stateCdTitle}</td>
				<th>취소 상세 사유</th>
				<td>${enroll.cancelRsEtc}</td>
			</tr>
			
			<tr>
				<th>강좌 명 (아이디)</th>
				<td>${enroll.subjectTitle} (${enroll.subjectId})</td>
				<th>강좌 기간</th>
				<td>${enroll.startDay} ~ ${enroll.endDay}</td>
				<th>일수</th>
				<td>${enroll.days}</td>
				<th>시수</th>
				<td id="subject-hours">${enroll.hours}</td>
			</tr>
			
			<tr>
				
				<th>강좌 상태</th>
				<td>${enroll.openStateCdTitle}</td>
				<th>강좌 분류</th>
				<td>${enroll.catSubjectCdTitle}</td>
				<th>강좌 난이도</th>
				<td>${enroll.levelCdTitle}</td>
				<th>과정 명 (아이디)</th>
				<td>${enroll.courseTitle} (${enroll.courseId})</td>
			</tr>
			
			<tr>
				
			</tr>
			
			<tr>
				
				
			</tr>
		</table>

		<table class="enroll-detail-table student-table all-table">
			<tr>
				<th class="info student-info" colspan='8'>수강생 정보</th>
			</tr>
			
			<tr>
				<th>수강 관리 아이디</th>
				<td>${enroll.studentId}</td>
				<th>이름 (아이디)</th>
				<td>${enroll.name} (${enroll.userId})</td>
				<th>생년월일</th>
				<td>${enroll.birth}</td>
				<th>성별</th>
				<td>${enroll.genderCdTitle}</td>
			</tr>
			
			<tr>
				<th>직위</th>
				<td>${enroll.positionCdTitle}</td>
				<th>연락처</th>
				<td>${enroll.phone}</td>
				<th>주소</th>
				<td colspan='3' style="text-align: left"> ${enroll.addDoCdTitle} ${enroll.addEtc}</td>
			</tr>
		</table>

		

		<table class="enroll-detail-table add-hours-table all-table">
			<tr class="hours-ratio">
				<th style="width:20%; background-color: #9BC3FF;">현재 수강 완료 시간</th>
				<th style="width:20%; background-color: #9BC3FF;">진도율</th>
				<th style="width:60%; background-color: #9BC3FF;">추가 수강 시간</th>
			</tr>
			
			<tr>
				<td id="enroll-complete-hours">${enroll.completeHours}</td>
				<td><span id="ratio">${enroll.ratio}</span>%</td>
				<td>
					<form onsubmit="submitFunction(event)" class="add-hours-form" action="<c:url value='/enroll/addhours'/>" method="post"/>
						<input name="enrollId" value="${enroll.enrollId}" type="hidden">
						<input id="add-hours-input" class="add-hours-input" name="addHours" type="number" placeholder="추가할 시간을 입력하세요.">
						<input id="add-hours-submit" class="add-hours-submit btn btn-outline-secondary" type="submit" value="추가">
					</form>
				</td>
			</tr>

		</table>
		<input type="reset" onclick="back()" value="이 전" class="btn">
	</div>
	
</div>

<script>
	window.onload = function () {
		const ratio = document.getElementById('ratio').innerText;
		const stateCd = document.getElementById('stateCdTitle').innerText;
		console.log(stateCdTitle);
		console.log(typeof stateCdTitle);
		console.log(ratio);
		console.log(typeof ratio);
		const addHoursInput = document.getElementById('add-hours-input');
		const addHoursSubmit = document.getElementById('add-hours-submit');
		if(ratio>=100) {
			addHoursInput.setAttribute("readonly", true);
			addHoursInput.setAttribute("placeholder", "진도율이 100%인 강좌는 수강시간을 추가할 수 없습니다.");
			addHoursSubmit.setAttribute("type","button");
		} else if(stateCd === '수강신청' || stateCd === '수강예정' || stateCd === '수강취소' || stateCd === '수강완료') {
			addHoursInput.setAttribute("readonly", true);
			addHoursInput.setAttribute("placeholder", "수강 중이 아닐 때는 시간을 입력할 수 없습니다.");
			addHoursSubmit.setAttribute("type", "button");
		} 
	}

	function submitFunction(event) {
		const addHoursInput = document.getElementById('add-hours-input');
		let addHoursInputValue = addHoursInput.value;
		addHoursInputValue = Number(addHoursInputValue);
		let subjectHours = document.getElementById('subject-hours').innerText;
		subjectHours = Number(subjectHours);
		let enrollCompleteHours = document.getElementById('enroll-complete-hours').innerText;
		enrollCompleteHours = Number(enrollCompleteHours);

		// 수강시수 초과 입력 방지
		if(addHoursInputValue+enrollCompleteHours>subjectHours){
			alert('수강시수를 초과하여 입력할 수 없습니다.');
			event.preventDefault();
		} else {
			return true;
		}
	}
	
	function back() {
		history.back();
	}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<link rel="stylesheet" href="<c:url value='/resources/css/register/details.css'/>"/>
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>"/>

<div class="card">
	<div class="card-header"> 
		<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
		<div> > 수강 관리 > <span class="submenu-title">수강 목록 조회 > 수강 상세 페이지</span></div>
	</div>
	
	<div class="card-body">
		<table class="enroll-detail-table student-table all-table">
			<colgroup>
				<col width="10%">
				<col width="20%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="20%">
				<col width="10%">
				<col width="20%">
			</colgroup>
			<tr>
				<th class="info open-info" colspan='8'>수강 정보</th>
			</tr>
			
			<tr>
				<th id="title">수강 아이디</th>
				<td class="content2">${enroll.enrollId}</td>
				<th id="title">수강 등록일</th>
				<td class="content0">${enroll.enrollDt}</td>
				<th id="title">수강 상태</th>
				<td class="content1">${enroll.stateCdTitle}
					<input id="getStateCdTitle" type="hidden" value="${enroll.stateCdTitle}">
					<c:if test="${!empty enroll.cancelRsTitle}">
						(${enroll.cancelRsTitle})
					</c:if>
				</td>
				<th id="title">취소 상세 사유</th>
				<td class="content3">${enroll.cancelRsEtc}</td>
			</tr>
			
			<tr>
				<th>강좌 명 (아이디)</th>
				<td>${enroll.subjectTitle} (${enroll.subjectId})</td>
				<th>강좌 회차</th>
				<td>${enroll.subjectSeq}</td>
				<th>과정 명 (아이디)</th>
				<c:if test="${empty enroll.courseId}">
					<td>${enroll.courseTitle}</td>
				</c:if>
				<c:if test="${!empty enroll.courseId}">
					<td>${enroll.courseTitle} (${enroll.courseId})</td>
				</c:if>
				<th>과정 개설연도</th>
				<td>${enroll.courseOpenYear}</td>
			</tr>
			
			<tr>
				<th id="subject-hours">강좌 기간 (시수)</th>
				<td>${enroll.startDay} ~ ${enroll.endDay} (${enroll.hours})</td>
				<th>강좌 상태</th>
				<td>${enroll.openStateCdTitle}</td>
				<th>강좌 난이도</th>
				<td>${enroll.levelCdTitle}</td>
				<th>강좌 분류</th>
				<td>${enroll.catSubjectCdTitle}</td>
				
			</tr>

		</table>

		<table class="enroll-detail-table student-table all-table" style="margin-top: 50px">
			<tr>
				<th class="info student-info" colspan='8'>수강생 정보</th>
			</tr>
			
			<tr>
				<th id="title">수강 관리 아이디</th>
				<td class="content4">${enroll.studentId}</td>
				<th id="title">이름 (아이디)</th>
				<td class="content4">${enroll.name} (${enroll.userId})</td>
				<th id="title">생년월일</th>
				<td class="content5">${enroll.birth}</td>
				<th id="title">성별</th>
				<td class="content6">${enroll.genderCdTitle}</td>
			</tr>
			
			<tr>
				<th>직위</th>
				<td>${enroll.positionCdTitle}</td>
				<th>연락처</th>
				<td>${enroll.phone}</td>
				<th>주소</th>
				<td colspan='3' style="text-align: left"> ${enroll.addDoCdTitle} ${enroll.addEtc}</td>
			</tr>
			<tr>
				<th>현재 수강 완료 시간</th>
				<td id="enroll-complete-hours">${enroll.completeHours}</td>
				<th>진도율</th>
				<td><span id="ratio">${enroll.ratio}</span>%</td>
				<th>수강 시간 입력</th>
				<td colspan='3' id="hour-column">
				<div class="hour-column">
					<form onsubmit="submitFunction(event)" class="add-hours-form" action="<c:url value='/enroll/addhours'/>" method="post"/>
						<input name="enrollId" value="${enroll.enrollId}" type="hidden">
						<input type="number" id="add-hours-input" class="add-hours-input" name="addHours" >
						<input type="submit" id="add-hours-submit" class="btn btn-secondary " value="추가">
					</form>
					<div class="hour-info">
						<div class="hour-details"></div>
					</div>
				</div>
				</td>
			</tr>
		</table>
		<div class="submit-btn">
			<input type="reset" onclick="history.back()" class="reset-btn" value="◀ 이 전">
		</div>
	</div>
	
</div>

<script>

	window.onload = function () {
		const ratio = document.getElementById('ratio').innerText;
		const stateCd = document.getElementById('getStateCdTitle').value;
		const addHoursInput = document.getElementById('add-hours-input');
		const addHoursSubmit = document.getElementById('add-hours-submit');
		
		const makeDiv = document.createElement('div');
		
		if(ratio>=100) {
			addHoursInput.style.display = "none";
			addHoursSubmit.style.display = "none";
			makeDiv.setAttribute("class", "no-add-hours");
			makeDiv.innerHTML = '※ 진도율 100% 이상 강좌는 추가할 수 없습니다.';
			$('.hour-details').append(makeDiv);
		} else if(stateCd === '수강신청' || stateCd === '수강예정' || stateCd === '수강취소' || stateCd === '수강완료') {
			addHoursInput.style.display = "none";
			addHoursSubmit.style.display = "none";
			makeDiv.setAttribute("class", "no-add-hours");
			makeDiv.innerHTML = "※ '수강 중' 인 상태만 입력할 수 있습니다.";
			$('.hour-details').append(makeDiv);
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
			alert('수강 시수를 초과하여 입력할 수 없습니다.');
			event.preventDefault();
		} else {
			return true;
		}
	}
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
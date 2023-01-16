<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<link rel="stylesheet" href="<c:url value='/resources/css/register/details.css'/>"/>

<div class="card m-2">
	<div class="card-header"> 
		<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
		<div> > 수강 관리 > <span class="submenu-title">수강 목록 조회 > 수강 상세 페이지</span></div>
	</div>
	<div class="card-body">
		<table class="enroll-detail-table enroll-table">
			<tr>
				<th class="info enroll-info" colspan='8'>수강 정보</th>
			</tr>
			<tr>
				<th>수강 아이디</th>
				<td>${enroll.enrollId}</td>
				<th>수강 상태</th>
				<td>${enroll.stateCd}</td>
				<th>수강 완료 시간</th>
				<td>${enroll.completeHours}</td>
				<th>수강 등록 시간</th>
				<td>${enroll.regDt}</td>
			</tr>
		</table>

		<table class="enroll-detail-table student-table">
			<tr>
				<th class="info student-info" colspan='8'>수강생 정보</th>
			</tr>
			<tr>
				<th>수강생 아이디</th>
				<td>${enroll.studentId}</td>
				<th>수강생 이름</th>
				<td>${enroll.name}</td>
				<th>수강생 구분</th>
				<td>${enroll.positionCd}</td>
				<th>수강생 성별</th>
				<td>${enroll.genderCd}</td>
			</tr>
			<tr>
				<th>수강생 생년월일</th>
				<td>${enroll.birth}</td>
				<th>수강생 연락처</th>
				<td>${enroll.phone}</td>
				<th>수강생 주소</th>
				<td>${enroll.addDoCd}</td>
				<th>수강생 상세주소</th>
				<td>${enroll.addEtc}</td>
			</tr>
		</table>

		<table class="enroll-detail-table student-table">
			<tr>
				<th class="info open-info" colspan='8'>개설 강좌 정보</th>
			</tr>
			<tr>
				<th>강좌 아이디</th>
				<td>${enroll.subjectId}</td>
				<th>강좌명</th>
				<td colspan='3'>${enroll.subjectTitle}</td>
				<th>강좌 상태</th>
				<td>${enroll.openStateCd}</td>
			</tr>
			<tr>
				<th>과정 아이디</th>
				<td>${enroll.courseId}</td>
				<th>과정명</th>
				<td>${enroll.courseTitle}</td>
				<th>강좌 분류</th>
				<td>${enroll.catSubject}</td>
				<th>강좌 난이도</th>
				<td>${enroll.levelCd}</td>
			</tr>
			<tr>
			<tr>
				<th>강좌일수</th>
				<td>${enroll.days}</td>
				<th>강좌시수</th>
				<td>${enroll.hours}</td>
				<th>강좌 기간</th>
				<td colspan='3'>${enroll.startDay} ~ ${enroll.endDay}</td>
			</tr>
			<tr>
				<th>강좌 모집 기간</th>
				<td colspan='5'>${enroll.recruitStartDay} ~ ${enroll.recruitEndDay}</td>
				<th>강좌 모집인원</th>
				<td>${enroll.recruitPeople}</td>
			</tr>
		</table>

		<table class="enroll-detail-table student-table">
			<tr>
				<th>현재 수강 완료 시간</th>
				<th>수강률</th>
				<th>추가 수강 시간</th>
			</tr>
			<tr>
				<td>${enroll.completeHours}</td>
				<td>${enroll.completeHours}/${enroll.hours}*100</td>
				<td>
					<form action="<c:url value='/enroll/addhours'/>" method="post"/>
						<input name="enrollId" value="${enroll.enrollId}" type="hidden">
						<input name="addHours" type="number">
						<input type="submit" value="추가할 시간을 입력하세요.">
					</form>
				</td>
			</tr>

		</table>

	</div>
	<script>

	</script>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
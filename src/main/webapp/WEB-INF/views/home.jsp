<%@ page contentType="text/html; charset=UTF-8" %>	

<%@ include file="/WEB-INF/views/common/header-main.jsp" %>


<style>
.main-first-row { text-align: center;}

</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/main.css"/>

 
<div class="main-first-row"> 

	<div class="main-first-row-btn first-btn"><a href="<c:url value='/subject/subjectboardlist'/>"><img id="first_image" src="<c:url value='/resources/images/main/main_course.jpg'/>" style="display:block;" />강좌</a></div>
	<div class="main-first-row-btn second-btn"><a href="<c:url value='/student/boardlist'/>"><img id="first_image" src="<c:url value='/resources/images/main/main_student.jpg'/>" style="display:block;" />수강생</a></div>
	<div class="main-first-row-btn third-btn"><a href="<c:url value='/enroll/boardlist'/>"><img id="first_image" src="<c:url value='/resources/images/main/main_register.png'/>" style="display:block;" />수강</a></div>
	<div class="main-first-row-btn fourth-btn"><a href="<c:url value='/survey/summary'/>"><img id="first_image_forth" src="<c:url value='/resources/images/main/main_survey.jpg'/>" style="display:block;" />강의 만족도 조사</a></div>
	<div class="main-first-row-btn fifth-btn"><a href="<c:url value='/data/download'/>"><img id="first_image_fifth" src="<c:url value='/resources/images/main/main_download.png'/>" style="display:block;" />연계 자료</a></div>
</div>
 
<div class="main-second-row">
	<div class="main-second-row-btn level">
		<div class="title"><a><img id="course_image" src="<c:url value='/resources/images/main/course.png'/>"/> 개설 강좌 분류별 보기</a></div>
		<div class="level-content">

			<div class="level-content-item"><a href="<c:url value='/subject/subjectboardlist?catSubject=SUB01'/>"><img id="second_image" src="<c:url value='/resources/images/main/main_programming.jpg'/>" style="display:block;"/>프로그래밍</a></div>
			<div class="level-content-item"><a href="<c:url value='/subject/subjectboardlist?catSubject=SUB02'/>"><img id="second_image" src="<c:url value='/resources/images/main/main_bigdata.png'/>" style="display:block;"/>빅데이터</a></div>
			<div class="level-content-item"><a href="<c:url value='/subject/subjectboardlist?catSubject=SUB03'/>"><img id="second_image" src="<c:url value='/resources/images/main/main_ai.jpg'/>" style="display:block;"/>AI</a></div>

		</div>
	</div>
	<div class="main-second-row-btn regular">
		<div class="title"><a><img id="category_image" src="<c:url value='/resources/images/main/category.png'/>"/> 개설 과정 분류별 보기</a></div>
		<div class="regular-content">
			<div class="regular-content-item"><a href="<c:url value='/subject/courseboardlist?catCourse=CRS01'/>">국비 지원 과정</a></div>
			<div class="regular-content-item"><a href="<c:url value='/subject/courseboardlist?catCourse=CRS02'/>">전문가 과정</a></div>
			<div class="regular-content-item"><a href="<c:url value='/subject/courseboardlist?catCourse=CRS03'/>">기초 과정</a></div>
		</div>		
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer-main.jsp" %>


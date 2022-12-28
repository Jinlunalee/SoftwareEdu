<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>


<style>
.main-first-row { text-align: center;}
.main-first-row img {
width: 100px;
height: 100px;
}
 #first_image {
position: relative;
 top: -51px;
 right: 80px; 
 bottom: 300px;
 left: 60px; 
 border-radius: 50%;
 border: 4px solid white;
 } 

 #second_image {
 width: 180px; 
 height: 100px; 
 margin: 10px;

 }
 
 #course_image {
 width: 40px;
 height: 40px;
 }
 #category_image{
 width: 40px;
 height: 40px;
 }
.regular-content-item {
justify-content: center;
}
.level-content-item{
width: 180px; 
height: 299px;

}
 a{
  text-align: center;
  }
  
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/main.css"/>	

<%@ include file="/WEB-INF/views/common/header-main.jsp" %>
 
<div class="main-first-row"> 
	<div class="main-first-row-btn first-btn"><a href="<c:url value='/course/regularlist'/>"><img id="first_image" src="<c:url value='/resources/images/main/main_course.jpg'/>" style="display:block;" />강좌</a></div>
	<div class="main-first-row-btn second-btn"><a href="<c:url value='/student/list'/>"><img id="first_image" src="<c:url value='/resources/images/main/main_student.jpg'/>" style="display:block;" />수강생</a></div>
	<div class="main-first-row-btn third-btn"><a href="<c:url value='/register/list'/>"><img id="first_image" src="<c:url value='/resources/images/main/main_register.png'/>" style="display:block;" />수강</a></div>
	<div class="main-first-row-btn fourth-btn"><a href="<c:url value='/survey/list'/>"><img id="first_image" src="<c:url value='/resources/images/main/main_survey.jpg'/>" style="display:block;" />강의 만족도 조사</a></div>
	<div class="main-first-row-btn fifth-btn"><a href="<c:url value='/data/download'/>"><img id="first_image" src="<c:url value='/resources/images/main/main_download.png'/>" style="display:block;" />연계 자료</a></div>
</div>
 
<div class="main-second-row">
	<div class="main-second-row-btn level">
		<div class="title"><a><img id="course_image" src="<c:url value='/resources/images/main/course.png'/>"/> 개설 강좌 분류별 보기</a></div>
		<div class="level-content">
			<div class="level-content-item"><a><img id="second_image" src="<c:url value='/resources/images/main/main_programming.jpg'/>" style="display:block;"/>프로그래밍</a></div>
			<div class="level-content-item"><a><img id="second_image" src="<c:url value='/resources/images/main/main_bigdata.png'/>" style="display:block;"/>빅데이터</a></div>
			<div class="level-content-item"><a><img id="second_image" src="<c:url value='/resources/images/main/main_ai.jpg'/>" style="display:block;"/>AI</a></div>
		</div>
	</div>
	<div class="main-second-row-btn regular">
		<div class="title"><a><img id="category_image" src="<c:url value='/resources/images/main/category.png'/>"/> 개설 과정 분류별 보기</a></div>
		<div class="regular-content">
			<div class="regular-content-item">국비 지원 과정</div>
			<div class="regular-content-item">전문가 과정</div>
			<div class="regular-content-item">기초 과정</div>
		</div>		
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer-main.jsp" %>


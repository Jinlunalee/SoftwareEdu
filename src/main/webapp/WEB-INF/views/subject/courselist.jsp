<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/register/list.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/course.css'/>" />

<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div><span> > 강좌 관리 > </span> <span class="submenu-title">과정 정보 확인</span></div>
	</div>
	<div class="card-body">
		<!-- 검색 시작 -->
		<div class="search">
		  <select class="select-box">
		  	<option>과정명</option>
		  	<option>과정아이디</option>
		  </select>
          <input class="input-text" type="text" placeholder="과정명 / 과정아이디를 입력해 주세요">
          <input class="input-button" type="button" value="검색">
        </div>
        
                
		<!-- list top -->
		<div class="list_top">
		  <div class="cnt">
			전체목록 <b class="basic_txt_color"> ?? </b>개, 
			페이지<b class="basic_txt_color"> ?? </b> / ??
		  </div>
		  <div class="view">
			<select class="select-view">
				<option>10개</option>
				<option>30개</option>
				<option>50개</option>
			</select>
		  </div>
		</div>
		<!-- // list top -->
		
		<!-- list table -->
		<table class="list">
		  <thead>
            <tr>
                <th>과정아이디</th>
                <th>과정명</th>
                <th>연수기간</th>
                <th>신청기간</th>
                <th>교육비</th>
                <th>상태</th>
                <th></th>
            </tr>
           </thead>
		  <tbody>
		  <c:if test="${courseListSize ne 0}">
		  <c:forEach var="course" items="${courseList}">
            <tr>
              <td>${course.courseId}</td>
              <td>
				<span>
					<a href="<c:url value='/subject/details/1'/>">${course.courseTitle}</a>
		        </span>
              </td>
              <td>${course.startDay}~${course.endDay}</td>
              <td>${course.recruitStartDay}~${course.recruitEndDay}</td>
              <td>${course.cost}</td>
              <td>${course.state}</td>
             </tr>
          </c:forEach>
          </c:if>
		</table>
		<a href="<c:url value='/subject/subjectlist'/>">웹 개발자</a>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
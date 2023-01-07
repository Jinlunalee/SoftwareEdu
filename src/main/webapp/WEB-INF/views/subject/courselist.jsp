<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/register/list.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/course.css'/>" />

<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div><span> > 강좌 관리 > </span> <span class="submenu-title">개설 과정 목록</span></div>
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
			전체목록 <b class="basic_txt_color">${courseListSize}</b>개, 
			페이지<b class="basic_txt_color"> ?? </b> / ??
		  </div>
		  <div class="view">
		  	<button type="button" class="btn btn-outline-secondary" onclick="location.href ='<c:url value="/subject/insert"/>'">강좌/과정 개설</button>
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
              <td>${course.courseTitle}</td>
              <td>${course.startDay}~${course.endDay}</td>
              <td>${course.recruitStartDay}~${course.recruitEndDay}</td>
              <td>${course.cost}</td>
              <td>${course.comnCdTitle}</td>
              <td>
              	<div>
              		<c:choose>
              			<c:when test="${subject.comnCdTitle eq '모집예정'}">
              				<button type="button" class="btn btn-secondary" onclick="location.href=''">수정</button>
							<button type="button" class="btn btn-secondary" onclick="del()">삭제</button>
              			</c:when>
              			<c:when test="${subject.comnCdTitle eq '진행중'}">
              				<button type="button" class="btn btn-secondary" onclick="location.href=''">수정</button>
              			</c:when>
              			<c:when test="${subject.comnCdTitle eq '폐강'}">
              				<button type="button" class="btn btn-secondary" onclick="location.href=''">수정</button>
              			</c:when>
              			<c:when test="${subject.comnCdTitle eq '진행완료'}">
              			</c:when>
              			<c:otherwise>
              				<button type="button" class="btn btn-secondary" onclick="location.href=''">수정</button>
              				<button type="button" class="btn btn-secondary" onclick="location.href=''">폐강</button>
						</c:otherwise>
              		</c:choose>
              	</div> 
              </td>
             </tr>
          </c:forEach>
          </c:if>
		</table>
	</div>
</div>

	<script>
	function del() {
		if(confirm('수강 정보를 삭제하시겠습니까?') == true) {
			console.log('삭제')
		} else {
			console.log('취소')
		}
	}
	</script>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
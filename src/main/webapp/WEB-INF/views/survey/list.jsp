<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/survey/list.css'/>" />

<div class="card m-2">
	<div class="card-header">
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	 <div> > 만족도 조사 관리 > 만족도 조사 양식 목록 조회</div>
	</div>
	<div class="card-body">

		<table class="list">
			<tr>
				<th>만족도 조사 아이디</th>
				<th>만족도 조사 제목</th>
			</tr>
			<c:forEach var="i" begin="1" end="5" step="1">
				<tr>
					<td>만족도 조사 아이디${i}</td>
					<td><a href="<c:url value='/survey/details/{surveyId}'/>">기본 만족도 조사</a></td>
				</tr>
			</c:forEach>
			<c:forEach var="i" begin="6" end="10" step="1">
				<tr>
					<td>만족도 조사 아이디${i}</td>
					<td><a href="<c:url value='/survey/details/{surveyId}'/>">강의 난이도 만족도 조사</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
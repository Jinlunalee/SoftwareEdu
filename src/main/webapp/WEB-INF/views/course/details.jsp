<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/course/details.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />

<div class="card m-2">
	<div class="card-header"> 강좌 관리 > 개설 강좌 정보 확인 > 개설 강좌 상세 페이지</div>
	<div class="card-body">
		<div class="sub_title">정기과정명 | 웹 개발자 과정 </div>
		<div class="course_title">
			<div class="main_title"><b class="basic_txt_color">강좌아이디</b> 한번에 끝내는 JavaScript </div>
			<div class="course_state">모집중</div>
		</div>
		<!-- 교육 상세내용 -->
		<table class="list">
			<thead>
			<tr>
				<th></th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td rowspan="7">
					<img class="detail_img" src="<c:url value='/resources/images/course/AI.jpg'/>"/>
				</td>
				<td> 연수기간(일수)</td>
				<td> 2022.12.15~2023.01.14(30일)</td>
			</tr>
			<tr>
				<td> 연수시간</td>
				<td> 09:00 ~ 18:00 </td>
			</tr>
			<tr>
				<td> 신청기간 </td>
				<td> 2022.12.29 ~ 2023.01.23 </td>
			</tr>
			<tr>
				<td> 난이도 </td>
				<td> 초급 </td>
			</tr>
			<tr>
				<td> 모집인원</td>
				<td> 0/50 </td>
			</tr>
			<tr>
				<td> 교육비</td>
				<td> 300,000 
					<c:if test="${1 eq 1}">* 교육비 지원을 받는 강좌입니다.</c:if>
				</td>
			</tr>
			<tr>
				<td> 만족도 조사 아아디</td>
				<td> SVEW0001 </td>
			</tr>
			</tbody>
		</table>
		
		<!-- 교육 소개 -->
		<div class="course_intro">
			<img src="<c:url value='/resources/images/course/course_intro.png'/>"/>
			<p class="txt">강좌에 대한 간략한 소개 </p>
		</div>
		
		<!-- button -->
		<div class="submit-btn">
			<input type="button" onclick="location.href='<c:url value="/course/update/1"/>'" value="수정">
	        <input type="button" onclick="del()" value="삭제">
		</div> 
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
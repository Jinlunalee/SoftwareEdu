<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<c:url value='/resources/css/register/insert.css'/>" />
<div class="card m-2">
	<div class="card-header">수강 관리 > 새 수강 추가</div>
	<div class="card-body">
	
	<div class="wrap">
	<div class="search-box">
	<div class="search-content">
	수강생 명 &nbsp; &nbsp;
	<select>
	<option>STDT001  |  홍길동</option>
	<option>STDT002  |  홍길서</option>
	<option>STDT003  |  홍길남</option>
	</select>
	</div>
	</div>
	
	<ul class="a">
	<li>회원 아이디 | STDT001</li>
	<li>이름 | 홍길동</li>
	<li>생년월일 | 1990-01-01</li>
	<li>성별 | 남성</li>
	<li>이메일 | stdt001@gmail.com</li>
	<li>전화번호 | 010-6832-1973</li>
	<li>주소 | 서울시 종로구 혜화동</li>
	<li>직위 | 학생</li>
	</ul>
	</div>
	
	
	<div class="wrap">
	<div class="search-box">
	<div class="search-content">
	강좌 명 &nbsp; &nbsp;
	<select>
	<option>CRSE0001  |  자바 초급</option>
	<option>CRSE0002  |  자바 중급</option>
	<option>CRSE0003  |  CSS 기초</option>
	</select>
	</div>
	</div>
	
	<ul class="a">
	<li>강좌 아이디 | CRSE0001</li>
	<li>강좌 명 | 자바 초급</li>
	<li>강좌 기간 | 2020-01-05 ~ 2020-04-04</li>
	<li>강좌 시간 | 09:00 ~ 20:00</li>
	<li>모집 기간 | 2020-01-01 ~ 2020-01-04</li>
	<li>모집 인원 | 30</li>
	<li>모집 상태 | 신청 중</li>
	</ul>
	</div>
	<div class="submit-btn">
	<input type="button" value="저 장">
	<input type="reset" value="취 소">
	</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
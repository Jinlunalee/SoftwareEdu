<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/register/insert.css'/>" />
<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	 <div> > 수강 관리 > <span class="submenu-title">수강 추가</span></div>
	</div>
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
	<div class="user-info">
	<li> 회원 아이디 | STDT001</li>
	<li> 이름 | 홍길동</li>
	<li> 생년월일 | 1990-01-01</li>
	<li> 성별 | 남성</li>
	</div>
	<div class="user-info2">
	<li> 이메일 | stdt001@gmail.com</li>
	<li> 전화번호 | 010-6832-1973</li>
	<li> 주소 | 서울시 종로구 혜화동</li>
	<li> 직위 | 학생</li>
	</div>
	</ul>
	</div>
	
	
	<div class="wrap">
	<div class="search-box">
	<div class="search-content">
	강좌/과정 &nbsp; &nbsp;
		<select onchange="changeType(this)">
			<option>강좌와 과정 중 선택</option>
			<option value="a">강좌</option>
			<option value="b">과정</option>
		</select>
		
		<select id="courselist">
			<option>리스트 목록</option>
		</select>
		
		<script>
			function changeType(v) {
				var course = ["자바 start", "자바 활용", "C언어 시작", "C언어 실습", "파이썬 기초"];
				var cl = ["자바 국비 과정", "자바 전문가 과정", "자바 기초 과정", "C언어 국비 과정", "C언어 전문가 과정", "C언어 기초 과정", "파이썬 국비 과정", "파이썬 전문가 과정", "파이썬 기초 과정"];
				var target = document.getElementById("courselist");
				
				if(v.value == "a") var d = course;
				else if(v.value == "b") var d = cl;
				
				target.options.length = 0;
				
				for(x in d) {
					var opt = document.createElement("option");
					opt.value = d[x];
					opt.innerHTML = d[x];
					target.appendChild(opt);
				}
			}
		</script>
	</div>
	</div>
	
	<ul class="a">
	<div class="course-info">
	<li> 강좌 아이디 | CRSE0001</li>
	<li> 강좌 명 | 자바 초급</li>
	<li> 강좌 기간 | 2020-01-05 ~ 2020-04-04</li>
	<li> 강좌 시간 | 09:00 ~ 20:00</li>
	</div>
	<div class="course-info2">
	<li> 모집 기간 | 2020-01-01 ~ 2020-01-04</li>
	<li> 모집 인원 | 30</li>
	<li> 모집 상태 | 신청 중</li>
	</div>
	</ul>
	</div>
	<div class="submit-btn">
	<input type="button" value="저 장">
	<input type="reset" onclick="location.href='<c:url value="/register/list"/>'" value="취 소">
	</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/register/list.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/course.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />

<div class="card m-2" style="border:none">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	강좌 관리 > 개설 강좌 정보 확인 > 개설 강좌 목록 
	</div>
	<div class="card-body">
		<!-- 검색 시작 -->
		<div class="search">
		  <select class="select-box">
		  	<option>강좌명</option>
		  	<option>강좌아이디</option>
		  </select>
          <input class="input-text" type="text" placeholder="강좌명 / 강좌아이디를 입력해 주세요">
          <input class="input-button" type="button" value="검색">
        </div>
		<!-- 검색끝 -->
		
		<div class="title">과정명:웹 개발자 과정</div>
		
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
                <th>강좌 아이디</th>
                <th>강좌명</th>
                <th>연수기간</th>
                <th>신청일</th>
                <th>교육비</th>
                <th>상태</th>
                <th></th>
            </tr>
           </thead>
		  <tbody>
            <tr>
              <td>??1</td>
              <td class="title">
				<span class="txt">
					<a href="<c:url value='/course/details/1'/>">강좌명 한번에끝내는 JS 상세보기로 연결 </a>
		        </span>
              </td>
              <td>2022.12.15 ~ 2023.1.14</td>
              <td>2022.10.14 ~ 2022.11.14</td>
              <td>300,000</td>
              <td>신청중(15/30)</td>
              <td>
              	<div class="submit-btn" style="display:flex;">
					<input type="button" onclick="location.href='<c:url value="/course/update/1"/>'" value="수정">
			        <input type="button" onclick="del()" value="삭제">
				</div> 
              </td>
             </tr>
		</table>
	
		<a href="<c:url value='/course/insert'/>">새 강좌 개설 입력</a>
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
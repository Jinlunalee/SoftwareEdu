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
                <th>번호</th>
                <th>제목</th>
            </tr>
           </thead>
		  <tbody>
            <tr>
              <td>??5</td>
              <td class="title" >
				<span class="txt">
					<a href="<c:url value='/course/courselist'/>">과정명 강좌보기로 연결 </a>
		        </span>
              </td>
             </tr>
		</table>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
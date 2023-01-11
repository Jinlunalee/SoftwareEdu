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
			전체목록 <b class="basic_txt_color">${pager.totalRows}</b>개, 
			페이지<b class="basic_txt_color"> ${pager.pageNo} </b> / ${pager.totalPageNo}
			</div>
			<div class="view">
			<button type="button" class="btn btn-outline-secondary" onclick="location.href ='<c:url value="/subject/insert"/>'">강좌/과정 개설</button>
			<select class="select-view" onchange="if(this.value) location.href=(this.value);">
				<option value="<c:url value="/subject/courseboardlist?pageNo=1"/>">선택</option>
				<option value="<c:url value="/subject/courseboardlist?pageNo=1&rowsPerPage=10"/>">10개</option>
				<option value="<c:url value="/subject/courseboardlist?pageNo=1&rowsPerPage=30"/>">30개</option>
				<option value="<c:url value="/subject/courseboardlist?pageNo=1&rowsPerPage=50"/>">50개</option>
			</select>
			</div>
		</div>
		<!-- // list top -->
		
		<!-- list table -->
		<table class="list">
			<thead>
				<tr>
					<th>분류</th>
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
				<c:if test="${boardListSize ne 0}">
					<c:forEach var="board" items="${boardList}">
						<tr>
							<td>${board.catCourseTitle}</td>
							<td>${board.courseId}</td>
							<td>${board.courseTitle}</td>
							<td>${board.startDay}~${board.endDay}</td>
							<td>${board.recruitStartDay}~${board.recruitEndDay}</td>
							<td>${board.cost}</td>
							<td>${board.comnCdTitle}</td>
							<td>
								<div>
									<c:choose>
										<c:when test="${board.comnCdTitle eq '모집예정'}">
											<button type="button" class="btn btn-secondary" onclick="location.href=''">수정</button>
											<button type="button" class="btn btn-secondary" onclick="location.href=''">삭제</button>
										</c:when>
										<c:when test="${board.comnCdTitle eq '진행중'}">
											<button type="button" class="btn btn-secondary" onclick="location.href=''">수정</button>
										</c:when>
										<c:when test="${board.comnCdTitle eq '폐강'}">
											<button type="button" class="btn btn-secondary" onclick="location.href=''">수정</button>
										</c:when>
										<c:when test="${board.comnCdTitle eq '진행완료'}">
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
				
				<!--paging-->
				<tr>
					<td>
						<div id="paging">
							<ul class="paging">
								<li><a href="courseboardlist?pageNo=1&rowsPerPage=${pager.rowsPerPage}&catCourse=${catId}">처음</a></li>
								<c:if test="${pager.groupNo>1}">
									<li><a href="courseboardlist?pageNo=${pager.startPageNo-1}&rowsPerPage=${pager.rowsPerPage}&catCourse=${catId}">이전</a></li>
								</c:if>

								<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
									<c:if test="${pager.pageNo != i}">
										<li><a href="courseboardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&catCourse=${catId}">${i}</a></li>
									</c:if>
									<c:if test="${pager.pageNo == i}">
										<li><a href="courseboardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&catCourse=${catId}">${i}</a></li>
									</c:if>
								</c:forEach>

								<c:if test="${pager.groupNo<pager.totalGroupNo}">
									<li><a href="courseboardlist?pageNo=${pager.endPageNo+1}&rowsPerPage=${pager.rowsPerPage}&catCourse=${catId}">다음</a></li>
								</c:if>
								<li><a href="courseboardlist?pageNo=${pager.totalPageNo}&rowsPerPage=${pager.rowsPerPage}&catCourse=${catId}">맨끝</a></li>
							</ul>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
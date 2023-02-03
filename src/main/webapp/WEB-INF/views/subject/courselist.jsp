<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/student/list.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/course.css'/>" />

<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div><span> > 강좌 관리 > </span> <span class="submenu-title">개설 과정 목록</span></div>
	</div>
	<div class="card-body">
		<!-- 검색 시작 -->
		<form action="<c:url value='/subject/searchCourseBoardlist'/>">
		<div class="search">
			<select name="course" class="select-box">
				<option value="crseTitle" ${course eq 'crseTitle'?"selected":""}>과정명</option>
				<option value="crseId" ${course eq 'crseId'?"selected":""}>과정아이디</option>
			</select>
			<input name="keyword" class="input-text" type="text" value="${keyword}">
			<input class="input-button" type="submit" value="검색" style="position: static;">
        </div>
        </form>
        <!-- 검색끝 -->
        
        <div class="view">
			<button type="button" class="btn btn-outline-secondary" onclick="location.href ='<c:url value="/subject/insert"/>'">강좌/과정 개설</button>
			<select class="select-view" onchange="if(this.value) location.href=(this.value);">
				<option value="">선택</option>
				<option value="<c:url value="/subject/searchCourseBoardlist?pageNo=1&rowsPerPage=10&course=${course}&keyword=${keyword}"/>" ${rowsPerPage eq '10'?"selected":""}>10개</option>
				<option value="<c:url value="/subject/searchCourseBoardlist?pageNo=1&rowsPerPage=10&course=${course}&keyword=${keyword}"/>" ${rowsPerPage eq '30'?"selected":""}>30개</option>
				<option value="<c:url value="/subject/searchCourseBoardlist?pageNo=1&rowsPerPage=10&course=${course}&keyword=${keyword}"/>" ${rowsPerPage eq '50'?"selected":""}>50개</option>
			</select>
		</div>
		
		<!-- list table -->
		<div id="list-wrap">
			<div class="list_top">
				<div class="cnt">
				전체목록 <b class="basic_txt_color">${pager.totalRows}</b>개, 
				페이지<b class="basic_txt_color"> ${pager.pageNo} </b> / ${pager.totalPageNo}
				</div>
			</div>
		<table class="list">
			<thead>
				<tr>
					<th>과정아이디</th>
					<th>과정명</th>
					<th>분류</th>
					<th>연수기간</th>
					<th>신청기간</th>
					<th>교육비(원)</th>
					<th>상태</th>
					<th>개설연도</th>
					<th>처리</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${boardListSize ne 0}">
					<c:forEach var="board" items="${boardList}">
						<tr>
							<td>${board.courseId}</td>
							<td>${board.courseTitle}</td>
							<td>${board.catCourseCdTitle}</td>
							<td>${board.startDay} ~ ${board.endDay}</td>
							<td>${board.recruitStartDay} ~ ${board.recruitEndDay}</td>
							<td><fmt:formatNumber value="${board.cost}" type="number"/></td>
							<td>${board.openStateCdTitle}</td>
							<td>${board.courseOpenYear}
							<td>
								<div>
									<c:choose>
										<c:when test="${(board.openStateCdTitle eq '모집예정') or (board.openStateCdTitle eq '모집중') or (board.openStateCdTitle eq '추가모집중') or (board.openStateCdTitle eq '모집마감') }">
											<button type="button" class="btn btn-secondary" onclick="location.href=''">수정</button>
											<button type="button" class="btn btn-secondary" onclick="location.href=''">폐강</button>
										</c:when>
										<c:when test="${board.openStateCdTitle eq '진행중'}">
											<button type="button" class="btn btn-secondary" onclick="location.href=''">수정</button>
										</c:when>
										<c:when test="${board.openStateCdTitle eq '폐강'}">
											<button type="button" class="btn btn-secondary" onclick="location.href=''">삭제</button>
										</c:when>
										<c:when test="${board.openStateCdTitle eq '진행완료'}">
										</c:when>
									</c:choose>
								</div> 
							</td>
						</tr>
					</c:forEach>
				</c:if>
				
				
			</tbody>
		</table>
		<!--paging-->
            <div id="paging">
                <ul class="paging">
                    <li><a href="searchCourseBoardlist?pageNo=1&rowsPerPage=${pager.rowsPerPage}&catCourseCd=${catId}&course=${course}&keyword=${keyword}">처음</a></li>
                    <c:if test="${pager.groupNo>1}">
                        <li><a href="searchCourseBoardlist?pageNo=${pager.startPageNo-1}&rowsPerPage=${pager.rowsPerPage}&catCourseCd=${catId}&course=${course}&keyword=${keyword}">이전</a></li>
                    </c:if>

                    <c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
                        <c:if test="${pager.pageNo != i}">
                            <li><a href="searchCourseBoardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&catCourseCd=${catId}&course=${course}&keyword=${keyword}">${i}</a></li>
                        </c:if>
                        <c:if test="${pager.pageNo == i}">
                            <li><a href="searchCourseBoardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&catCourseCd=${catId}&course=${course}&keyword=${keyword}">${i}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${pager.groupNo<pager.totalGroupNo}">
                        <li><a href="searchCourseBoardlist?pageNo=${pager.endPageNo+1}&rowsPerPage=${pager.rowsPerPage}&catCourseCd=${catId}&course=${course}&keyword=${keyword}">다음</a></li>
                    </c:if>
                    <li><a href="searchCourseBoardlist?pageNo=${pager.totalPageNo}&rowsPerPage=${pager.rowsPerPage}&catCourseCd=${catId}&course=${course}&keyword=${keyword}">맨끝</a></li>
                </ul>
            </div>
		</div>
	</div>
</div>
	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/subject.js'/>"></script>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="<c:url value='/resources/css/student/list.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/course.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />

<div class="card">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div><span> > 강좌 관리 > </span><span class="submenu-title">개설 강좌 목록</span></div>
	</div>
	<div class="card-body">
		<!-- 검색 시작 -->
		<div class="search">
			<form action="<c:url value='/subject/searchSubjectBoardlist'/>">
				<div class="search-row">
					<div class="search-section">
						<span class="search-section-title">개설강좌</span>
						<div class="search-section-content">
							<select name="subject" class="select-box input-box">
								<option value="subjTitle" ${subject eq 'subjTitle'?"selected":""}>강좌명</option>
								<option value="subjId" ${subject eq 'subjId'?"selected":""}>강좌아이디</option>
							</select>
							<input name="keyword" class="input-text input-box" type="text" value="${keyword}">
						</div>
					</div>
					<input class="input-button btn-mt-15 btn btn-outline-secondary" type="submit" value="검색">
				</div>
			</form>
		</div>
		<!-- 검색끝 -->
		
		<div class="view">
			<button type="button" class="btn btn-outline-secondary" onclick="location.href ='<c:url value="/subject/insert?check=${check}"/>'">강좌/과정 개설</button>
			<select class="select-view" onchange="if(this.value) location.href=(this.value);">
				<option value="">선택</option>
				<option value="<c:url value="/subject/searchSubjectBoardlist?pageNo=1&rowsPerPage=10&subject=${subject}&keyword=${keyword}"/>" ${rowsPerPage eq '10'?"selected":""}>10개</option>
				<option value="<c:url value="/subject/searchSubjectBoardlist?pageNo=1&rowsPerPage=30&subject=${subject}&keyword=${keyword}"/>" ${rowsPerPage eq '30'?"selected":""}>30개</option>
				<option value="<c:url value="/subject/searchSubjectBoardlist?pageNo=1&rowsPerPage=50&subject=${subject}&keyword=${keyword}"/>" ${rowsPerPage eq '50'?"selected":""}>50개</option>
			</select>
		</div>

		<!-- list table -->
		<div id="list-wrap">
			<div class="list_top">
				<div class="cnt">
					전체목록 <b class="basic_txt_color">${pager.totalRows}</b>개
           <c:if test="${pager.totalRows ne 0}">
					, 페이지<b class="basic_txt_color"> ${pager.pageNo} </b> / ${pager.totalPageNo}
				</c:if>
				</div>
			</div>

			<table class="list">
				<thead>
					<tr>
						<th>강좌아이디</th>
						<th>회차</th>
						<th>과정명</th>
						<th>강좌명</th>
						<th>분류</th>
						<th>강좌기간</th>
						<th>모집기간</th>
						<th>교육비(원)</th>
						<th>상태</th>
						<th>개설일시</th>
						<th>처리</th>
					</tr>
				</thead>
				
				<tbody>
					<c:if test="${boardListSize ne 0}">
						<c:forEach var="board" items="${boardList}">
							<tr>
								<td>${board.subjectId}</td>
								<td>${board.subjectSeq}
								<td>${board.courseTitle}</td>
								<td>
									<span>
									<a href="<c:url value='/subject/details/${board.subjectId}/${board.subjectSeq}'/>">${board.subjectTitle}</a>
									</span>
								</td>
								<td>${board.catSubjectCdTitle}</td>
								<td>${board.startDay} ~ ${board.endDay}</td>
								<td>${board.recruitStartDay} ~ ${board.recruitEndDay}</td>
								<td><fmt:formatNumber value="${board.cost}" type="number"/></td>
								<td>${board.openStateCdTitle}</td>
								<td>${board.openDt}</td>
								<td>
									<div>
										<!-- 모집상태에 따라 나오는 버튼 변경 -->
										<c:choose>
											<c:when test="${(board.openStateCdTitle eq '모집예정') or (board.openStateCdTitle eq '모집중') or (board.openStateCdTitle eq '추가모집중') or (board.openStateCdTitle eq '모집마감') }">
												<button type="button" class="btn btn-outline-secondary btn-11 btn-blue" onclick="location.href='<c:url value="/subject/update/${board.subjectId}/${board.subjectSeq}"/>'">수정</button>
												<button type="button" class="btn btn-outline-secondary btn-11 btn-red" onclick="closeCourse('${board.subjectId}', '${board.subjectSeq}', '${board.fileId}')">폐강</button>
											</c:when>
											<c:when test="${board.openStateCdTitle eq '진행중'}">
												<button type="button" class="btn btn-outline-secondary btn-11 btn-blue" onclick="location.href='<c:url value="/subject/update/${board.subjectId}/${board.subjectSeq}"/>'">수정</button>
											</c:when>
											<c:when test="${board.openStateCdTitle eq '폐강'}">
												<button type="button" class="btn btn-outline-secondary btn-11" onclick="del('${board.subjectId}', '${board.subjectSeq}', '${board.fileId}')" >삭제</button>
											</c:when>
											<c:when test="${board.openStateCdTitle eq '진행완료'}">
											</c:when>
										</c:choose>
									</div> 
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${boardListSize eq 0}">
					<tr>
					<td colspan='11'>
						<div class="table-empty">
							게시물이 없습니다.
						</div>
						</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<div class="bottoms">
				<!--paging-->
           <c:if test="${pager.totalRows ne 0}">
				<div id="paging">
					<ul class="paging">
						<li><a href="searchSubjectBoardlist?pageNo=1&rowsPerPage=${pager.rowsPerPage}&catCourseCd=${catId}&subject=${subject}&keyword=${keyword}">처음</a></li>
						<c:if test="${pager.groupNo>1}">
							<li><a href="searchSubjectBoardlist?pageNo=${pager.startPageNo-1}&rowsPerPage=${pager.rowsPerPage}&catSubjectCd=${catId}&subject=${subject}&keyword=${keyword}">이전</a></li>
						</c:if>
						<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
							<c:if test="${pager.pageNo != i}">
								<li><a href="searchSubjectBoardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&catSubjectCd=${catId}&subject=${subject}&keyword=${keyword}">${i}</a></li>
							</c:if>
							<c:if test="${pager.pageNo == i}">
								<li><a href="searchSubjectBoardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&catSubjectCd=${catId}&subject=${subject}&keyword=${keyword}">${i}</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${pager.groupNo<pager.totalGroupNo}">
							<li><a href="searchSubjectBoardlist?pageNo=${pager.endPageNo+1}&rowsPerPage=${pager.rowsPerPage}&catSubjectCd=${catId}&subject=${subject}&keyword=${keyword}">다음</a></li>
						</c:if>
						<li><a href="searchSubjectBoardlist?pageNo=${pager.totalPageNo}&rowsPerPage=${pager.rowsPerPage}&catSubjectCd=${catId}&subject=${subject}&keyword=${keyword}">맨끝</a></li>
					</ul>
				</div>
				</c:if>
			</div>

		</div>
	</div>
</div>

	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/subject.js'/>"></script>
	<script type="text/javascript">
		/*수강삭제*/
		function del(subjectId, subjectSeq, fileId) {
			if(confirm('강좌 정보를 삭제하시겠습니까?')) {
				location.href = '<c:url value="/subject/del/'+subjectId+'/'+subjectSeq+'?fileId='+fileId+'"/>'
			} else {
			}
		}
	
		/*폐강*/
		function closeCourse(subjectId, subjectSeq, fileId){
			if(confirm('폐강하시겠습니까?')) {
				location.href = '<c:url value="/subject/closesubject/'+subjectId+'/'+subjectSeq+'?fileId='+fileId+'"/>'
			} else {
			}
		}
	</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
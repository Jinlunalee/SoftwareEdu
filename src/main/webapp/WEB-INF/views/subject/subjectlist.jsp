<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/register/list.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/course.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />

<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div><span> > 강좌 관리 > </span><span class="submenu-title">개설 강좌 목록</span></div>
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
				전체목록 <b class="basic_txt_color">${pager.totalRows}</b>개, 
				페이지<b class="basic_txt_color"> ${pager.pageNo} </b> / ${pager.totalPageNo}
			</div>

			<div class="view">
				<button type="button" class="btn btn-outline-secondary" onclick="location.href ='<c:url value="/subject/insert"/>'">강좌/과정 개설</button>
				<select class="select-view" onchange="if(this.value) location.href=(this.value);">
					<option value="<c:url value="/subject/subjectboardlist?pageNo=1"/>">선택</option>
					<option value="<c:url value="/subject/subjectboardlist?pageNo=1&rowsPerPage=10"/>">10개</option>
					<option value="<c:url value="/subject/subjectboardlist?pageNo=1&rowsPerPage=30"/>">30개</option>
					<option value="<c:url value="/subject/subjectboardlist?pageNo=1&rowsPerPage=50"/>">50개</option>
				</select>
			</div>
		</div>
		<!-- // list top -->
		
		<!-- list table -->
		<table class="list">
			<thead>
				<tr>
					<th>분류</th>
					<th>강좌아이디</th>
					<th>과정명</th>
					<th>강좌명</th>
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
							<td>${board.catSubjectTitle}</td>
							<td>${board.subjectId}</td>
							<td>${board.courseTitle}</td>
							<td>
								<span>
								<a href="<c:url value='/subject/details/${board.subjectId}/${board.subjectSeq}'/>">${board.subjectTitle}</a>
								</span>
							</td>
							<td>${board.startDay}~${board.endDay}</td>
							<td>${board.recruitStartDay}~${board.recruitEndDay}</td>
							<td>${board.cost}</td>
							<td>${board.comnCdTitle}</td>
							<td>
								<div>
									<!-- 모집상태에 따라 나오는 버튼 변경 -->
									<c:choose>
										<c:when test="${(board.comnCdTitle eq '모집예정') or (board.comnCdTitle eq '모집중') or (board.comnCdTitle eq '추가모집중') or (board.comnCdTitle eq '모집마감') }">
											<button type="button" class="btn btn-secondary" onclick="location.href='<c:url value="/subject/update/${board.subjectId}/${board.subjectSeq}"/>'">수정</button>
											<button type="button" class="btn btn-secondary" onclick="closeCourse('${board.subjectId}', '${board.subjectSeq}', '${board.fileId}')">폐강</button>
										</c:when>
										<c:when test="${board.comnCdTitle eq '진행중'}">
											<button type="button" class="btn btn-secondary" onclick="location.href='<c:url value="/subject/update/${board.subjectId}/${board.subjectSeq}"/>'">수정</button>
										</c:when>
										<c:when test="${board.comnCdTitle eq '폐강'}">
											<button type="button" class="btn btn-secondary" onclick="del('${board.subjectId}', '${board.subjectSeq}', '${board.fileId}')" >삭제</button>
										</c:when>
										<c:when test="${board.comnCdTitle eq '진행완료'}">
										</c:when>
										<c:otherwise>
											<button type="button" class="btn btn-secondary" onclick="location.href='<c:url value="/subject/update/${board.subjectId}/${board.subjectSeq}"/>'">수정</button>
											<button type="button" class="btn btn-secondary" onclick="closeCourse('${board.subjectId}', '${board.subjectSeq}', '${board.fileId}')">폐강</button>
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
								<li><a href="subjectBoardList?pageNo=1&rowsPerPage=${pager.rowsPerPage}&catCourse=${catId}">처음</a></li>
								<c:if test="${pager.groupNo>1}">
									<li><a href="subjectboardlist?pageNo=${pager.startPageNo-1}&rowsPerPage=${pager.rowsPerPage}&catSubject=${catId}">이전</a></li>
								</c:if>
								<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
									<c:if test="${pager.pageNo != i}">
										<li><a href="subjectboardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&catSubject=${catId}">${i}</a></li>
									</c:if>
									<c:if test="${pager.pageNo == i}">
										<li><a href="subjectboardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&catSubject=${catId}">${i}</a></li>
									</c:if>
								</c:forEach>
								<c:if test="${pager.groupNo<pager.totalGroupNo}">
									<li><a href="subjectboardlist?pageNo=${pager.endPageNo+1}&rowsPerPage=${pager.rowsPerPage}&catSubject=${catId}">다음</a></li>
								</c:if>
								<li><a href="subjectboardlist?pageNo=${pager.totalPageNo}&rowsPerPage=${pager.rowsPerPage}&catSubject=${catId}">맨끝</a></li>
							</ul>
						</div>
					</td>
				</tr>
		</table>
	</div>
</div>

	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/subject.js'/>"></script>
	<script type="text/javascript">
		/*수강삭제*/
		function del(subjectId, subjectSeq, fileId) {
			if(confirm('수강 정보를 삭제하시겠습니까?')) {
				alert('삭제');
				//alert(subjectId+'/'+subjectSeq+'/'+fileId);
				location.href = '<c:url value="/subject/del/'+subjectId+'/'+subjectSeq+'?fileId='+fileId+'"/>'
			} else {
				alert('취소');
			}
		}
	
		/*폐강*/
		function closeCourse(subjectId, subjectSeq, fileId){
			if(confirm('폐강하시겠습니까?')) {
				alert('폐강');
				location.href = '<c:url value="/subject/closesubject/'+subjectId+'/'+subjectSeq+'?fileId='+fileId+'"/>'
			} else {
				alert('취소');
			}
		}
	</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
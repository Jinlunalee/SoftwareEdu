<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<div id="page-list">
	<div class="list_top">
		<div class="cnt">
			전체목록 <b class="basic_txt_color">${pager.totalRows}</b>개, 페이지<b
				class="basic_txt_color"> ${pager.pageNo} </b> / ${pager.totalPageNo}
		</div>
	</div>
	
	<table class="list">
		<thead>
			<tr>
				<c:choose>
				<c:when test="${check eq 'subject'}">
					<th>강좌아이디</th>
					<th>과정명</th>
					<th>강좌명</th>
					<th>분류</th>
					<th>연수기간</th>
					<th>신청기간</th>
					<th>교육비</th>
					<th>상태</th>
					<th>개설날짜</th>
					<th>처리</th>
				</c:when>
				<c:otherwise>
					<th>과정아이디</th>
					<th>과정명</th>
					<th>분류</th>
					<th>연수기간</th>
					<th>신청기간</th>
					<th>교육비</th>
					<th>상태</th>
					<th>처리</th>
				</c:otherwise>
				</c:choose>
			</tr>
		</thead>
		<tbody>
			<c:if test="${boardListSize ne 0}">
				<c:forEach var="board" items="${boardList}">
					<tr>
						<c:choose>
							<c:when test="${check eq 'subject'}">
								<td>${board.subjectId}</td>
								<td>${board.courseTitle}</td>
								<td><span> 
										<a href="<c:url value='/subject/details/${board.subjectId}/${board.subjectSeq}'/>">${board.subjectTitle}</a>
								</span></td>
								<td>${board.catSubjectTitle}</td>
								<td>${board.startDay}~${board.endDay}</td>
								<td>${board.recruitStartDay}~${board.recruitEndDay}</td>
								<td><fmt:formatNumber value="${board.cost}" type="number" /></td>
								<td>${board.comnCdTitle}</td>
								<td>${board.regDt}</td>
							</c:when>
							<c:otherwise>
								<td>${board.courseId}</td>
								<td>${board.courseTitle}</td>
								<td>${board.catCourseTitle}</td>
								<td>${board.startDay}~${board.endDay}</td>
								<td>${board.recruitStartDay}~${board.recruitEndDay}</td>
								<td><fmt:formatNumber value="${board.cost}" type="number"/></td>
								<td>${board.comnCdTitle}</td>			
							</c:otherwise>
						</c:choose>
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
										<button type="button" class="btn btn-secondary" onclick="del('${board.subjectId}', '${board.subjectSeq}', '${board.fileId}')">삭제</button>
									</c:when>
									<c:when test="${board.comnCdTitle eq '진행완료'}">
									</c:when>
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
							<li><a href="subjectboardlist?pageNo=1&rowsPerPage=${pager.rowsPerPage}&catCourse=${catId}">처음</a></li>
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
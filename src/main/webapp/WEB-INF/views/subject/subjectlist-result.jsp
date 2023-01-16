<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="page-list">
	<div>
		<table class="table">
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
					<th>개설날짜</th>
					<th>처리</th>
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
							<td><fmt:formatNumber value="${board.cost}" type="number"/></td>
							<td>${board.comnCdTitle}</td>
							<td>${board.regDt}</td>
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
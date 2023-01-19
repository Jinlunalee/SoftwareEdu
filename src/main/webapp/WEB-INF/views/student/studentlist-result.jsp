<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="page-list">
	<div class="list_top">
		<div class="cnt">
			전체목록 <b class="basic_txt_color">${pager.totalRows}</b>개, 
			페이지<b class="basic_txt_color"> ${pager.pageNo} </b> / ${pager.totalPageNo}
		</div>
	</div>

	<table class="list">
		<tr>
			<th>수강생 아이디</th>
			<th>수강생명</th>
			<th>이메일</th>
			<th>생년월일</th>
			<th>구분</th>
			<th>수정/삭제</th>
			<th></th>
		</tr>

		<!-- 리스트 -->
		<c:if test="${boardListSize ne 0}">
			<c:forEach var="board" items="${boardList}" varStatus="status">
				<tr>
					<td>${board.studentId}</td>
					<td>${board.name}</td>
					<td>${board.email}</td>
					<td>${board.birth}</td>
					<td>${board.position}</td>
					<td>
						<form>
							<button type="button" class="btn btn-secondary">수정</button>
							<button type="button" class="btn btn-secondary" value="삭제" onclick="del()">삭제</button>
						</form>
					</td>
				</tr>
			</c:forEach>
		</c:if>

		<!-- paging -->
		<tr>
			<td colspan="4" class="text-center">
				<div>
					<a class="btn btn-outline-primary btn-sm" href="boardlist?pageNo=1&rowsPerPage=${pager.rowsPerPage}">처음</a>
					<c:if test="${pager.groupNo>1}">
						<a class="btn btn-outline-info btn-sm"
							href="boardlist?pageNo=${pager.startPageNo-1}&rowsPerPage=${pager.rowsPerPage}">이전</a>
					</c:if>

					<c:forEach var="i" begin="${pager.startPageNo}"
						end="${pager.endPageNo}">
						<c:if test="${pager.pageNo != i}">
							<a class="btn btn-outline-success btn-sm"
								href="boardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}">${i}</a>
						</c:if>
						<c:if test="${pager.pageNo == i}">
							<a class="btn btn-danger btn-sm"
								href="boardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}">${i}</a>
						</c:if>
					</c:forEach>

					<c:if test="${pager.groupNo<pager.totalGroupNo}">
						<a class="btn btn-outline-info btn-sm"
							href="boardlist?pageNo=${pager.endPageNo+1}&rowsPerPage=${pager.rowsPerPage}">다음</a>
					</c:if>
					<a class="btn btn-outline-primary btn-sm"
						href="boardlist?pageNo=${pager.totalPageNo}&rowsPerPage=${pager.rowsPerPage}">맨끝</a>
				</div>
			</td>
		</tr>
	</table>
	<!-- 얘가 74번째 줄로 들어가야 하는 거 아닌가? -->
</div>
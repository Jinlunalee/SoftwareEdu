<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<link rel="stylesheet" href="<c:url value='/resources/css/register/list.css'/>" />

<div class="card m-2">
	<div class="card-header">
		<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
		<div>> 수강생 관리 > <span class="submenu-title">수강생 정보 확인</span></div>
	</div>

	<div class="card-body">

		<div class="search">
			<select class="select-box">
				<option>수강생 명</option>
				<option>수강생 아이디</option>
			</select> 
			<input class="input-text" type="text" placeholder="수강생 명을 입력해 주세요"> 
			<input class="input-button" type="button" value="검색">
		</div>

		<div class="list_top">
			<div class="cnt">
			전체목록 <b class="basic_txt_color">${pager.rowsPerPage}</b>개, 
	<!--	페이지<b class="basic_txt_color">  ??</b> /??  -->	
				<div class="view">
						<button type="button" class="btn btn-outline-secondary">수강생추가</button>
					<select class="select-view" onchange="changeRowsPerPage(this.value)">
						<option value="10">10개</option>
						<option value="30">30개</option>
						<option value="50">50개</option>
					</select>
				</div>
			</div>

			<table class="list">
				<tr>
					<th>수강생명</th>
					<th>수강생 아이디</th>
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
							<th>${board.name}</th>
							<th>${board.studentId}</th>
							<th>${board.email}</th>
							<th>${board.birth}</th>
							<th>${board.position}</th>
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
							<a class="btn btn-outline-primary btn-sm" href="boardList?pageNo=1">처음</a>
							<c:if test="${pager.groupNo>1}">
								<a class="btn btn-outline-info btn-sm" href="boardList?pageNo=${pager.startPageNo-1}&rowsPerPage=${pager.rowsPerPage}">이전</a>
							</c:if>
							
							<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
								<c:if test="${pager.pageNo != i}">
									<a class="btn btn-outline-success btn-sm" href="boardList?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}">${i}</a>
								</c:if>
								<c:if test="${pager.pageNo == i}">
									<a class="btn btn-danger btn-sm" href="boardList?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}">${i}</a>
								</c:if>
							</c:forEach>
							
							<c:if test="${pager.groupNo<pager.totalGroupNo}">
								<a class="btn btn-outline-info btn-sm" href="boardList?pageNo=${pager.endPageNo+1}&rowsPerPage=${pager.rowsPerPage}">다음</a>
							</c:if>
							<a class="btn btn-outline-primary btn-sm" href="boardList?pageNo=${pager.totalPageNo}&rowsPerPage=${pager.rowsPerPage}">맨끝</a>
						</div>
					</td>
				</tr>			
			</table>  <!-- 얘가 74번째 줄로 들어가야 하는 거 아닌가? -->
		</div>
	</div>
</div>
	
	<script>
		$("#modal_open_btn").click(function() {
			$("#modal").attr("style", "display:block");
		});

		$("#modal_close_btn").click(function() {
			$("#modal").attr("style", "display:none");
		});
	</script>
	<script>
	function del() {
		if(confirm('수강생 정보를 삭제하시겠습니까?') == true) {
			console.log('삭제')
		} else {
			console.log('취소')
		}
	}
	</script>
	<script>
		function changeRowsPerPage(value) {
			var pageNo = "${pager.pageNo}";
			console.log("pageNo: "+ pageNo);
			console.log("rowsPerPage: " + value);
			$.ajax({
				url : "boardList?pageNo=" + pageNo + "&rowsPerPage=" + value,
				type : "GET",
				success : function() {
					
					console.log("RowsPerPage is working");
					
				}
			})
		}
	</script>
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
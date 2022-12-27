<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/register/list.css'/>" />

<div class="card m-2">
	<div class="card-header">수강 관리 > 수강 목록 조회</div>
	<div class="card-body">
		<div class="search">
			<input class="input-date" type="date"> <select
				class="select-box">
				<option>수강생 명</option>
				<option>강좌 명</option>
			</select> <input class="input-text" type="text"
				placeholder="수강생 명 / 강좌 명을 입력해 주세요"> <input
				class="input-button" type="button" value="검색">
		</div>
		<div class="view">
			<select class="select-view">
				<option>10개</option>
				<option>30개</option>
				<option>50개</option>
			</select>
		</div>

		<table class="list">
			<tr>
				<th>신청일자</th>
				<th>수강생 명</th>
				<th>강좌 명</th>
				<th>강좌아이디</th>
				<th>현재 상태</th>
				<th>승인/수정</th>
				<th>반려/삭제</th>
				<th></th>
			</tr>
			<c:forEach var="i" begin="1" end="5" step="1">
				<tr>
					<td>2022.12.03</td>
					<td>이수강</td>
					<td><a id="modal_open_btn">처음 시작하는 스프링 프레임워크</a></td>
					<div id="modal">
						<div class="modal_content">
							<li>홍길동 | STDT001
							<li>강좌명 : 자바 초급</li>
							<li>강의 시간 : 09:00 ~ 18:00</li>
							<li>교육 기간 : 2022.12.19 ~ 2022.12.22</li>
							<li>진도율 : 80%</li>
							<input type="button" onclick="location.href='<c:url value="/register/update/1"/>'" value="수정">
							<button type="button" id="modal_close_btn">창 닫기</button>
						</div>

						<div class="modal_layer"></div>
					</div>
					<td>12</td>
					<td><img src="<c:url value='/resources/images/register/waiting.png'/>" /></td>
					<td><form>
							<input type="button" value="승인">
						</form></td>
					<td><form>
							<input type="button" value="반려">
						</form></td>
				</tr>
			</c:forEach>
			<c:forEach var="i" begin="1" end="5" step="1">
				<tr>
					<td>2022.12.03</td>
					<td>이수강</td>
					<td><a id="modal_open_btn">처음 시작하는 스프링 프레임워크</a></td>
					<div id="modal">
						<div class="modal_content">
							<li>홍길동 | STDT001
							<li>강좌명 : 자바 초급</li>
							<li>강의 시간 : 09:00 ~ 18:00</li>
							<li>교육 기간 : 2022.12.19 ~ 2022.12.22</li>
							<li>진도율 : 80%</li>
							<button type="button" id="modal_close_btn">창 닫기</button>
						</div>

						<div class="modal_layer"></div>
					</div>
					<td>12</td>
					<td><img src="<c:url value='/resources/images/register/complete.png'/>" /></td>
					<td><form>
							<input type="button" onclick="location.href='<c:url value="/register/update/1"/>'" value="수정">
						</form></td>
					<td><form>
							<input type="button" onclick="del()" value="삭 제">
							
						</form></td>
				</tr>
			</c:forEach>
		</table>
		<div class="down">
		<img class="excelimg" src="<c:url value='/resources/images/register/exceldown.png'/>" />
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
		if(confirm('수강 정보를 삭제하시겠습니까?') == true) {
			console.log('삭제')
		} else {
			console.log('취소')
		}
	}
	</script>
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/register/list.css'/>" />

<div class="card m-2">
	<div class="card-header">
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div>수강생 관리 > <span class="submenu-title">수강생 정보 확인</span></div>
	</div>
	<div class="card-body">
		<div class="search-box">
			 <select class="select-box">
				<option>수강생 명</option>
				<option>수강생 아이디</option>
			</select> <input class="input-text" type="text"
				placeholder="수강생 명을 입력해 주세요"> <input
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
				<th>수강생명</th>
				<th>수강생 아이디</th>
				<th>이메일</th>
				<th>생년월일</th>
				<th>수정/삭제</th>
				<th></th>
			</tr>
			<c:forEach var="i" begin="1" end="10" step="1">
				<tr>
					<td>이수강</td>
					<td>sugang</td>
					<td>sugang@sg.com</td>
					<td>1900.01.01</td>
					<td><form>
						<button type="button" class="btn btn-secondary">수정</button>
							<button type="button" class="btn btn-secondary" value="삭제" onclick="del()">삭제</button>
						</form></td>
				</tr>
			</c:forEach>
		</table>

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
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
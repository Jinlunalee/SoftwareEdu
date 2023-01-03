<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/register/list.css'/>" />

<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	 <div> > 수강 관리 > <span class="submenu-title">수강 목록 조회</span></div>
	</div>
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
			<c:forEach var="ls" items="${list}">
				<tr>
					<td>${ls.regDt}</td>
					<td>${student.name}</td>
					<td><a class="modal-open">${subject.subjectTitle}</a></td>
					<div class="modal">
						<div class="modal-content">
							
							<li style="text-align: center;">${student.name}  |  ${ls.studentId}  |  <c:if test="${ls.stateCd eq 'ERL06'}"> 수강 완료</c:if></li>
							<br>
							<li>강좌명 | ${subject.subjectTitle}</li>
							<li>강의 시간 | ${open.startTime} ~ ${open.endTime} </li>
							<li>교육 기간 | ${open.startDay} ~ ${open.endDay} </li>
							<li>진도율 | ${ratio} %</li>
							완료한 시간 입력<input class="input-time" type="number"><input class="input-time-btn" type="button" value="입력">
							<div id="close-btn"><button class="close-btn">닫기</button></div>
						</div>
					</div>
					<td>${ls.subjectId}</td>
					<c:if test="${ls.stateCd eq 'ERL06'}">
					<td><img src="<c:url value='/resources/images/register/complete.png'/>" /></td>
					</c:if>
					<td><form>
							<input class="btn btn-secondary"type="button" value="승인">
						</form></td>
					<td><form>
							<input class="btn btn-secondary"type="button" value="반려" onclick="ret()">
						</form></td>
				</tr>
			</c:forEach>
		</table>
		<div class="down">
		<a href="#">
		<img class="excelimg" src="<c:url value='/resources/images/register/exceldown.png'/>" />
		</a>
		</div>
		<!-- <button class="custom-btn btn-12"><span>Click!</span><span>Read More</span></button>  -->
		<div class="test">
		<div id="paging">
		<ul class="paging">
			<li><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li><a href="#">4</a></li>
			<li><a href="#">5</a></li>
			<li><a href="#">6</a></li>
			<li><a href="#">7</a></li>
			<li><a href="#">8</a></li>
			<li><a href="#">9</a></li>
			<li><a href="#">10</a></li>
		</ul>
		</div>
		</div>
	</div>
	
	<script>
		$(function(){
			$(".modal-open").click(function(){
				$(".modal").fadeIn();
			});
			
			$(".close-btn").click(function(){
				$(".modal").fadeOut();
			});
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
	
	function ret() {
		if(confirm('수강을 반려하시겠습니까?') == true) {
			console.log('반려')
		} else {
			console.log('취소')
		}
	}
	</script>
	
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
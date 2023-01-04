<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/register/list.css'/>" />

<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	 <div> > 수강 관리 > <span class="submenu-title">수강 목록 조회</span></div>
	</div>
	<div class="card-body">
		<div class="search">
		<span>신청기간</span>
			<input class="input-date" type="date"> ~
			<input class="input-date" type="date"> 
			<select class="select-box">
				<option>수강생 명</option>
				<option>강좌 명</option>
			</select>
			<select class="select-box">
				<option>수강상태</option>
				<option>수강신청취소</option>
				<option>수강예정</option>
				<option>수강중</option>
				<option>수강취소</option>
				<option>수강신청</option>
				<option>수강완료</option>
			</select>
			<input class="input-text" type="text"
				placeholder="수강생 명 / 강좌 명을 입력해 주세요"> <input
				class="input-button" type="button" value="검색">
		</div>
		<div class="view">
		<a href="<c:url value='/enroll/insert'/>"><img src="<c:url value='/resources/images/register/add.png'/>"/></a>
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
				<th>취소/삭제</th>
				<th>승인</th>
			</tr>

			<c:forEach var="ls" items="${list}" varStatus="status">
					<div class="hd">
						<input id="stu" type="hidden" value="${ls.studentId}">
						<input id="sub" type="hidden" value="${ls.subjectId}">
						<input id="seq" type="hidden" value="${ls.subjectSeq}">
					</div>
				<tr>
					<td>${ls.regDt}</td>
					<td>${ls.name}</td>
					<td><a class="modal-open modal-open-${status.count}" onclick="showModal(${status.count});">${ls.subjectTitle}</a></td>
					<div class="modal modal-${status.count}">
						<div class="modal-content modal-content-${status.count}">
							<li style="text-align: center;">${ls.name}  |  ${ls.studentId}  |  <c:if test="${ls.stateCd eq 'ERL06'}"> 수강 완료</c:if></li>
							<br>
							<li>강좌명 | ${ls.subjectTitle}</li>
							<li>강의 시간 | ${ls.startTime} ~ ${ls.endTime} </li>
							<li>교육 기간 | ${ls.startDay} ~ ${ls.endDay} </li>
							진도율 |  <span id="ratio"></span>
							<li>현재 완료 시간  |  ${ls.completeHours}</li>
							완료한 시간 입력
							<form action="<c:url value='/enroll/addhours/${ls.studentId}/${ls.subjectId}/${ls.subjectSeq}'/>" method="post"/>
								<input name="addHours" class="input-time" type="number">
								<input type="submit" class="input-time-btn"  value="입력">
							</form>
							<div id="close-btn"><button class="close-btn">닫기</button></div>
						</div>
					</div>
					<td>${ls.subjectId}</td>
					<td>
					
					<%-- 수강 상태에 따른 현재 상태 --%>
					<c:choose>
					<c:when test="${ls.stateCd eq 'ERL01'}">
					<img src="<c:url value='/resources/images/register/ERL01.png'/>" />
					</c:when>
					<c:when test="${ls.stateCd eq 'ERL02'}">
					<img src="<c:url value='/resources/images/register/ERL02.png'/>" />
					</c:when>
					<c:when test="${ls.stateCd eq 'ERL03'}">
					<img src="<c:url value='/resources/images/register/ERL03.png'/>" />
					</c:when>
					<c:when test="${ls.stateCd eq 'ERL04'}">
					<img src="<c:url value='/resources/images/register/ERL04.png'/>" />
					</c:when>
					<c:when test="${ls.stateCd eq 'ERL05'}">
					<img src="<c:url value='/resources/images/register/ERL05.png'/>" />
					</c:when>
					<c:when test="${ls.stateCd eq 'ERL06'}">
					<img src="<c:url value='/resources/images/register/ERL06.png'/>" />
					</c:when>
					</c:choose>
					</td>
					
					<td>
					<%-- 취소 버튼이 나오는 경우 --%>
					<c:choose>
					<c:when test="${ls.stateCd eq 'ERL01' or ls.stateCd eq 'ERL03' or ls.stateCd eq 'ERL04'}">
					<button class="btn btn-secondary modal-open modal-open-${status.count}" onclick="showModal(${status.count});">취소</button>
					
					<%-- 취소 사유 모달창 --%>
					<div class="modal modal-${status.count}">
					<div class="modal-content modal-content-${status.count}">
					<span style="font-size: 1.2em;">수강 신청을 취소하시겠습니까?</span>
					<form action="<c:url value='/enroll/cancel/${ls.studentId}/${ls.subjectId}/${ls.subjectSeq}'/>" method="post" class="cacelform">
						<select name="cancelRsCd" class="cancelrs">
							<option>취소 사유</option>
								<c:forEach var="cl" items="${cancelList}">
									<option value="${cl.comnCd}">${cl.comnCdTitle}</option>	
								</c:forEach>	
						</select>
						<input type="text" name="cancelRsEtc" class="cancelrs"  placeholder="기타 입력">
						<input type="submit" value="확인" class="confirm">
					</form>
					
					<div id="close-btn">
					<button class="close-btn2">닫기</button>
					</div>
					</div>
					</div>
					</c:when>
					
					<%-- 삭제 버튼 나오는 경우  --%>
					<c:when test="${ls.stateCd eq 'ERL02' or ls.stateCd eq 'ERL05'}">
					<form>
						<input type="submit" onclick="del()" class="btn btn-secondary" value="삭제">
					</form>
					</c:when>
					</c:choose>
					</td>
					
					<td>
					<c:if test="${ls.stateCd eq 'ERL01'}">
					<form>
						<input class="btn btn-secondary"type="button"  onclick="approval()" value="승인">
					</form>
					</c:if>
					</td>
					
				</tr>	
			</c:forEach>
		</table>
		<div class="down">
		<a href="#">
		<a href="<c:url value='/enroll/download'/>"><img class="excelimg" src="<c:url value='/resources/images/register/exceldown.png'/>" /></a>
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
 		function showModal(i){
 			var openBtnClassName = ".modal-open-" + i;
 			var modalClassName = ".modal-" + i; 
			$(openBtnClassName).click(function(){
				$(modalClassName).fadeIn();
			});
			
			$(".close-btn").click(function(){
				$(".modal").fadeOut();
			});
			$(".close-btn2").click(function(){
				$(".modal").fadeOut();
			});
		};
	</script>
	
	<script>
		$('.modal-open').click(function() {
			var studentId = $("#stu").val();
			console.log(studentId);
			var subjectId = $("#sub").val();
			var subjectSeq = $("#seq").val();
			var ratioEl = $("#ratio");
			$.ajax({
				url: "ratio/" + studentId + "/" + subjectId + "/" + subjectSeq,
				success: function(data) {
					console.log(data);
					ratioEl.text(data + '%');
				}
			});
		})
	</script>
	
	<script>
		function del() {
			var studentId = $("#stu").val();
			var subjectId = $("#sub").val();
			var subjectSeq = $("#seq").val();
		
		if(confirm('수강 정보를 삭제하시겠습니까?')) {
			$.ajax({
				type : "POST", 
				url : "enroll/del/" + studentId + "/" + subjectId + "/" + subjectSeq
			})
			
		} else {
			return false;
		}
	}
	</script>
	
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
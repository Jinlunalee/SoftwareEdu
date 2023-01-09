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
		
		<%-- 수강 검색  --%>
		<div class="search">
		<span>신청기간</span>
		<form name="sc-form">
			<input type="date" name="applyStartDay" class="input-date"> ~
			<input type="date" name="applyEndDay"class="input-date">
			
			<%-- 수강생 선택 --%>
			<select name="student" class="select-box">
				<option value="">수강생 선택</option>
				<option value="sdName">수강생 명</option>
				<option value="sdId">수강생 아이디</option>
			</select>
			<input type="text" name="keyword1" class="input-text"  placeholder="수강생 명을 입력해 주세요">
			
			<%-- 강좌 과정 선택 --%>
			<select name="course">
				<option value="">강좌/과정</option>
				<option value="sj">강좌</option>
				<option value="cs">과정</option>
			</select>
			<input type="text" name="keyword2" class="input-text"  placeholder="강좌 명을 입력해 주세요">
			
			<%-- 수강 상태 선택 --%>
			<select name="state" class="select-box">
				<option value="">수강 상태</option>
				<option value="applyCancel">수강 신청 취소</option>
				<option value="expect">수강 예정</option>
				<option value="progress">수강 중</option>
				<option value="cancel">수강 취소</option>
				<option value="apply">수강 신청</option>
				<option value="complete">수강 완료</option>
			</select>
			<input type="submit" onclick="search()" class="input-button" value="검색">
			</form>
		</div>
		
		<%-- 뷰 갯수 --%>
		<div class="view">
			<button type="button" class="btn btn-outline-secondary" onclick="location.href ='<c:url value="/enroll/insert"/>'">수강 추가</button>
			<select class="select-view" onchange="if(this.value) location.href=(this.value);">
				<option value="<c:url value="/enroll/boardList?pageNo=1"/>">선택</option>
				<option value="<c:url value="/enroll/boardList?pageNo=1&rowsPerPage=10"/>">10개</option>
				<option value="<c:url value="/enroll/boardList?pageNo=1&rowsPerPage=30"/>">30개</option>
				<option value="<c:url value="/enroll/boardList?pageNo=1&rowsPerPage=50"/>">50개</option>
			</select>
		</div>

		<%-- 목록 --%>
		<table class="list">
			<tr>
				<th>신청일자</th>
				<th>수강생 명</th>
				<th>강좌 명</th>
				<th>강좌아이디</th>
				<th>과정 명</th>
				<th>과정 아이디</th>
				<th>현재 상태</th>
				<th>취소/삭제</th>
				<th>승인</th>
			</tr>

			<c:forEach var="searchList" items="${searchList}" varStatus="status">
				<tr>
					<td>${searchList.regDt}</td>
					<td>${searchList.name}</td>
					<td><a class="modal-open modal-open-${status.count}" onclick="showModal(${status.count}); rto('${searchList.studentId}', '${searchList.subjectId}', '${searchList.subjectSeq}');">${searchList.subjectTitle}</a></td>
					<div class="modal modal-${status.count}">
						<div class="modal-content modal-content-${status.count}">
							<li style="text-align: center;">${searchList.name}  |  ${searchList.studentId}  |  
							<c:choose>
								<c:when test="${searchList.stateCd eq 'ERL01'}">수강 신청</c:when>
								<c:when test="${searchList.stateCd eq 'ERL02'}">수강 신청 취소</c:when>
								<c:when test="${searchList.stateCd eq 'ERL03'}">수강 예정</c:when>
								<c:when test="${searchList.stateCd eq 'ERL04'}">수강 중</c:when>
								<c:when test="${searchList.stateCd eq 'ERL05'}">수강 취소</c:when>
								<c:when test="${searchList.stateCd eq 'ERL06'}">수강 완료</c:when>
							</c:choose>
							</li>
							<br>
							<li>강좌명 | ${searchList.subjectTitle}</li>
							<li>강의 시간 | ${searchList.startTime} ~ ${searchList.endTime} </li>
							<li>교육 기간 | ${searchList.startDay} ~ ${searchList.endDay} </li>
							<span>진도율 | </span><span class="rt"></span>
							<li>현재 완료 시간  | ${searchList.completeHours}</li>
							완료한 시간 입력
							<form action="<c:url value='/enroll/addhours/${searchList.studentId}/${searchList.subjectId}/${searchList.subjectSeq}'/>" method="post"/>
								<input name="addHours" class="input-time" type="number">
								<input type="submit" onclick="getHours(${searchList.enrollId})" class="input-time-btn"  value="입력">
							</form>
							<div id="close-btn"><button class="close-btn">닫기</button></div>
						</div>
					</div>
					<td>${searchList.subjectId}</td>
					<td>${searchList.courseTitle}</td>
					<td>${searchList.courseId}</td>
					<td>
					
					<%-- 수강 상태에 따른 현재 상태 --%>
					<c:choose>
					<c:when test="${searchList.stateCd eq 'ERL01'}">
					<img src="<c:url value='/resources/images/register/ERL01.png'/>" />
					</c:when>
					<c:when test="${searchList.stateCd eq 'ERL02'}">
					<img src="<c:url value='/resources/images/register/ERL02.png'/>" />
					</c:when>
					<c:when test="${searchList.stateCd eq 'ERL03'}">
					<img src="<c:url value='/resources/images/register/ERL03.png'/>" />
					</c:when>
					<c:when test="${searchList.stateCd eq 'ERL04'}">
					<img src="<c:url value='/resources/images/register/ERL04.png'/>" />
					</c:when>
					<c:when test="${searchList.stateCd eq 'ERL05'}">
					<img src="<c:url value='/resources/images/register/ERL05.png'/>" />
					</c:when>
					<c:when test="${searchList.stateCd eq 'ERL06'}">
					<img src="<c:url value='/resources/images/register/ERL06.png'/>" />
					</c:when>
					</c:choose>
					</td>
					
					<td>
					<%-- 취소 버튼이 나오는 경우 --%>
					<c:choose>
					<c:when test="${searchList.stateCd eq 'ERL01' or searchList.stateCd eq 'ERL03' or searchList.stateCd eq 'ERL04'}">
					<button class="btn btn-secondary modal-open modal-open2-${status.count}" onclick="showModal2(${status.count});">취소</button>
					
					<%-- 취소 사유 모달창 --%>
					<div class="modal2 modal2-${status.count}">
					<div class="modal-content2 modal-content2-${status.count}">
					<span style="font-size: 1.2em;">수강 신청을 취소하시겠습니까?</span>
					<form action="<c:url value='/enroll/cancel/${searchList.studentId}/${searchList.subjectId}/${searchList.subjectSeq}'/>" method="post" class="cacelform">
						<select name="cancelRsCd" class="cancelrs">
							<option>취소 사유</option>
								<c:forEach var="cl" items="${cancelList}">
									<option value="${cl.comnCd}">${cl.comnCdTitle}</option>	
								</c:forEach>	
						</select>
						<input type="text" name="cancelRsEtc" class="cancelrs"  placeholder="기타 입력">
						<input type="submit" value="확인" class="confirm">
					</form>
					
					<div id="close-btn2">
					<button class="close-btn2">닫기</button>
					</div>
					</div>
					</div>
					</c:when>
					
					<%-- 삭제 버튼 나오는 경우  --%>
					<c:when test="${searchList.stateCd eq 'ERL02' or searchList.stateCd eq 'ERL05'}">
					<form>
						<input type="submit" onclick="del('${searchList.studentId}', '${searchList.subjectId}', '${searchList.subjectSeq}')" class="btn btn-secondary" value="삭제">
					</form>
					</c:when>
					</c:choose>
					</td>
					
					<td>
					<c:if test="${searchList.stateCd eq 'ERL01'}">
						<form>
						<input type="submit" class="btn btn-secondary" onclick="approval('${searchList.studentId}', '${searchList.subjectId}', '${searchList.subjectSeq}')" value="승인">
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
		};
		
		function showModal2(i){
 			var openBtnClassName = ".modal-open2-" + i;
 			var modalClassName = ".modal2-" + i; 
			$(openBtnClassName).click(function(){
				$(modalClassName).fadeIn();
			});

			$(".close-btn2").click(function(){
				$(".modal2").fadeOut();
			});
		};
	</script>
	
	<script>
		function rto(studentId, subjectId, subjectSeq) {
			var ratioEl = $(".rt");
			$.ajax({
				url: "ratio/" + studentId + "/" + subjectId + "/" + subjectSeq,
				success: function(data) {
					ratioEl.text(data + '%');
				}
			});
		}
	</script>
	
	<script>
		function del(studentId, subjectId, subjectSeq) {
		
		if(confirm('수강 정보를 삭제하시겠습니까?')) {
			$.ajax({
				type : "POST", 
				url : "del/" + studentId + "/" + subjectId + "/" + subjectSeq
			})
			
		} else {
			return false;
		}
	}
	</script>
	
	<script>
			function approval(studentId, subjectId, subjectSeq) {
				if(confirm('수강 신청을 승인하시겠습니까?')) {
					$.ajax({
						url : "approval/" + studentId + "/" + subjectId + "/" + subjectSeq
					})
				}
				else{
				}
			}
	</script>
	
	<script>
			function getHours(enrollId) {
				var ch = $(".ch");
					$.ajax({
						url : "gethours" + enrollId,
						success: function(data) {
						ch.text(data + '시간');
					}
					})
			}
	</script>
	
	<script>
		function search() {
			$.ajax({
				type : 'POST',
				url : 'searchlist',
				async : false,
				data : $("form[name=sc-form]").serialize(),
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success : function(result){
				}
			})
		}
	</script>
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
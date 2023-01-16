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
		<span id="applyperiod">신청기간</span>
		<form name="sc-form" action="<c:url value='/enroll/searchlist'/>">
			<input type="date" name="applyStartDay" class="input-date" value="${enroll.applyStartDay}"> ~
			<input type="date" name="applyEndDay"class="input-date" value="${enroll.applyEndDay}">
			
			<%-- 수강생 선택 --%>
			<select name="student" class="select-box">
				<c:if test="${enroll.student eq ''}">
				<option value="">이름/아이디</option>
				<option value="sdName">수강생 명</option>
				<option value="sdId">수강생 아이디</option>
				</c:if>
				
				<c:if test="${enroll.student eq 'sdName'}">
				<option value="">이름/아이디</option>
				<option selected="selected" value="sdName">수강생 명</option>
				<option value="sdId">수강생 아이디</option>
				</c:if>
				
				<c:if test="${enroll.student eq 'sdId'}">
				<option value="">이름/아이디</option>
				<option value="sdName">수강생 명</option>
				<option selected="selected" value="sdId">수강생 아이디</option>
				</c:if>
				
			</select>
			<input type="text" name="keyword1" class="input-text" value="${enroll.keyword1}">
			
			<%-- 강좌 과정 선택 --%>
			<select name="course" class="select-box">
				<c:if test="${enroll.course eq ''}">
				<option value="">강좌/과정</option>
				<option value="sj">강좌</option>
				<option value="cs">과정</option>
				</c:if>
				
				<c:if test="${enroll.course eq 'sj'}">
				<option value="">강좌/과정</option>
				<option selected="selected" value="sj">강좌</option>
				<option value="cs">과정</option>
				</c:if>
				
				<c:if test="${enroll.course eq 'cs'}">
				<option value="">강좌/과정</option>
				<option value="sj">강좌</option>
				<option selected="selected" value="cs">과정</option>
				</c:if>
				
			</select>
			<input type="text" name="keyword2" class="input-text" value="${enroll.keyword2}">
			
			<%-- 수강 상태 선택 --%>
			<select name="state" class="select-box">
				<c:if test="${enroll.state eq ''}">
				<option value="">수강 상태</option>
				<option value="applyCancel">수강 신청 취소</option>
				<option value="expect">수강 예정</option>
				<option value="progress">수강 중</option>
				<option value="cancel">수강 취소</option>
				<option value="apply">수강 신청</option>
				<option value="complete">수강 완료</option>
				</c:if>
				
				<c:if test="${enroll.state eq 'applyCancel'}">
				<option value="">수강 상태</option>
				<option selected="selected" value="applyCancel">수강 신청 취소</option>
				<option value="expect">수강 예정</option>
				<option value="progress">수강 중</option>
				<option value="cancel">수강 취소</option>
				<option value="apply">수강 신청</option>
				<option value="complete">수강 완료</option>
				</c:if>
				
				<c:if test="${enroll.state eq 'expect'}">
				<option value="">수강 상태</option>
				<option value="applyCancel">수강 신청 취소</option>
				<option selected="selected" value="expect">수강 예정</option>
				<option value="progress">수강 중</option>
				<option value="cancel">수강 취소</option>
				<option value="apply">수강 신청</option>
				<option value="complete">수강 완료</option>
				</c:if>
				
				<c:if test="${enroll.state eq 'progress'}">
				<option value="">수강 상태</option>
				<option value="progress">수강 신청 취소</option>
				<option value="expect">수강 예정</option>
				<option selected="selected" value="progress">수강 중</option>
				<option value="cancel">수강 취소</option>
				<option value="apply">수강 신청</option>
				<option value="complete">수강 완료</option>
				</c:if>
				
				<c:if test="${enroll.state eq 'cancel'}">
				<option value="">수강 상태</option>
				<option value="applyCancel">수강 신청 취소</option>
				<option value="expect">수강 예정</option>
				<option value="progress">수강 중</option>
				<option selected="selected" value="cancel">수강 취소</option>
				<option value="apply">수강 신청</option>
				<option value="complete">수강 완료</option>
				</c:if>
				
				<c:if test="${enroll.state eq 'apply'}">
				<option value="">수강 상태</option>
				<option value="applyCancel">수강 신청 취소</option>
				<option value="expect">수강 예정</option>
				<option value="progress">수강 중</option>
				<option value="cancel">수강 취소</option>
				<option selected="selected" value="apply">수강 신청</option>
				<option value="complete">수강 완료</option>
				</c:if>
				
				<c:if test="${enroll.state eq 'complete'}">
				<option value="">수강 상태</option>
				<option value="applyCancel">수강 신청 취소</option>
				<option value="expect">수강 예정</option>
				<option value="progress">수강 중</option>
				<option value="cancel">수강 취소</option>
				<option value="apply">수강 신청</option>
				<option selected="selected" value="complete">수강 완료</option>
				</c:if>
				
			</select>
			<input type="submit" class="input-button" value="검색">
			</form>
		</div>
		
		<div class="list_top">
			<div class="cnt">
			전체목록 <b class="basic_txt_color">${pager.totalRows}</b>개,
			페이지<b class="basic_txt_color"> ${pager.pageNo} </b> / ${pager.totalPageNo}
			<div>
			[검색 결과] &nbsp;
			* 신청 기간 : ${enroll.applyStartDay} - ${enroll.applyEndDay} &nbsp; &nbsp; &nbsp; 
			* 이름, 아이디 : ${enroll.keyword1} &nbsp; &nbsp; &nbsp;
			* 강좌 명, 아이디 : ${enroll.keyword2} &nbsp; &nbsp; &nbsp;
			* 수강 상태 :
			<c:if test="${enroll.state eq 'applyCancel'}">수강 신청 취소</c:if>
			<c:if test="${enroll.state eq 'expect'}">수강 예정</c:if>
			<c:if test="${enroll.state eq 'progress'}">수강 중</c:if>
			<c:if test="${enroll.state eq 'cancel'}">수강 취소</c:if>
			<c:if test="${enroll.state eq 'apply'}">수강 신청</c:if>
			<c:if test="${enroll.state eq 'complete'}">수강 완료</c:if>		
			</div>
			<%-- 뷰 갯수 --%>
			<div class="view">
				<button type="button" class="btn btn-outline-secondary" onclick="location.href ='<c:url value="/enroll/insert"/>'">수강 추가</button>
				<select class="select-view" onchange="if(this.value) location.href=(this.value);">
					<option value="<c:url value="/enroll/searchlist?pageNo=1&applyStartDay=${enroll.applyStartDay}&applyEndDay=${enroll.applyEndDay}&student=${enroll.student}&keyword1=${enroll.keyword1}&course=${enroll.course}&keyword2=${enroll.keyword2}&state=${enroll.state}"/>">선택</option>
					<option value="<c:url value="/enroll/searchlist?pageNo=1&rowsPerPage=10&applyStartDay=${enroll.applyStartDay}&applyEndDay=${enroll.applyEndDay}&student=${enroll.student}&keyword1=${enroll.keyword1}&course=${enroll.course}&keyword2=${enroll.keyword2}&state=${enroll.state}"/>">10개</option>
					<option value="<c:url value="/enroll/searchlist?pageNo=1&rowsPerPage=30&applyStartDay=${enroll.applyStartDay}&applyEndDay=${enroll.applyEndDay}&student=${enroll.student}&keyword1=${enroll.keyword1}&course=${enroll.course}&keyword2=${enroll.keyword2}&state=${enroll.state}"/>">30개</option>
					<option value="<c:url value="/enroll/searchlist?pageNo=1&rowsPerPage=50&applyStartDay=${enroll.applyStartDay}&applyEndDay=${enroll.applyEndDay}&student=${enroll.student}&keyword1=${enroll.keyword1}&course=${enroll.course}&keyword2=${enroll.keyword2}&state=${enroll.state}"/>">50개</option>
				</select>
			</div>
		</div>

		<%-- 목록 --%>
		<table class="list">

			<tr>
				<th>강좌 명 (과정 명)</th>
				<th>수강생 명 (아이디)</th>
				<th>신청일자</th>
				<th>현재 상태 (진도율)</th>
				<th>취소 사유</th>
				<th>취소</th>
				<th>삭제</th>
				<th>승인</th>
			</tr>

			<!-- 리스트 -->
			<c:forEach var="board" items="${boardList}" varStatus="status">
				<tr>
					<td><a class="modal-open modal-open-${status.count}" onclick="showModal(${status.count}); rto('${board.studentId}', '${board.subjectId}', '${board.subjectSeq}');">
					${board.subjectTitle} 
					<!-- 과정명  --> 
					<c:if test="${not empty board.courseTitle}">(${board.courseTitle})</c:if>
					</a>
					</td>
					<!-- 수강생 명 -->
					<td>${board.name} (${board.studentId})</td>
					<!-- 신청일자 -->
					<td>${board.regDt}</td>
					
					<td>${board.stateCdTitle} 
					<!-- 현재 상태 옆에 진도율 -->
					<c:if test="${board.stateCdTitle eq '수강중'}">
					<span id="getBoardRatio" onclick="rtoLoad('${board.studentId}', '${board.subjectId}', '${board.subjectSeq}')"></span>
					(<span class="boardRatio">
					</c:if>
					</td>
					
					<td>
					<c:if test="${board.stateCdTitle eq '수강취소'}">
						${board.cancelRsTitle}
					</c:if>
					</td>
					
					<!-- 버튼  -->
					<td> <!-- 취소 버튼 -->
					<c:if test="${(board.stateCdTitle eq '수강신청') or (board.stateCdTitle eq '수강예정') or (board.stateCdTitle eq '수강중') }">
								<button class="btn btn-secondary modal-open modal-open2-${status.count}" onclick="showModal2(${status.count});">취소</button>
									<%-- 취소 사유 모달창 --%>
									<div class="modal2 modal2-${status.count}">
										<div class="modal-content2 modal-content2-${status.count}">
											<span style="font-size: 1.2em;">취소하시겠습니까?</span>
											<form action="<c:url value='/enroll/cancel/${board.studentId}/${board.subjectId}/${board.subjectSeq}'/>" method="post" class="cacelform">
												<select name="cancelRsCd" class="cancelrs">
													<option>취소 사유</option>
													<c:forEach var="cancel" items="${cancelList}">
														<option value="${cancel.comnCd}">${cancel.comnCdTitle}</option>	
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
					</c:if>
					</td>
					
					<td> <!-- 삭제 버튼 -->
					<c:if test="${board.stateCdTitle eq '수강취소'}">
						<form>
							<input type="submit" onclick="del('${board.studentId}', '${board.subjectId}', '${board.subjectSeq}')" class="btn btn-secondary" value="삭제">
						</form>
					</c:if>
					</td>
					
					<td> <!-- 승인 버튼 -->
					<c:if test="${(board.stateCdTitle eq '수강신청') and (board.openStateCdTitle eq '모집마감')}">
						<form>
							<input type="submit" class="btn btn-secondary" onclick="approval('${board.studentId}', '${board.subjectId}', '${board.subjectSeq}')" value="승인">
						</form>
					</c:if>
					</td>
				</tr>	
			</c:forEach>

				<!-- paging -->
				<tr>
					<td colspan="4" class="text-center">
						<div>
							<a class="btn btn-outline-primary btn-sm" href="searchlist?pageNo=1&applyStartDay=${enroll.applyStartDay}&applyEndDay=${enroll.applyEndDay}&student=${enroll.student}&keyword1=${enroll.keyword1}&course=${enroll.course}&keyword2=${enroll.keyword2}&state=${enroll.state}">처음</a>
							<c:if test="${pager.groupNo>1}">
								<a class="btn btn-outline-info btn-sm" href="searchlist?pageNo=${pager.startPageNo-1}&rowsPerPage=${pager.rowsPerPage}&applyStartDay=${enroll.applyStartDay}&applyEndDay=${enroll.applyEndDay}&student=${enroll.student}&keyword1=${enroll.keyword1}&course=${enroll.course}&keyword2=${enroll.keyword2}&state=${enroll.state}">이전</a>
							</c:if>
							
							<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
								<c:if test="${pager.pageNo != i}">
									<a class="btn btn-outline-success btn-sm" href="searchlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&applyStartDay=${enroll.applyStartDay}&applyEndDay=${enroll.applyEndDay}&student=${enroll.student}&keyword1=${enroll.keyword1}&course=${enroll.course}&keyword2=${enroll.keyword2}&state=${enroll.state}">${i}</a>
								</c:if>
								<c:if test="${pager.pageNo == i}">
									<a class="btn btn-danger btn-sm" href="searchlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&applyStartDay=${enroll.applyStartDay}&applyEndDay=${enroll.applyEndDay}&student=${enroll.student}&keyword1=${enroll.keyword1}&course=${enroll.course}&keyword2=${enroll.keyword2}&state=${enroll.state}">${i}</a>
								</c:if>
							</c:forEach>
							
							<c:if test="${pager.groupNo<pager.totalGroupNo}">
								<a class="btn btn-outline-info btn-sm" href="searchlist?pageNo=${pager.endPageNo+1}&rowsPerPage=${pager.rowsPerPage}&applyStartDay=${enroll.applyStartDay}&applyEndDay=${enroll.applyEndDay}&student=${enroll.student}&keyword1=${enroll.keyword1}&course=${enroll.course}&keyword2=${enroll.keyword2}&state=${enroll.state}">다음</a>
							</c:if>
							<a class="btn btn-outline-primary btn-sm" href="searchlist?pageNo=${pager.totalPageNo}&rowsPerPage=${pager.rowsPerPage}&applyStartDay=${enroll.applyStartDay}&applyEndDay=${enroll.applyEndDay}&student=${enroll.student}&keyword1=${enroll.keyword1}&course=${enroll.course}&keyword2=${enroll.keyword2}&state=${enroll.state}">맨끝</a>
						</div>
					</td>
				</tr>		
		</table>
		<div class="down">
			<a href="#">
			<a href="<c:url value='#'/>"><img class="excelimg" src="<c:url value='/resources/images/register/exceldown.png'/>" /></a>
		</a>
		</div>
		<!-- <button class="custom-btn btn-12"><span>Click!</span><span>Read More</span></button>  -->
	</div>
	<!-- <script>
		$(document).ready(function(){
			$("#getBoardRatio").trigger('click');
		});
	</script> -->
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
		function rtoLoad(studentId, subjectId, subjectSeq) {
			var boardRatioEl = $(".boardRatio");
			$.ajax({
				url: "ratio/" + studentId + "/" + subjectId + "/" + subjectSeq,
				success: function(data) {
					boardRatioEl.text(data + '%)');
				}
			});
		}
	</script>
	
	<script>
		function del(studentId, subjectId, subjectSeq) {
			event.preventDefault();
		if(confirm('수강 정보를 삭제하시겠습니까?')) {
			$.ajax({
				type : "GET",
				url : "del/" + studentId + "/" + subjectId + "/" + subjectSeq,
				success : function(data) {
					document.location.href = document.location.href;
				}
			})
			
		} else {
			return false;
		}
	}
	</script>
	
	<script>
			function approval(studentId, subjectId, subjectSeq) {
				event.preventDefault();
				if(confirm('수강 신청을 승인하시겠습니까?')) {
					$.ajax({
						url : "approval/" + studentId + "/" + subjectId + "/" + subjectSeq,
						success : function(data) {
							document.location.href = document.location.href;
						}
					})
				}
				else{
				}
			}
	</script>
	
	<%--

	
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
	</script>  --%>
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
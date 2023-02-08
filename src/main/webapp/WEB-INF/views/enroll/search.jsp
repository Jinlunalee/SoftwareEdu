<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/student/list.css'/>"/>

<div class="card">
	<div class="card-header">
		<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
		<div>
			> 수강 관리 > <span class="submenu-title">수강 목록 조회</span>
		</div>
	</div>
	<div class="card-body">

		<%-- 수강 검색  --%>
		<div class="search">
			<form name="sc-form" action="<c:url value='/enroll/searchlist'/>">
				<div class="search-first-row search-row">
					<%--신청 기간 선택 --%>
					<div class="apply-period search-section">
						<span class="search-section-title">신청기간</span>
						<div class="search-section-content">
							<input type="date" name="applyStartDay" class="input-date input-box" id="applyStartDay" value="${applyStartDay}"> ~ 
							<input type="date" name="applyEndDay" class="input-date input-box" id="applyEndDay" value="${applyEndDay}">
						</div>
					</div>

					<%-- 강좌 과정 선택 --%>
					<div class="select-subcor search-section">
						<span class="search-section-title">개설강좌/개설과정</span>
						<div class="search-section-content">
							<select name="course" class="select-box input-box">
								<option value="sj" ${course eq 'sj' ? "selected" : ""}>개설강좌명</option>
								<option value="cs" ${course eq 'cs' ? "selected" : ""}>개설과정명</option>
							</select>
							<input type="text" name="keyword2" class="input-text input-box" value="${keyword2}">
						</div>
					</div>

					<%-- 수강생 선택 --%>
					<div class="selectstudent search-section">
						<span class="search-section-title">수강생</span>
						<div class="search-section-content">
							<select name="student" class="select-box select-stu input-box">
									<option value="sdName" ${student eq 'sdName' ? "selected" : ""}>수강생명</option>
									<option value="sdId" ${student eq 'sdId' ? "selected" : ""}>수강생아이디</option>
							</select>
							<input type="text" name="keyword1" class="input-text input-student input-box" value="${keyword1}">
						</div>
					</div>

					<%-- 수강 상태 선택 --%>
					<div class="state search-section">
						<span class="search-section-title">수강상태</span>
						<div class="search-section-content">
							<select id="enroll-state" name="state" class="select-box input-box" style="width: 150px;">
								<option value="">전체</option>
								<option value="expect" ${state eq 'expect' ? "selected" : ""}>수강 예정</option>
								<option value="progress" ${state eq 'progress' ? "selected" : ""}>수강 중</option>
								<option value="cancel" ${state eq 'cancel' ? "selected" : ""}>수강 취소</option>
								<option value="apply" ${state eq 'apply' ? "selected" : ""}>수강 신청</option>
								<option value="complete" ${state eq 'complete' ? "selected" : ""}>수강 완료</option>
							</select>
						</div>
					</div>

					<input type="submit" class="input-button btn btn-outline-secondary" value="검색">

				</div>
			</form>
		</div>

		<div class="view">
			<button type="button" class="btn btn-outline-secondary" onclick="location.href ='<c:url value="/enroll/insert"/>'">수강추가</button>
			<select class="select-view" onchange="if(this.value) location.href=(this.value);">
				<option value="">선택</option>
				<option ${rowsPerPages eq 10 ? "selected" : ""} value="<c:url value="/enroll/searchlist?pageNo=1&rowsPerPage=10&applyStartDay=${applyStartDay}&applyEndDay=${applyEndDay}&student=${student}&keyword1=${keyword1}&course=${course}&keyword2=${keyword2}&state=${state}"/>">10개</option>
				<option ${rowsPerPages eq 30 ? "selected" : ""} value="<c:url value="/enroll/searchlist?pageNo=1&rowsPerPage=30&applyStartDay=${applyStartDay}&applyEndDay=${applyEndDay}&student=${student}&keyword1=${keyword1}&course=${course}&keyword2=${keyword2}&state=${state}"/>">30개</option>
				<option ${rowsPerPages eq 50 ? "selected" : ""} value="<c:url value="/enroll/searchlist?pageNo=1&rowsPerPage=50&applyStartDay=${applyStartDay}&applyEndDay=${applyEndDay}&student=${student}&keyword1=${keyword1}&course=${course}&keyword2=${keyword2}&state=${state}"/>">50개</option>
			</select>
		</div>

		<%-- list table --%>
		<div id="list-wrap">
			<div class="list_top">
				<div class="cnt">
					전체목록 <b class="basic_txt_color">${pager.totalRows}</b>개, 
					<c:if test="${pager.totalRows eq 0}">
						페이지<b class="basic_txt_color"> 1</b> / 1
					</c:if>
					<c:if test="${pager.totalRows ne 0}">
						페이지<b class="basic_txt_color"> ${pager.pageNo}</b> / ${pager.totalPageNo}
					</c:if>
				</div>
			</div>

			<%-- 목록 --%>
			<table class="list">
				<thead>
					<tr>
						<th>강좌 명 (과정 명)</th>
						<th>수강생 명 (아이디)</th>
						<th>신청 일자</th>
						<th>수강 상태</th>
						<th>취소</th>
						<th>삭제</th>
						<th>승인</th>
					</tr>
				</thead>

				<%-- 리스트 --%>
				<tbody>
					<c:if test="${boardListSize ne 0}">
						<c:forEach var="board" items="${boardList}" varStatus="status">
							<tr>
								<td>
									<a href="<c:url value='/enroll/details/${board.enrollId}'/>">${board.subjectTitle}
								
									<%-- 과정명  --%> 
									<c:if test="${not empty board.courseTitle}">
										(${board.courseTitle})
									</c:if></a>
								</td>
								
								<%-- 수강생 명 --%>
								<td>${board.name} (${board.userId})</td>
								
								<%-- 신청일자 --%>
								<td>${board.enrollDt}</td>

								<%-- 현재 상태 옆에 (진도율 / 취소사유) --%>
								<td>
									${board.stateCdTitle}
									<c:if test="${board.stateCdTitle eq '수강중'}">
										(${board.ratio}%)
									</c:if>
									<c:if test="${board.stateCdTitle eq '수강취소' && !empty board.cancelRsTitle}">
										(${board.cancelRsTitle})
									</c:if>
								</td>

								<%-- 버튼  --%>
								<td>
									<%-- 취소 버튼 --%>
									<c:if test="${(board.stateCdTitle eq '수강신청') or (board.stateCdTitle eq '수강예정') or (board.stateCdTitle eq '수강중') }">
										<button class="btn btn-secondary modal-open modal-open-${status.count}" onclick="showModal(${status.count});">취소</button>
										<%-- 취소 사유 모달창 --%>
										<div class="modal-background modal-background-${status.count}">
											<div class="modal show modal-${status.count}">
												<div class="modal-content modal-content-${status.count}">
													<!-- <img class="cancel-img" src="/resources/images/survey/survey_question.png"> -->
													<span id="cancelId">취소하시겠습니까?</span>
													<form action="<c:url value='/enroll/cancel/${board.studentId}/${board.subjectId}/${board.subjectSeq}'/>" method="post" class="cacelform">
														<div class="modal-items">
															<select id="selectCancel-${status.count}" name="cancelRsCd" class="cancelrs modal-item"  onchange="cancel(${status.count}); this.onclick=null;">
																<option value="cancelDefault">취소 사유 선택</option>
																<c:forEach var="cancel" items="${cancelList}">
																	<option value="${cancel.comnCd}">${cancel.comnCdTitle}</option>
																</c:forEach>
															</select>
															<!-- <input type="text" name="cancelRsEtc" class="cancelrs" placeholder="기타 입력"> -->
															<span id="cancelRsEtc-${status.count}"></span>
														</div>
														<div class="modal-btns">
															<input id="cancelConfirmBtn-${status.count}" type="submit" style = "display: none;" value="확인" class="modal-btn confirm-btn">
															<button type="button" class="modal-btn close-btn close-btn-${status.count}">닫기</button>
														</div>
													</form>
												</div>
											</div>
										</div>
									</c:if>
								</td>

								<td>
									<%-- 삭제 버튼 --%>
									<c:if test="${board.stateCdTitle eq '수강취소'}">
										<form>
											<input type="submit" onclick="del('${board.studentId}', '${board.subjectId}', '${board.subjectSeq}')" class="btn btn-secondary" value="삭제">
										</form>
									</c:if>
								</td>

								<td>
									<%-- 승인 버튼 --%>
									<c:if test="${(board.stateCdTitle eq '수강신청') and (board.openStateCdTitle eq '모집마감')}">
										<form>
											<input type="submit" class="btn btn-secondary" onclick="approval('${board.studentId}', '${board.subjectId}', '${board.subjectSeq}')" value="승인">
										</form>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
			
			<c:if test="${boardListSize eq 0}">
				<div class="table-empty" style="text-align: center">
					게시물이 없습니다.
				</div>
			</c:if>

			<div class="bottoms">
				<%-- paging --%>
				<c:if test="${pager.totalRows ne 0}">
				<div id="paging">
					<ul class="paging">
						<li><a href="searchlist?pageNo=1&applyStartDay=${applyStartDay}&applyEndDay=${applyEndDay}&student=${student}&keyword1=${keyword1}&course=${course}&keyword2=${keyword2}&state=${state}">처음</a></li>
						<c:if test="${pager.groupNo>1}">
							<li><a href="searchlist?pageNo=${pager.startPageNo-1}&rowsPerPage=${pager.rowsPerPage}&applyStartDay=${applyStartDay}&applyEndDay=${applyEndDay}&student=${student}&keyword1=${keyword1}&course=${course}&keyword2=${keyword2}&state=${state}">이전</a></li>
						</c:if>

						<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
							<c:if test="${pager.pageNo != i}">
								<li><a href="searchlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&applyStartDay=${applyStartDay}&applyEndDay=${applyEndDay}&student=${student}&keyword1=${keyword1}&course=${course}&keyword2=${keyword2}&state=${state}">${i}</a></li>
							</c:if>
							<c:if test="${pager.pageNo == i}">
								<li><a href="searchlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&applyStartDay=${applyStartDay}&applyEndDay=${applyEndDay}&student=${student}&keyword1=${keyword1}&course=${course}&keyword2=${keyword2}&state=${state}">${i}</a></li>
							</c:if>
						</c:forEach>

						<c:if test="${pager.groupNo<pager.totalGroupNo}">
							<li><a href="searchlist?pageNo=${pager.endPageNo+1}&rowsPerPage=${pager.rowsPerPage}&applyStartDay=${applyStartDay}&applyEndDay=${applyEndDay}&student=${student}&keyword1=${keyword1}&course=${course}&keyword2=${keyword2}&state=${state}">다음</a></li>
						</c:if>
						<li><a href="searchlist?pageNo=${pager.totalPageNo}&rowsPerPage=${pager.rowsPerPage}&applyStartDay=${applyStartDay}&applyEndDay=${applyEndDay}&student=${student}&keyword1=${keyword1}&course=${course}&keyword2=${keyword2}&state=${state}">맨끝</a></li>
					</ul>
				</div>
				</c:if>
				
				<%-- 엑셀 파일 다운로드 --%>
				<div class="down">
					<a href="<c:url value='/enroll/enrollsearchexcel?pageNo=${pager.pageNo}&rowsPerPage=${pager.rowsPerPage}&applyStartDay=${applyStartDay}&applyEndDay=${applyEndDay}
					&course=${course}&keyword2=${keyword2}&student=${student}&keyword1=${keyword1}&state=${state}'/>">
						<img class="excelimg" src="<c:url value='/resources/images/register/exceldown.png'/>"/>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>

<script>

	const applyStartDay = $('#applyStartDay').val();
	const applyEndDay = $('#applyEndDay').val();
	const course = $('select[name=course]').val();
	const keyword2 = $('input[name=keyword2]').val();
	const student = $('select[name=student]').val();
	const keyword1 = $('input[name=keyword1]').val();
	const state = $('select[name=state]').val();
	
	if (applyStartDay === '') {
		const today1 = new Date();
		const oneYearAgo = new Date(today1.setFullYear(today1.getFullYear() - 1));
		const startDay = formatDate(oneYearAgo);
		console.log("startDay : " + startDay);
		document.getElementById('applyStartDay').value = startDay
	}

	if (applyEndDay === '') {
		const today2 = new Date();
		console.log("today2 : " + today2);
		const endDay = formatDate(today2);
		console.log("endDay : " + endDay);
		document.getElementById('applyEndDay').value = endDay
	}

	function formatDate(date) {
		var dt = date;
		var year = dt.getFullYear();
		var month = dt.getMonth() + 1 > 9 ? dt.getMonth() + 1 : '0' + (dt.getMonth() + 1);
		var day = dt.getDate() > 9 ? dt.getDate() : '0' + dt.getDate();

		return [year, month, day].join('-');
	}

	const body = document.querySelector('body');
	/* 모달창 열기 */
	function showModal(i) {
		let modalOpenClassName = '.modal-open' + i; 
		let modalOpen = document.querySelector(modalOpenClassName); // 모달 여는 버튼

		let modalBgClassName = '.modal-background-' + i;
		let modalBg = document.querySelector(modalBgClassName); // 모달 배경

		modalBg.classList.add('show'); // class를 이용한 모달 on
		
		var selectCancelDefault = document.getElementById("selectCancel-" + i);
		selectCancelDefault.value = "cancelDefault"; // 취소 사유 초기화
		
		if (modalBg.classList.contains('show')) { // 모달이 on일 때
			body.style.overflow = 'hidden'; // body의 스크롤을 막음
		}

		modalBg.addEventListener('click', (event) => { // 배경 클릭했을 때
			if (event.target === modalBg) {
				modalBg.classList.remove('show'); // class를 이용한 모달 off
				
				var calcelRsEtc = document.getElementById("cancelRsEtc-" + i);
				var inputCancel = document.getElementById("input-cancel-" + i);
				if(inputCancel) {
					calcelRsEtc.removeChild(inputCancel); // 배경 클릭하면 취소 사유 입력칸 제거
				}
				
				if (!modalBg.classList.contains('show')) { // 모달이 off일 때
				body.style.overflow = 'auto';  // body의 스크롤을 풂
				}
			}
		});

		const closeBtn = document.querySelector(".close-btn-" + i);
		$(closeBtn).click(function(){ // 모달창 닫기
			modalBg.classList.remove('show'); // 모달창 닫기
			
			var calcelRsEtc = document.getElementById("cancelRsEtc-" + i);
			var inputCancel = document.getElementById("input-cancel-" + i);
			if(inputCancel) {
				calcelRsEtc.removeChild(inputCancel); // 닫기 버튼 클릭하면 취소 사유 입력칸 제거
			}
		});

	}
	
	function cancel(i) {
		const selectCancel = "#selectCancel-" + i + " option:selected";
		const selectCancelValue = $(selectCancel).val();
		const cancelConfirmBtn = "#cancelConfirmBtn-" + i;
		const cancelRsEtcDiv = "#cancelRsEtc-" + i;
		
		$(cancelConfirmBtn).show();
		
		if(selectCancelValue === 'cancelDefault') {
			$(cancelConfirmBtn).hide();
			alert('취소 사유를 선택해 주세요');
		}
		
		if(selectCancelValue === 'CXL07'){
			var createInput = document.createElement("input");
			createInput.setAttribute("type", "text");
			createInput.setAttribute("name", "cancelRsEtc");
			createInput.setAttribute("Id", "input-cancel-" + i);
			createInput.setAttribute("class", "input-cancel modal-item");
			$(cancelRsEtcDiv).append(createInput);
		}else{
			$(cancelRsEtcDiv).empty();
		}
	}

	function del(studentId, subjectId, subjectSeq) {
		if (confirm('수강 정보를 삭제하시겠습니까?')) {
			$.ajax({
				type: "GET",
				url: "del/" + studentId + "/" + subjectId + "/" + subjectSeq,
				success: function (data) {
					document.location.href = document.location.href;
				}
			})
		}
	}

	function approval(studentId, subjectId, subjectSeq) {
		if (confirm('수강 신청을 승인하시겠습니까?')) {
			$.ajax({
				url: "approval/" + studentId + "/" + subjectId + "/" + subjectSeq,
				success: function (data) {
					document.location.href = document.location.href;
				}
			})
		}
	}

</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
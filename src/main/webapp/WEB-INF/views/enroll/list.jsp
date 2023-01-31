<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/register/list.css'/>"/>

<div class="card m-2">
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
				<%--신청 기간 --%>
				<div class="apply-period">
					<span id="applyperiod">신청기간</span>
					<input type="date" name="applyStartDay" class="input-date"> ~ 
					<input type="date" name="applyEndDay" class="input-date">
				</div>

				<%-- 강좌 과정 선택 --%>
				<div class="select-subcor">
					<select name="course" class="select-box">
						<option value="sj">강좌</option>
						<option value="cs">과정</option>
					</select>
					<input type="text" name="keyword2" class="input-text">
				</div>

				<%-- 수강생 선택 --%>
				<div class="selectstudent">
					<select name="student" class="select-box select-stu">
						<option value="sdName">수강생 명</option>
						<option value="sdId">수강생 아이디</option>
					</select>
					<input type="text" name="keyword1" class="input-text input-student">
				</div>

				<%-- 수강 상태 선택 --%>
				<div class="state">
					<span>수강 상태</span>
					<select name="state" class="select-box">
						<option value="">전체</option>
						<option value="expect">수강 예정</option>
						<option value="progress">수강 중</option>
						<option value="cancel">수강 취소</option>
						<option value="apply">수강 신청</option>
						<option value="complete">수강 완료</option>
					</select>
				</div>
				<input type="submit" class="input-button" value="검색">
			</form>
		</div>

		<div class="list_top">
			<div class="cnt">
				<%-- 뷰 갯수 --%>
				<div class="view">
					<button type="button" class="btn btn-outline-secondary" onclick="location.href ='<c:url value="/enroll/insert"/>'">수강추가</button>
					<select class="select-view" onchange="if(this.value) location.href=(this.value);">
						<option ${rowsPerPages eq 10 ? "selected" : ""} value="<c:url value="/enroll/boardlist?pageNo=1&rowsPerPage=10"/>">10개</option>
						<option ${rowsPerPages eq 30 ? "selected" : ""} value="<c:url value="/enroll/boardlist?pageNo=1&rowsPerPage=30"/>">30개</option>
						<option ${rowsPerPages eq 50 ? "selected" : ""} value="<c:url value="/enroll/boardlist?pageNo=1&rowsPerPage=50"/>">50개</option>
					</select>
				</div>
				전체목록 <b class="basic_txt_color">${pager.totalRows}</b>개, 
				페이지<b class="basic_txt_color"> ${pager.pageNo}</b> / ${pager.totalPageNo}
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

			<%-- 리스트 --%>
			<c:forEach var="board" items="${boardList}" varStatus="status">
				<tr>
					<td>
						<a href="<c:url value='/enroll/details/${board.enrollId}'/>">${board.subjectTitle}
							<c:if test="${not empty board.courseTitle}">
								(${board.courseTitle})
							</c:if>
						</a>
					</td>
					<td>${board.name} (${board.studentId})</td>
					<td>${board.enrollDt}</td>

					<%-- 현재 상태 옆에 진도율 --%>
					<td>${board.stateCdTitle}
						<c:if test="${board.stateCdTitle eq '수강중'}">
						(${board.ratio}%)
						</c:if>
					</td>

					<td>
						<%-- 취소 사유 --%>
						<c:if test="${board.stateCdTitle eq '수강취소'}">
						${board.cancelRsTitle}
						</c:if>
					</td>

					<%-- 버튼 --%>
					<td>
						<%-- 취소 버튼 --%>
						<c:if test="${(board.stateCdTitle eq '수강신청') or (board.stateCdTitle eq '수강예정') or (board.stateCdTitle eq '수강중') }">
							<button class="btn btn-secondary modal-open-${status.count}" onclick="showModal(${status.count})">취소</button>
							<%-- 취소 사유 모달창 --%>
							<div class="modal modal-${status.count}" >
								<div class="modal-content modal-content-${status.count}">
									<img class="cancel-img" src="/resources/images/survey/survey_question.png">
									<span id="cancelId" style="font-size: 1.2em;">취소하시겠습니까?</span>
									
									<form action="<c:url value='/enroll/cancel/${board.studentId}/${board.subjectId}/${board.subjectSeq}'/>" method="post" class="cacelform" onSubmit="checkForm()">
										<select id="selectCancel" name="cancelRsCd" class="cancelrs" onchange="cancel(); this.onclick=null;">
											<option value="">취소 사유 선택</option>
											<c:forEach var="cancel" items="${cancelList}">
												<option value="${cancel.comnCd}">${cancel.comnCdTitle}</option>
											</c:forEach>
										</select>
										<span id="cancelRsEtc"></span>
										<input type="submit" value="확인" class="confirm">
									</form>
									
									<div id="close-btn">
										<button class="close-btn">닫기</button>
									</div>
								</div>
								</div>
						</c:if>
					</td>

					<td>
						<%-- 삭제 버튼 --%>
						<c:if test="${board.stateCdTitle eq '수강취소'}">
							<button type="button" onclick="del('${board.studentId}', '${board.subjectId}', '${board.subjectSeq}')" class="btn btn-secondary">삭제</button>
						</c:if>
					</td>

					<td>
						<%-- 승인 버튼 --%>
						<c:if test="${(board.stateCdTitle eq '수강신청') and (board.openStateCdTitle eq '모집마감')}">
							<button type="submit" class="btn btn-secondary" onclick="approval('${board.studentId}', '${board.subjectId}', '${board.subjectSeq}')">승인</button>
						</c:if>
					</td>
				</tr>
			</c:forEach>

		</table>
		
       <%-- paging --%>

            <!-- paging -->
             <div id="paging">
                   <ul class="paging">
                    <li><a href="boardlist?pageNo=1">처음</a></li>
                    <c:if test="${pager.groupNo>1}">
                        <li><a href="boardlist?pageNo=${pager.startPageNo-1}&rowsPerPage=${pager.rowsPerPage}">이전</a></li>
                    </c:if>

                    <c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
                        <c:if test="${pager.pageNo != i}">
                            <li><a href="boardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}">${i}</a></li>
                        </c:if>
                        <c:if test="${pager.pageNo == i}">
                            <li><a href="boardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}">${i}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${pager.groupNo<pager.totalGroupNo}">
                        <li><a href="boardlist?pageNo=${pager.endPageNo+1}&rowsPerPage=${pager.rowsPerPage}">다음</a></li>
                    </c:if>
                    <li><a href="boardlist?pageNo=${pager.totalPageNo}&rowsPerPage=${pager.rowsPerPage}">맨끝</a></li>
                </ul>
              </div> 


		<div class="down">
				<a href="<c:url value='/enroll/enrollexcel?pageNo=${pager.pageNo}&rowsPerPage=${pager.rowsPerPage}'/>">
					<img class="excelimg" src="<c:url value='/resources/images/register/exceldown.png'/>"/>
				</a>
		</div>
		
	</div>

</div>

	<script>
		function showModal(i){
			var openBtnClassName = ".modal-open-" + i;
			var modalClassName = ".modal-" + i;
			function click() {
				$(modalClassName).fadeIn();
			}
			
			click();
			
			$(".close-btn").click(function(){
				$(".modal").fadeOut();
				document.location.href = document.location.href;
			});       
			
		};
		
		function del(studentId, subjectId, subjectSeq) {
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
		
		function approval(studentId, subjectId, subjectSeq) {
			if(confirm('수강 신청을 승인하시겠습니까?')) {
				$.ajax({
					url : "approval/" + studentId + "/" + subjectId + "/" + subjectSeq,
					success : function(data) {
						document.location.href = document.location.href;
					}
				})
			} else{
				return false;
			}
		}

		function cancel(){
			var selectCancel = document.getElementById('selectCancel');
			var cancel = selectCancel.options[selectCancel.selectedIndex].text;
		
			if(cancel === '관리자 기타'){
				var createInput = document.createElement("input");
				createInput.setAttribute("type", "text");
				createInput.setAttribute("name", "cancelRsEtc");
				createInput.setAttribute("class", "input-cancel");
				document.querySelector("#cancelRsEtc").append(createInput);
			}else if(cancel !== '관리자 기타'){
				$('#cancelRsEtc').empty();
			}
		}
		
		function checkForm() {
			if($('select[name=cancelRsCd]').val() === "") {
				alert("취소 사유를 선택해 주세요.");
				event.preventDefault();
			} 
		}
	</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
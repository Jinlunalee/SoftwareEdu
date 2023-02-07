<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/student/list.css'/>" />

<div class="card m-2">
   <div class="card-header">
      <img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
      <div>> 수강생 관리 > <span class="submenu-title">수강생 정보 확인</span></div>
   </div>

	<div class="card-body">
		<div class="search">
			<form action="<c:url value='/student/searchStudentBoardlist'/>">    
				<div class="search-row">
					<div class="search-section">
						<span class="search-section-title">수강생</span>
						<div class="search-section-content selectstudent">
							<select class="select-box input-box" name="student">
								<option value="stdtName" ${student eq 'stdtName' ? "selected" : ""}>수강생명</option>
								<option value="stdtId" ${student eq 'stdtId' ? "selected" : ""}>수강생아이디</option>
							</select> 
							<input name="keyword" class="input-text input-box" type="text" value="${keyword}" placeholder="검색어를 입력해 주세요">
						</div>
					</div>
					<input class="input-button btn btn-outline-secondary" type="submit" value="검색">
				</div>
			</form>  
		</div>


      <div class="view">
<!--          <button type="button" class="btn btn-outline-secondary">수강생추가</button>  -->
         <select class="select-view" onchange="if(this.value) location.href=(this.value);">
            <option value="">선택</option>
            <option value="<c:url value="/student/searchStudentBoardlist?pageNo=1&rowsPerPage=10&student=${student}&keyword=${keyword}"/>" ${rowsPerPage eq '10'?"selected":""}>10개</option>
            <option value="<c:url value="/student/searchStudentBoardlist?pageNo=1&rowsPerPage=30&student=${student}&keyword=${keyword}"/>" ${rowsPerPage eq '30'?"selected":""}>30개</option>
            <option value="<c:url value="/student/searchStudentBoardlist?pageNo=1&rowsPerPage=50&student=${student}&keyword=${keyword}"/>" ${rowsPerPage eq '50'?"selected":""}>50개</option>
         </select>
      </div>

      <div id = "list-wrap">
         <div class="list_top">
            <div class="cnt">
               전체목록 <b class="basic_txt_color">${pager.totalRows}</b>개,
               페이지<b class="basic_txt_color"> ${pager.pageNo} </b> / ${pager.totalPageNo}
            </div>
         </div>

         <table class="list">
            <thead>
               <tr>
                  <th>수강생 명(관리아이디)</th>            
                  <th>수강생아이디</th>
                  <th>생년월일</th>
                  <th>이메일</th>
                  <th>직위</th>
                  <th>수정/삭제</th>
               </tr>
            </thead>
            
            <tbody>
            <!-- 리스트 -->
            <c:if test="${boardListSize ne 0}">     
               <c:forEach var="board" items="${boardList}" varStatus="status"> 
                  <tr>
                     <td>${board.name}(${board.studentId})</td> 
                     <td>${board.userId}</td>
                     <td>${board.birth}</td>							
							<td>${board.email}</td>
							<td>${board.positionTitle}</td>
							<td>
								<form>
									<button type="button" class="btn btn-secondary">수정</button>
									<button type="button" class="btn btn-secondary" value="삭제" onclick="del()">삭제</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${boardListSize eq 0}">
						<div class="table-empty">
							게시물이 없습니다.
						</div>
				</c:if>
				</tbody>
			</table>

         <div class="bottoms">
            <!-- paging -->
            <div id="paging">
               <ul class="paging">
                  <li><a href="searchStudentBoardlist?pageNo=1&rowsPerPage=${pager.rowsPerPage}&student=${student}&keyword=${keyword}">처음</a></li>
                  <c:if test="${pager.groupNo>1}">
                     <li><a href="searchStudentBoardlist?pageNo=${pager.startPageNo-1}&rowsPerPage=${pager.rowsPerPage}&student=${student}&keyword=${keyword}">이전</a></li>
                  </c:if>
            
                  <c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
                     <c:if test="${pager.pageNo != i}">
                        <li><a href="searchStudentBoardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&student=${student}&keyword=${keyword}">${i}</a></li>
                     </c:if>
                     <c:if test="${pager.pageNo == i}">
                        <li><a href="searchStudentBoardlist?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}&student=${student}&keyword=${keyword}">${i}</a></li>
                     </c:if>
                  </c:forEach>
            
                  <c:if test="${pager.groupNo<pager.totalGroupNo}">
                     <li><a href="searchStudentBoardlist?pageNo=${pager.endPageNo+1}&rowsPerPage=${pager.rowsPerPage}&student=${student}&keyword=${keyword}">다음</a></li>
                  </c:if>
                  <li><a href="searchStudentBoardlist?pageNo=${pager.totalPageNo}&rowsPerPage=${pager.rowsPerPage}&student=${student}&keyword=${keyword}">맨끝</a></li>
               </ul>
            </div>
         </div>
      </div>
   </div>
</div>
<script type="text/javascript">
	function listCount(RowsPerPage){
		console.log(RowsPerPage);
		$.ajax({
			url : "ajaxstudentlist?strRowsPerPage="+RowsPerPage,
			type : "POST"
		}).done(function(result){
			console.log('success');
			var html = $('<div>').html(result);
			var contents = html.find('div#page-list').html();
			$('#list-wrap').html(contents);
		}).fail(function(){
			console.log('fail');
		});
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
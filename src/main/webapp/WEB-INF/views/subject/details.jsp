<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>


<link rel="stylesheet" href="<c:url value='/resources/css/course/details.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/survey/details.css'/>" />
<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div> > 강좌 관리 > <span class="submenu-title">개설 강좌 목록</span> > 개설 강좌 상세 페이지</div>
	</div>
	<div class="card-body">
		<c:if test="${not empty open.courseTitle}">
			<div class="sub_title">정기과정명 | ${open.courseTitle} </div>
		</c:if>
		<div class="course_title">
			<div class="main_title"><b class="basic_txt_color">${open.subjectId}</b>  ${open.subjectTitle} ${open.subjectSeq}회차</div>
			<div class="course_state">${open.openStateCdTitle}</div>
		</div>
		<!-- 교육 상세내용 -->
		<div class="list-wrap">
		<table class="list">
			<colgroup>
				<col width="50%">
				<col width="15%">
				<col width="35%">
			</colgroup>
			
			<thead>
			<tr>
				<th></th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td rowspan="7">
					<c:if test="${!empty open.fileName}">
						<c:set var="len" value="${fn:length(open.fileName)}"/>
						<c:set var="filetype" value="${fn:toUpperCase(fn:substring(open.fileName, len-4, len))}"/>
						<c:if test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.PNG') or (filetype eq '.GIF')}">
							<img class="detail_img" src='<c:url value="/subject/file/${open.fileId}"/>'><br>
						</c:if>
					</c:if>
				</td>
				<td> 강좌기간(시수)</td>
				<td> ${open.startDay} ~ ${open.endDay} (${open.hours}시간)
				</td>
			</tr>
			<tr>
				<td> 강좌시간</td>
				<td> ${open.startTime} ~ ${open.endTime}</td>
			</tr>
			<tr>
				<td> 모집기간 </td>
				<td> ${open.recruitStartDay} ~ ${open.recruitEndDay} </td>
			</tr>
			<tr>
				<td> 난이도 </td>
				<td> ${open.levelCdTitle} 
					<c:if test="${not empty open.levelEtc}">(${open.levelEtc})</c:if>
				</td>
			</tr>
			<tr>
				<td> 모집인원</td>
				<td> ${open.totalPeople}/${open.recruitPeople} </td>
			</tr>
			<tr>
				<td> 교육비</td>
				<td> <fmt:formatNumber value="${open.cost}" type="number"/> 원
					<c:if test="${open.supportYn eq 'Y'}"><span class="support">※ 교육비 지원을 받는 강좌입니다.</span></c:if>
					<c:if test="${open.supportYn eq 'N'}"><span class="support">※ 교육비 지원을 받지않는 강좌입니다.</span></c:if>
				</td>
			</tr>
			<tr>
				<td> 만족도 조사</td>
				<td> <button class="btn-open-popup btn btn-secondary" style="height:35px;">조회</button> </td>
			</tr>
			</tbody>
		</table>
		</div>
		
		<!-- 교육 소개 -->
		<div class="course_intro">
			<img src="<c:url value='/resources/images/subject/subject_intro.png'/>"/>
			<p class="txt" style="white-space:pre;">${open.content}</p>
		</div>
		
		<!-- button -->
		<div class="submit-btn">
			<c:choose>
				<c:when
					test="${(open.openStateCdTitle eq '모집예정') or (open.openStateCdTitle eq '모집중') or (open.openStateCdTitle eq '추가모집중') or (open.openStateCdTitle eq '모집마감') }">
					<button type="button" class="btn btn-secondary"
						onclick="location.href='<c:url value="/subject/update/${open.subjectId}/${open.subjectSeq}"/>'">수정</button>
					<button type="button" class="btn btn-secondary"
						onclick="closeCourse('${open.subjectId}', '${open.subjectSeq}', '${open.fileId}')">폐강</button>
				</c:when>
				<c:when test="${open.openStateCdTitle eq '진행중'}">
					<button type="button" class="btn btn-secondary"
						onclick="location.href='<c:url value="/subject/update/${open.subjectId}/${open.subjectSeq}"/>'">수정</button>
				</c:when>
				<c:when test="${open.openStateCdTitle eq '폐강'}">
					<button type="button" class="btn btn-secondary"
						onclick="del('${open.subjectId}', '${open.subjectSeq}', '${open.fileId}')">삭제</button>
				</c:when>
				<c:when test="${open.openStateCdTitle eq '진행완료'}">
				</c:when>
			</c:choose>
		</div> 
		
		<input type="reset" onclick="history.back();" value="이 전" class="btn">
		
		<!-- modal -->
		<div class="modal">
			<div class="modal_body">
			<div class="content-grid">
				<div class="survey_content">
				<c:forEach var="question" items="${questionSet}">
				<div class="question-set">
					<div class="question">
						<img class="surveyqn-img" src="<c:url value='/resources/images/survey/survey_question.png'/>"/>
						${question.questionNum}. ${question.questionContent}
					</div>
				</div>
				</c:forEach>
				</div>
			</div>
			</div>
		</div>		
		
	</div>
</div>

	<script type="text/javascript" src="<c:url value='/resources/js/subject.js'/>"></script>
	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	<script>
		/*수강삭제*/
		function del(subjectId, subjectSeq, fileId) {
			if(confirm('수강 정보를 삭제하시겠습니까?')) {
				location.href = '<c:url value="/subject/del/'+subjectId+'/'+subjectSeq+'?fileId='+fileId+'"/>'
			} else {
			}
		}
	
		/*폐강*/
		function closeCourse(subjectId, subjectSeq, fileId){
			if(confirm('폐강하시겠습니까?')) {
				location.href = '<c:url value="/subject/closesubject/'+subjectId+'/'+subjectSeq+'?fileId='+fileId+'"/>'
			} else {
			}
		}
		
	/* 모달창 */
    const body = document.querySelector('body');
    const modal = document.querySelector('.modal');
    const btnOpenPopup = document.querySelector('.btn-open-popup');

    btnOpenPopup.addEventListener('click', () => {
      modal.classList.toggle('show');

      if (modal.classList.contains('show')) {
        body.style.overflow = 'hidden';
      }
    });

    modal.addEventListener('click', (event) => {
      if (event.target === modal) {
        modal.classList.toggle('show');

        if (!modal.classList.contains('show')) {
          body.style.overflow = 'auto';
        }
      }
    });
     
	</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
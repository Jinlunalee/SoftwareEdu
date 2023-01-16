<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="<c:url value='/resources/css/course/details.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/survey/details.css'/>" />
<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	<div> > 강좌 관리 > <span class="submenu-title">개설 강좌 목록</span> > 개설 강좌 상세 페이지</div>
	</div>
	<div class="card-body">
		<c:if test="${not empty subject.courseTitle}">
			<div class="sub_title">정기과정명 | ${subject.courseTitle} </div>
		</c:if>
		<div class="course_title">
			<div class="main_title"><b class="basic_txt_color">${subject.subjectId}</b>  ${subject.subjectTitle}</div>
			<div class="course_state">${subject.comnCdTitle}</div>
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
					<c:if test="${!empty subject.fileName}">
						<c:set var="len" value="${fn:length(subject.fileName)}"/>
						<c:set var="filetype" value="${fn:toUpperCase(fn:substring(subject.fileName, len-4, len))}"/>
						<c:if test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.PNG') or (filetype eq '.GIF')}">
							<img class="detail_img" src='<c:url value="/subject/file/${subject.fileId}"/>'><br>
						</c:if>
					</c:if>
				</td>
				<td> 연수기간(일수)</td>
				<td> ${subject.startDay} ~ ${subject.endDay} (${subject.days}일)
				</td>
			</tr>
			<tr>
				<td> 연수시간</td>
				<td> ${subject.startTime} ~ ${subject.endTime}</td>
			</tr>
			<tr>
				<td> 신청기간 </td>
				<td> ${subject.recruitStartDay} ~ ${subject.recruitEndDay} </td>
			</tr>
			<tr>
				<td> 난이도 </td>
				<td> ${subject.levelTitle} 
					<c:if test="${not empty subject.levelEtc}">(${subject.levelEtc})</c:if>
				</td>
			</tr>
			<tr>
				<td> 모집인원</td>
				<td> ${totalPeople}/${subject.recruitPeople} </td>
			</tr>
			<tr>
				<td> 교육비</td>
				<td> <fmt:formatNumber value="${subject.cost}" type="number"/>
					<c:if test="${subject.supportYn eq 'Y'}">* 교육비 지원을 받는 강좌입니다.</c:if>
					<c:if test="${subject.supportYn eq 'N'}">* 교육비 지원하지않는 강좌입니다.</c:if>
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
			<p class="txt" style="white-space:pre;">${subject.content}</p>
		</div>
		
		<!-- button -->
		<div class="submit-btn">
			<c:choose>
				<c:when
					test="${(subject.comnCdTitle eq '모집예정') or (subject.comnCdTitle eq '모집중') or (subject.comnCdTitle eq '추가모집중') or (subject.comnCdTitle eq '모집마감') }">
					<button type="button" class="btn btn-secondary"
						onclick="location.href='<c:url value="/subject/update/${subject.subjectId}/${subject.subjectSeq}"/>'">수정</button>
					<button type="button" class="btn btn-secondary"
						onclick="closeCourse('${subject.subjectId}', '${subject.subjectSeq}', '${subject.fileId}')">폐강</button>
				</c:when>
				<c:when test="${subject.comnCdTitle eq '진행중'}">
					<button type="button" class="btn btn-secondary"
						onclick="location.href='<c:url value="/subject/update/${subject.subjectId}/${subject.subjectSeq}"/>'">수정</button>
				</c:when>
				<c:when test="${subject.comnCdTitle eq '폐강'}">
					<button type="button" class="btn btn-secondary"
						onclick="del('${subject.subjectId}', '${subject.subjectSeq}', '${subject.fileId}')">삭제</button>
				</c:when>
				<c:when test="${subject.comnCdTitle eq '진행완료'}">
				</c:when>
			</c:choose>
		</div> 
		
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
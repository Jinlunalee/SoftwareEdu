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
		<div class="sub_title">정기과정명 | ${subject.courseTitle} </div>
		<div class="course_title">
			<div class="main_title"><b class="basic_txt_color">${subject.subjectId}</b>  ${subject.subjectTitle}</div>
			<div class="course_state">${subject.comnCdTitle}</div>
		</div>
		<!-- 교육 상세내용 -->
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
							<img class="detail_img" src='<c:url value="/file/${subject.fileId}"/>'><br>
						</c:if>
					</c:if>
					
					<!-- img class="detail_img" src="<c:url value='/resources/images/subject/AI.jpg'/>"/-->
				</td>
				<td> 연수기간(일수)</td>
				<td> <fmt:parseDate value="${subject.startDay}" var="start" pattern="yyyyMMdd"/> 
					<fmt:formatDate value="${start}" pattern="yyyy-MM-dd"/>
				~ <fmt:parseDate value="${subject.endDay}" var="end" pattern="yyyyMMdd"/> 
					<fmt:formatDate value="${end}" pattern="yyyy-MM-dd"/>
				(${subject.days}일)
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
				<td> ${subject.level} 
					<c:if test="${not empty subject.levelEtc}">(${subject.levelEtc})</c:if>
				</td>
			</tr>
			<tr>
				<td> 모집인원</td>
				<td> ${totalPeople}/${subject.recruitPeople} </td>
			</tr>
			<tr>
				<td> 교육비</td>
				<td> ${subject.cost}
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
		
		<!-- 교육 소개 -->
		<div class="course_intro">
			<img src="<c:url value='/resources/images/subject/subject_intro.png'/>"/>
			<p class="txt">${subject.content}</p>
		</div>
		
		<!-- button -->
		<div class="submit-btn">
			<input type="button" onclick="location.href='<c:url value="/subject/update/${subject.subjectId}/${subject.subjectSeq}"/>'" value="수정">
<<<<<<< HEAD
	        <input type="button" onclick="del('${subject.subjectId}', '${subject.subjectSeq}', '${subject.fileId}')" value="삭제">
=======
			<input type="button" onclick="del()" value="삭제">
>>>>>>> branch 'master' of https://github.com/Jinlunalee/SoftwareEdu.git
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
					<div class="answer">
						<input class="answer-item answer-5" type="radio" name="check${i}" value="5" onclick="return(false)">매우 만족
						<input class="answer-item answer-4" type="radio" name="check${i}" value="4" onclick="return(false)">만족
						<input class="answer-item answer-3" type="radio" name="check${i}" value="3" onclick="return(false)">보통
						<input class="answer-item answer-2" type="radio" name="check${i}" value="2" onclick="return(false)">불만족
						<input class="answer-item answer-1" type="radio" name="check${i}" value="1" onclick="return(false)">매우 불만족
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
	<script>
	/*수강삭제*/
	function del(subjectId, subjectSeq, fileId) {
		if(confirm('수강 정보를 삭제하시겠습니까?')) {
			alert('삭제');
			alert(subjectId+'/'+subjectSeq+'/'+fileId);
			location.href = '<c:url value="/subject/del/'+subjectId+'/'+subjectSeq+'/'+fileId+'"/>'
		} else {
			alert('취소');
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
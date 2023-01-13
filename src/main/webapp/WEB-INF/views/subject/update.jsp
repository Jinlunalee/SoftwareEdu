<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="<c:url value='/resources/css/course/details.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/form.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">

<div class="card m-2">
	<div class="card-header">  
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	 <div> > 강좌 관리 > <span class="submenu-title">개설 강좌 목록</span> > 개설 강좌 수정 페이지</div>
	</div>
	<div class="card-body">
		<div class="sub_title">정기과정명 | ${subject.courseTitle} </div>
				
		<form class="insert_form" action="<c:url value='/subject/update/${subject.subjectId}/${subject.subjectSeq}'/>" method="post" enctype="multipart/form-data">
			<div class="course_title">
				<div class="main_title"><b>${subject.subjectId}</b> 
					<input class="readonly_txt" type="text" value="${subject.subjectTitle}" readonly>
				</div>
				<div class="course_state">${subject.comnCdTitle}</div>
			</div>
			
			<table class="list">
				<colgroup>
					<col width="40%">
					<col width="15%">
					<col width="45%">
				</colgroup>
			
			<thead>
			<tr>
				<th></th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td rowspan="8">
					<c:choose>
						<c:when test="${!empty subject.fileName}">
							<c:set var="len" value="${fn:length(subject.fileName)}"/>
							<c:set var="filetype" value="${fn:toUpperCase(fn:substring(subject.fileName, len-4, len))}"/>
							<c:if test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.PNG') or (filetype eq '.GIF')}">
								<img class="detail_img" src='<c:url value="/subject/file/${subject.fileId}"/>'><br>
							</c:if>
						</c:when>
						<c:otherwise>
							<img class="detail_img" src="">
						</c:otherwise>
					</c:choose>					
				</td>
				<td> 연수기간(일수)</td>
				<td> 
					<input type="hidden" name="hours" id="hours" value="${subject.hours}">
					<input type="date" name="startDay" id="startDay" value="${subject.startDay}" onchange="calcEndDay()"}>
					~ 
					<input type="date" name="endDay" id="endDay" value="${subject.endDay}" readonly>
					<span id="printDay"></span>
					<span id="printHours"></span>
				</td>
			</tr>
			<tr>
				<td> 연수시간</td>
				<td>
					<input class="timepicker" name="startTime" id="startTime" value="${subject.startTime}"> 
					~
					<input class="timepicker" name="endTime" id="endTime" value="${subject.endTime}">
				</td>
			</tr>
			<tr>
				<td> 신청기간 </td>
				<td> 
					<input type="date" name="recruitStartDay" id="recruitStartDay" value="${subject.recruitStartDay}" onchange="inputState()"> 
					~ 
					<input type="date" name="recruitEndDay" id="recruitEndDay" value="${subject.recruitEndDay}" onchange="inputState()">
				</td>
			</tr>
			<tr>
				<td> 난이도 </td>
				<td> ${subject.level}
					<c:if test="${not empty subject.levelEtc}">(${subject.levelEtc})</c:if>
				</td>
			</tr>
			<tr>
				<td> 모집인원</td>
				<td> <input type="text" name="recruitPeople" value="${subject.recruitPeople}"> 명 </td>
			</tr>
			<tr>
				<td> 교육비</td>
				<td class="readonly_txt"> <input type="text" name="cost" value="${subject.cost}" readonly> 원 <br>
					<c:if test="${subject.supportYn eq 'Y'}">* 교육비 지원을 받는 강좌입니다.</c:if>
				</td>
			</tr>
			<tr>
				<td> 만족도 조사 </td>
				<td>
					<button class="btn-open-popup btn btn-secondary" style="height:35px;"> 수정 </button> 
				</td>
			</tr>
			<tr>
				<td> 첨부파일 </td>
				<td class="filebox"> 
					<input class="insert_FileUpload" value="${subject.fileName}" placeholder="${subject.fileName}">
					<label for="file">파일찾기</label>
					<input type="file" name="file" id="file" onchange="previewImg(this);">
				</td>
			</tr>
			</tbody>
		</table>
		<div class="course_intro">
			<img src="<c:url value='/resources/images/subject/subject_intro.png'/>"/>
			<p class="txt"><textarea name="content" cols="60" rows="10">${subject.content}</textarea></p>
		</div>
		<div class="submit-btn">
			<input type="hidden" name="fileId" value="${subject.fileId}">
			<input type="hidden" name="courseId" value="${subject.courseId}">
			<input type="hidden" name="state" id="state" value="${subject.state}">
			<input type="submit" value="저장">
		</div>
		</form>
	</div>
</div>

	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/subject.js'/>"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
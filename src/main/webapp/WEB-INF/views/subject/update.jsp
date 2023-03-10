<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>


<link rel="stylesheet" href="<c:url value='/resources/css/course/details.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/form.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">

<div class="card">
   <div class="card-header">  
   <img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
   <div> > 강좌 관리 > <span class="submenu-title">개설 강좌 목록</span> > 개설 강좌 수정 페이지</div>
   </div>
   <div class="card-body">
      <form class="insert_form" action="<c:url value='/subject/update/${open.subjectId}/${open.subjectSeq}'/>" method="post" enctype="multipart/form-data">
         <div class="course_title">
            <div class="main_title"><b class="basic_txt_color"></b>  ${open.subjectTitle} (${open.subjectId}) ${open.subjectSeq}회차</div>
            <c:if test="${not empty open.courseTitle}">
               <div class="sub_title">과정명 | ${open.courseTitle} </div>
            </c:if>
            <div class="course_state">${open.openStateCdTitle}</div>
         </div>
         
         <table class="list">
            <colgroup>
               <col width="20%">
               <col width="20%">
               <col width="15%">
               <col width="45%">
            </colgroup>
         <tbody>
            <tr>
               <td colspan="4" style="text-align: right;"><span class="write-txt">※</span> 항목은 필수 입력 사항입니다.</td>
            </tr>
            <tr>
               <td colspan="2" rowspan="7">
                  <c:choose>
                     <c:when test="${!empty open.fileName}">
                        <c:set var="len" value="${fn:length(open.fileName)}"/>
                        <c:set var="filetype" value="${fn:toUpperCase(fn:substring(open.fileName, len-4, len))}"/>
                        <c:if test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.PNG') or (filetype eq '.GIF')}">
                           <img class="detail_img" src='<c:url value="/subject/file/${open.fileId}"/>'><br>
                        </c:if>
                     </c:when>
                     <c:otherwise>
                        <img class="detail_img" src="">
                     </c:otherwise>
                  </c:choose>               
               </td>
               <td class="write-txt"> 강좌기간(시수)</td>
               <td> 
                  <input type="hidden" name="hours" id="hours" value="${open.hours}">
                  <input type="date" name="startDay" id="startDay" value="${open.startDay}" onchange="calcEndDay()" required>
                  ~ 
                  <input type="date" name="endDay" id="endDay" value="${open.endDay}" readonly>
                  (${open.hours}시간)
                  <input type="hidden" Id="calcHours" value="">
                  <span id="printDay"></span>
               </td>
            </tr>
            <tr>
               <td class="write-txt"> 강좌시간</td>
               <td>
                  <select name="startTime" id="startTime" onchange="calcEndDay()" required>
                     <option value="">선택</option>
                     <option value="09:00" ${open.startTime eq '09:00'?"selected":""}>09:00</option>
                     <c:forEach var="i" begin="10" end="21">
                        <option value="${i}:00" ${open.startTime eq i+=':00'?"selected":""}>${i}:00</option>
                     </c:forEach>
                  </select>
                  ~
                  <select name="endTime" id="endTime" onchange="calcEndDay()" required>
                     <option value="">선택</option>
                     <option value="09:00" ${open.endTime eq '09:00'?"selected":""}>09:00</option>
                     <c:forEach var="i" begin="10" end="21">
                        <option value="${i}:00" ${open.endTime eq i+=':00'?"selected":""}>${i}:00</option>
                     </c:forEach>
                  </select>
               </td>
            </tr>
            <tr>
               <td class="write-txt"> 모집기간 </td>
               <td> 
                  <input type="date" name="recruitStartDay" id="recruitStartDay" value="${open.recruitStartDay}" onchange="inputState()" required> 
                  ~ 
                  <input type="date" name="recruitEndDay" id="recruitEndDay" value="${open.recruitEndDay}" onchange="inputState()" required>
               </td>
            </tr>
            <tr>
               <td> 난이도 </td>
               <td> ${open.levelCdTitle}
                  <c:if test="${not empty open.levelEtc}">(${open.levelEtc})</c:if>
               </td>
            </tr>
            <tr>
               <td class="write-txt"> 모집인원</td>
               <td> <input type="number" name="recruitPeople" min="5" value="${open.recruitPeople}" required> 명 </td>
            </tr>
            <tr>
               <td> 교육비</td>
               <td class="readonly_txt"> 
                  <fmt:formatNumber value="${open.cost}" type="number"/>원
                  <c:if test="${open.supportYn eq 'Y'}">* 교육비 지원을 받는 강좌입니다.</c:if>
               </td>
            </tr>
            <tr>
               <td> 첨부파일 </td>
               <td class="filebox"> 
                  <input class="insert_FileUpload" value="${open.fileName}" placeholder="${open.fileName}">
                  <label for="file">파일찾기</label>
                  <input type="file" name="file" id="file" onchange="previewImg(this);">
               </td>
            </tr>
            <tr>
               <td class="content-image">
                  <img src="<c:url value='/resources/images/subject/subject_intro.png'/>"/>
               </td>
               <td colspan="3">
                  <textarea name="content" id="content">${open.content}</textarea>
               </td>
            </tr>
         </tbody>
      </table>
      <div class="submit-btn">
         <input type="reset" onclick="history.back();" value="◀ 이전">
         <input type="hidden" name="fileId" value="${open.fileId}">
         <input type="hidden" name="courseId" value="${open.courseId}">
         <input type="hidden" name="openStateCd" id="openStateCd" value="${open.openStateCd}">
         <input type="hidden" name="courseOpenYear" id="courseOpenYear" value="${open.courseOpenYear}">
         <input type="hidden" id ="openCourseStartDay" value="${openCourse.startDay}">
         <input type="submit" value="저장">
      </div>
      </form>
   </div>
</div>

   <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
   <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
   <script type="text/javascript" src="<c:url value='/resources/js/subject.js'/>"></script>
   <script type="text/javascript">
      window.onload = function() {
         let startTime = document.getElementById("startTime").value;
	      let endTime = document.getElementById("endTime").value;
         let startDay = document.getElementById("startDay").value;
         let recruitStartDay = document.getElementById('recruitStartDay');
         let recruitEndDay = document.getElementById('recruitEndDay');
         timeMinMax(startTime, endTime);
         MinMaxChange(startDay,recruitStartDay,recruitEndDay);
      }

   </script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
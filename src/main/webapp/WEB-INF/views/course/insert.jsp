<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/course/details.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/form.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/course/button.css'/>" />

<div class="card m-2">
	<div class="card-header"> 강좌 관리 > 강좌 개설 </div>
	<div class="card-body">
		<div class="sub_title">정기과정명 | 
			<select class="select_course" name="정기과정명">
				<option>선택안함</option>
				<option>앱 개발자 과정</option>
				<option>웹 개발자 과정</option>
			</select> 
		</div>
		<form class="insert_form" action="<c:url value=''/>" method="post" enctype="multipart/form-data">
			<div class="course_title">
			<div class="main_title"><b>강좌명</b> 
				<select>
					<option>한번에 끝내는 JavaScript</option>
					<option>두번만에 끝내는 JS</option>
					<option>세번만에 끝낸 JS</option>
				</select>
			</div>
			</div>
			<table class="list">
			<thead>
			<tr>
				<th></th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td rowspan="8">
					<img class="detail_img" id="preview"/>
				</td>
				<td> 연수기간(일수)</td>
				<td> <input type="date"> ~ <input type="date"> </td>
			</tr>
			<tr>
				<td> 연수시간</td>
				<td> <input type="time"> ~ <input type="time"> </td>
			</tr>
			<tr>
				<td> 신청기간 </td>
				<td> <input type="date"> ~ <input type="date"> </td>
			</tr>
			<tr>
				<td> 난이도 </td>
				<td> 초급 (지정되어있는 값 가져오기)</td>
			</tr>
			<tr>
				<td> 모집인원</td>
				<td> <input type="text"> 명 </td>
			</tr>
			<tr>
				<td> 교육비</td>
				<td> <input type="text"> 원 <br>
					<c:if test="${1 eq 1}">* 교육비 지원을 받는 강좌입니다.</c:if>
				</td>
			</tr>
			<tr>
				<td> 만족도 조사 아아디</td>
				<td>
					<select>
						<option>SVEW0001</option>
						<option>SVEW0002</option>
						<option>SVEW0003</option>
					</select>
				</td>
			</tr>
			<tr>
				<td> 첨부파일 </td>
				<td class="filebox"> 
					<input class="insert_FileUpload" placeholder="업로드 파일의 최대 크기는 50MB 입니다.">
					<label for="file">파일찾기</label>
					<input type="file" name="file" id="file" onchange="previewImg(this);">
				</td>
			</tr>
			</tbody>
		</table>
		<div class="course_intro">
			<img src="<c:url value='/resources/images/course/course_intro.png'/>"/>
			<p class="txt"> <textarea cols="60" rows="10"></textarea></p>
		</div>
		<div class="submit-btn">
			<input type="submit" value="저장">
		</div>
		</form>
		
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#file").on('change',function(){
		console.log("change");
		  var fileName = $("#file").val();
		  $(".insert_FileUpload").val(fileName);
	});
});
function 
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
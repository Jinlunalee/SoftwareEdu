<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/register/insert.css'/>" />
<div class="card m-2">
	<div class="card-header"> 
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	 <div> > 수강 관리 > <span class="submenu-title">수강 추가</span></div>
	</div>
	<div class="card-body">
	
	<div class="wrap">
	<div class="search-box">
	<div class="search-content">
	<span class="name">수강생 명</span> &nbsp; &nbsp;
	
	<form name="search-form" class="search">
		<select name="type" class="sc">
			<option selected value="">수강생 명 / 아이디</option>
			<option value="name">수강생 명</option>
			<option value="studentId">아이디 </option>
		</select>
		<input type="text" name="keyword" class="search-in">
		<input type="button" onclick="getStudentList()" class="btn btn2" value="검색">
	</form>
	
		
	
	<script>
		var a;
		var b;
		var c;
		var d;
		
		function getStudentList() {
			$.ajax({
				type : 'GET',
				url : 'studentlist',
				data : $("form[name=search-form]").serialize(),
				async : false,
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
				success : function(result){
					a = JSON.stringify(result[0].studentId);
					a = a.replace(/\"/gi, "");
					
					$(".rs").empty();
					if(result.length > 0) {
						var ul = $("<ul/>");
						for(var i in result) {
							var $studentId = result[i].studentId;
							var $name = result[i].name;
							var $birth = result[i].birth;
							var $email = result[i].email;
							var $phone = result[i].phone;
							
							var li = $("<ul class='stu'/>").append(
									$("<li/>").text(' ' + '이름 : ' + $name),
									$("<li/>").text(' ' + '생년월일 : ' + $birth),
									$("<li/>").text(' ' + '이메일 : ' + $email),
									$("<li/>").text(' ' + '전화번호 : ' + $phone)
							);
							ul.append(li);
						}
						$(".rs").append(ul);
					}
					
				}
			})
		}
		
		function addEnroll(){
			var studentId = a;
			var subjectId = b;
			var subjectSeq = c;
			var course = d;
			
			if(studentId && subjectId && subjectSeq) {
			$.ajax({
				type : 'POST',
				url : 'addenroll/' + studentId + '/' + subjectId + '/' + subjectSeq,
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success : function(result){
				}
				})
			}
			else if(studentId && course){
				$.ajax({
					type : 'POST',
					url : 'addcourse/' + studentId,
					data : course,
					contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
					success : function(result){
					}
				})
				
				
				
				
			}
		}
		
		function getOpenList() {
			$.ajax({
				type : 'GET',
				url : 'openlist', 
				dataType : 'json',
				data : $("form[name=search-subject-course]").serialize(),
				async : false,
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
				success : function(result){
					if(result.length > 1) {
						d = JSON.stringify(result);
						console.log(d);
					}else{
						b = JSON.stringify(result[0].subjectId);
						b = b.replace(/\"/gi, "");
						console.log(b);
						c = JSON.stringify(result[0].subjectSeq);
						c = c.replace(/\"/gi, "");	
					}
					
					$(".rs2").empty();
					if(result.length > 0) {
						var td = $("<table class='tb'/>");
						
						var rowTitle = $("<tr/>").append(
								$("<td/>").text("강좌 아이디"),
								$("<td/>").text("강좌 시퀀스 "),
								$("<td/>").text("강좌 제목"),
								$("<td/>").text("과정 아이디"),
								$("<td/>").text("시작 일자"),
								$("<td/>").text("종료 일자"),
								$("<td/>").text("시작 시간"),
								$("<td/>").text("종료 시간"),
								$("<td/>").text("모집 시작일"),
								$("<td/>").text("모집 마감일"),
								$("<td/>").text("모집 인원")
								)
							td.append(rowTitle);
						
						for(var i in result) {
							var $subjectId = result[i].subjectId;
							var $subjectSeq = result[i].subjectSeq;
							var $subjectTitle = result[i].subjectTitle;
							var $courseId = result[i].courseId;
							var $startDay = result[i].startDay;
							var $endDay = result[i].endDay;
							var $startTime = result[i].startTime;
							var $endTime = result[i].endTime;
							var $recruitStartDay = result[i].recruitStartDay;
							var $recruitEndDay = result[i].recruitEndDay;
							var $recruitPeople = result[i].recruitPeople;
														
							var row = $("<tr/>").append(
									$("<td/>").text($subjectId),
									$("<td/>").text($subjectSeq),
									$("<td/>").text($subjectTitle),
									$("<td/>").text($courseId),
									$("<td/>").text($startDay),
									$("<td/>").text($endDay),
									$("<td/>").text($startTime),
									$("<td/>").text($endTime),
									$("<td/>").text($recruitStartDay),
									$("<td/>").text($recruitEndDay),
									$("<td/>").text($recruitPeople)
									
							);
							td.append(row);
						}
						$(".rs2").append(td);
					}
				}
			})
		}
	</script>
	</div>
	</div>
	
	<div class="rs"></div>
	</div>
	
	<div class="wrap">
	<div class="search-box">
	<div class="search-content">
	<span class="name">강좌 / 과정</span> &nbsp; &nbsp;
	<form name="search-subject-course" class="search2">
		<select name="subcor" class="sc2">
			<option selected value="">강좌 / 과정</option>
			<option value="subject">강좌</option>
			<option value="course">과정</option>
		</select>
		<input type="text" name="kw" class="search-in">
		<input type="button" onclick="getOpenList()" class="btn btn2" value="검색">
	</form>
	
	</div>
	</div>
	<div class="rs2"></div>
	</div>
	
	<div class="submit-btn">
	<form>
	<input type="submit" onclick="addEnroll()" value="저 장" class="btn">
	<input type="reset" onclick="location.href='<c:url value="/enroll/list"/>'" value="취 소" class="btn">
	</form>
	</div>
	
	</div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
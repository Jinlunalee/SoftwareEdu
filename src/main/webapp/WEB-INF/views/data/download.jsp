<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>
img {
	vertical-align: middle;
	border-style: none;
	width: 20px;
	height: 20px;
}

.card_check {
	margin: 40px;
}

#check_img {
	width: 80px;
	height: 30px;
	margin-bottom: 5px;
}

.btn-outline-secondary {
	color: #6c757d;
	border-color: #6c757d;
	position: relative;
	top: 5px;
	right: -140px
}

.vl {
	border-left: 1.5px dotted #bdc3c8;
	height: 550px;
	position: absolute;
	left: 600px;
	margin-left: 3px;
	margin-right: 3px;
	margin-left: 3px;
	margin-right: 3px;
	top: 80px;
	flex-direction: row;
}

.card-body {
	width: 100%;
	display: flex;
	flex-direction: row;
	justify-content: space-around;
	flex-wrap: wrap;
	margin-left: 20px;
	margin-right: 20px;
	margin-bottom: 40px;
}

.card_left {
	width: 50%;
	float: left;
}

.card_right {
	width: 50%;
	float: right;
	height: 600px;
	font-size: 15px;
}

.box {
	width: 400px;
	height: 450px;

	border: 1.5px solid #b1becc;
	margin: 35px;
	display: none;
}

a{

}
</style>




<div class="card m-2">
	<div class="card-header">
		<img class="home_img"
			src="<c:url value='/resources/images/home_small.png'/>" />
		<div>
			> 연계 자료 관리 > <span class="submenu-title">연계 자료 조회 </span>
		</div>
	</div>
	<div class="card-body">
		<br>

		<div class="card_left" style="width: 50%">
			<div class="card_check">
			
				<img id="check_img" src="<c:url value='/resources/images/json.png'/>" /> 
				<br> <a>연수원_교육비 지원대상<br> 교육비 지원 대상 교육과정을 수강하는 수강생 교육 정보<br> 
				(이수율 포함)</a>
				<button type="button" class="btn btn-outline-secondary"
					id="first_btn">
					연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
				</button>
			</div>

			<div class="card_check">
				<img id="check_img" src="<c:url value='/resources/images/xml.png'/>" />
				<br> <a>연수원_교육비 지원대상<br>교육비 지원 대상 교육과정을 수강하는 수강생 교육 정보<br>
				(이수율 포함)
				</a>
				<button type="button" class="btn btn-outline-secondary"
					id="second_btn">
					연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
				</button>
			</div>
			
			<div class="card_check">
				<img id="check_img" src="<c:url value='/resources/images/csv.png'/>" />
				<br> <a> 연수원_교육비 지원대상<br>교육비 지원 대상 교육과정을 수강하는 수강생 교육 정보<br>
				(이수율 포함)</a>
				<button type="button" class="btn btn-outline-secondary"
					id="third_btn">
					연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
				</button>
			</div>
		</div>
		<div class="vl"></div>

		<div class="card_right">


				<div class="box" id="show_JSON" >
				<img id="check_img" src="<c:url value='/resources/images/json.png'/>"/><br><a>연수원 교육비 지원 대상</a></div>

				<div class="box" id="show_XML" >
				<img id="check_img" src="<c:url value='/resources/images/xml.png'/>" /><br><a>연수원 교육비 지원 대상</a></div>
				
				<div class="box" id="show_CSV" >
				<img id="check_img" src="<c:url value='/resources/images/csv.png'/>" /><br><a>연수원 교육비 지원 대상</a></div>				

			</div>
		</div>

</div>




	<script>

	
	
$(function (){
	$("#first_btn").click(function (){
  	$("#show_JSON").toggle();
  	$("#show_XML").hide();
  	$("#show_CSV").hide();
  });
});


$(function (){
	$("#second_btn").click(function (){
  	$("#show_XML").toggle();
  	$("#show_JSON").hide();
  	$("#show_CSV").hide();
  });
});

$(function (){
	$("#third_btn").click(function (){
  	$("#show_CSV").toggle();
  	$("#show_JSON").hide();
  	$("#show_XML").hide();
  });
});




</script>





<%@ include file="/WEB-INF/views/common/footer.jsp"%>
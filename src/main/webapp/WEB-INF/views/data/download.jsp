<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>
img {
	vertical-align: middle;
	border-style: none;
	width: 20px;
	height: 20px;
}

.card {
overflow-x: scroll;

}
.card{
   -ms-overflow-style: none;
}
.card::-webkit-scrollbar{
  display:none;
}

.card_check {
	margin: 15px;
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
	width: 1250px;
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
	width: 600px;
	height: 550px;
	border: 1.5px solid #b1becc;
	margin: 10px;
	display: none;
}

#studentInfo{
    color: slategrey;
}


.second_card {
    margin-top: 60px;
}

.card_info{
    text-align: center;
    margin: 10px;
    width: 600px;
    height: 120px;
    border: 2px solid #95b3d4;
    display: none;

}
#first_info{
    font-size: 12px;
    color: slategrey;

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
		<div class="first_card">
		
		
			<div class="card_check">
				<img id="check_img"
					src="<c:url value='/resources/images/json.png'/>" /> 
					<br><a>연수원_교육비 지원대상 교육과정을 수강 완료한<br>수강생 교육 정보<br>(수강 완료 시수 포함)</a>
				<button type="button" class="btn btn-outline-secondary"
					id="first_btn">연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
				</button>
			</div>


			<div class="card_check">
				<img id="check_img" src="<c:url value='/resources/images/xml.png'/>" />
				<br> <a>연수원_교육비 지원대상 교육과정을 수강 완료한<br>수강생 교육 정보<br>(수강 완료 시수 포함)</a>
				<button type="button" class="btn btn-outline-secondary"
					id="second_btn">연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" /><br>

				</button>
			</div>
		</div>



		<div class="second_card">
			<div class="card_check">
				<img id="check_img" src="<c:url value='/resources/images/json.png'/>" />
				<br> <a>연수원_교육비 환급 대상 교육과정 최종 검증용 연계자료<br>(수강 완료 시수 포함)</a>
				<button type="button" class="btn btn-outline-secondary"
					id="third_btn">연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
				</button>
			</div>
			
			
			
			<div class="card_check">
				<img id="check_img" src="<c:url value='/resources/images/xml.png'/>" />
				<br> <a>연수원_교육비 환급 대상 교육과정 최종 검증용 연계자료<br>(수강 완료 시수 포함)</a>
				<button type="button" class="btn btn-outline-secondary"
					id="forth_btn">연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
				</button>
			</div>			
			</div>
		</div>
		
		
		<div class="vl"></div>

		<div class="card_right">
		
		  <div class ="card_info" id="show_info1">
		      <a id="first_info" class="first_info">
                * agent_id : 훈련기관ID<br>
                * std_sbj : 수강생, 강좌 정보 (교육연도, 강좌아이디, 강좌시퀀스, 수강아이디, 수강생아이디)<br>
                * name : 수강생 이름<br>
                * complete_hours : 수강완료시수<br>
                * send_dt : 전송시수<br>
		      </a>
		  </div>


			<div class="box" id="show_JSON" style="overflow:scroll;">
				<img id="check_img" src="<c:url value='/resources/images/json.png'/>" /><br>

				<div id="result">


				</div>
			</div>

			<div class="box" id="show_XML" style="overflow:scroll;">
				<img id="check_img" src="<c:url value='/resources/images/xml.png'/>" /><br>
				<div id="resultXml">
				</div>			
			</div>


			<div class="box" id="show_JSON2" style="overflow:scroll;">
				<img id="check_img" src="<c:url value='/resources/images/json.png'/>" /><br>
				<div id="result3">
				</div>	
			</div>		
				
				
			<div class="box" id="show_XML2" style="overflow:scroll;">
				<img id="check_img" src="<c:url value='/resources/images/xml.png'/>" /><br>
				<div id="result4">
				</div>		
			</div>
			
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		//$("#first_btn").click();
	});
	function getJson() {
		$.ajax({
			url : "getjson", 
			async : true,
            type : "GET",
            contentType: "application/json; charset:UTF-8",  // 한글이 물음표로 깨져서 나오는 현상 방지
			success : function(data) {
        		var str = "";
        		
        		str += "[";
            	for (var i = 0; i < data.length; i++) {
            		
            		str += "{";
            		// 큰따옴표가 나왔으면 좋겠어서 문자열을 표현하는 ' '로 감싸줌 
            		str += '"agent_id":' + '"' + "KOSA01" + '",';
            		str += '"std_sbj":' + '"' + data[i].stdSbj + '",';
            		str += '"name":' + '"' + data[i].name + '",';
            		str += '"complete_hours":' + '"' + data[i].completeHours + '",';
            		str += '"send_dt":' + '"' + data[i].sendDt + '"';

            		
            		if (i == data.length - 1) { // ,로 연결이 되어야 하는데 마지막일 때는 들어가면 안 됨
            			str += "}";
            		} else { // 마지막이아닐때  (콤마가 들어가야 하니까)
            			str += "},";
            		}
            	}
            	str += "]";
				$("#result").html(str);
			}
		});
	}

	function getXml() {
		$.ajax({
			url : "getxml", 
			async : true,
            type : "GET",
            contentType: "application/xml; charset:UTF-8",
			success : function(data) {
	
				$("#resultXml").text(data);			
			}
		});
	}

	function getJsonSbj() {
		$.ajax({
			type : "GET",
			url : "getjsonSbj",
			// data : input이 필요할 때 쓰는 것. 여기에는 input이 없으므로 적을 필요가 없음
			async : true,
//             contentType: "application/json; charset:UTF-8",  // 한글이 물음표로 깨져서 나오는 현상 방지
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success : function(data) {

        		var str = "";   
        		
        		str += "[";
            	for (var i = 0; i < data.length; i++) {
            		str += "{";
            		// 큰따옴표가 나왔으면 좋겠어서 문자열을 표현하는 ' '로 감싸줌 
            		str += '"sbjId_seq":' + '"' + data[i].sbjIdSeq + '",';
            		str += '"subject_title":' + '"' + data[i].subjectTitle + '",';
            		str += '"hours":' + '"' + data[i].hours + '",';
            		str += '"start_day":' + '"' + data[i].startDay + '",';
            		str += '"end_day":' + '"' + data[i].endDay + '",';
            		str += '"cost":' + '"' + data[i].cost + '",';
            		str += '"cnt_std":' + '"' + data[i].cntStd + '명",';
            		str += '"send_dt":' + '"' + data[i].sendDt + '"';

            		/*
            		alert(
           				data[i].sbjIdSeq + '\n' +
                   		data[i].subjectTitle + '\n' +
                   		data[i].hours + '\n' +
                   		data[i].startDay + '\n' +
                   		data[i].endDay + '\n' +
                   		data[i].cost + '\n' +
                   		data[i].sendDt
                   		data[i].cntStd
            		);
            		*/
            		
            		if (i == data.length - 1) { // ,로 연결이 되어야 하는데 마지막일 때는 들어가면 안 됨
            			str += "}";
            		} else { // 마지막이아닐때  (콤마가 들어가야 하니까)
            			str += "},";
            		}
            	}
            	str += "]";
            	
// alert(str);
				 $("#result3").text(str);
			}
		});
	}
	
	
	
	
	
	function getXmlSbj() {
		$.ajax({
			url : "getxmlSbj", 
			async : true,
            type : "GET",
            contentType: "application/xml; charset:UTF-8",
			success : function(data) {
	
				var str="";
				for (var i = 0; i < data.length; i++) {
					
					
					str += '<subject>';
            		str += '<sbjId_seq>' + data[i].sbjIdSeq + '</sbjId_seq>';
            		str += '<subject_title>' + data[i].subjectTitle + '</subject_title>';
            		str += '<hours>' + data[i].hours + '</hours>';
            		str += '<start_day>' + data[i].startDay +'</start_day>';
            		str += '<end_day>' + data[i].endDay +'</end_day>';
            		str += '<cost>' + data[i].cost + '</cost>';
            		str += '<send_dt>' + data[i].sendDt + '</send_dt>';
            		str += '<cnt_std>' + data[i].cntStd + '명' + '</cnt_std>';
            		str += '</subject>';		
				}
			
				$("#result4").text(str);			
			}
		});
	}
	
	
	
	
	
	
	

	$(function() {
		$("#first_btn").click(function() {
			$("#show_JSON, #show_info1").toggle();
			$("#show_XML").hide();
			$("#show_JSON2").hide();
			$("#show_XML2").hide();
			
			getJson();
		});
	});

	$(function() {
		$("#second_btn").click(function() {
			$("#show_XML").toggle();
			$("#show_JSON, #show_info1").hide();
			$("#show_XML2").hide();
			$("#show_JSON2").hide();
			
			getXml();
		});
	});

	$(function() {
		$("#third_btn").click(function() {
			$("#show_JSON2").toggle();
			$("#show_JSON, #show_info1").hide();
			$("#show_XML").hide();
			$("#show_XML2").hide();
			
			getJsonSbj();
		});
	});
	
	
	$(function() {
		$("#forth_btn").click(function() {
			$("#show_XML2").toggle();
			$("#show_JSON, #show_info1").hide();
			$("#show_JSON2").hide();
			$("#show_XML").hide();
			
			getXmlSbj();
		});
	});
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
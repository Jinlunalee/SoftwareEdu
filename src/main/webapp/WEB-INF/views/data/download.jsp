<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="<c:url value='/resources/css/data/download.css'/>" />


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
      <%-- 연계자료 기간으로 검색  --%>
      <div class="search">
      <%-- 수강생: std_sbj의 강좌 시작일이 기준 --%>
      <%-- 강좌: 강좌 시작일이 기준 --%>
         <form name="sc-form" >
            <%--연계자료 기간 --%>
            <div class="data-period">
               <span id="dataperiod">기간별 자료</span> <input type="date"
                  name="startDay" id="input_startDay" class="input-date"
                  value="${startDay}"> ~ <input
                  type="date" name="endDay" id="input_endDay" class="input-date"
                  value="${endDay}">
            </div>
         </form>
      </div>




      <div class="card_left" style="width: 50%">
         <div class="first_card">


            <div class="card_check">
               <img id="check_img"
                  src="<c:url value='/resources/images/json.png'/>" /><br>
               <a>연수원_교육비 지원대상 교육과정을 수강 완료한 수강생 교육 정보 <br>(수강 완료 시수 포함)
               </a>  <%-- (검색조건은 std_sbj에 있는 강좌 교육일로) --%>
               <button type="button" class="btn btn-outline-secondary"
                  id="first_btn">
                  연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
               </button>
            </div>


            <div class="card_check">
               <img id="check_img"
                  src="<c:url value='/resources/images/xml.png'/>" /><br>
                  <a>연수원_교육비 지원대상 교육과정을 수강 완료한 수강생 교육 정보  <br>(수강 완료 시수 포함)
               </a>
               <button type="button" class="btn btn-outline-secondary"
                  id="second_btn">
                  연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" /><br>

               </button>
            </div>
         </div>



         <div class="second_card">
            <div class="card_check">
               <img id="check_img"
                  src="<c:url value='/resources/images/json.png'/>" /><br> 
                  <a>연수원_교육비 환급 대상 교육과정 최종 검증용 연계자료 <br>(수강 완료 시수 포함)
               </a> <%--검색조건은 강좌시작일 --%>
               <button type="button" class="btn btn-outline-secondary"
                  id="third_btn">
                  연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
               </button>
            </div>



            <div class="card_check">
               <img id="check_img"
                  src="<c:url value='/resources/images/xml.png'/>" /><br> 
                  <a>연수원_교육비 환급 대상 교육과정 최종 검증용 연계자료<br>(수강 완료 시수 포함)
               </a>
               <button type="button" class="btn btn-outline-secondary"
                  id="forth_btn">
                  연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
               </button>
            </div>
         </div>
      </div>


      <div class="vl"></div>

      <div class="card_right">

         <div class="card_info" id="show_info1">
            <a id="first_info" class="first_info"> * agent_id : 훈련기관ID<br>
               * std_sbj : 수강생, 강좌 정보 (교육연도, 강좌아이디, 강좌시퀀스, 수강아이디, 수강생아이디)<br>
               * name : 수강생 이름  &emsp; &emsp; &emsp; * state_cd : 진행상태(ERL06)<br> * complete_hours : 수강완료시수<br> 
               * send_dt : 전송시간<br>
            </a>
         </div>

         <div class="card_info" id="show_info2">
            <a id="first_info" class="first_info"> * agent_id : 훈련기관ID<br>
               * std_sbj : 수강생, 강좌 정보 (교육연도, 강좌아이디, 강좌시퀀스, 수강아이디, 수강생아이디)<br>
               * name : 수강생 이름 &emsp; &emsp; &emsp; * state_cd : 진행상태(ERL06) <br> * complete_hours : 수강완료시수<br> 
               * send_dt : 전송시간<br>
            </a>
         </div>

         <div class="card_info" id="show_info3">
            <a id="first_info" class="first_info"> * sbjId_seq : 강좌아이디,
               강좌시퀀스 &emsp; &emsp; &emsp; &emsp; * subject_title : 강좌 이름<br>
               * hours : 해당 강좌 전체 시수 &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; *
               cnt_std : 수강 완료 된 수강생 수<br> * start_day : 강좌 시작 일자 &emsp;
               &emsp; &emsp; &emsp; * end_day : 강좌 마감 일자<br> * cost : 교육비
               &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; * send_dt : 전송시간<br>
            </a>
         </div>

         <div class="card_info" id="show_info4">
            <a id="first_info" class="first_info"> * sbjId_seq : 강좌아이디,
               강좌시퀀스 &emsp; &emsp; &emsp; &emsp; * subject_title : 강좌 이름<br>
               * hours : 해당 강좌 전체 시수 &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; *
               cnt_std : 수강 완료 된 수강생 수<br> * start_day : 강좌 시작 일자 &emsp;
               &emsp; &emsp; &emsp; * end_day : 강좌 마감 일자<br> * cost : 교육비
               &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; * send_dt : 전송시간<br>
            </a>
         </div>


         <div class="box" id="show_JSON" style="overflow: scroll;">
            <img id="check_img"
               src="<c:url value='/resources/images/json.png'/>" /><br>

            <div id="result"></div>
         </div>

         <div class="box" id="show_XML" style="overflow: scroll;">
            <img id="check_img" src="<c:url value='/resources/images/xml.png'/>" /><br>
            <div id="resultXml"></div>
         </div>


         <div class="box" id="show_JSON2" style="overflow: scroll;">
            <img id="check_img"
               src="<c:url value='/resources/images/json.png'/>" /><br>
            <div id="result3"></div>
         </div>


         <div class="box" id="show_XML2" style="overflow: scroll;">
            <img id="check_img" src="<c:url value='/resources/images/xml.png'/>" /><br>
            <div id="result4"></div>
         </div>

      </div>
   </div>
</div>
<script>
   
   $(document).ready(function() {
      //$("#first_btn").click();
   });
   function getJson() {
      
      var startDay = $('#input_startDay').val();
      var endDay = $('#input_endDay').val();
      
      $.ajax({
         url : "getjson",
         async : true,
         type : "GET",
         data : { // Ajax쓸때 컨트롤러로 넘겨줄 파라메터 정의.
            sDay : startDay,
            eDay : endDay
         },
         contentType : "application/json; charset:UTF-8", // 한글이 물음표로 깨져서 나오는 현상 방지
         success : function(data) {


            $("#result").text(JSON.stringify(data, null, 4));
         }
      });
   }

   function getXml() {
      
         var startDay = $('#input_startDay').val();
         var endDay = $('#input_endDay').val();
      
      $.ajax({
         url : "getxml",
         async : true,
         type : "GET",
           data : { // Ajax쓸때 컨트롤러로 넘겨줄 파라메터 정의.
                  sDay : startDay,
                  eDay : endDay
               },
         contentType : "application/json; charset:UTF-8", 
         success : function(data) {

            $("#resultXml").text(data, null, 4);
         }
      });
   }

   function getJsonSbj() {
        var startDay = $('#input_startDay').val();
        var endDay = $('#input_endDay').val();
          
      $.ajax({
         type : "GET",
         url : "getjsonSbj",
         // data : input이 필요할 때 쓰는 것 startDay, endDay input이 있으므로 적어주기
            data : { // Ajax쓸때 컨트롤러로 넘겨줄 파라메터 정의.
                   sDay : startDay,
                   eDay : endDay
                },
         async : true,
         //             contentType: "application/json; charset:UTF-8",  // 한글이 물음표로 깨져서 나오는 현상 방지
         contentType : "application/json; charset=UTF-8",
         success : function(data) {console.log(data);

            $("#result3").text(JSON.stringify(data, null, 4));
         }
      });
   }

   function getXmlSbj() {
        var startDay = $('#input_startDay').val();
        var endDay = $('#input_endDay').val();
      
      $.ajax({
         url : "getxmlSbj",
         async : true,
         type : "GET",
            data : { // Ajax쓸때 컨트롤러로 넘겨줄 파라메터 정의.
                sDay : startDay,
                eDay : endDay
             },
         contentType : "application/json; charset:UTF-8",
         success : function(data) {

            
            $("#result4").text(data);
         },
             error : function(data){
                alert("error" + data);
             }
      });
   }

   $(function() {
      $("#first_btn").click(function() {
         $("#show_JSON, #show_info1").toggle();
         $("#show_XML, #show_info2").hide();
         $("#show_JSON2, #show_info3").hide();
         $("#show_XML2, #show_info4").hide();

         getJson();
      });
   });

   $(function() {
      $("#second_btn").click(function() {
         $("#show_XML, #show_info2").toggle();
         $("#show_JSON, #show_info1").hide();
         $("#show_XML2, #show_info4").hide();
         $("#show_JSON2, #show_info3").hide();

         getXml();
      });
   });

   $(function() {
      $("#third_btn").click(function() {
         $("#show_JSON2, #show_info3").toggle();
         $("#show_JSON, #show_info1").hide();
         $("#show_XML, #show_info2").hide();
         $("#show_XML2, #show_info4").hide();

         getJsonSbj();
      });
   });

   $(function() {
      $("#forth_btn").click(function() {
         $("#show_XML2, #show_info4").toggle();
         $("#show_JSON, #show_info1").hide();
         $("#show_JSON2, #show_info3").hide();
         $("#show_XML, #show_info2").hide();

         getXmlSbj();
      });
   });
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
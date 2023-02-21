<%@ page contentType="text/html; charset=UTF-8" %>

   <%@ include file="/WEB-INF/views/common/header.jsp" %>

      <link rel="stylesheet" href="<c:url value='/resources/css/data/download.css'/>" />


      <div class="card">
         <div class="card-header">
            <img class="home_img" src="<c:url value='/resources/images/home_small.png'/>" />
            <div>
               > 연계 자료 관리 > <span class="submenu-title">연계 자료 조회</span>
            </div>
         </div>
         <div class="card-body">
            <%-- 연계자료 기간으로 검색 --%>
               <div class="card_combo">
                  <div class="card_left">
                     <div class="search">
                        <%-- 수강생: std_sbj의 강좌 시작일이 기준 --%>
                        <%-- 강좌: 강좌 시작일이 기준 --%>
                        <form name="sc-form" class="search-form">
                           <%--연계자료 기간 --%>
                           <div class="data-period">
                              <span id="dataperiod">기간별 조회  <a id=dataExpl>※ 강좌 시작 일자(startDay)를 기준으로 검색됩니다.</a></span>
                              <div class="date-inputs">
                                 <input type="date" name="startDay" id="input_startDay" class="input-date" value="${startDay}"> ~ 
                                 <input type="date" name="endDay" id="input_endDay" class="input-date" value="${endDay}">
                              </div>
                           </div>
                           <div class="reset-group">
                              <input type="reset" class="btn btn-outline-secondary reset-btn" id="reset_btn"> 
                              <img id="resetImg" src="<c:url value='/resources/images/reset.png'/>"/>
                           </div>
                        </form>
                     </div>

                     <div class="card_check">
                        <div class="first_card">
                           <a class="card_title">▶ 연수원_교육비 지원대상 교육강좌를 수강 완료한 수강생 교육 정보 <br>&emsp;(수강 완료 시수 포함)
                           </a> <%-- (검색조건은 std_sbj에 있는 강좌 교육일로) --%>
                              <div class="checkDataStd output_btns">
                                 <div class="card_check">
                                    <img id="check_img" src="<c:url value='/resources/images/json.png'/>" />
                                    <button type="button" class="btn btn-outline-secondary" id="first_btn">
                                       연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
                                    </button>
                                 </div>
                                 <div class="card_check">
                                    <img id="check_img" src="<c:url value='/resources/images/xml.png'/>" />
                                    <button type="button" class="btn btn-outline-secondary" id="second_btn">
                                       연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
                                    </button>
                                 </div>
                              </div>
                        </div>

                        <div class="second_card">
                           <a class="card_title">▶ 연수원_교육비 환급 대상 교육강좌 최종 검증용 연계자료 <br>&emsp;(수강 완료 시수 포함)
                           </a> <%--검색조건은 강좌시작일 --%>
                              <br>
                              <div class="checkDataSbj output_btns">
                                 <div class="card_check">
                                    <img id="check_img" src="<c:url value='/resources/images/json.png'/>" />
                                    <button type="button" class="btn btn-outline-secondary" id="third_btn">
                                       연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
                                    </button>
                                 </div>


                                 <div class="card_check">
                                    <img id="check_img" src="<c:url value='/resources/images/xml.png'/>" />
                                    <button type="button" class="btn btn-outline-secondary" id="forth_btn">
                                       연계 정보 출력 <img src="<c:url value='/resources/images/check.png'/>" />
                                    </button>
                                 </div>
                              </div>
                        </div>
                     </div>
                  </div>

                  <!-- <div class="vl"></div> -->

                  <div class="card_right">
                     <div class="card_info" id="show_info1">
                        <div id="first_info" class="first_info">
                           <table class="table_info1 table_info">
                              <colgroup>
                                 <col width="20%">
                                 <col width="30%">
                                 <col width="20%">
                                 <col width="30%">
                              </colgroup>
                              <tr>
                                 <th>agentId</th>
                                 <td colspan="3">훈련기관ID</td>
                              </tr>
                              <tr>
                                 <th>stdSbj</th>
                                 <td colspan="3">수강생, 강좌 정보 (교육연도, 강좌아이디, 강좌시퀀스, 수강아이디, 수강생아이디)</td>
                              </tr>
                              <tr>
                                 <th>name</th>
                                 <td>수강생 이름</td>
                                 <th>completeHours</th>
                                 <td>수강완료시수</td>
                              </tr>
                              <tr>
                                 <th>stateCd</th>
                                 <td>진행상태 (ERL06:진행완료)</td>                              
                                 <th>sendDt</th>
                                 <td>전송시간</td>
                              </tr>
                           </table>
                        </div>
                     </div>

                     <div class="card_info" id="show_info2">
                        <div id="first_info" class="first_info">
                           <table class="table_info2 table_info">
                              <tr>
                                 <th>sbjIdSeq</th>
                                 <td>강좌아이디, 강좌시퀀스</td>
                                 <th>subjectTitle</th>
                                 <td>강좌 이름</td>
                              </tr>
                              <tr>
                                 <th>hours</th>
                                 <td>해당 강좌 전체 시수</td>
                                 <th>cntStd</th>
                                 <td>수강 완료 된 수강생 수</td>
                              </tr>
                              <tr>
                                 <th>startDay</th>
                                 <td>강좌 시작 일자</td>
                                 <th>endDay</th>
                                 <td>강좌 마감 일자</td>
                              </tr>
                              <tr>
                                 <th>cost</th>
                                 <td>교육비 (단위: 원)</td>                              
                                 <th>sendDt</th>
                                 <td>전송시간</td>
                              </tr>
                           </table>
                        </div>
                     </div>

                     <div class="box" id="show_JSON" style="overflow: scroll;">
                        <img id="result_img" src="<c:url value='/resources/images/json.png'/>" /><br>
                        <div id="result"></div>
                     </div>

                     <div class="box" id="show_XML" style="overflow: scroll;">
                        <img id="result_img" src="<c:url value='/resources/images/xml.png'/>" /><br>
                        <div id="resultXml"></div>
                     </div>

                     <div class="box" id="show_JSON2" style="overflow: scroll;">
                        <img id="result_img" src="<c:url value='/resources/images/json.png'/>" /><br>
                        <div id="result3"></div>
                     </div>

                     <div class="box" id="show_XML2" style="overflow: scroll;">
                        <img id="result_img" src="<c:url value='/resources/images/xml.png'/>" /><br>
                        <div id="result4"></div>
                     </div>

                  </div>
               </div>
         </div>
      </div>
      <script>

         $(document).ready(function () {
            //$("#first_btn").click();
         });
         function getJson() {

            var startDay = $('#input_startDay').val();
            var endDay = $('#input_endDay').val();

            $.ajax({
               url: "getjson",
               async: true,
               type: "GET",
               data: { // Ajax쓸때 컨트롤러로 넘겨줄 파라메터 정의.
                  sDay: startDay,
                  eDay: endDay
               },
               contentType: "application/json; charset:UTF-8", 
               success: function (data) {


                  $("#result").text(JSON.stringify(data, null, 4));
               }
            });
         }

         function getXml() {

            var startDay = $('#input_startDay').val();
            var endDay = $('#input_endDay').val();

            $.ajax({
               url: "getxml",
               async: true,
               type: "GET",
               data: { // Ajax쓸때 컨트롤러로 넘겨줄 파라메터 정의.
                  sDay: startDay,
                  eDay: endDay
               },
               contentType: "application/json; charset:UTF-8",
               success: function (data) {

                  $("#resultXml").text(data, null, 4);
               }
            });
         }

         function getJsonSbj() {
            var startDay = $('#input_startDay').val();
            var endDay = $('#input_endDay').val();

            $.ajax({
               type: "GET",
               url: "getjsonSbj",
               // data : input이 필요할 때 쓰는 것 startDay, endDay input이 있으므로 적어주기
               data: { // Ajax쓸때 컨트롤러로 넘겨줄 파라메터 정의.
                  sDay: startDay,
                  eDay: endDay
               },
               async: true,
               //             contentType: "application/json; charset:UTF-8",  // 한글이 물음표로 깨져서 나오는 현상 방지
               contentType: "application/json; charset=UTF-8",
               success: function (data) {
                  console.log(data);

                  $("#result3").text(JSON.stringify(data, null, 4));
               }
            });
         }

         function getXmlSbj() {
            var startDay = $('#input_startDay').val();
            var endDay = $('#input_endDay').val();

            $.ajax({
               url: "getxmlSbj",
               async: true,
               type: "GET",
               data: { // Ajax쓸때 컨트롤러로 넘겨줄 파라메터 정의.
                  sDay: startDay,
                  eDay: endDay
               },
               contentType: "application/json; charset:UTF-8",
               success: function (data) {


                  $("#result4").text(data);
               },
               error: function (data) {
                  alert("error" + data);
               }
            });
         }
         
         /* 첫번째 JSON */
         $(function () {
            $("#first_btn").click(function () {
               $("#show_XML, #show_info1").hide();
               $("#show_JSON2, #show_info2").hide();
               $("#show_XML2, #show_info2").hide();

               $("#show_JSON, #show_info1").show();

               getJson();
            });
         });

         /* 첫번째 XML */
         $(function () {
            $("#second_btn").click(function () {
               $("#show_JSON, #show_info1").hide();
               $("#show_JSON2, #show_info2").hide();
               $("#show_XML2, #show_info2").hide();

               $("#show_XML, #show_info1").show();

               getXml();
            });
         });

         /* 두번째 JSON */
         $(function () {
            $("#third_btn").click(function () {
               $("#show_JSON, #show_info1").hide();
               $("#show_XML, #show_info1").hide();
               $("#show_XML2, #show_info2").hide();

               $("#show_JSON2, #show_info2").show();

               getJsonSbj();
            });
         });

         /* 두번째 XML */
         $(function () {
            $("#forth_btn").click(function () {
               $("#show_JSON, #show_info1").hide();
               $("#show_XML, #show_info1").hide();
               $("#show_JSON2, #show_info2").hide();

               $("#show_XML2, #show_info2").show();

               getXmlSbj();
            });
         });


         $(function () {
            $("#reset_btn").click(function () {
               /*    
                    const result = document.getElementById('result');
                    result.innerText='';
                	
                     const resultXml = document.getElementById('resultXml');
                     resultXml.innerText='';
                     
                     const result3 = document.getElementById('result3');
                     result3.innerText='';
                     
                     const result4 = document.getElementById('result4');
                     result4.innerText=''; 
                */

               $("#show_JSON, #show_info1").hide();
               $("#show_JSON2, #show_info3").hide();
               $("#show_XML, #show_info2").hide();
               $("#show_XML2, #show_info4").hide();
            });
         });



      </script>


      <%@ include file="/WEB-INF/views/common/footer.jsp" %>
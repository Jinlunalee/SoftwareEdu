<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<link rel="stylesheet" href="<c:url value='/resources/css/register/details.css'/>"/>
<div class="card m-2">
	<div class="card-header">
	<img class="home_img" src="<c:url value='/resources/images/home_small.png'/>"/>
	 <div> > 수강 관리  >  등록 수강 정보 확인  >  등록 수강 상세 페이지
	</div>
	</div>
	<div class="card-body">
	
	<div id="root">
    <button type="button" id="modal_opne_btn">모달 창 열기</button>
	</div>
	
	<div id="modal">
	<div class="modal_content">
	<h2>모달 창</h2>
	<p>모달 창입니다.</p>
		<button type="button" id="modal_close_btn">모달 창 닫기</button>
	</div>
	
	<div class="modal_layer"></div>
	</div>
	
	<script>
    $("#modal_opne_btn").click(function(){
        $("#modal").attr("style", "display:block");
    });
   
     $("#modal_close_btn").click(function(){
        $("#modal").attr("style", "display:none");
    });      
	</script>
	
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
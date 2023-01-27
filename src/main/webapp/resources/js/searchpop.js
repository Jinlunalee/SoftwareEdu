$(document).ready(function() {
});


/* 검색조건 입력 후 버튼 클릭 시 검색 결과 리스트 출력 */
	const searchBtn = document.getElementById('search-btn'); // 검색 버튼
	searchBtn.addEventListener('click', bringValue);
	searchBtn.addEventListener('click', showList);

/* 부모창에서 작성 해에 courseId에 등록된 강좌 리스트 가져오기 */
function bringValue() {
    const unavailablePop = document.getElementById('unavailable-pop'); // pop에 있는 hidden div
    const subjectIdString = opener.document.getElementById('subjectId-string'); // 부모창에 있는 hidden input
    $(subjectIdString).clone().appendTo(unavailablePop);
}

/* 검색 결과 리스트 출력 함수 */
function showList() {
    const searchForm = document.getElementById('search-form'); // 검색 폼
    let formInputs = '';
    for(var i=1; i<searchForm.length-1; i++) {
        formInputs += "&" + searchForm.elements[i].name + "=" + searchForm.elements[i].value;
    }
    let searchUrl = String(formInputs).substring(1);
    console.log("searchUrl : " + searchUrl);
    const pathArr = location.pathname.split('/');
    console.log("location : " + location.pathname);
    console.log("pathArr : " + pathArr);
    const path = pathArr[2];
    console.log("path : " + path);
    console.log(path + "-result?" + searchUrl);
    $.ajax({
        url : path + "-result?" + searchUrl,
        type : "POST",
        contentType: "application/json; charset:UTF-8"  // 한글이 물음표로 깨져서 나오는 현상 방지
    }).done(function(result){
        var html = jQuery('<div>').html(result);
        var contents = html.find("div#result-list").html();
        $(".list-wrap").html(contents);
        if(path.substring(10,25)==='subject') {
            disableSubjectList(); // 강좌 개설에서 과정에 이미 담긴 강좌는 개설하지 못하게 하기
        } else if (path.substring(10,25)==='course') {
        
        } else if (path.substring(10,25)==='opencourse') {
            const EnrollInsert = 'EnrollInsert'
            disableListByState(EnrollInsert); // 수강 추가에서 모집 중, 모집 마감, 진행중만 선택할 수 있게
        } else if (path.substring(10,25)==='opensubject') {
            const EnrollInsert = 'EnrollInsert'
            disableListByState(EnrollInsert); // 수강 추가에서 모집 중, 모집 마감, 진행중만 선택할 수 있게
        } else if (path.substring(10,25)==='student'){
            // 수강 추가에서 강좌/과정이 선택되어 있을 시 이미 해당 강좌 수강중인 학생은 튕기게
        } else if (path.substring(10,30)==='opensubjectDone') {
            const Survey = 'Survey'
            disableListByState(Survey); // 만족도 조사에서 완료된 강좌만 선택할 수 있게
        }
    })
    
}

/* bringValue로 가져온 강좌아이디에 해당하는 showList 리스트는 비활성화하기 */
function disableSubjectList() {
    const subjectIdString = document.getElementById('subjectId-string').value;
    const subjectIdArr = subjectIdString.split('/');
    for(var i=0; i<subjectIdArr.length; i++) {
        let id = String(subjectIdArr[i]);
        let boardSubjectId = document.getElementById(id);
        boardSubjectId.removeAttribute("onclick");
        boardSubjectId.setAttribute("onclick", 'alert("이미 과정에 동일 강좌를 개설하였습니다.")');
    }
}

/* 수강 추가에서 모집 중, 모집 마감, 진행중만 선택할 수 있게 OPN02, OPN03, OPN04 : OK / OPN01, 0PN05, OPN07 : NO */
function disableListByState(value) {
    if(value==='EnrollInsert') {
        for(var i=0; i<document.getElementsByClassName('OPN01').length; i++) {
            document.getElementsByClassName('OPN01')[i].removeAttribute("onclick");
            document.getElementsByClassName('OPN01')[i].setAttribute("onclick", 'alert("모집예정인 과정은 수강 신청하실 수 없습니다.")');
        }
        for(var k=0; k<document.getElementsByClassName('OPN05').length; k++) {
            document.getElementsByClassName('OPN05')[k].removeAttribute("onclick");
            document.getElementsByClassName('OPN05')[k].setAttribute("onclick", 'alert("진행완료인 과정은 수강 신청하실 수 없습니다.")');
        }
        for(var j=0; j<document.getElementsByClassName('OPN07').length; j++) {
            document.getElementsByClassName('OPN07')[j].removeAttribute("onclick");
            document.getElementsByClassName('OPN07')[j].setAttribute("onclick", 'alert("폐강인 과정은 수강 신청하실 수 없습니다.")');
        }
    } else if(value==='Survey') {
        for(var i=0; i<document.getElementsByClassName('OPN01').length; i++) {
            document.getElementsByClassName('OPN01')[i].removeAttribute("onclick");
            document.getElementsByClassName('OPN01')[i].setAttribute("onclick", 'alert("모집예정인 과정은 만족도 조사 결과가 존재하지 않습니다.")');
        }
        for(var k=0; k<document.getElementsByClassName('OPN02').length; k++) {
            document.getElementsByClassName('OPN02')[k].removeAttribute("onclick");
            document.getElementsByClassName('OPN02')[k].setAttribute("onclick", 'alert("모집중인 과정은 만족도 조사 결과가 존재하지 않습니다.")');
        }
        for(var j=0; j<document.getElementsByClassName('OPN03').length; j++) {
            document.getElementsByClassName('OPN03')[j].removeAttribute("onclick");
            document.getElementsByClassName('OPN03')[j].setAttribute("onclick", 'alert("모집마감인 과정은 만족도 조사 결과가 존재하지 않습니다.")');
        }
        for(var j=0; j<document.getElementsByClassName('OPN04').length; j++) {
            document.getElementsByClassName('OPN04')[j].removeAttribute("onclick");
            document.getElementsByClassName('OPN04')[j].setAttribute("onclick", 'alert("진행중인 과정은 만족도 조사 결과가 존재하지 않습니다.")');
        }
        for(var j=0; j<document.getElementsByClassName('OPN07').length; j++) {
            document.getElementsByClassName('OPN07')[j].removeAttribute("onclick");
            document.getElementsByClassName('OPN07')[j].setAttribute("onclick", 'alert("폐강인 과정은 만족도 조사 결과가 존재하지 않습니다.")');
        }
    }

}

/* ㅇㅇ명/ㅇㅇ아이디 선택에 따른 input name 설정 */
let subjectInput = document.getElementById('subject-input'); // input 태그
let courseInput = document.getElementById('course-input'); // input 태그
let studentInput = document.getElementById('student-input');

function putNameonInput(value) { // ㅇㅇ강좌명/ㅇㅇ강좌아이디 선택에 따라 iput 이름 설정
    if(value==='subjectId') {
        subjectInput.setAttribute("name", 'subjectId');
    } else if(value==='subjectTitle') {
        subjectInput.setAttribute("name", 'subjectTitle');
    } else if(value==='courseId') {
        courseInput.setAttribute("name", 'courseId');
    } else if(value === 'courseTitle'){
        courseInput.setAttribute("name", 'courseTitle');
    } else if(value === 'studentId') {
        studentInput.setAttribute("name", 'studentId');
    } else{
        studentInput.setAttribute("name", 'name');
    }

}




/* ㅇㅇ명 클릭했을 시 팝업창 닫기 및 선택값 반영하기  */
function moveOutside(event, value){
    event.preventDefault();

    console.log(value);
    let valueArr = value.split('/');
    let valueId = valueArr[0];
    
    console.log(valueId.substring(0,4));
    // find()함수로 반영할 곳을 찾아서 값 반영하기 - 강좌일 경우
    if(valueId.substring(0,4)==='SUBJ') {
        let valueTitle = valueArr[2];
        let reg = valueArr[3];
        let supportYn = valueArr[5];
        let levelCdTitle = valueArr[6];
        let levelEtc = valueArr[7];
        let days = valueArr[8];
        let hours = valueArr[9];
        let startDay = valueArr[10];
        let endDay = valueArr[11];
        let recruitStartDay = valueArr[12];
        let recruitEndDay = valueArr[13];
        let recruitPeople = valueArr[14];
        let openStateCdTitle = valueArr[15];
        let catSubjectCdTitle = valueArr[16];
        
        $(opener.document).find("#subjectTitle-input").val("강좌아이디 : " + valueId + "  |  강좌명 : " + valueTitle + "  |  등록일자 : " + reg);
        $(opener.document).find("#subject-input").val(value);
        $(opener.document).find("#subjectId-input").val(valueId);
        
        var table = $("<table class='subjectdetails'/>");
        var tr = $("<table class='subjectdetails' border='1'/>").append(
        		$("<tr/>"),
        		$("<td/>").text('강좌 기간'),
        		$("<td/>").text('모집 기간'),
				$("<td/>").text('일수'),
				$("<td/>").text('시수'),
				$("<tr/>"),
				$("<td/>").text(startDay + ' ~ ' + endDay),
				$("<td/>").text(recruitStartDay + ' ~ ' + recruitEndDay),
				$("<td/>").text(days),
				$("<td/>").text(hours),
				$("<tr/>"),
				$("<td/>").text('모집 인원'),
				$("<td/>").text('강좌 분류'),
				$("<td/>").text('개설 상태'),
				$("<td/>").text('난이도 (기타)'),
				$("<tr/>"),
				$("<td/>").text(recruitPeople),
				$("<td/>").text(catSubjectCdTitle),
				$("<td/>").text(openStateCdTitle),
				$("<td/>").text(levelCdTitle + '(' + levelEtc + ')')
		);
		table.append(tr);
		$(opener.document).find("#subject-list").html(table);
        window.close();
    }
    // find()함수로 반영할 곳을 찾아서 값 반영하기 - 과정일 경우
    if(valueId.substring(0,4)==='CRSE') {
        let valueTitle = valueArr[2];
        let valueYear = valueArr[3];
        $(opener.document).find("#courseTitle-input").val("과정아이디 : " + valueId + "  |  과정명 : " + valueTitle);
        $(opener.document).find("#course-input").val(value);
        $(opener.document).find("#courseId-input").val(valueId);
        $(opener.document).find("#courseYear-input").val(valueYear);
        
        const pathArr = location.pathname.split('/');
        const path = pathArr[2];
        
        // course 만 해당
        if(path.substring(10,25)==='course') {
            setUnavailableSubjectId('courseTitleClicked', valueId); // 과정 타이틀 클릭 시, 작성 해에 courseId에 등록된 강좌 리스트 반영하기
        }
        
        $.ajax({
        	url : 'selectsubjectlistbycourseid?courseId=' + valueId,
        	dataType : "json",
        	async : false,
        	success : function(result) {
        		if(result.length > 0) {
        			var table = $("<table class='courselist'/>");
        			var tr1 = $("<table class='courselist' border='1'/>").append(
        					$("<tr/>"),
                    		$("<td/>").text('강좌 아이디'),
            				$("<td/>").text('강좌 명'),
            				$("<td/>").text('강좌 기간'),
            				$("<td/>").text('강좌 시간'),
            				$("<td/>").text('일수'),
            				$("<td/>").text('시수'),
            				$("<td/>").text('난이도'),
            				$("<td/>").text('비용'),
            				$("<td/>").text('교육비 지원 여부')
            		);
            				
        			for(var i in result) {
        				var $subjectId = result[i].subjectId;
        				var $subjectTitle = result[i].subjectTitle;
        				var $startDay = result[i].startDay;
        				var $endDay = result[i].endDay;
        				var $startTime = result[i].startTime;
        				var $endTime = result[i].endTime;
        				var $days = result[i].days;
        				var $hours = result[i].hours;
        				var $levelCdTitle = result[i].levelCdTitle;
        				var $cost = result[i].cost;
        				var $supportYn = result[i].supportYn;
        				
        				var tr2 = tr1.append(
                				$("<tr/>"),
                				$("<td/>").text($subjectId),
                				$("<td/>").text($subjectTitle),
                				$("<td/>").text($startDay + ' ~ ' + $endDay),
                				$("<td/>").text($startTime + ' ~ ' + $endTime),
                				$("<td/>").text($days),
                				$("<td/>").text($hours),
                				$("<td/>").text($levelCdTitle),
                				$("<td/>").text($cost),
                				$("<td/>").text($supportYn)
                		);
        				table.append(tr2);
        			}
        			$(opener.document).find("#subject-list").html(table);
        		}
        	},
        	error : function(result) {
        		alert("에러" + JSON.stringify(result));
        	}
        
        });
        
    }
    
    if(valueId.substring(0,4)==='STDT') {
        let valueTitle = valueArr[1];
        let studentBirth = valueArr[2];
        let studentGenderTitle = valueArr[3];
        let studentEmail = valueArr[4];
        let studentPhone = valueArr[5];
        let studentAddDoTitle = valueArr[6];
        let studentAddEtc = valueArr[7];
        let studentPositionTitle = valueArr[8];
        
        $(opener.document).find("#studentTitle-input").val("수강생 아이디 : " + valueId + "  |  이름 : " + valueTitle);
        $(opener.document).find("#student-input").val(value);
        $(opener.document).find("#studentId-input").val(valueId);
        
        var ul = $("<ul/>");
        var li = $("<ul class='stu'/>").append(
				$("<li/>").text(' ' + '이름 : ' + valueTitle),
				$("<li/>").text(' ' + '성별 : ' + studentGenderTitle),
				$("<li/>").text(' ' + '생년월일 : ' + studentBirth),
				$("<li/>").text(' ' + '이메일 : ' + studentEmail),
				$("<li/>").text(' ' + '전화번호 : ' + studentPhone),
				$("<li/>").text(' ' + '주소 : ' + studentAddDoTitle + ' ' + studentAddEtc),
				$("<li/>").text(' ' + '직위 : ' + studentPositionTitle)
		);
		ul.append(li);
		$(opener.document).find("#student-list").html(ul);
        window.close();
    }
    // 팝업창 닫기
    window.close();
    return false;
}

/* 작성 해에 courseId에 등록된 강좌 리스트 insert.jsp에 반영하기 */
function setUnavailableSubjectId(valueId) {
    const now = new Date();
    const year = String(now.getFullYear());
    console.log(valueId, year);
    // 작성 해에 courseId에 등록된 강좌 리스트 가져오기
    $.ajax({
        url: 'selectOpenSubjectByCourseIdAndYear?courseId=' + valueId + '&year=' + year,
        type: 'GET',
        async : false,
        success: function(result) {
            console.log(result);
            const count = Object.keys(result).length;
            console.log(count);

            // 강좌 리스트에 담긴 만큼 반복해서 insert.jsp #subjectId-string의 value에 반영하기
            let subjectIdString = '';
            for(var i=0; i<count; i++) {
                subjectIdString += "/" + result[i].subjectId;
            }
            subjectIdString = String(subjectIdString).substring(1);
            console.log(subjectIdString);
            $(opener.document).find("#subjectId-string").val(subjectIdString);
            
            checkUnavailableSubjectId(result, count);
        },
        error : function () {
            console.log("error");
        }
    })
}

/* insert.jsp에 set한 강좌리스트값이랑 선택된 강좌값이랑 비교 후 일치하면 강좌값 reset */
function checkUnavailableSubjectId(result, count) {
    console.log("checkUnavailableSubjectId")
    console.log(result);
    console.log(count);
    const subjectIdInput = opener.document.getElementById('subjectId-input');  // insert.jsp에 선택된 subjectId
    const subjectTitleInput = opener.document.getElementById('subjectTitle-input');
    const subjectInput = opener.document.getElementById('subject-input');
    for(var i=0; i<count; i++) {
        console.log("for");
        if(result[i].subjectId===subjectIdInput.value) { // 강좌리스트에 insert.jsp에 선택된 subjectId가 있을 경우
            console.log("if");
            console.log(result[i].subjectId);
            subjectIdInput.removeAttribute("value");
            subjectTitleInput.value=null;
            subjectTitleInput.setAttribute("placeholder", "강좌를 다시 선택해주세요.");
            subjectInput.removeAttribute("value");
            alert("해당 과정에는 이미 선택하신 강좌가 존재합니다.\n강좌를 다시 선택해주세요.");
        }
    }
}

//const searchStudentBtn = document.getElementById('student-btn'); // 수강생 검색 버튼
//searchStudentBtn.addEventListener('click', studentList);

//function studentList() {
//    //const searchForm = document.getElementById('search-student-form'); // 검색 폼
//    /*let formInputs = '';
//    for(var i=1; i<searchForm.length-1; i++) {
//        formInputs += "&" + searchForm.elements[i].name + "=" + searchForm.elements[i].value;
//    }
//    let searchUrl = String(formInputs).substring(1);
//    const pathArr = location.pathname.split('/');
//    console.log(location.pathname);
//    console.log(pathArr);
//    const path = pathArr[2];
//    console.log(path + "-result?" + searchUrl);*/
//    $.ajax({
//        url : 'searchpop-student-result',
//        type : "POST"
//        
//    }).done(function(result){
//        var html = jQuery('<div>').html(result);
//        var contents = html.find("div#student-result-list").html();
//        $(".student-list-wrap").html(contents);
//        /*if(path.substring(10,20)==='subject') {
//            disableSubjectList();
//        } else if (path.substring(10,20)==='course') {
//            
//        }*/
//    })
//    
//}



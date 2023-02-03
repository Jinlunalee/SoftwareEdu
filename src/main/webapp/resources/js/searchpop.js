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
    if(opener.document.getElementById('subjectSeq-string')){
        const subjectSeqString = opener.document.getElementById('subjectSeq-string'); // 부모창에 있는 hidden input
        $(subjectSeqString).clone().appendTo(unavailablePop);
    }
    if(opener.document.getElementById('courseId-string')){
        const courseIdString = opener.document.getElementById('courseId-string'); // 부모창에 있는 hidden input
        $(courseIdString).clone().appendTo(unavailablePop);
    }
    if(opener.document.getElementById('courseOpenYear-string')){
        const courseOpenYearString = opener.document.getElementById('courseOpenYear-string'); // 부모창에 있는 hidden input
        $(courseOpenYearString).clone().appendTo(unavailablePop);
    }
}

/* 검색 결과 리스트 출력 함수 */
function showList() {
    const searchForm = document.getElementById('search-form'); // 검색 폼
    let formInputs = '';
    for(var i=1; i<searchForm.length-1; i++) {
        formInputs += "&" + searchForm.elements[i].name + "=" + searchForm.elements[i].value;
    }
    let searchUrl = String(formInputs).substring(1);
    const pathArr = location.pathname.split('/');
    const path = pathArr[2];
    console.log(path + '-result?' + searchUrl);
    $.ajax({
        url : path + "-result?" + searchUrl,
        type : "POST",
        contentType: "application/json; charset:UTF-8"  // 한글이 물음표로 깨져서 나오는 현상 방지
    }).done(function(result){
        var html = jQuery('<div>').html(result);
        var contents = html.find("div#result-list").html();
        $(".list-wrap").html(contents);
        
        /* 불러온 리스트에서 수행할 작업 ex. 제한조건 */
        // 강좌 검색 팝업
        if(path.substring(10,25)==='subject') { 
            const subjectInsertSubject = 'SubjectInsertSubject';
            disableHiddenBringValueList(subjectInsertSubject); // 강좌 개설 : 과정에 이미 담긴 강좌는 개설하지 못하게 강좌 클릭 방지

        // 과정 검색 팝업
        } else if (path.substring(10,25)==='course') { 
            const subjectInsertCourse = 'SubjectInsertCourse';
            disableHiddenBringValueList(subjectInsertCourse); // 강좌 개설 : 과정에 이미 담긴 강좌는 개설하지 못하게 하기 과정 클릭 방지

        // 개설 강좌 검색 팝업
        } else if (path.substring(10,25)==='opensubject') { 
            const enrollInsertOpenSubject = 'EnrollInsertOpenSubject';
            disableHiddenBringValueList(enrollInsertOpenSubject); // 수강 추가 : 수강생이 이미 수강했거나 수강하는 강좌는 팝업띄워서 안눌리게 하기


        // 개설 과정 검색 팝업
        } else if (path.substring(10,25)==='opencourse') {
            const enrollInsertOpenCourse = 'EnrollInsertOpenCourse';
            disableHiddenBringValueList(enrollInsertOpenCourse); // 수강 추가 : 수강생이 이미 수강했거나 수강하는 강좌는 팝업띄워서 안눌리게 하기


        // 수강생 검색 팝업
        } else if (path.substring(10,25)==='student'){ 


        // 개설 강좌 완료 검색 팝업
        } else if (path.substring(10,30)==='opensubjectDone') { 

        }
    })
}

/* bringValue로 가져온 강좌아이디에 해당하는 showList 리스트는 비활성화하기 */
function disableHiddenBringValueList(value) {
    console.log('disableHiddenBringValueList');

    if(value==='SubjectInsertSubject') {
        console.log('SubjectInsertSubject');
        const subjectIdString = document.getElementById('subjectId-string').value;
        if(subjectIdString){
            const subjectIdArr = subjectIdString.split('/');
            for(var i=0; i<subjectIdArr.length; i++) {
                let id = String(subjectIdArr[i]);
                let boardSubjectId = document.getElementById(id);
                console.log(boardSubjectId);
                if(boardSubjectId) {
                    boardSubjectId.removeAttribute("onclick");
                    boardSubjectId.setAttribute("onclick", 'alert("과정에 동일한 강좌를 개설할 수 없습니다.")');
                }
            }
        }
    } else if(value==='SubjectInsertCourse') {
        console.log('SubjectInsertCourse');
        const courseIdString = document.getElementById('courseId-string').value;
        const courseIdArr = courseIdString.split('/');
        for(var i=0; i<courseIdArr.length; i++) {
            let id = String(courseIdArr[i]);
            let boardCourseId = document.getElementById(id);
            console.log(boardCourseId);
            if(boardCourseId) {
                boardCourseId.removeAttribute("onclick");
                boardCourseId.setAttribute("onclick", 'alert("과정에 동일한 강좌를 개설할 수 없습니다.")');
            }
        }
    } else if(value==='EnrollInsertOpenSubject') {
        console.log('EnrollInsertOpenSubject');
        const subjectIdString = document.getElementById('subjectId-string').value;
        const subjectSeqString = document.getElementById('subjectSeq-string').value;
        const subjectIdArr = subjectIdString.split('/');
        const subjectSeqArr = subjectSeqString.split('/');
        for(var i=0; i<subjectIdArr.length; i++) {
            let id = String(subjectIdArr[i]);
            let seq = String(subjectSeqArr[i]);
            let idSeq = id+'-'+seq;
            for(var j=0; j<document.getElementsByClassName(idSeq).length; j++) {
                document.getElementsByClassName(idSeq)[j].removeAttribute("onclick");
                document.getElementsByClassName(idSeq)[j].setAttribute("onclick", 'alert("이미 해당 강좌/과정을 수강신청하였습니다.")');
            }
        }
    } else if(value==='EnrollInsertOpenCourse'){
        console.log('EnrollInsertOpenCourse');
        const courseIdString = document.getElementById('courseId-string').value;
        const courseOpenYearString = document.getElementById('courseOpenYear-string').value;
        const courseIdArr = courseIdString.split('/');
        const courseOpenYearArr = courseOpenYearString.split('/');
        for(var i=0; i<courseIdArr.length; i++) {
            let id = String(courseIdArr[i]);
            let openYear = String(courseOpenYearArr[i]);
            let idOpenYear = id + '-' + openYear;
            for(var j=0; j<document.getElementsByClassName(idOpenYear).length; j++) {
                document.getElementsByClassName(idOpenYear)[j].removeAttribute("onclick");
                document.getElementsByClassName(idOpenYear)[j].setAttribute("onclick", 'alert("이미 해당 강좌/과정을 수강신청하였습니다.")');
            }
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
        let valueSeq = valueArr[1];
        let valueTitle = valueArr[2];
        let openDt = valueArr[3];
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
        
        $(opener.document).find("#subjectTitle-input").val(valueTitle + " (" + valueId + ")  |  등록일자 : " + openDt);
        $(opener.document).find("#subject-input").val(value);
        $(opener.document).find("#subjectId-input").val(valueId);

        const pathArr = location.pathname.split('/');
        const path = pathArr[2];

        // 강좌개설 : subject만 해당
        if(path.substring(10,25)==='subject') {
            // 과정 타이틀 클릭 시, 작성 해에 courseId에 등록된 강좌 리스트 반영하기
            setUnavailableSubjectId('subjectTitleClicked', valueId); 

        // 만족도 조사 : open subject done만 해당, 통계 테이블 보여주기
        } else if(path.substring(10,30)==='opensubjectDone') { 
            viewSummary(valueId, valueSeq);

        // 수강추가 : open subject만 해당, 선택한 강좌 정보 보여주기
        } else if(path.substring(10,30)==='opensubject') { 
            var table = $("<table class='subjectdetails'/>");
            var tr = $("<table class='subjectdetails' border='1'/>").append(
                    $("<tr/>"),
                    $("<td class='subject-th'/>").text('연수 기간'),
                    $("<td class='subject-th'/>").text('신청 기간'),
                    $("<td class='subject-th'/>").text('일수'),
                    $("<td class='subject-th'/>").text('시수'),
                    $("<td class='subject-th'/>").text('모집 인원'),
                    $("<td class='subject-th'/>").text('강좌 분류'),
                    $("<td class='subject-th'/>").text('개설 상태'),
                    $("<td class='subject-th'/>").text('난이도 (기타)'),
                    $("<tr/>"),
                    $("<td/>").text(startDay + ' ~ ' + endDay),
                    $("<td/>").text(recruitStartDay + ' ~ ' + recruitEndDay),
                    $("<td/>").text(days),
                    $("<td/>").text(hours),
                    $("<td/>").text(recruitPeople),
                    $("<td/>").text(catSubjectCdTitle),
                    $("<td/>").text(openStateCdTitle),
                    $("<td/>").text(levelCdTitle + '(' + levelEtc + ')')
            );
            table.append(tr);
            $(opener.document).find("#subject-list").html(table);
            }
    }
    // find()함수로 반영할 곳을 찾아서 값 반영하기 - 과정일 경우
    if(valueId.substring(0,4)==='CRSE') {
        let valueTitle = valueArr[2];
        let valueYear = valueArr[3];
        $(opener.document).find("#courseTitle-input").val(valueTitle + " (" + valueId + ")");
        $(opener.document).find("#course-input").val(value);
        $(opener.document).find("#courseId-input").val(valueId);
        $(opener.document).find("#courseYear-input").val(valueYear);
        
        const pathArr = location.pathname.split('/');
        const path = pathArr[2];
        
        // 강좌개설 : course만 해당
        if(path.substring(10,25)==='course') {
            // 과정 타이틀 클릭 시, 작성 해에 courseId에 등록된 강좌 리스트 반영하기
            setUnavailableSubjectId('courseTitleClicked', valueId); 
        }

        // 수강추가 : open course만 해당
        if(path.substring(10,25)==='opencourse') {
            // 선택한 과정 정보 반영하기
            $.ajax({
                url : 'selectsubjectlistbycourseid?courseId=' + valueId,
                dataType : "json",
                async : false,
                success : function(result) {
                    if(result.length > 0) {
                        var table = $("<table class='courselist'/>");
                        var tr1 = $("<table class='courselist' border='1'/>").append(
                                $("<tr/>"),
                                $("<td class='course-th'/>").text('강좌 아이디'),
                                $("<td class='course-th'/>").text('강좌 명'),
                                $("<td class='course-th'/>").text('연수 기간'),
                                $("<td class='course-th'/>").text('연수 시간'),
                                $("<td class='course-th'/>").text('일수'),
                                $("<td class='course-th'/>").text('시수'),
                                $("<td class='course-th'/>").text('난이도'),
                                $("<td class='course-th'/>").text('비용'),
                                $("<td class='course-th'/>").text('교육비 지원 여부')
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
                            
                            if($supportYn === 'Y') {
                            	$supportYn = '지원 가능'
                            }else if($supportYn === 'N') {
                            	$supportYn = '지원 불가'
                            }
                            
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
    }

    // find()함수로 반영할 곳을 찾아서 값 반영하기 - 학생일 경우
    if(valueId.substring(0,4)==='STDT') {
        let valueTitle = valueArr[1];
        let studentBirth = valueArr[2];
        let studentGenderTitle = valueArr[3];
        let studentEmail = valueArr[4];
        let studentPhone = valueArr[5];
        let studentAddDoTitle = valueArr[6];
        let studentAddEtc = valueArr[7];
        let studentPositionTitle = valueArr[8];
        
        $(opener.document).find("#studentTitle-input").val(valueTitle + " (" + valueId + ")");
        $(opener.document).find("#student-input").val(value);
        $(opener.document).find("#studentId-input").val(valueId);
        
        // 수강생 정보 반영하기
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
        
        opener.document.getElementById('subject-btn').removeAttribute("disabled"); // 수강생 선택하면 강좌 검색 버튼 활성화
        opener.document.getElementById('course-btn').removeAttribute("disabled"); // 수강생 선택하면 과정 검색 버튼 활성화
        
        resetValue();    // 강좌/과정 검색 리셋

        setUnavailableSubjectId('studentNameClicked', valueId); // 수강생 이름 클릭 시, 수강생이 수강했거나 수강하고 있는 개설강좌 리스트 반영하기
    }
    // 팝업창 닫기
    setTimeout(function(){
        window.close();
    }, 900);

    return false;
}

/* 만족도 조사 : 통계 조회 버튼 누를 시 통계 테이블 보여주기 */
function viewSummary(subjectId, subjectSeq){
    $.ajax({
        url : "getjson?subjectId=" + subjectId + "&subjectSeq=" + subjectSeq,
        type : "GET",
        async : false,
        success : function(data){
            console.log(data);
            showTableChart(data); // subject에 따른 table chart 보여주기
            showBarChart(data); // subject에 따른 bar chart 보여주기
        },
        error:function(e){
            alert("요청에 실패했습니다. 관리자에게 문의하세요.");
        }
    });
};

/* 불가능한 강좌리스트 OPENER에 반영하기 */
function setUnavailableSubjectId(section, valueId) {
    console.log('setUnavailableSubjectId');
    console.log(section)

    // 강좌개설 : 작성 해에 courseId에 등록된 강좌 리스트 insert.jsp에 반영하기
    if(section==='courseTitleClicked') {
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

                // 리스트에 담긴 만큼 반복해서 insert.jsp #subjectId-string의 value에 반영하기
                let subjectIdString = '';
                for(var i=0; i<count; i++) {
                    subjectIdString += "/" + result[i].subjectId;
                }
                subjectIdString = String(subjectIdString).substring(1);
                console.log(subjectIdString);
                $(opener.document).find("#subjectId-string").val(subjectIdString);
                
                // checkUnavailableSubjectId(result, count); // reset시키기
            },
            error : function () {
                alert("error");
            }
        })

    // 강좌개설 : 작성 해에 subjectId에 등록된 과정 리스트 insert.jsp에 반영하기
    } else if(section==='subjectTitleClicked'){
        const now = new Date();
        const year = String(now.getFullYear());
        console.log(valueId, year);
        // 작성 해에 subjectId에 등록된 과정 리스트 가져오기
        $.ajax({
            url: 'selectOpenCourseBySubjectIdAndYear?subjectId=' + valueId + '&year=' + year,
            type: 'GET',
            async : false,
            success: function(result) {
                console.log(result);
                const count = Object.keys(result).length;
                console.log(count);

                // 리스트에 담긴 만큼 반복해서 insert.jsp #courseId-string의 value에 반영하기
                let courseIdString = '';
                for(var i=0; i<count; i++) {
                    courseIdString += "/" + result[i].courseId;
                }
                courseIdString = String(courseIdString).substring(1);
                console.log(courseIdString);
                $(opener.document).find("#courseId-string").val(courseIdString);
                
                // checkUnavailableSubjectId(result, count); // reset시키기
            },
            error : function () {
                alert("error");
            }
        })

    // 수강추가 : 수강생이 수강했거나 수강하고 있는 개설강좌 리스트 반영하기
    } else if(section==='studentNameClicked') {
        $.ajax({
            url : 'selectOpenSubjectByStudentId?studentId=' + valueId,
            type : 'GET',
            async : false,
            success : function(result) {
                console.log(result);
                const count = Object.keys(result).length;
                console.log(count);

                // 리스트에 담긴 만큼 반복해서 insert.jsp #subjectId-string #subjectSeq-string #courseId-String #courseOpenYear-String의 value에 반영하기
                let subjectIdString = '';
                let subjectSeqString = '';
                let courseIdString = '';
                let courseOpenYearString = '';
                for(var i=0; i<count; i++) {
                    subjectIdString += "/" + result[i].subjectId;
                    subjectSeqString += "/" + result[i].subjectSeq;
                    courseIdString += "/" + result[i].courseId;
                    courseOpenYearString += "/" + result[i].courseOpenYear;
                }
                subjectIdString = String(subjectIdString).substring(1);
                subjectSeqString = String(subjectSeqString).substring(1);
                courseIdString = String(courseIdString).substring(1);
                courseOpenYearString = String(courseOpenYearString).substring(1);
                console.log(subjectIdString);
                console.log(subjectSeqString);
                console.log(courseIdString);
                console.log(courseOpenYearString);
                $(opener.document).find("#subjectId-string").val(subjectIdString);
                $(opener.document).find("#subjectSeq-string").val(subjectSeqString);
                $(opener.document).find("#courseId-string").val(courseIdString);
                $(opener.document).find("#courseOpenYear-string").val(courseOpenYearString);

            },
            error : function() {
                alert('error');
            }
        })
    } 
}

/* 강좌개설 : insert.jsp에 set한 강좌리스트값이랑 선택된 강좌값이랑 비교 후 일치하면 강좌값 reset */
function checkUnavailableSubjectId(result, count) {
    console.log("checkUnavailableSubjectId")
    console.log(result);
    console.log(count);
    const subjectIdInput = opener.document.getElementById('subjectId-input');  // insert.jsp에 선택된 subjectId
    const subjectTitleInput = opener.document.getElementById('subjectTitle-input');
    const subjectInput = opener.document.getElementById('subject-input');
    for(var i=0; i<count; i++) {
        if(result[i].subjectId===subjectIdInput.value) { // 강좌리스트에 insert.jsp에 선택된 subjectId가 있을 경우
            console.log(result[i].subjectId);
            subjectIdInput.removeAttribute("value");
            subjectTitleInput.value=null;
            subjectTitleInput.setAttribute("placeholder", "강좌를 다시 선택해주세요.");
            subjectInput.removeAttribute("value");
            alert("해당 과정에는 이미 선택하신 강좌가 존재합니다.\n강좌를 다시 선택해주세요.");
        }
    }
}

/* 수강추가 : 강좌/과정 선택값 리셋하기 */
function resetValue() {
    console.log('resetValue');
    // const subjectIdInput = opener.document.getElementById('subjectId-input');
    const subjectTitleInput = opener.document.getElementById('subjectTitle-input');
    const subjectInput2 = opener.document.getElementById('subject-input'); // subjectInput이 이미 있다고 떠서 2 붙임
    // const courseIdInput = opener.document.getElementById('courseId-input');
    const courseTitleInput = opener.document.getElementById('courseTitle-input');
    const courseInput2 = opener.document.getElementById('course-input');
    const subjectList = opener.document.getElementById('subject-list');
    if(subjectTitleInput.value || courseTitleInput.value) {
        // subjectIdInput.removeAttribute("value");
        subjectTitleInput.value=null;
        subjectTitleInput.setAttribute("placeholder", "수강생 선택 후 검색 버튼을 눌러 강좌를 검색하세요.");
        subjectInput2.removeAttribute("value");
        // courseIdInput.removeAttribute("value");
        courseTitleInput.value=null;
        courseTitleInput.setAttribute("placeholder", "수강생 선택 후 검색 버튼을 눌러 과정을 검색하세요.");
        courseInput2.removeAttribute("value");
        subjectList.innerText=null;
        alert("수강생을 다시 선택하였습니다. 강좌/과정을 다시 선택해주세요.");
    }
}
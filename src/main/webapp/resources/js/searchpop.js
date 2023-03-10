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
    $.ajax({
        url : path + "-result?" + searchUrl,
        type : "POST",
        contentType: "application/json; charset:UTF-8"
    }).done(function(result){
        var html = jQuery('<div>').html(result); // <div>를 jQuery객체를 만들고, ajax결과(jsp)를 html에 담음
        var contents = html.find("div#result-list").html();  // ajax결과(jsp)에서 #result-list <div>를 찾아 그 내용을 contents에 담음
        $(".list-wrap").html(contents); // #result-list <div>의 내용을 .list-wrap에 넣음
        
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
        studentInput.setAttribute("name", 'userId');
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
        let totalPeople = valueArr[17];

        $(opener.document).find("#subjectTitle-input").val(valueTitle + " (" + valueId + ") " + valueSeq + "회차  |  개설연도 : " + openDt);
        $(opener.document).find("#subject-input").val(value);
        $(opener.document).find("#subjectId-input").val(valueId);

        const pathArr = location.pathname.split('/');
        const path = pathArr[2];

        // 강좌개설 : subject만 해당
        if(path.substring(10,25)==='subject') {
            // 과정 타이틀 클릭 시, 작성 해에 courseId에 등록된 강좌 리스트 반영하기
            $(opener.document).find("#subjectTitle-input").val(valueTitle + " (" + valueId + ") " + "  |  등록연도 : " + openDt);
            checkHideFirst(); //강좌/과정 다시선택 
            setUnavailableSubjectId('subjectTitleClicked', valueId); 

        // 만족도 조사 : open subject done만 해당, 통계 테이블 보여주기
        } else if(path.substring(10,30)==='opensubjectDone') { 
            viewSummary(valueId, valueSeq);

        // 수강추가 : open subject만 해당, 선택한 강좌 정보 보여주기
        } else if(path.substring(10,30)==='opensubject') { 

            // 난이도 정해놓기
            let levelString;
            if(levelEtc === '') {
                levelString = levelCdTitle;
            }
            else{
                levelString = levelEtc;
            }

            var table = $("<table class='result-table' border='1'/>");
            var tr = table.append($("<tr class='result-tr'/>").append(
                    $("<th class='result-th'/>").text('강좌기간'),
                    $("<th class='result-th'/>").text('모집기간'),
                    $("<th class='result-th'/>").text('시수(시간)'),
                    $("<th class='result-th'/>").text('모집인원'),
                    $("<th class='result-th'/>").text('강좌분류'),
                    $("<th class='result-th'/>").text('개설상태'),
                    $("<th class='result-th'/>").text('난이도')
            ));
            table.append(tr);
            var tr = table.append($("<tr class='result-tr'/>").append(
                $("<td class='result-td'/>").text(startDay + ' ~ ' + endDay),
                $("<td class='result-td'/>").text(recruitStartDay + ' ~ ' + recruitEndDay),
                $("<td class='result-td'/>").text(hours),
                $("<td class='result-td'/>").text(totalPeople + '/' + recruitPeople),
                $("<td class='result-td'/>").text(catSubjectCdTitle),
                $("<td class='result-td'/>").text(openStateCdTitle),
                $("<td class='result-td'/>").text(levelString)
            ));
            table.append(tr);
            $(opener.document).find("#subject-list").html(table);
            }
    }
    // find()함수로 반영할 곳을 찾아서 값 반영하기 - 과정일 경우
    if(valueId.substring(0,4)==='CRSE') {
        let valueTitle = valueArr[2];
        let valueYear = valueArr[3];
        
        $(opener.document).find("#courseTitle-input").val(valueTitle + " (" + valueId + ") | 개설연도 : " + valueYear);
        $(opener.document).find("#course-input").val(value);
        $(opener.document).find("#courseId-input").val(valueId);
        $(opener.document).find("#courseYear-input").val(valueYear);
        
        const pathArr = location.pathname.split('/');
        const path = pathArr[2];
        
        // 강좌개설 : course만 해당
        if(path.substring(10,25)==='course') {
            // 과정 타이틀 클릭 시, 작성 해에 courseId에 등록된 강좌 리스트 반영하기
            if(valueYear === '0'){
                valueYear = '신규 개설 과정';
            }else {
                valueYear = '2023';
            }

            $(opener.document).find("#courseTitle-input").val(valueTitle + " (" + valueId + ") | 개설연도 : " + valueYear);
            checkHideFirst(); //강좌/과정 다시선택
            setUnavailableSubjectId('courseTitleClicked', valueId); 

        }

        // 수강추가 : open course만 해당
        if(path.substring(10,25)==='opencourse') {
        	const courseOpenYear = valueArr[3];
            // 선택한 과정 정보 반영하기
            $.ajax({
                url : 'selectsubjectlistbycourseid?courseId=' + valueId + '&courseOpenYear=' + courseOpenYear,
                dataType : "json",
                async : false,
                success : function(result) {
                    if(result.length > 0) {
                        var table = $("<table class='result-table' border='1'/>");
                        var tr1 = table.append($("<tr class='result-tr'/>").append(
                                $("<th class='result-th'/>").text('강좌아이디'),
                                $("<th class='result-th'/>").text('회차'),
                                $("<th class='result-th'/>").text('강좌명'),
                                $("<th class='result-th'/>").text('강좌기간'),
                                $("<th class='result-th'/>").text('강좌시간'),
                                $("<th class='result-th'/>").text('시수(시간)'),
                                $("<th class='result-th'/>").text('난이도'),
                                $("<th class='result-th'/>").text('교육비(원)'),
                                $("<th class='result-th'/>").text('교육비지원여부')
                        ));
                                    
                        for(var i in result) {
                            console.log(result);
                            var $subjectId = result[i].subjectId;
                            var $subjectSeq = result[i].subjectSeq;
                            var $subjectTitle = result[i].subjectTitle;
                            var $startDay = result[i].startDay;
                            var $endDay = result[i].endDay;
                            var $startTime = result[i].startTime;
                            var $endTime = result[i].endTime;
                            var $hours = result[i].hours;
                            var $levelCdTitle = result[i].levelCdTitle;
                            var $levelEtc = result[i].levelEtc;
                            var $cost = result[i].cost;
                            $cost = $cost.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','); // 비용 콤마 처리
                            var $supportYn = result[i].supportYn;
                            
                            if($supportYn === 'Y') {
                                $supportYn = '지원 가능'
                            }else if($supportYn === 'N') {
                                $supportYn = '지원 불가'
                            }
                            // 난이도 정해놓기
                            let levelString;
                            if(!$levelEtc) {
                                levelString = $levelCdTitle;
                            }
                            else{
                                levelString = $levelEtc;
                            }
                            
                            var tr2 = table.append($("<tr class='result-tr'/>").append(
                                    $("<td class='result-td'/>").text($subjectId),
                                    $("<td class='result-td'/>").text($subjectSeq),
                                    $("<td class='result-td'/>").text($subjectTitle),
                                    $("<td class='result-td'/>").text($startDay + ' ~ ' + $endDay),
                                    $("<td class='result-td'/>").text($startTime + ' ~ ' + $endTime),
                                    $("<td class='result-td'/>").text($hours),
                                    $("<td class='result-td'/>").text(levelString),
                                    $("<td class='result-td'/>").text($cost),
                                    $("<td class='result-td'/>").text($supportYn)
                            ));
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
        let studentUserId = valueArr[9];
        
        $(opener.document).find("#studentTitle-input").val(valueTitle + " (" + studentUserId + ")");
        $(opener.document).find("#student-input").val(value);
        $(opener.document).find("#studentId-input").val(valueId);
        
        // 수강생 정보 반영하기
        var table = $("<table class='result-table' border='1'/>");
        var tr = table.append($("<tr class='result-tr'/>").append(
            $("<th class='result-th'/>").text('이름'),
            $("<th class='result-th'/>").text('성별'),
            $("<th class='result-th'/>").text('생년월일'),
            $("<th class='result-th'/>").text('이메일'),
            $("<th class='result-th'/>").text('전화번호'),
            $("<th class='result-th'/>").text('직위')
        ));
        table.append(tr);
        var tr = table.append($("<tr class='result-tr'/>").append(
            $("<td class='result-td'/>").text(valueTitle),
            $("<td class='result-td'/>").text(studentGenderTitle),
            $("<td class='result-td'/>").text(studentBirth),
            $("<td class='result-td'/>").text(studentEmail),
            $("<td class='result-td'/>").text(studentPhone),
            $("<td class='result-td'/>").text(studentPositionTitle)
        ));
        table.append(tr);
		$(opener.document).find("#student-list").html(table);
        
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

/* 만족도 조사 : 강좌명 누를 시 통계 테이블 보여주기 */
function viewSummary(subjectId, subjectSeq){
    opener.document.querySelector('#chart-table').innerHTML=''; // 리셋
    opener.document.querySelector('#chart-bar').innerHTML=''; // 리셋
    $.ajax({
        url : "getjson?subjectId=" + subjectId + "&subjectSeq=" + subjectSeq,
        type : "GET",
        async : false,
        success : function(data){
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

/*hide-fist가 없으면 alert창 띄우고 다시 숨겨주기*/
function checkHideFirst() {
    const removeHide = opener.document.getElementsByClassName('remove-hide').length;
    const hideFirst = opener.document.getElementsByClassName('remove-hide hide-first');

    if(hideFirst.length == 0){ // 입력창이 나와있을때
        alert("강좌/과정을 다시 선택했습니다. 선택완료 버튼을 눌러 상세정보를 입력해주세요.");
        addHideFirst();
    }
}

/*검색버튼 클릭시 remove-hide 클래스에서 hide-first 크래스 추가하기*/
function addHideFirst() {
    const removeHide = opener. document.getElementsByClassName('remove-hide');
     /*검색버튼 클릭 시 remove-hide 클래스에서 hide-first 클래서 추가하기*/
     for(let i=0; i<removeHide.length; i++) {
        removeHide[i].classList.add("hide-first");
    }
}

const closeBtn = document.getElementById('close-btn');
closeBtn.addEventListener("click", closePop);

function closePop() {
    close();
}
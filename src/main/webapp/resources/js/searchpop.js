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
    const pathArr = location.pathname.split('/');
    const path = pathArr[3];
    console.log(path + "-result?" + searchUrl);
    $.ajax({
        url : path + "-result?" + searchUrl,
        type : "POST",
        contentType: "application/json; charset:UTF-8"  // 한글이 물음표로 깨져서 나오는 현상 방지
    }).done(function(result){
        var html = jQuery('<div>').html(result);
        var contents = html.find("div#result-list").html();
        $(".list-wrap").html(contents);
        if(path.substring(10,20)==='subject') {
            disableSubjectList();
        } else if (path.substring(10,20)==='course') {
            
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

function disableCourseList() {
    const now = new Date();
    const year = String(now.getFullYear());
    // 해당 연도에 이미 개설된 과정 선택 시
    $.ajax({
        url : 'selectCourseByYear?year=' + year,
        type: "GET",
        success: function(result) {
            console.log(result);
        }
    })
}



/* ㅇㅇ명/ㅇㅇ아이디 선택에 따른 input name 설정 */
let subjectInput = document.getElementById('subject-input'); // input 태그
let courseInput = document.getElementById('course-input'); // input 태그

function putNameonInput(value) { // ㅇㅇ강좌명/ㅇㅇ강좌아이디 선택에 따라 iput 이름 설정
    if(value==='subjectId') {
        subjectInput.setAttribute("name", 'subjectId');
    } else if(value==='subjectTitle') {
        subjectInput.setAttribute("name", 'subjectTitle');
    } else if(value==='courseId') {
        courseInput.setAttribute("name", 'courseId');
    } else {
        courseInput.setAttribute("name", 'courseTitle');
    }
}




/* ㅇㅇ명 클릭했을 시 팝업창 닫기 및 선택값 반영하기  */
function moveOutside(event, value){
    event.preventDefault();

    console.log(value);
    let valueArr = value.split('/');
    let valueId = valueArr[0];
    console.log(valueId.substring(0,4));
    // find()함수로 반영할 곳을 찾아서 값 반영하기
    if(valueId.substring(0,4)==='SUBJ') {
        let valueTitle = valueArr[2];
        let reg = valueArr[3];
        $(opener.document).find("#subjectTitle-input").val("강좌아이디 : " + valueId + "  |  강좌명 : " + valueTitle + "  |  등록일자 : " + reg);
        $(opener.document).find("#subject-input").val(value);
        $(opener.document).find("#subjectId-input").val(valueId);
        console.log("it's subject");
        window.close();
    }
    if(valueId.substring(0,4)==='CRSE') {
        let valueTitle = valueArr[2];
        $(opener.document).find("#courseTitle-input").val("과정아이디 : " + valueId + "  |  강좌명 : " + valueTitle);
        $(opener.document).find("#course-input").val(value);
        $(opener.document).find("#courseId-input").val(valueId);
        
        // 작성 해에 courseId에 등록된 강좌 리스트 가져오기
        const now = new Date();
        const year = String(now.getFullYear());
        console.log(valueId, year);
        $.ajax({
            url: 'selectOpenSubjectByCourseIdAndYear?courseId=' + valueId + '&year=' + year,
            type: 'GET',
            success: function(result) {
                console.log(result);
                const count = Object.keys(result).length;
                console.log(count);

                // 강좌 리스트에 담긴 만큼 반복해서 insert.jsp #unavailable-list에 추가하기
                let subjectIdString = '';
                for(var i=0; i<count; i++) {
                    subjectIdString += "/" + result[i].subjectId;
                }
                subjectIdString = String(subjectIdString).substring(1);
                console.log(subjectIdString);
                $(opener.document).find("#subjectId-string").val(subjectIdString);
                
                // 팝업 종료
                window.close();
            },
            error : function () {
                console.log("error");
            }
        })
    }
    return false;
}
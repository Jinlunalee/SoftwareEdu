$(document).ready(function() {
});

/* 검색조건 입력 후 버튼 클릭 시 검색 결과 리스트 출력 */
const searchBtn = document.getElementById('search-btn'); // 검색 버튼
searchBtn.addEventListener('click', showList);

function showList() { // 검색 결과 리스트 출력 함수
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
    }
    if(valueId.substring(0,4)==='CRSE') {
        let valueTitle = valueArr[2];
        $(opener.document).find("#courseTitle-input").val("과정아이디 : " + valueId + "  |  강좌명 : " + valueTitle);
        $(opener.document).find("#course-input").val(value);
        $(opener.document).find("#courseId-input").val(valueId);
        console.log("it's course");
    }

    window.close();

    return false;
}
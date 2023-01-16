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
    $.ajax({
        url : "opensubjectsearchpop2?" + searchUrl,
        type : "POST",
        contentType: "application/json; charset:UTF-8"  // 한글이 물음표로 깨져서 나오는 현상 방지
    }).done(function(result){
        var html = jQuery('<div>').html(result);
        var contents = html.find("div#result-list").html();
        $(".list-wrap").html(contents);
    })
}

/* 강좌명/강좌아이디 선택에 따른 input name 설정 */
let subjectInput = document.getElementById('subject-input'); // input 태그

function putNameonInput(value) { // 강좌명/강좌아이디 선택에 따라 iput 이름 설정
    if(value==='subjectId') {
        subjectInput.setAttribute("name", 'subjectId');
    } else {
        subjectInput.setAttribute("name", 'subjectTitle');
    }
}

/* 강좌명 선택했을 시 팝업창 닫기 및 선택값 반영하기  */
function moveOutside(subject){
    console.log(subject);
    let subjectArr = subject.split('/');
    let subjectId = subjectArr[0];
    let subjectTitle = subjectArr[2];
    let regDt = subjectArr[3];

    // find()함수로 반영할 곳을 찾아서 값 반영하기
    $(opener.document).find("#subjectTitle-input").val("강좌아이디 : " + subjectId + "  |  강좌명 : " + subjectTitle + "  |  등록일자 : " + regDt);
    $(opener.document).find("#subject-input").val(subject);

    window.close();
}
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
    console.log(searchUrl);
    $.ajax({
        url : "opensubjectsearchpop2?" + searchUrl,
        type : "GET",
        success : function(data) {
            console.log(data);
            console.log("working!");
            var html = jQuery('<div>').html(result);
            var contents = html.find("div#result-list").html();
            $(".list-wrap").html(contents);
        }
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

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
        // success : function(result) {
        //     console.log(result);
        //     console.log("working!");
        //     var html = jQuery('<div>').html(result);
        //     var contents = html.find("div#result-list").html();
        //     $(".list-wrap").html(contents);
        // }
    }).done(function(result){
        console.log(result);
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
$(".move").on("click", function(event){
    event.preventDefault(); // 왜 안 먹지?!?!?!?!?!?!?!?!?

    let subject = $(this).attr("href");
    let subjectTitle = $(this).attr("name");
    let subjectArr = subject.split('/');
    console.log(subjectArr);
    let subjectId = subjectArr[0];
    let subjectSeq = subjectArr[1];
    let regDt = subjectArr[2];
    $(opener.document).find("#subjectTitle-input").val(subjectTitle);
    $(opener.document).find("#subjectId-input").val(subjectId);
    $(opener.document).find("#subjectSeq-input").val(subjectSeq);
    $(opener.document).find("#regDt-input").val(regDt);

    window.close();

});

// function moveOutside(subject, subjectTitle, event){

//     event.preventDefault();

//     let subjectArr = subject.split('/');
//     let subjectId = subjectArr[0];
//     let subjectSeq = subjectArr[1];
//     let regDt = subjectArr[2];
//     $(opener.document).find("#subjectTitle-input").val(subjectTitle);
//     $(opener.document).find("#subjectId-input").val(subjectId);
//     $(opener.document).find("#subjectSeq-input").val(subjectSeq);
//     $(opener.document).find("#regDt-input").val(regDt);

//     window.close();
// }
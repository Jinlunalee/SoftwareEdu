/* open subject 검색 버튼 누를 시 검색 팝업 실행 */
$('.open-subject-popup-btn').on("click", function(e){
    //버튼 창 전환 방지
    e.preventDefault();

    // 팝업창 실행
    let popupUrl = "/common/searchpop-opensubject";
    let popupOption = "width = 1300px, height=550px, top=200px, left=200px, scrollbars=yes";

    window.open(popupUrl,"개설 강좌 검색", popupOption);
});

/* 완료 open subject 검색 버튼 누를 시 검색 팝업 실행 */
$('.open-subject-done-popup-btn').on("click", function(e){
    //버튼 창 전환 방지
    e.preventDefault();

    // 팝업창 실행
    let popupUrl = "/common/searchpop-opensubjectDone";
    let popupOption = "width = 1300px, height=550px, top=200px, left=200px, scrollbars=yes";

    window.open(popupUrl,"완료 강좌 검색", popupOption);
});

/* open course 검색 버튼 누를 시 검색 팝업 실행 */
$('.open-course-popup-btn').on("click", function(e){
    //버튼 창 전환 방지
    e.preventDefault();

    // 팝업창 실행
    let popupUrl = "/common/searchpop-opencourse";
    let popupOption = "width = 1300px, height=550px, top=200px, left=200px, scrollbars=yes";

    window.open(popupUrl,"개설 과정 검색", popupOption);
});

/* subject 검색 버튼 누를 시 검색 팝업 실행 */
$('.subject-popup-btn').on("click", function(e){
    //버튼 창 전환 방지
    e.preventDefault();

    // 팝업창 실행
    let popupUrl = "/common/searchpop-subject";
    let popupOption = "width = 1300px, height=550px, top=200px, left=200px, scrollbars=yes";

    window.open(popupUrl,"강좌 검색", popupOption);
});

/* course 검색 버튼 누를 시 검색 팝업 실행 */
$('.course-popup-btn').on("click", function(e){
    //버튼 창 전환 방지
    e.preventDefault();

    // 팝업창 실행
    let popupUrl = "/common/searchpop-course";
    let popupOption = "width = 1300px, height=550px, top=200px, left=200px, scrollbars=yes";

    window.open(popupUrl,"과정 검색", popupOption);
});

/* 수강 입력에서 수강생 검색 팝업*/
$('.student-popup-btn').on("click", function(e){
    e.preventDefault();
    
    let popupUrl = "/common/searchpop-student";
    let popupOption = "width = 1300px, height=550px, top=200px, left=200px, scrollbars=yes";
    
    window.open(popupUrl, "수강생 검색", popupOption);
});
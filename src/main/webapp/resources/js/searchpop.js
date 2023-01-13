// 완료된 강좌 선택 시
$('.open-subject-search-btn').on("click", function(e){
    //버튼 창 전환 방지
    e.preventDefault();

    // 팝업창 실행
    let popupUrl = "/SoftwareEducation/common/opensubjectsearchpop";
    let popupOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";

    window.open(popupUrl,"검색 팝업", popupOption);
});




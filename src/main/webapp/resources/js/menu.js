// Controller에서 model 담아서 뷰로 보내기

const submenuNames = {
    subject : [
        '개설 과정 목록', '개설 강좌 목록', '과정 목록', '강좌 목록'
    ],
    student : [
        '수강생 목록'
    ],
    enroll : [
        '수강 목록'
    ],
    survey : [
        '만족도 조사 통계'
    ],
    data : [
        '연계 자료 조회'
    ]
}

const submenuLinks = {
    subject : [
        'http://localhost/subject/courseboardlist?catCourse=all', 'http://localhost/subject/subjectboardlist?catSubject=all', '', ''
    ],
    student : [
        'http://localhost/student/boardlist', ''
    ],
    enroll : [
        'http://localhost/enroll/boardlist'
    ],
    survey : [
        'http://localhost/survey/summary'
    ],
    data : [
        'http://localhost/data/download'
    ]
}

// // Controller에서 model.addAttribute("menu", "course");


// // EL태그로 받아온 course를 tag에 저장
// const tag = '<c:out value="${menu}"/>';

// // submenuName/Link에 course를 키 값으로 대입해 value 호출하여 arrName/Link에 저장
// const arrName = submenuName[tag];
// const arrLink = submenuLink[tag];

// for(let i=0, max = arrName.length; i<max; i++) {
//     let subMenu = `<div class="aside-bar-submenu-` + i + `><a href="<c:url value='` + submenuLink[tag][i] + `'/>">` + submenuName[tag][i] + `</a>` +`</div>`;
//     $(".aside-bar-submenu").append(subMenu);
// }


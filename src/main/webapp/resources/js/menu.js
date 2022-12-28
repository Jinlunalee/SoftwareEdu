// Controller에서 model 담아서 뷰로 보내기

const submenuNames = {
    course : [
        '과정 정보 확인', '과정 추가', '강좌 정보 확인', '강좌 등록', '개설 강좌 목록', '강좌 개설'
    ],
    student : [
        '수강생 정보 확인', '수강생 추가'
    ],
    register : [
        '수강 목록 조회', '수강 추가'
    ],
    survey : [
        '만족도 조사 양식 목록 조회', '만족도 조사 양식 추가', '만족도 조사 통계'
    ],
    data : [
        '연계 자료 조회'
    ]
}

const submenuLinks = {
    course : [
        'http://localhost/SoftwareEducation/course/regularlist', '', '', '', 'http://localhost/SoftwareEducation/course/courselist', 'http://localhost/SoftwareEducation/course/insert'
    ],
    student : [
        'http://localhost/SoftwareEducation/student/list', ''
    ],
    register : [
        'http://localhost/SoftwareEducation/register/list', 'http://localhost/SoftwareEducation/register/insert'
    ],
    survey : [
        'http://localhost/SoftwareEducation/survey/list', 'http://localhost/SoftwareEducation/survey/insert', 'http://localhost/SoftwareEducation/survey/summary'
    ],
    data : [
        'http://localhost/SoftwareEducation/data/download'
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


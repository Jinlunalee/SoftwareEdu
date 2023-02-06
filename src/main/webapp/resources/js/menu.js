// Controller에서 model 담아서 뷰로 보내기

const submenuNames = {
    subject : [
        '개설 강좌 목록', '개설 과정 목록'
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

// const submenuLinks = {
//     subject : [
//         'http://192.168.0.147/subject/searchSubjectBoardlist?catCourse=all', 'http://192.168.0.147/subject/searchCourseBoardlist?catSubject=all'
//     ],
//     student : [
//         'http://192.168.0.147/student/boardlist', ''
//     ],
//     enroll : [
//         'http://192.168.0.147/enroll/searchlist'
//     ],
//     survey : [
//         'http://192.168.0.147/survey/summary'
//     ],
//     data : [
//         'http://192.168.0.147/data/download'
//     ]
// }

const submenuLinks = {
    subject : [
        'http://localhost/subject/searchSubjectBoardlist?catCourse=all', 'http://localhost/subject/searchCourseBoardlist?catSubject=all'
    ],
    student : [
        'http://localhost/student/boardlist', ''
    ],
    enroll : [
        'http://localhost/enroll/searchlist'
    ],
    survey : [
        'http://localhost/survey/summary'
    ],
    data : [
        'http://localhost/data/download'
    ]
}
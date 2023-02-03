package com.mycompany.webapp.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EnrollVO {
	// 수강
	private String enrollId;			// 수강 아이디
	private String subjectId;			// 강좌 아이디
	private int subjectSeq;				// 강좌 시퀀스
	private String studentId;			// 수강생 관리 아이디
	private String userId;				// 수강생 아이디
	private String stateCd;				// 수강 상태 코드
	private int completeHours;			// 수강 완료 시수
	private String enrollDt;			// 수강 신청 일시
	private String regId;				// 수강 등록자
	private String regDt;				// 수강 등록 일시
	private String modiId;				// 수강 변경자
	private String modiDt;				// 수강 변경 일시
	private String delYn;				// 수강 삭제 여부
	private String cancelRsCd;			// 수강 취소 사유 코드
	private String cancelRsEtc;			// 수강 취소 사유 기타
	
	private int ratio;					// 수강 진도율
	private int addHours;				// 수강 추가 시간
	
	// 강좌
	private String subjectTitle;		// 강좌 명
	private String catSubjectCd;		// 강좌 분류 코드
	private int days;					// 강좌 일수
	private int hours;					// 강좌 시수
	private String levelCd;				// 강좌 난이도 코드
	
	// 과정
	private String courseId;			// 과정 아이디
	private String courseTitle;			// 과정 명
	
	// 개설
	private String startDay;			// 강좌 시작 일자
	private String endDay;				// 강좌 종료 일자
	private String startTime;			// 강좌 시작 시간
	private String endTime;				// 강좌 종료 시간
	private String recruitStartDay;		// 개설 강좌 모집 시작 일자
	private String recruitEndDay;		// 개설 강좌 모집 종료 일자
	private String recruitPeople;		// 개설 강좌 모집 인원
	
	private String openStateCd;			// 개설 강좌 상태 코드
	
	// 수강생
	private String name;				// 수강생 명
	private String birth;				// 수강생 생년월일
    private String genderCd;			// 수강생 성별 코드
    private String email;				// 수강생 이메일
    private String phone;				// 수강생 전화번호
    private String addDoCd;				// 수강생 주소 코드
    private String addEtc;				// 수강생 주소 기타
    private String positionCd;			// 수강생 구분 코드
    
    // 검색
    private String applyStartDay;		// 신청 시작 일자
	private String applyEndDay;			// 신청 종료 일자
	private String student;				// 수강생 이름 아이디 선택
	private String course; 				// 강좌 과정 선택
	private String state;				// 수강 진행 상태 선택
	private String keyword1;			// 수강생 이름 아이디 입력
	private String keyword2;			// 강좌 과정 명 입력
    
    // 공통
	private String stateCdTitle;		// 수강 상태 코드 명
	private String cancelRsTitle;		// 수강 취소 코드 명
	private String catSubjectCdTitle;	// 강좌 분류 코드 명
	private String levelCdTitle;		// 강좌 난이도 코드 명
	private String openStateCdTitle;	// 개설 강좌 상태 코드 명
	private String genderCdTitle;		// 수강생 성별 코드 명
	private String addDoCdTitle;		// 수강생 주소 코드 명
	private String positionCdTitle;		// 수강생 구분 코드 명
	
}

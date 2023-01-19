package com.mycompany.webapp.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EnrollVO {
	private String enrollId;
	private String subjectId;
	private String subjectTitle;
	private String courseId;
	private String courseTitle;
	private int subjectSeq;
	private String studentId;
	private String name;
	private String stateCd;	// 수강상태 공통코드
	private String stateCdTitle;	// 수강상태 공통코드명
	private int completeHours;
	private String enroll_dt; //
	private String regId;
	private String regDt;
	private String modiId;
	private String modiDt;
	private String delYn;
	private String cancelRsCd;
	private String cancelRsTitle;
	private String cancelRsEtc;
	private String startTime;
	private String endTime;
	private String startDay;
	private String endDay;
	
	private int progress;
	private int addHours;
	private int ratio;
	
	private String applyStartDay;
	private String applyEndDay;
	private String student;
	private String course;
	private String state;
	private String keyword1;
	private String keyword2;
	
	private String openStateCd;	// 강좌 상태 공통코드
	private String openStateCdTitle;	// 강좌 상태 공통코드명
	
	private String levelCd;	// 강좌 난이도 공통코드
	private String levelCdTitle;	// 강좌 난이도 공통코드명 
	private int days;	// 강좌 일수
	private int hours;	// 강좌 시수
	private String recruitStartDay;	// 개설 강좌 모집시작일자
	private String recruitEndDay;	// 개설 강좌 모집종료일자
	private String recruitPeople;	// 개설 강좌 모집인원 
	private String catSubjectCd;	// 강좌 분류
	private String catSubjectCdTitle;	// 강좌 분류
	private String birth;	// 수강생 생년월일
    private String genderCd;	// 수강생 성별 공통코드
    private String genderCdTitle;	// 수강생 성별 공통코드명
    private String email;	// 수강생 이메일
    private String phone;	// 수강생 전화번호
    private String addDoCd;	// 수강생 주소 공통코드
    private String addDoCdTitle;	// 수강생 주소 공통코드명
    private String addEtc;	// 수강생 주소 기타
    private String position;	// 수강생 구분 공통코드
    private String positionCdTitle;	// 수강생 구분 공통코드명
}

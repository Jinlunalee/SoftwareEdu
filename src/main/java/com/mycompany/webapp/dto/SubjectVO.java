package com.mycompany.webapp.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SubjectVO {
	
	private String subjectId; //강좌아이디
	private String subjectTitle; //강좌명
	private int subjectSeq; //강좌시퀀스
	private String support; //지원여부
	private int days; //일수
	private int hours; //시수
	private String level; //레벨
	private int cost; //수강비
	
	private String courseId; //과정 아이디
	private String courseTitle; // 과정명
	private String cat; // 과정 분류 코드
	private String content; //개설 강좌 내용
	private String startTime; //개설 강좌 시작 시간
	private String endTime; //개설 강좌 종료 시간
	private String startDay; //개설 강좌 시작 일자
	private String endDay; //개설 강좌 종료 일자
	private String recruitStartDay; //모집 시작 일자
	private String recruitEndDay; //모집 마감 일자
	private int recruitPeople; // 모집인원
	private String state; //강좌 상태 코드
	
	private String comnCdTitle; //공통코드명
	
	private String supprotYn;
	private String catCd;
	private int days;
	private int hours;
	private String levelCd;
	private String levelEtc;
	private int regYear;
	
}

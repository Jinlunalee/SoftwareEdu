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
	private String regId;
	private String regDt;
	private String modiId;
	private String modiDt;
	private String delYn;
	private String cancelRsCd;
	private String cancelRsEtc;
	
	private String startTime;
	private String endTime;
	private String startDay;
	private String endDay;
	
	private int progress;
	private int addHours;
	
	private String applyStartDay;
	private String applyEndDay;
	private String student;
	private String course;
	private String state;
	private String keyword1;
	private String keyword2;
	
	private String openStateCd;	// 수강한 강좌의 공통코드
	private String openStateCdTitle;	// 수강한 강좌의 공통코드명
}

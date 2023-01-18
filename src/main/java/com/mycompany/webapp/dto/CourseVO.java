package com.mycompany.webapp.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CourseVO {
	public String courseId;	// 과정아이디
	public String courseTitle;	// 과정명
	public String catCourseCd;	// 과정 분류 코드
	public String catCourseCdTitle;	// 과정 분류 코드명
	public String stateCd;	// 과정 상태 코드
	public String stateCdTitle; // 과정 상태 코드명
	private String startDay; //개설 강좌 시작 일자
	private String endDay; //개설 강좌 종료 일자
	private String recruitStartDay; //모집 시작 일자
	private String recruitEndDay; //모집 마감 일자
	private int cost; //수강비
	private int regYear;//등록년도
}

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
	public int checkFirst; //과정 최초 개설 여부 확인
}

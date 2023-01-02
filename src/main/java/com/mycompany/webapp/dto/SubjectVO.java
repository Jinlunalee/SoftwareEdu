package com.mycompany.webapp.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SubjectVO {
	private String subjectId;
	private String subjectTitle;
	private String supprotYn;
	private String catCd;
	private int days;
	private int hours;
	private String levelCd;
	private String levelEtc;
	private int cost;
	private int regYear;

}

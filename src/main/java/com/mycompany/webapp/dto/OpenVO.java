package com.mycompany.webapp.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OpenVO {
	private String subjectId;
	private int subjectSeq;
	private String subjectTitle;
	private String courseId;
	private String courseTitle;
	private String startDay;
	private String endDay;
	private String startTime;
	private String endTime;
	private String recruitStartDay;
	private String recruitEndDay;
	private int recruitPeople;
	
	private String subCor;
	private String kw;
}

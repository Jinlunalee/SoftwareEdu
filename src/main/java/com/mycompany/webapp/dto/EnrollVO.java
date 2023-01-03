package com.mycompany.webapp.dto;

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
	private int subjectSeq;
	private String studentId;
	private String name;
	private String stateCd;
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
	

}

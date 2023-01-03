package com.mycompany.webapp.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SurveyVO {
	private String surveyId;
	private String subjectSeq;
	private List<SurveyQuestionSetVO> questionSet;
}

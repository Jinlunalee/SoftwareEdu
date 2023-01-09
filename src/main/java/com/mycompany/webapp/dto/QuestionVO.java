package com.mycompany.webapp.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QuestionVO {
	private String subjectId;
	private int subjectSeq;
	private List<QuestionSetVO> questionSet;
}

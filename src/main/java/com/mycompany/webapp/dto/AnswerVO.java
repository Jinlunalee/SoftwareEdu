package com.mycompany.webapp.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AnswerVO {
//	private String answerId;
//	private String studentId;
	private String subjectId;	// 강좌아이디
	private int subjectSeq;		// 강좌시퀀스
	private int questionNum;	// 항목순번
	private String questionContent;	// 항목질문
	private int answerValue;	// 만족도답변 숫자
	private int countAnswerValue;	// 만족도답변 숫자 카운트

}

package com.mycompany.webapp.service;

import com.mycompany.webapp.dto.AnswerVO;

public interface ISurveyService {
	AnswerVO getAnswerValue(String subjectId, int subjectSeq, int questionNum, int answerValue);
}

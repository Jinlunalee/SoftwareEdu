package com.mycompany.webapp.service;

import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.AnswerVO;

public interface ISurveyService {
	AnswerVO getAnswerValue(String subjectId, int subjectSeq, int questionNum, int answerValue);
	int getCountQuestionNum(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
}

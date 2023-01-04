package com.mycompany.webapp.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.AnswerVO;

@Mapper
public interface ISurveyRepository {
	AnswerVO getAnswerValue(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq, @Param("questionNum") int questionNum, @Param("answerValue") int answerValue);
}

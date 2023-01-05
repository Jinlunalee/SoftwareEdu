package com.mycompany.webapp.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.AnswerVO;
import com.mycompany.webapp.dto.SubjectVO;

public interface ISurveyService {
	AnswerVO getAnswerValue(String subjectId, int subjectSeq, int questionNum, int answerValue);
	int getCountQuestionNum(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	List<SubjectVO> selectSubjectListByFinishedState();
	void clickdeleteQuestion(String subjectId, int subjectSeq);
	void clickdeleteAnswer(String subjectId, int subjectSeq);
}

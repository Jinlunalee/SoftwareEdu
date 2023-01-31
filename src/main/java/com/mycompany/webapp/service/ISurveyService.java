package com.mycompany.webapp.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.AnswerVO;
import com.mycompany.webapp.dto.QuestionSetVO;
import com.mycompany.webapp.dto.QuestionVO;
import com.mycompany.webapp.dto.SubjectVO;

public interface ISurveyService {
	AnswerVO getAnswerValue(String subjectId, int subjectSeq, int questionNum, int answerValue);
	int getCountQuestionNum(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	List<SubjectVO> selectSubjectListByFinishedState();
	void clickDeleteQuestion(String subjectId, int subjectSeq);
	void clickDeleteAnswer(String subjectId, int subjectSeq);
	List<QuestionSetVO> selectSubjectQuestionSet(String subjectId, int subjectSeq);
	void insertQuestion(QuestionVO questionVo);
	int getMaxSubjectSeq(String subjectId);
	
	List<AnswerVO> selectAnswerList(String subjectId, int subjectSeq); //해당 강좌에 대한 답변정보
	Map<String, Integer> pivotAnswerValue(String subjectId, int subjectSeq, int questionNum);
}

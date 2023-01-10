package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.AnswerVO;
import com.mycompany.webapp.dto.QuestionSetVO;
import com.mycompany.webapp.dto.QuestionVO;
import com.mycompany.webapp.dto.SubjectVO;

@Mapper
public interface ISurveyRepository {
	AnswerVO getAnswerValue(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq, @Param("questionNum") int questionNum, @Param("answerValue") int answerValue);
	int getCountQuestionNum(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	List<SubjectVO> selectSubjectListByFinishedState();
	void clickDeleteQuestion(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	void clickDeleteAnswer(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	List<QuestionSetVO> selectSubjectQuestionSet(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	void insertQuestion(@Param("subjectId") String subjectId, @Param("subjectSeq") int SubjectSeq, @Param("questionSetVo") QuestionSetVO questionSetVo);
	int getMaxSubjectSeq(String subjectId);
}

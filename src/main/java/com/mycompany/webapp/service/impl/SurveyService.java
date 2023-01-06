package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.ISurveyRepository;
import com.mycompany.webapp.dto.AnswerVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.ISurveyService;

@Service
public class SurveyService implements ISurveyService {

	@Autowired
	ISurveyRepository surveyRepository;
	
	@Override
	public AnswerVO getAnswerValue(String subjectId, int subjectSeq, int questionNum, int answerValue) {
		return surveyRepository.getAnswerValue(subjectId, subjectSeq, questionNum, answerValue);
	}

	@Override
	public int getCountQuestionNum(String subjectId, int subjectSeq) {
		return surveyRepository.getCountQuestionNum(subjectId, subjectSeq);
	}

	@Override
	public List<SubjectVO> selectSubjectListByFinishedState() {
		return surveyRepository.selectSubjectListByFinishedState();
	}

	@Override
	public void clickDeleteQuestion(String subjectId, int subjectSeq) {
		surveyRepository.clickDeleteQuestion(subjectId, subjectSeq);
	}

	@Override
	public void clickDeleteAnswer(String subjectId, int subjectSeq) {
		surveyRepository.clickDeleteAnswer(subjectId, subjectSeq);
	}

}

package com.mycompany.webapp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.ISurveyRepository;
import com.mycompany.webapp.dto.AnswerVO;
import com.mycompany.webapp.dto.QuestionSetVO;
import com.mycompany.webapp.dto.QuestionVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.ISurveyService;

@Service
public class SurveyService implements ISurveyService {

	@Autowired
	ISurveyRepository surveyRepository;
	
	@Override
	public AnswerVO getAnswerValue(String subjectId, int subjectSeq, int questionNum, int answerValue) {
		AnswerVO answerVo = surveyRepository.getAnswerValue(subjectId, subjectSeq, questionNum, answerValue);
		return answerVo;
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

	@Override
	public List<QuestionSetVO> selectSubjectQuestionSet(String subjectId, int subjectSeq) {
		return surveyRepository.selectSubjectQuestionSet(subjectId, subjectSeq);
	}

	@Override
	public void insertQuestion(QuestionVO questionVo) {
		List<QuestionSetVO> questionSetList = questionVo.getQuestionSet();
		
		for(QuestionSetVO questionSetVo : questionSetList) {
			
			
			System.out.println(questionSetVo.getQuestionNum());
			System.out.println(questionSetVo.getQuestionContent()); // questionSetVo.getQuestionContent()가 "test1,test1" 와 같은 형식으로 나옴.. 왜인지 모르겠지만 일단 해결해보자
			String[] questionContentArr = questionSetVo.getQuestionContent().split(","); // , 기준으로 split으로 자름
			questionSetVo.setQuestionContent(questionContentArr[0]); // 첫번째 값을 set 해줌
			System.out.println(questionSetVo); // "test1"만 questionContent에 잘 들어감
			surveyRepository.insertQuestion(questionVo.getSubjectId(), questionVo.getSubjectSeq(), questionSetVo); // 저장
		}
	}

	@Override
	public int getMaxSubjectSeq(String subjectId) {
		return surveyRepository.getMaxSubjectSeq(subjectId);
	}

	@Override
	public List<AnswerVO> selectAnswerList(String subjectId, int subjectSeq) {
		return surveyRepository.selectAnswerList(subjectId, subjectSeq);
	}

	@Override
	public Map<String, Integer> pivotAnswerValue(String subjectId, int subjectSeq, int questionNum) {
		return surveyRepository.pivotAnswerValue(subjectId, subjectSeq, questionNum);
	}

}

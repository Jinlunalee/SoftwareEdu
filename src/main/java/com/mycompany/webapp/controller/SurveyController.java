package com.mycompany.webapp.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.webapp.dto.AnswerVO;
import com.mycompany.webapp.dto.QuestionVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IEnrollService;
import com.mycompany.webapp.service.ISubjectService;
import com.mycompany.webapp.service.ISurveyService;

@Controller
@RequestMapping("/survey")
public class SurveyController {
	static final Logger logger = LoggerFactory.getLogger(SurveyController.class);
	
	@Autowired
	IEnrollService enrollService;
	
	@Autowired
	ISubjectService subjectService;
	
	@Autowired
	ISurveyService surveyService;
	
	//목록조회
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String getSurveyList(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/list";
	}

	//상세조회
	@RequestMapping(value="/details/{surveyId}", method=RequestMethod.GET)
	public String getSurveyDetails(@PathVariable String subjectId, @PathVariable String subjectSeq, Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/details";
	}

	//수정
	@RequestMapping(value="/update/{surveyId}", method=RequestMethod.GET)
	public String updateSurvey(@PathVariable String subjectId, @PathVariable String subjectSeq, Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/update";
	}

	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateSurvey(QuestionVO questionVo) {
		return "redirect:/survey/details"+questionVo.getSubjectId();
	}

	//삭제
	@RequestMapping(value="/delete/{surveyId}", method=RequestMethod.POST)
	public String deleteSurvey(@PathVariable String subjectId ,QuestionVO questionVo) {
		return "redirect:/survey/list";
	}

	//입력
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertSurvey(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/insert";
	}

	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertSurvey(QuestionVO questionVo) {
		return "redirect:/survey/details"+questionVo.getSubjectId();
	}
	
	//통계
	@RequestMapping(value="/summary", method=RequestMethod.GET)
	public String getSurveySummary(Model model, QuestionVO questionVo, AnswerVO answerVo) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		
		
		List<SubjectVO> subjectList = subjectService.selectSubjectList();
		logger.info("details/subject: "+ subjectList);
		model.addAttribute("subjectList", subjectList);
		return "survey/summary";
	}
	
	@RequestMapping(value="/getjson", method=RequestMethod.GET)
	public String getjson(String subjectId, String subjectSeq) {
		System.out.println("subjectId : " + subjectId);
		System.out.println("subjectSeq : " + subjectSeq);
		int subjectSeqInt = Integer.parseInt(subjectSeq);
		List<AnswerVO> answerList = new ArrayList<>();
		AnswerVO answerVo = new AnswerVO();
		System.out.println(surveyService.getCountQuestionNum(subjectId, subjectSeqInt));
		// 문항 수만큼 반복
		for(int i=0; i<surveyService.getCountQuestionNum(subjectId, subjectSeqInt); i++) {
			// 답변 개수 (5개) 만큼 반복
			for(int k=0; k<5; k++) {
				answerVo = surveyService.getAnswerValue(subjectId, subjectSeqInt, i, k);
				answerList.add(answerVo);
			}
		}
		logger.info("survey/summary-post: "+ answerList);
		String result = answerList.toString();
//		String result = "안녕";
		return result;
	}
}

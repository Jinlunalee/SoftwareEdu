package com.mycompany.webapp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
		
		
		List<SubjectVO> subjectListFinished = surveyService.selectSubjectListByFinishedState();
		logger.info("details/subject: "+ subjectListFinished);
		model.addAttribute("subjectList", subjectListFinished);
		return "survey/summary";
	}
	
	// 통계 ajax
	@RequestMapping(value="/getjson", method=RequestMethod.GET)
	@ResponseBody
	public List<AnswerVO> getjson(String subjectId, String subjectSeq) {
		System.out.println("subjectId : " + subjectId);
		System.out.println("subjectSeq : " + subjectSeq);
		int subjectSeqInt = Integer.parseInt(subjectSeq);
		
		List<AnswerVO> answerVoList = new ArrayList<>();
		

		// 문항 수 구하기
		int questionNum = surveyService.getCountQuestionNum(subjectId, subjectSeqInt);

		// 문항 수만큼 반복
		for(int i=1; i<=questionNum; i++) {
			// 답변 개수 (5개) 만큼 반복
			for(int k=1; k<=5; k++) {
				AnswerVO answerVo = surveyService.getAnswerValue(subjectId, subjectSeqInt, i, k); // vo에 답변 저장하기
				answerVoList.add(answerVo);
			}
		}
		logger.info("survey/summary-post: "+ answerVoList);
		return answerVoList;
	}
	
/*	// 통계 ajax
	@RequestMapping(value="/getjson", method=RequestMethod.GET)
	@ResponseBody
	public String getjson(String subjectId, String subjectSeq) {
		System.out.println("subjectId : " + subjectId);
		System.out.println("subjectSeq : " + subjectSeq);
		int subjectSeqInt = Integer.parseInt(subjectSeq);
		
		AnswerVO answerVo = new AnswerVO();
		
		// 데이터 쌓을 List<AnswerVO> 만들기
//		List<AnswerVO> answerList = new ArrayList<>();
//		JSONArray jsonDataList = new JSONArray();
		JSONObject jsonObject = new JSONObject();

		// 문항 수 구하기
		int questionNum = surveyService.getCountQuestionNum(subjectId, subjectSeqInt);

		List<HashMap<String, Object>> answerValueByQuestionList = new ArrayList<>();
		HashMap<String, Object> answerValueByQuestionMap = new HashMap();
		// 문항 수만큼 반복
		for(int i=1; i<=questionNum; i++) {
			answerValueByQuestionMap = new HashMap();
			
			List<HashMap<String, Integer>> answerValueCountList = new ArrayList<>();
			HashMap<String, Integer> answerValueCountMap = new HashMap();
			
			// 답변 개수 (5개) 만큼 반복
			for(int k=1; k<=5; k++) {
				answerValueCountMap = new HashMap();
				answerVo = surveyService.getAnswerValue(subjectId, subjectSeqInt, i, k); // vo에 답변 저장하기
				
				// vo에서 데이터 추출
				int answerValue = answerVo.getAnswerValue();
				int countAnswerValue = answerVo.getCountAnswerValue();
				
				answerValueCountMap.put("answerValue", answerValue);
				answerValueCountMap.put("countAnswerValue", countAnswerValue);
				answerValueCountList.add(answerValueCountMap);
			}
			
			answerValueByQuestionMap.put("questionNum", i);
			answerValueByQuestionMap.put("answerValueCount", answerValueCountList);
			answerValueByQuestionList.add(answerValueByQuestionMap);
			
//			HashMap<String, Object> answerMap = new HashMap();
//			answerMap.put("subjectId", subjectId);
//			answerMap.put("subjectSeq", subjectSeq);
//			answerMap.put("answerValueByQuestion", answerValueByQuestionMap);
			

		}
		jsonObject.put("subjectId", subjectId);
		jsonObject.put("subjectSeq", subjectSeq);
		jsonObject.put("answerValueByQuestion", answerValueByQuestionList);
		
		logger.info("survey/summary-post: "+ jsonObject);
		
		// 문자열로 바꿔서 리턴
		String result = jsonObject.toString();
		System.out.println("-----------------------");
		System.out.println(result);
		return result;
	}*/	
}

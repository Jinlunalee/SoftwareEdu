package com.mycompany.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.webapp.dto.SurveyVO;

@Controller
@RequestMapping("/survey")
public class SurveyController {
	
	//테스트
	@RequestMapping("/details/")
	public String detailsTest(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/details";
	}
	@RequestMapping("/update/")
	public String updateTest(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/update";
	}
	@RequestMapping("/summary")
	public String summaryTest(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/summary";
	}
	
	//목록조회
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String getSurveyList(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/list";
	}

	//상세조회
	@RequestMapping(value="/details/{surveyId}", method=RequestMethod.GET)
	public String getSurveyDetails(@PathVariable String surveyId, Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/details";
	}

	//수정
	@RequestMapping(value="/update/{surveyId}", method=RequestMethod.GET)
	public String updateSurvey(@PathVariable String surveyId, Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/update";
	}

	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateSurvey(SurveyVO surveyVo) {
		return "redirect:/survey/details"+surveyVo.getSurveyId();
	}

	//삭제
	@RequestMapping(value="/delete/{surveyId}", method=RequestMethod.POST)
	public String deleteSurvey(@PathVariable String subjectId ,SurveyVO surveyVo) {
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
	public String insertSurvey(SurveyVO surveyVo) {
		return "redirect:/survey/details"+surveyVo.getSurveyId();
	}
	
	//통계
	@RequestMapping(value="/summary/{subjectId}", method=RequestMethod.GET)
	public String getSurveySummary(@PathVariable String subjectId, Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/summary";
	}
}

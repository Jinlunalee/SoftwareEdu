package com.mycompany.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.webapp.dto.SurveyVO;

@Controller
public class SurveyController {
	
	//테스트
	@RequestMapping("/survey/details/")
	public String detailsTest(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/details";
	}
	@RequestMapping("/survey/update/")
	public String updateTest(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/update";
	}
	
	//목록조회
	@RequestMapping(value="/survey/list", method=RequestMethod.GET)
	public String getSurveyList(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/list";
	}

	//상세조회
	@RequestMapping(value="/survey/details/{surveyId}", method=RequestMethod.GET)
	public String getSurveyDetails(@PathVariable String surveyId, Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/details";
	}

	//수정
	@RequestMapping(value="/survey/update/{surveyId}", method=RequestMethod.GET)
	public String updateSurvey(@PathVariable String surveyId, Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/update";
	}

	@RequestMapping(value="/survey/update", method=RequestMethod.POST)
	public String updateSurvey(SurveyVO surveyVo) {
		return "redirect:/survey/details"+surveyVo.getSurveyId();
	}

	//삭제
	@RequestMapping(value="/survey/delete/{surveyId}", method=RequestMethod.POST)
	public String deleteSurvey(@PathVariable String courseId ,SurveyVO surveyVo) {
		return "redirect:/survey/list";
	}

	//입력
	@RequestMapping(value="/survey/insert", method=RequestMethod.GET)
	public String insertSurvey(Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/insert";
	}

	@RequestMapping(value="/survey/insert", method=RequestMethod.POST)
	public String insertSurvey(SurveyVO surveyVo) {
		return "redirect:/survey/details"+surveyVo.getSurveyId();
	}
	
	//통계
	@RequestMapping(value="/survey/summary/{courseId}", method=RequestMethod.GET)
	public String getSurveySummary(@PathVariable String courseId, Model model) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		return "survey/summary";
	}
}

package com.mycompany.webapp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.SurveyVO;
import com.mycompany.webapp.service.IEnrollService;

@Controller
@RequestMapping("/survey")
public class SurveyController {
	
	@Autowired
	IEnrollService enrollService;
	
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
	@RequestMapping(value="/summary", method=RequestMethod.GET)
	public String getSurveySummary(Model model, SurveyVO surveyVo) {
		model.addAttribute("menu", "survey");
		model.addAttribute("menuKOR", "만족도 조사 관리");
		
		List<EnrollVO> list = enrollService.getEnrollList();
		model.addAttribute("list", list);
		return "survey/summary";
	}
}

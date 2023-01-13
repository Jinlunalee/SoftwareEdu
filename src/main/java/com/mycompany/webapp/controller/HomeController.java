package com.mycompany.webapp.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IHomeService;
import com.mycompany.webapp.service.IPagerService;

@RequestMapping
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	IHomeService homeService;
	
	@Autowired
	IPagerService pagerService;
	
	@RequestMapping("/")
	public String home() {
		logger.info("실행");
//		log.info("실행");
		return "home";
	}
	
	
	@RequestMapping(value="/boardlist",method=RequestMethod.GET)
	public String getSubjectList(Model model, @RequestParam String catSubject) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		
		List<SubjectVO> subjectList = homeService.selectSubjectList(catSubject);
		model.addAttribute("boardList", subjectList);
		model.addAttribute("subjectListSize", subjectList.size());
		logger.info("subjectlist: " + subjectList);	
		return "subject/subjectlist";
	}
	
	
	
	@RequestMapping(value="/courseboardlist",method=RequestMethod.GET)
	public String getCourseList(Model model, @RequestParam String catCourse) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "과정 관리");
		
		List<SubjectVO> courseList = homeService.selectCourseList(catCourse);
		model.addAttribute("boardList", courseList);
		model.addAttribute("courseListSize", courseList.size());
		logger.info("courselist: " + courseList);	
		return "subject/courselist";
	}
	
	
	/**
	 * @description	개설강좌 검색 팝업
	 * @date	2023. 1. 13.
	 * @author	Jin Lee
	 * @throws Exception
	 */
	@GetMapping(value="/common/opensubjectsearchpop")
	public void openSubjectSearchPop(Model model) throws Exception{
		
		logger.info("---------------openSubjectSearchPopController--------------");
	}
	
	/**
	 * @description	개설강좌 검색 팝업
	 * @date	2023. 1. 13.
	 * @author	Jin Lee
	 * @throws Exception
	 */
	@GetMapping(value="/common/opensubjectsearchpop2")
	public String openSubjectSearchPop2(SubjectVO subjectVo, Model model) throws Exception{
//		if()
		List<SubjectVO> openSubjectList = homeService.searchOpenSubject(subjectVo);
		
		if(!openSubjectList.isEmpty()) {
			model.addAttribute("boardList",openSubjectList);	// 작가 존재 경우
		} else {
			model.addAttribute("boardCheck", "empty");	// 작가 존재하지 않을 경우
		}
		
//		model.addAttribute("boardList", openSubjectList);
//		System.out.println(subjectVo);
		System.out.println(openSubjectList);
		
		logger.info("---------------openSubjectSearchPopController2--------------");
		return "common/opensubjectsearchpop";
	}
	
}


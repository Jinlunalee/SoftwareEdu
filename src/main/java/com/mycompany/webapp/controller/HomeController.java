package com.mycompany.webapp.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IHomeService;
import com.mycompany.webapp.service.impl.HomeService;

import lombok.extern.log4j.Log4j2;

@RequestMapping
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	IHomeService homeService;
	

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
		model.addAttribute("menuKOR", "강좌 관리");
		
		List<SubjectVO> courseList = homeService.selectCourseList(catCourse);
		model.addAttribute("boardList", courseList);
		model.addAttribute("courseListSize", courseList.size());
		logger.info("courselist: " + courseList);	
		return "subject/courselist";
	}
	
	
	
}


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
	public void openSubjectSearchPop(@RequestParam(required = false) SubjectVO subjectVo, Model model) throws Exception{
		
//		searchType = 검색할 것
//				SCHT001	강좌
//				SCHT002	과정
//				SCHT003	개설강좌
//				SCHT004	개설과정
//				SCHT005	수강생
		
//		List<Map<String, String>> searchParam: key = 변수명, value = 검색값
//		{변수명, 검색값}, {변수명, 검색값}, {변수명, 검색값}, {변수명, 검색값}, {변수명, 검색값}
//				
//		switch(searchType) {
//		case "SCHT0001" : // 강좌 리스트 검색,
//			model.addAttribute("board", homeService.searchSubject(searchParam));
//			model.addAttribute("columnName", homeService.getColumnName(searchType, searchParam));
// 			break;
//		case "SCHT0002" : // 과정 리스트 검색 매퍼,
//			break;
//		case "SCHT0003" : // 개설 강좌 리스트 검색 매퍼,
//			break;
//		case "SCHT0004" : // 개설 과정 리스트 검색 매퍼,
//			break;
//		case "SCHT0005" : // 수강생 리스트 검색 매퍼,
//			break;
//	}
		logger.info("---------------openSubjectSearchPopController--------------");
		List<SubjectVO> openSubjectList = homeService.searchOpenSubject(subjectVo);
		model.addAttribute("boardList", openSubjectList);
		System.out.println(subjectVo);
		logger.info("---------------openSubjectSearchPopController--------------");
	}
	
}


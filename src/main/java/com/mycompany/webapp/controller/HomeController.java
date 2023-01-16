package com.mycompany.webapp.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@GetMapping(value="/common/searchpop-opensubject")
	public void searchPopOpenSubject(Model model) throws Exception{
		model.addAttribute("levelList", homeService.getComnCdList("LEV"));	// 난이도 공통코드 리스트
		model.addAttribute("stateList", homeService.getComnCdList("OPN"));	// 상태 공통코드 리스트
		model.addAttribute("catSubjectList", homeService.getComnCdList("SUB"));	// 분류 공통코드 리스트
	}
	
	/**
	 * @description	개설강좌 검색 팝업 : 결과
	 * @date	2023. 1. 13.
	 * @author	Jin Lee
	 * @throws Exception
	 */
	@PostMapping(value="/common/searchpop-opensubject-result", produces = "application/text; charset=UTF-8")
	public String searchPopOpenSubjectResult(SubjectVO subjectVo, Model model) throws Exception{
		System.out.println(subjectVo);
		
		List<SubjectVO> openSubjectList = homeService.searchOpenSubject(subjectVo);
		
		// ajax로 구현할 것
		if(!openSubjectList.isEmpty()) {
			model.addAttribute("boardList",openSubjectList);	// 존재 경우
		} else {
			model.addAttribute("boardCheck", "empty");	// 존재하지 않을 경우
		}
		
		return "common/searchpop-opensubject-result";
	}
	
	/**
	 * @description	강좌 검색 팝업
	 * @date	2023. 1. 16.
	 * @author	Jin Lee
	 * @param model
	 * @throws Exception
	 */
	@GetMapping(value="/common/searchpop-subject")
	public void searchPopSubject(Model model) throws Exception{
		model.addAttribute("levelList", homeService.getComnCdList("LEV"));	// 난이도 공통코드 리스트
		model.addAttribute("catSubjectList", homeService.getComnCdList("SUB"));	// 분류 공통코드 리스트
	}
	
	/**
	 * @description	강좌 검색 팝업 : 결과
	 * @date	2023. 1. 16.
	 * @author	Jin Lee
	 * @param subjectVo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/common/searchpop-subject-result", produces = "application/text; charset=UTF-8")
	public String searchPopSubjectResult(SubjectVO subjectVo, Model model) throws Exception{
		System.out.println(subjectVo);
		
		List<SubjectVO> openSubjectList = homeService.searchSubject(subjectVo);
		
		// ajax로 구현할 것
		if(!openSubjectList.isEmpty()) {
			model.addAttribute("boardList",openSubjectList);	//  존재 경우
		} else {
			model.addAttribute("boardCheck", "empty");	// 존재하지 않을 경우
		}
		
		return "common/searchpop-subject-result";
	}
	
}


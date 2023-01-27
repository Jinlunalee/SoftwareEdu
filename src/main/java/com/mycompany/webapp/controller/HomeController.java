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

import com.mycompany.webapp.dto.CourseVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IHomeService;
import com.mycompany.webapp.service.IPagerService;
import com.mycompany.webapp.service.ISubjectService;

@RequestMapping
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	IHomeService homeService;
	
	@Autowired
	IPagerService pagerService;
	
	@Autowired
	ISubjectService subjectService;
	
	@RequestMapping("/")
	public String home() {
		logger.info("실행");
//		log.info("실행");
		return "home";
	}
	
	
	/**
	 * @description 강좌 목록
	 * @date		2023. 1. 20.
	 * @param model
	 * @param catSubject
	 * @return
	 */
	@RequestMapping(value="/boardlist",method=RequestMethod.GET)
	public String getSubjectList(Model model, @RequestParam String catSubjectCd) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		
		List<OpenVO> subjectList = homeService.selectSubjectList(catSubjectCd);
		model.addAttribute("boardList", subjectList);
		model.addAttribute("subjectListSize", subjectList.size());
		logger.info("subjectlist: " + subjectList);	
		return "subject/subjectlist";
	}
	
	
	
	/**
	 * @description 과정 목록
	 * @date		2023. 1. 20.
	 * @param model
	 * @param catCourse
	 * @return
	 */
	@RequestMapping(value="/courseboardlist",method=RequestMethod.GET)
	public String getCourseList(Model model, @RequestParam String catCourseCd) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "과정 관리");
		
		List<OpenVO> courseList = homeService.selectCourseList(catCourseCd);
		model.addAttribute("boardList", courseList);
		model.addAttribute("courseListSize", courseList.size());
		logger.info("courselist: " + courseList);	
		return "subject/courselist";
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
		
		List<SubjectVO> subjectList = homeService.searchSubject(subjectVo);
		
		// ajax로 구현할 것
		if(!subjectList.isEmpty()) {
			model.addAttribute("boardList",subjectList);	//  존재 경우
		} else {
			model.addAttribute("boardCheck", "empty");	// 존재하지 않을 경우
		}
		logger.info("subjectlist: " + subjectList);	
		return "common/searchpop-subject-result";
	}
	
	/**
	 * @description	과정 검색 팝업
	 * @date	2023. 1. 16.
	 * @author	Jin Lee
	 * @param model
	 * @throws Exception
	 */
	@GetMapping(value="/common/searchpop-course")
	public void searchPopCourse(Model model) throws Exception{
		model.addAttribute("catCourseList", homeService.getComnCdList("CRS"));	// 분류 공통코드 리스트
	}
	
	/**
	 * @description	과정 검색 팝업 : 결과
	 * @date	2023. 1. 16.
	 * @author	Jin Lee
	 * @param courseVo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/common/searchpop-course-result", produces = "application/text; charset=UTF-8")
	public String searchPopCourseResult(CourseVO courseVo, Model model) throws Exception{
		System.out.println(courseVo);
		
		List<CourseVO> courseList = homeService.searchCourse(courseVo);
		
		// ajax로 구현할 것
		if(!courseList.isEmpty()) {
			model.addAttribute("boardList",courseList);	//  존재 경우
		} else {
			model.addAttribute("boardCheck", "empty");	// 존재하지 않을 경우
		}
		logger.info("courselist: " + courseList);	
		return "common/searchpop-course-result";
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
	public String searchPopOpenSubjectResult(OpenVO openVo, Model model) throws Exception{
		System.out.println(openVo);
		
		List<OpenVO> openSubjectList = homeService.searchOpenSubject(openVo);
		
		// ajax로 구현할 것
		if(!openSubjectList.isEmpty()) {
			model.addAttribute("boardList",openSubjectList);	// 존재 경우
		} else {
			model.addAttribute("boardCheck", "empty");	// 존재하지 않을 경우
		}
		logger.info("openSubjectlist: " + openSubjectList);	
		return "common/searchpop-opensubject-result";
	}
	
	/**
	 * @description	완료 개설강좌 검색 팝업
	 * @date	2023. 1. 26.
	 * @author	Jin Lee
	 * @param model
	 * @throws Exception
	 */
	@GetMapping(value="/common/searchpop-opensubjectDone")
	public void searchPopOpenSubjectDone(Model model) throws Exception{
		model.addAttribute("levelList", homeService.getComnCdList("LEV"));	// 난이도 공통코드 리스트
		model.addAttribute("stateList", homeService.getComnCdList("OPN"));	// 상태 공통코드 리스트
		model.addAttribute("catSubjectList", homeService.getComnCdList("SUB"));	// 분류 공통코드 리스트
	}
	
	/**
	 * @description	완료 개설강좌 검색 팝업 : 결과
	 * @date	2023. 1. 26.
	 * @author	Jin Lee
	 * @param openVo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/common/searchpop-opensubjectDone-result", produces = "application/text; charset=UTF-8")
	public String searchPopOpenSubjectResultDone(OpenVO openVo, Model model) throws Exception{
		System.out.println(openVo);
		
		List<OpenVO> openSubjectList = homeService.searchOpenSubject(openVo);
		
		// ajax로 구현할 것
		if(!openSubjectList.isEmpty()) {
			model.addAttribute("boardList",openSubjectList);	// 존재 경우
		} else {
			model.addAttribute("boardCheck", "empty");	// 존재하지 않을 경우
		}
		logger.info("openSubjectlist: " + openSubjectList);	
		return "common/searchpop-opensubjectDone-result";
	}
	
	/**
	 * @description	개설과정 검색 팝업
	 * @date	2023. 1. 17.
	 * @author	Jin Lee
	 * @param model
	 * @throws Exception
	 */
	@GetMapping(value="/common/searchpop-opencourse")
	public void searchPopOpenCourse(Model model) throws Exception{
		model.addAttribute("stateList", homeService.getComnCdList("OPN"));	// 상태 공통코드 리스트
		model.addAttribute("catCourseList", homeService.getComnCdList("CRS"));	// 분류 공통코드 리스트
	}
	
	/**
	 * @description	개설과정 검색 팝업 : 결과
	 * @date	2023. 1. 17.
	 * @author	Jin Lee
	 * @param openVo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/common/searchpop-opencourse-result", produces = "application/text; charset=UTF-8")
	public String searchPopOpenCourseResult(OpenVO openVo, Model model) throws Exception{
		System.out.println(openVo);
		
		List<OpenVO> openCourseList = homeService.searchOpenCourse(openVo);
		logger.info("subjectlist: " + openCourseList);
		
		// ajax로 구현할 것
		if(!openCourseList.isEmpty()) {
			model.addAttribute("boardList",openCourseList);	// 존재 경우
		} else {
			model.addAttribute("boardCheck", "empty");	// 존재하지 않을 경우
		}
		logger.info("openCourseList: " + openCourseList);	
		return "common/searchpop-opencourse-result";
	}
	
	/**
	 * @description	작성 해에 courseId에 등록된 강좌 리스트 가져오기
	 * @date	2023. 1. 17.
	 * @author	Jin Lee
	 * @param courseId
	 * @param year
	 * @return
	 */
	@GetMapping(value="/common/selectOpenSubjectByCourseIdAndYear")
	@ResponseBody
	public List<OpenVO> selectOpenSubjectByCourseIdAndYear(String courseId, String year) {
		List<OpenVO> boardList = subjectService.selectOpenSubjectByCourseIdAndYear(courseId, year);
		logger.info("getSubjectListFromCourseId: " + boardList);
		return boardList;
	}
	
	/**
	 * @description	수강생 검색 팝업
	 * @date	2023. 1. 26.
	 * @author	Minsu
	 * @throws Exception
	 */
	@GetMapping(value="/common/searchpop-student")
	public void searchPopStudent() throws Exception{

	}

	/**
	 * @description	수강생 검색 팝업 : 결과
	 * @date	2023. 1. 26.
	 * @author	Minsu
	 * @param studentVo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/common/searchpop-student-result", produces = "application/text; charset=UTF-8")
	public String searchPopStudentResult(StudentVO studentVo, Model model) throws Exception{		
		List<StudentVO> studentList = homeService.searchStudentList(studentVo);
		
		if(!studentList.isEmpty()) {
			model.addAttribute("studentList", studentList);
		} else {
			model.addAttribute("boardCheck", "empty");
		}
		logger.info("studentList: " + studentList);	
		return "common/searchpop-student-result";
	}
	
	@GetMapping(value="/common/selectsubjectlistbycourseid")
	@ResponseBody
	public List<OpenVO> selectSubjectListByCourseId(OpenVO openVo) throws Exception {
		List<OpenVO> boardList = homeService.selectSubjectListByCourseId(openVo);
		logger.info("컨트롤러 : " + boardList);
		return boardList;
	}
}


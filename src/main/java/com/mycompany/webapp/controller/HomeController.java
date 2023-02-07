package com.mycompany.webapp.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.webapp.dto.AnswerVO;
import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.CourseVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IEnrollService;
import com.mycompany.webapp.service.IHomeService;
import com.mycompany.webapp.service.IPagerService;
import com.mycompany.webapp.service.ISubjectService;
import com.mycompany.webapp.service.ISurveyService;

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
	
	@Autowired
	ISurveyService surveyService;
	
	@Autowired
	IEnrollService enrollService;
	
	@RequestMapping("/")
	public String home() {
		logger.info("실행");
//		log.info("실행");
		return "home";
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
		model.addAttribute("yearList", homeService.selectYearListByPop("subject")); // 개설/등록연도 리스트
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
		List<CommonCodeVO> opnComnCdList = homeService.getComnCdList("OPN");
		opnComnCdList.remove(0); // 모집 예정 제거
		opnComnCdList.remove(3); // 진행 완료 제거
		opnComnCdList.remove(3); // 폐강 제거
		model.addAttribute("stateList", opnComnCdList);	// 상태 공통코드 리스트
		model.addAttribute("catSubjectList", homeService.getComnCdList("SUB"));	// 분류 공통코드 리스트
		model.addAttribute("yearList", homeService.selectYearListByPop("opensubject")); // 개설/등록연도 리스트
	}
	
	/**
	 * @description	개설강좌 검색 팝업 : 결과
	 * @date	2023. 1. 13.
	 * @author	Jin Lee
	 * @throws Exception
	 */
	@PostMapping(value="/common/searchpop-opensubject-result", produces = "application/text; charset=UTF-8")
	public String searchPopOpenSubjectResult(OpenVO openVo, Model model) throws Exception{
		openVo.setCases("case1"); // 개설강좌 상태가 모집중, 모집마감, 진행중인 경우만 보여주고, 개설과정에 포함된 건은 안보여주기 위함
		List<OpenVO> openSubjectList = homeService.searchOpenSubject(openVo);
		
		
		// ajax로 구현할 것
		if(!openSubjectList.isEmpty()) {
			model.addAttribute("boardList",openSubjectList);	// 존재 경우
		} else {
			model.addAttribute("boardCheck", "empty");	// 존재하지 않을 경우
		}
//		logger.info("openSubjectlist: " + openSubjectList);	
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
		model.addAttribute("catSubjectList", homeService.getComnCdList("SUB"));	// 분류 공통코드 리스트
		model.addAttribute("yearList", homeService.selectYearListByPop("opensubject")); // 개설/등록연도 리스트
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
		openVo.setCases("case2"); // 개설강좌 상태가 진행완료인 강좌만 보여주기 위함
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
	
	// 통계 ajax
		@RequestMapping(value="/common/getjson", method=RequestMethod.GET)
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
	
	
	/**
	 * @description	개설과정 검색 팝업
	 * @date	2023. 1. 17.
	 * @author	Jin Lee
	 * @param model
	 * @throws Exception
	 */
	@GetMapping(value="/common/searchpop-opencourse")
	public void searchPopOpenCourse(Model model) throws Exception{
		List<CommonCodeVO> opnComnCdList = homeService.getComnCdList("OPN");
		opnComnCdList.remove(0); // 모집예정 제거
		opnComnCdList.remove(2); // 진행중 제거
		opnComnCdList.remove(2); // 진행완료 제거
		opnComnCdList.remove(2); // 폐강 제거
		model.addAttribute("stateList", opnComnCdList);	// 상태 공통코드 리스트
		model.addAttribute("catCourseList", homeService.getComnCdList("CRS"));	// 분류 공통코드 리스트
		model.addAttribute("yearList", homeService.selectYearListByPop("opencourse")); // 개설/등록연도 리스트
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
		System.out.println("check1");
		openVo.setCases("case1"); // 개설강좌 상태가 모집중, 모집마감, 진행중인 경우만 보여주기 위함
		List<OpenVO> openCourseList = homeService.searchOpenCourse(openVo);
		System.out.println("check2");
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
	 * @description	작성 해에 subjectId에 등록된 과정 리스트 가져오기
	 * @date	2023. 1. 31.
	 * @author	Jin Lee
	 * @param subjectId
	 * @param year
	 * @return
	 */
	@GetMapping(value="/common/selectOpenCourseBySubjectIdAndYear")
	@ResponseBody
	public List<OpenVO> selectOpenCourseBySubjectIdAndYear(String subjectId, String year) {
		List<OpenVO> boardList = subjectService.selectOpenCourseBySubjectIdAndYear(subjectId, year);
		logger.info("getCourseListFromSubjectId: " + boardList);
		return boardList;
	}
	
	/**
	 * @description	수강생이 수강했거나 수강하고 있는 개설강좌 리스트 가져오기
	 * @date	2023. 1. 26.
	 * @author	Jin Lee
	 * @param studentId
	 * @return
	 */
	@GetMapping(value="/common/selectOpenSubjectByStudentId")
	@ResponseBody
	public List<OpenVO> selectOpenSubjectByStudentId(String studentId) {
		System.out.println(studentId);
		List<OpenVO> boardList = subjectService.selectOpenSubjectByStudentId(studentId);
		logger.info("selectOpenSubjectByStudentId: " + boardList);
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


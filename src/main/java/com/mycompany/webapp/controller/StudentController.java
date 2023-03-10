package com.mycompany.webapp.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.service.IPagerService;
import com.mycompany.webapp.service.IStudentService;

@Controller
@RequestMapping("/student")
public class StudentController {
	static final Logger logger = LoggerFactory.getLogger(StudentController.class);
	
	@Autowired
	IStudentService studentService;
	
	@Autowired
	IPagerService pagerService;
	
//목록조회
//	@RequestMapping(value="/list", method=RequestMethod.GET)
//	public String getStudentList(Model model) {
//		model.addAttribute("menu", "student");
//		model.addAttribute("menuKOR", "수강생 관리");
//		
//		List<StudentVO> boardList = studentService.getStudentList();
//		model.addAttribute("boardList", boardList);
//		model.addAttribute("boardListSize", boardList.size());
//		logger.info("boardList: " + boardList);
//		return "student/list";
//	}

	// paging 목록조회
	@GetMapping("/boardlist")
	public String studentList(@RequestParam(defaultValue="1") int pageNo, @RequestParam(defaultValue="10") int rowsPerPage, Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		
		// 페이징 대상이 되는 전체 행수
		int totalRows = pagerService.getCountStudentRow();

		// 페이저 정보가 담긴 Pager 객체 생성
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);  // (int rowsPerPage, int pagesPerGroup, int totalRows, int pageNo)

		// 해당 페이지의 행을 가져오기
		List<StudentVO> boardList = pagerService.selectStudentListByPage(pager);

		//JSP에서 사용할 데이터를 저장
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // 페이지 상단 좌측 "전체 목록" 수
		model.addAttribute("rowsPerPage", rowsPerPage);
		logger.info("boardList: " + boardList);
		logger.info("boardList.size: " +boardList.size());
		logger.info("pager.endPageNo: " + pager.getEndPageNo());
		
		return "student/list";
	}

	
	//상세조회
	@RequestMapping(value="/details/{studentId}", method=RequestMethod.GET)
	public String getStudentDetails(@PathVariable String studentId, StudentVO studentVo, Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		return "student/details";
	}

	//검색
	@RequestMapping(value="/searchStudentBoardlist", method=RequestMethod.GET)
	public String searchStudent(@RequestParam(defaultValue="1") int pageNo, 
			@RequestParam(defaultValue="10") int rowsPerPage, @RequestParam(defaultValue="") String keyword, 
			@RequestParam String student, Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		
		int totalRows = pagerService.getCountSearchStudentRow(student, keyword);
		
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);
		
		
		List<StudentVO> boardList = pagerService.selectSearchStudentListByPage(pager, student, keyword);
		model.addAttribute("student", student);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // 페이지 상단 좌측 "전체 목록" 수
		model.addAttribute("rowsPerPage", rowsPerPage);
		logger.info("searchStudentboardList: " + boardList);
		
		System.out.println(student);
		System.out.println(keyword);
		return "student/list";
	}

	//수정
	@RequestMapping(value="/update/{studentId}", method=RequestMethod.GET)
	public String updateStudent(@PathVariable String studentId, StudentVO studentVo, Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		return "student/update";
	}

	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateStudent(StudentVO studentVo) {
		return "redirect:/student/details"+studentVo.getStudentId();
	}

	//삭제
	@RequestMapping(value="/delete/{studentId}", method=RequestMethod.POST)
	public String deleteStudent(@PathVariable String studentId ,StudentVO studentVo) {
		return "redirect:/student/list";
	}

	//입력
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertStudent(Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		return "student/insert";
	}

	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertStudent(StudentVO studentVo) {
		return "redirect:/student/details"+studentVo.getStudentId();
	}
	
	/**
	 * @Description :paging 수강생 목록 조회 - ajax
	 * @author KOSA
	 * @date 2023. 1. 19.
	 * @param strPageNo
	 * @param strRowsPerPage
	 * @param model
	 * @return
	 */
	@PostMapping("/ajaxstudentlist")
	public String ajaxStudentList(@RequestParam(defaultValue="1") String strPageNo, @RequestParam(defaultValue="10") String strRowsPerPage, Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		
		int pageNo = Integer.parseInt(strPageNo);
		int rowsPerPage = Integer.parseInt(strRowsPerPage);		
		
		// 페이징 대상이 되는 전체 행수
		int totalRows = pagerService.getCountStudentRow();

		// 페이저 정보가 담긴 Pager 객체 생성
		Pager pager = new Pager(rowsPerPage, 5, totalRows, pageNo);  // (int rowsPerPage, int pagesPerGroup, int totalRows, int pageNo)

		// 해당 페이지의 행을 가져오기
		List<StudentVO> boardList = pagerService.selectStudentListByPage(pager);

		//JSP에서 사용할 데이터를 저장
		model.addAttribute("pager", pager);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListSize", boardList.size()); // 페이지 상단 좌측 "전체 목록" 수
		logger.info("boardList: " + boardList);
		logger.info("boardList.size: " +boardList.size());
		logger.info("pager.endPageNo: " + pager.getEndPageNo());
		
		return "student/studentlist-result";
	}
}

package com.mycompany.webapp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;

import com.mycompany.webapp.service.IStudentService;

@Controller
@RequestMapping("/student")
public class StudentController {
	
	@Autowired
	IStudentService studentService;
	
	//목록조회
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String getStudentList(Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		
		List<StudentVO> studentList = studentService.getStudentList();
		model.addAttribute("studentList", studentList);
		model.addAttribute("studentListSize", studentList.size());
		return "student/list";
	}

	/*
	
	@GetMapping("/studentList")
	public String studentList(@RequestParam(defaultValue="1") int pageNo, Model model) {
		// 페이징 대상이 되는 전체 행수
		int totalRows = 

		// 페이저 정보가 담긴 Pager 객체 생성
		Pager pager = new Pager(5, 5, totalRows, pageNo);

		// 해당 페이지의 행을 가져오기
		List<StudentVO> studentList = studentService.getBoards(pager);

		//JSP에서 사용할 데이터를 저장
		model.addAttribute("pager", pager);
		model.addAttribute("boards", boards);


		return "board/boardList";
	}
	
	
	
	
	*/
	
	
	
	//상세조회
	@RequestMapping(value="/details/{studentId}", method=RequestMethod.GET)
	public String getStudentDetails(@PathVariable String studentId, StudentVO studentVo, Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		return "student/details";
	}

	//검색
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String searchStudent(@RequestParam String studentName, @RequestParam String studentId, Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		return "student/search";
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
}

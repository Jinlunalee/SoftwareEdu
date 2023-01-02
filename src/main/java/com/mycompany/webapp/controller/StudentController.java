package com.mycompany.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.StudentVO;

@Controller
@RequestMapping("/student")
public class StudentController {
	
	//목록조회
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String getStudentList(Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		return "student/list";
	}

	//상세조회
	@RequestMapping(value="/details/{studentId}", method=RequestMethod.GET)
	public String getStudentDetails(@PathVariable String studentId, EnrollVO enrollVo, Model model) {
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
	public String updateStudent(@PathVariable String studentId, EnrollVO enrollVo, Model model) {
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

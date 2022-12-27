package com.mycompany.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.webapp.dto.RegisterVO;
import com.mycompany.webapp.dto.StudentVO;

@Controller
public class StudentController {
	
	//목록조회
	@RequestMapping(value="/student/list", method=RequestMethod.GET)
	public String getStudentList(Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		return "student/list";
	}

	//상세조회
	@RequestMapping(value="/student/details/{studentId}", method=RequestMethod.GET)
	public String getStudentDetails(@PathVariable String studentId, RegisterVO registerVo, Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		return "student/details";
	}

	//검색
	@RequestMapping(value="/student/search", method=RequestMethod.GET)
	public String searchStudent(@RequestParam String studentName, @RequestParam String studentId, Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		return "student/search";
	}

	//수정
	@RequestMapping(value="/student/update/{studentId}", method=RequestMethod.GET)
	public String updateStudent(@PathVariable String studentId, RegisterVO registerVo, Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		return "student/update";
	}

	@RequestMapping(value="/student/update", method=RequestMethod.POST)
	public String updateStudent(StudentVO studentVo) {
		return "redirect:/student/details"+studentVo.getStudentId();
	}

	//삭제
	@RequestMapping(value="/student/delete/{studentId}", method=RequestMethod.POST)
	public String deleteStudent(@PathVariable String studentId ,StudentVO studentVo) {
		return "redirect:/student/list";
	}

	//입력
	@RequestMapping(value="/student/insert", method=RequestMethod.GET)
	public String insertStudent(Model model) {
		model.addAttribute("menu", "student");
		model.addAttribute("menuKOR", "수강생 관리");
		return "student/insert";
	}

	@RequestMapping(value="/student/insert", method=RequestMethod.POST)
	public String insertStudent(StudentVO studentVo) {
		return "redirect:/student/details"+studentVo.getStudentId();
	}
}

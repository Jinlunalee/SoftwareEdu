package com.mycompany.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.webapp.dto.CourseVO;

@Controller
public class CourseController {

	//과정목록조회
	@RequestMapping(value="/course/regularlist", method=RequestMethod.GET)
	public String getRegularList(Model model) {
		model.addAttribute("menu", "course");
		model.addAttribute("menuKOR", "강좌 관리");
		return "course/regularlist";
	}

	//강좌목록조회
	@RequestMapping(value="/course/courselist", method=RequestMethod.GET)
	public String getCourseList(Model model) {
		model.addAttribute("menu", "course");
		model.addAttribute("menuKOR", "강좌 관리");
		return "course/courselist";
	}

	//상세조회
	@RequestMapping(value="/course/details/{courseId}", method=RequestMethod.GET)
	public String getCourseDetails(@PathVariable String courseId, Model model) {
		model.addAttribute("menu", "course");
		model.addAttribute("menuKOR", "강좌 관리");
		return "course/details";
	}

	//검색
	@RequestMapping(value="/course/search", method=RequestMethod.GET)
	public String searchCourse(@RequestParam String courseTitle, @RequestParam String courseId, Model model) {
		model.addAttribute("menu", "course");
		model.addAttribute("menuKOR", "강좌 관리");
		return "course/search";
	}

	//수정
	@RequestMapping(value="/course/update/{courseId}", method=RequestMethod.GET)
	public String updateCourse(@PathVariable String courseId, Model model) {
		model.addAttribute("menu", "course");
		model.addAttribute("menuKOR", "강좌 관리");
		return "course/update";
	}

	@RequestMapping(value="/course/update/{courseId}", method=RequestMethod.POST)
	public String updateCourse(CourseVO courseVo) {
		return "redirect:/course/details/"+courseVo.getCourseId();
	}

	//삭제
	
	public String deleteCourse(@PathVariable String courseId ,CourseVO courseVo, Model model) {
		model.addAttribute("menu", "course");
		model.addAttribute("menuKOR", "강좌 관리");
		return "redirect:/course/courselist";
	}

	//입력
	@RequestMapping(value="/course/insert", method=RequestMethod.GET)
	public String insertCourse(Model model) {
		model.addAttribute("menu", "course");
		model.addAttribute("menuKOR", "강좌 관리");
		return "course/insert";
	}

	@RequestMapping(value="/course/insert", method=RequestMethod.POST)
	public String insertCourse(CourseVO courseVo) {
		return "redirect:/course/details/"+courseVo.getCourseId();
	}

}

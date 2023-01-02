package com.mycompany.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.webapp.dto.SubjectVO;

@Controller
@RequestMapping("/subject")
public class SubjectController {

	//과정목록조회
	@RequestMapping(value="/courselist", method=RequestMethod.GET)
	public String getCourseList(Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "subject/courselist";
	}

	//강좌목록조회
	@RequestMapping(value="/subjectlist", method=RequestMethod.GET)
	public String getSubjectList(Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "subject/subjectlist";
	}

	//상세조회
	@RequestMapping(value="/details/{subjectId}", method=RequestMethod.GET)
	public String getSubjectDetails(@PathVariable String subjectId, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "subject/details";
	}

	//검색
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String searchSubject(@RequestParam String subjectTitle, @RequestParam String subjectId, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "subject/search";
	}

	//수정
	@RequestMapping(value="/update/{subjectId}", method=RequestMethod.GET)
	public String updateSubject(@PathVariable String subjectId, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "subject/update";
	}

	@RequestMapping(value="/update/{subjectId}", method=RequestMethod.POST)
	public String updateSubject(SubjectVO subjectVo) {
		return "redirect:/subject/details/"+subjectVo.getSubjectId();
	}

	//삭제
	@RequestMapping(value="/delete/{subjectId}")
	public String deleteSubject(@PathVariable String subjectId ,SubjectVO subjectVo, Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "redirect:/subject/subjectlist";
	}

	//입력
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertSubject(Model model) {
		model.addAttribute("menu", "subject");
		model.addAttribute("menuKOR", "강좌 관리");
		return "subject/insert";
	}

	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertSubject(SubjectVO subjectVo) {
		return "redirect:/subject/details/"+subjectVo.getSubjectId();
	}

}

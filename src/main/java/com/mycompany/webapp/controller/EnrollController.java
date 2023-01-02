package com.mycompany.webapp.controller;

import java.sql.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.webapp.dto.EnrollVO;

@Controller
@RequestMapping("/enroll")
public class EnrollController {
	
	//목록조회
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String getEnrollList(Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		return "enroll/list";
	}

	//상세조회
	@RequestMapping(value="/details/{enrollId}", method=RequestMethod.GET)
	public String getEnrollDetails(@PathVariable String enrollId, Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		return "enroll/details";
	}

	//검색
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String searchEnroll(@RequestParam Date enrollDate, @RequestParam String studentName, @RequestParam String courseName, Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		return "enroll/search";
	}
	
	//엑셀파일 다운로드
	@RequestMapping(value="/download", method=RequestMethod.GET)
	public void downloadEnroll() {
	}
	
	//수정
	@RequestMapping(value="/update/{enrollId}", method=RequestMethod.GET)
	public String updateEnroll(@PathVariable String enrollId, Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		return "enroll/update";
	}

	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateEnroll(EnrollVO enrollVo) {
		return "redirect:/enroll/details"+enrollVo.getEnrollId();
	}

	//삭제
	@RequestMapping(value="/delete/{enrollId}", method=RequestMethod.POST)
	public String deleteEnroll(@PathVariable String studentId ,EnrollVO enrollVo) {
		return "redirect:/enroll/list";
	}

	//입력
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insertEnroll(Model model) {
		model.addAttribute("menu", "enroll");
		model.addAttribute("menuKOR", "수강 관리");
		return "enroll/insert";
	}

	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertEnroll(EnrollVO enrollVo) {
		return "redirect:/enroll/details"+enrollVo.getEnrollId();
	}
}

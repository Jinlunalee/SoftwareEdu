package com.mycompany.webapp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.webapp.dto.StudentVO;

import com.mycompany.webapp.service.IStudentService;

@Controller
@RequestMapping("/data")
public class DataController {

	
	
	@Autowired
	IStudentService studentService;
	
	//통계
	@RequestMapping(value="/download", method=RequestMethod.GET)
	public String downloadData(Model model) {
		model.addAttribute("menu", "data");
		model.addAttribute("menuKOR", "연계 자료 관리");
		
		
		List<StudentVO> studentList = studentService.getStudentList();
		model.addAttribute("studentList", studentList);

		model.addAttribute("studentListSize", studentList.size());
		return "data/download";
	}
}

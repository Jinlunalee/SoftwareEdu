package com.mycompany.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class DataController {

	//통계
	@RequestMapping(value="/data/download", method=RequestMethod.GET)
	public String downloadData(Model model) {
		model.addAttribute("menu", "data");
		model.addAttribute("menuKOR", "연계 자료 관리");
		return "data/download";
	}
}

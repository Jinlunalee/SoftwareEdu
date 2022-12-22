package com.mycompany.webapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class DataController {

	//통계
	@RequestMapping(value="/data/download", method=RequestMethod.GET)
	public String downloadData() {
		return "data/download";
	}
}

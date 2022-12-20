package com.mycompany.webapp.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

public class DataController {

	//통계
	@RequestMapping(value="/data/download", method=RequestMethod.GET)
	public String downloadData() {
		return "data/download";
	}
}

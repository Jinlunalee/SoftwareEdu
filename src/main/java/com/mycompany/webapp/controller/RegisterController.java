package com.mycompany.webapp.controller;

import java.sql.Date;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.webapp.dto.RegisterVO;

@Controller
public class RegisterController {
	
	//목록조회
	@RequestMapping(value="/register/list", method=RequestMethod.GET)
	public String getRegisterList() {
		return "register/list";
	}

	//상세조회
	@RequestMapping(value="/register/details/{registerId}", method=RequestMethod.GET)
	public String getRegisterDetails(@PathVariable String registerId) {
		return "register/details";
	}

	//검색
	@RequestMapping(value="/register/search", method=RequestMethod.GET)
	public String searchRegister(@RequestParam Date registerDate, @RequestParam String studentName, @RequestParam String courseName) {
		return "register/search";
	}
	
	//엑셀파일 다운로드
	@RequestMapping(value="/register/download", method=RequestMethod.GET)
	public void downloadRegister() {
		
	}
	
	//수정
	@RequestMapping(value="/register/update/{registerId}", method=RequestMethod.GET)
	public String updateRegister(@PathVariable String registerId) {
		return "register/update";
	}

	@RequestMapping(value="/register/update", method=RequestMethod.POST)
	public String updateRegister(RegisterVO registerVo) {
		return "redirect:/register/details"+registerVo.getRegisterId();
	}

	//삭제
	@RequestMapping(value="/register/delete/{registerId}", method=RequestMethod.POST)
	public String deleteRegister(@PathVariable String studentId ,RegisterVO registerVo) {
		return "redirect:/register/list";
	}

	//입력
	@RequestMapping(value="/register/insert", method=RequestMethod.GET)
	public String insertRegister() {
		return "register/insert";
	}

	@RequestMapping(value="/register/insert", method=RequestMethod.POST)
	public String insertRegister(RegisterVO registerVo) {
		return "redirect:/register/details"+registerVo.getRegisterId();
	}
}

package com.mycompany.webapp.service.impl;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IHomeRepository;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IHomeService;
@Service
public class HomeService implements IHomeService {
	@Autowired
	IHomeRepository homeRepository;
	
	@Override
	public List<SubjectVO> selectSubjectList(String catSubject) {

		return homeRepository.selectSubjectList(catSubject); 
	}

	@Override
	public List<SubjectVO> selectCourseList(String catCourse) {
		return homeRepository.selectCourseList(catCourse); 
	}

	@Override
	public String getComnCdTitle(String comnCd) {
		return homeRepository.getComnCdTitle(comnCd);
	}

}

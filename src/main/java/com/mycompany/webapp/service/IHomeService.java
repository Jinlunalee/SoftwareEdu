package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.SubjectVO;

public interface IHomeService {

	List<SubjectVO> selectSubjectList(String catSubject);
	
	List<SubjectVO> selectCourseList(String catCourse);
}

package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.SubjectVO;

public interface ISubjectService {
	List<SubjectVO> selectCourseList();
	List<SubjectVO> selectSubjectList();
	
	SubjectVO selectSubjectDetails(String subjectId);
	
}

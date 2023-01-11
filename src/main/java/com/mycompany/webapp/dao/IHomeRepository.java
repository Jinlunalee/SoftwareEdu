package com.mycompany.webapp.dao;

import java.util.List;

import com.mycompany.webapp.dto.SubjectVO;

public interface IHomeRepository {
	
	List<SubjectVO> selectSubjectList(String catSubject);
	List<SubjectVO> selectCourseList(String catCourse);
}

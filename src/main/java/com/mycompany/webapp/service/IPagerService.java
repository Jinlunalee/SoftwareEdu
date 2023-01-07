package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;

public interface IPagerService {
	int getCountStudentRow();
	List<StudentVO> selectStudentListByPage(Pager pager);

	int getCountOpenCourseRow();
	List<SubjectVO> selectOpenCourseListByPage(Pager pager);
	
	int getCountOpenSubjectRow();
	List<SubjectVO> selectOpenSubjectListByPage(Pager pager);
	
	int getCountEnrollRow();
	List<EnrollVO> selectEnrollListByPage(Pager pager);
}

package com.mycompany.webapp.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;

public interface IPagerService {
	int getCountStudentRow();
	List<StudentVO> selectStudentListByPage(Pager pager);

	int getCountOpenCourseRow(String catCourse);
	List<SubjectVO> selectOpenCourseListByPage(Pager pager, String catCourse);
	
	int getCountOpenSubjectRow(String catSubject);
	List<SubjectVO> selectOpenSubjectListByPage(Pager pager, String catSubject);
	
	int getCountEnrollRow();
	List<EnrollVO> selectEnrollListByPage(Pager pager);
	
	int getCountSearchRow(EnrollVO enroll);
	List<EnrollVO> selectSearchListByPage(EnrollVO enroll, Pager pager);
}

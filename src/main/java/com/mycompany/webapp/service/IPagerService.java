package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;

public interface IPagerService {
	int getCountStudentRow();
	List<StudentVO> selectStudentListByPage(Pager pager);

	int getCountOpenCourseRow(String catCourseCd);
	List<OpenVO> selectOpenCourseListByPage(Pager pager, String catCourseCd);
	
	int getCountOpenSubjectRow(String catSubjectCd);
	List<OpenVO> selectOpenSubjectListByPage(Pager pager, String catSubjectCd);
	
	int getCountEnrollRow();
	List<EnrollVO> selectEnrollListByPage(Pager pager);
	
	int getCountSearchRow(EnrollVO enroll);
	List<EnrollVO> selectSearchListByPage(EnrollVO enroll, Pager pager);
	
	List<EnrollVO> selectSearchListByExcel(EnrollVO enroll);
}

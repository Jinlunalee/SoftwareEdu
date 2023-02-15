package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;

public interface IPagerService {
	int getCountStudentRow();
	List<StudentVO> selectStudentListByPage(Pager pager);

	List<EnrollVO> selectEnrollListByPage(Pager pager);
	
	//수강 검색
	int getCountSearchRow(EnrollVO enroll);
	List<EnrollVO> selectSearchListByPage(EnrollVO enroll, Pager pager);

	//과정/강좌 검색하기
	int getCountSearchOpenCourseRow(String catCourseCd, String course, String keyword);
	List<OpenVO> selectSearchOpenCourseListByPage(Pager pager, String catCourseCd, String course, String keyword);
	
	int getCountSearchOpenSubjectRow(String catSubjectCd, String subject, String keyword);
	List<OpenVO> selectSearchOpenSubjectListByPage(Pager pager, String catSubjectCd, String subject, String keyword);
	
	//수강생 검색
	int getCountSearchStudentRow(String student, String keyword);
	List<StudentVO> selectSearchStudentListByPage(Pager pager, String student, String keyword);
	
}

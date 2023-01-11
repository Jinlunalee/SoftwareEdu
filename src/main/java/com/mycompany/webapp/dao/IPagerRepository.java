package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;

@Mapper
public interface IPagerRepository {
	int getCountStudentRow();
	List<StudentVO> selectStudentListByPage(Pager pager);
	
	int getCountOpenCourseRow(@Param("catCourse") String catCourse);
	List<SubjectVO> selectOpenCourseListByPage(@Param("endRowNo") int endRowNo, @Param("startRowNo") int startRowNo, @Param("catCourse") String catCourse);
	
	int getCountOpenSubjectRow(@Param("catSubject") String catSubject);
	List<SubjectVO> selectOpenSubjectListByPage(@Param("endRowNo") int endRowNo, @Param("startRowNo") int startRowNo, @Param("catSubject") String catSubject);
	
	int getCountEnrollRow();
	List<EnrollVO> selectEnrollListByPage(Pager pager);
	
	int getCountSearchRow(EnrollVO enroll);
	List<EnrollVO> selectSearchListByPage(@Param("applyStartDay") String applyStartDay, @Param("applyEndDay") String applyEndDay, @Param("student") String student, @Param("course") String course, @Param("state") String state, @Param("endRowNo") int endRowNo, @Param("startRowNo") int startRowNo, @Param("keyword1") String keyword1, @Param("keyword2") String keyword2);
}

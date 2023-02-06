package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;

@Mapper
public interface IPagerRepository {
	int getCountStudentRow();
	List<StudentVO> selectStudentListByPage(Pager pager);
		
	int getCountEnrollRow();
	List<EnrollVO> selectEnrollListByPage(Pager pager);
	
	int getCountSearchRow(EnrollVO enroll);
	List<EnrollVO> selectSearchListByPage(@Param("applyStartDay") String applyStartDay, @Param("applyEndDay") String applyEndDay, @Param("student") String student, @Param("course") String course, @Param("state") String state, @Param("endRowNo") int endRowNo, @Param("startRowNo") int startRowNo, @Param("keyword1") String keyword1, @Param("keyword2") String keyword2);
	
	List<EnrollVO> selectSearchListByExcel(@Param("applyStartDay") String applyStartDay, @Param("applyEndDay") String applyEndDay, @Param("student") String student, @Param("course") String course, @Param("state") String state, @Param("keyword1") String keyword1, @Param("keyword2") String keyword2);

	//과정/강좌 검색
	int getCountSearchOpenCourseRow(@Param("catCourseCd") String catCourseCd, @Param("course") String course, @Param("keyword") String keyword);
	List<OpenVO> selectSearchOpenCourseListByPage(@Param("endRowNo") int endRowNo, @Param("startRowNo") int startRowNo, @Param("catCourseCd") String catCourseCd, 
			@Param("course") String course, @Param("keyword") String keyword);
	
	int getCountSearchOpenSubjectRow(@Param("catSubjectCd") String catSubjectCd, @Param("subject") String subject, @Param("keyword") String keyword);
	List<OpenVO> selectSearchOpenSubjectListByPage(@Param("endRowNo") int endRowNo, @Param("startRowNo") int startRowNo, @Param("catSubjectCd") String catSubjectCd, 
			@Param("subject") String subject, @Param("keyword") String keyword);
	
	//수강생 검색
	int getCountSearchStudentRow(@Param("student") String student, @Param("keyword") String keyword);
	List<StudentVO> selectSearchStudentListByPage(@Param("endRowNo") int endRowNo, @Param("startRowNo") int startRowNo, @Param("student") String student, @Param("keyword") String keyword);

}

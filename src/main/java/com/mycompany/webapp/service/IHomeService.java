package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.CourseVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
public interface IHomeService {
	List<SubjectVO> selectSubjectList(String catSubject);
	
	List<SubjectVO> selectCourseList(String catCourse);

	String getComnCdTitle(String comnCd);
	List<CommonCodeVO> getComnCdList (String comnCdType);
	
	List<SubjectVO> searchSubject(SubjectVO subjectVo);
	List<CourseVO> searchCourse(CourseVO courseVo);
	List<SubjectVO> searchOpenSubject(SubjectVO subjectVo);
	List<CourseVO> searchOpenCourse(CourseVO courseVo);
	
	List<StudentVO> searchStudentList(StudentVO studentVo);
	
//	List<String> getColumnName(String searchType, List<Map<String, Object>> searchParam);
}

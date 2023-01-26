package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.CourseVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.SubjectVO;

public interface IHomeService {
	List<OpenVO> selectSubjectList(String catSubjectCd);
	List<OpenVO> selectCourseList(String catCourseCd);

	String getComnCdTitle(String comnCd);
	List<CommonCodeVO> getComnCdList (String comnCdType);
	
	List<SubjectVO> searchSubject(SubjectVO subjectVo);
	List<CourseVO> searchCourse(CourseVO courseVo);
	List<OpenVO> searchOpenSubject(OpenVO openVo);
	List<OpenVO> searchOpenCourse(OpenVO openVo);
	
	List<StudentVO> searchStudentList(StudentVO studentVo);
	
//	List<String> getColumnName(String searchType, List<Map<String, Object>> searchParam);
}

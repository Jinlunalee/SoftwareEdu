package com.mycompany.webapp.service;

import java.util.List;
import java.util.Map;

import com.mycompany.webapp.dto.SubjectVO;


import org.apache.ibatis.annotations.Param;
public interface IHomeService {
	List<SubjectVO> selectSubjectList(String catSubject);
	
	List<SubjectVO> selectCourseList(String catCourse);

	String getComnCdTitle(String comnCd);
	
//	List<SubjectVO> searchSubject(List<Map<String, Object>> searchParam);
//	List<SubjectVO> searchCourse();
	List<SubjectVO> searchOpenSubject(SubjectVO subjectVo);
//	List<SubjectVO> searchOpenSubject();
	
//	List<String> getColumnName(String searchType, List<Map<String, Object>> searchParam);
}

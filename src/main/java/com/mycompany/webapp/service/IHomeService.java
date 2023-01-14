package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.SubjectVO;
public interface IHomeService {
	List<SubjectVO> selectSubjectList(String catSubject);
	
	List<SubjectVO> selectCourseList(String catCourse);

	String getComnCdTitle(String comnCd);
	List<CommonCodeVO> getComnCdList (String comnCdType);
	
//	List<SubjectVO> searchSubject(List<Map<String, Object>> searchParam);
//	List<SubjectVO> searchCourse();
	List<SubjectVO> searchOpenSubject(SubjectVO subjectVo);
//	List<SubjectVO> searchOpenSubject();
	
//	List<String> getColumnName(String searchType, List<Map<String, Object>> searchParam);
}

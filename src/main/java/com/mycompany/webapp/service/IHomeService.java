package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.SubjectVO;


import org.apache.ibatis.annotations.Param;
public interface IHomeService {
	List<SubjectVO> selectSubjectList(String catSubject);
	
	List<SubjectVO> selectCourseList(String catCourse);

	String getComnCdTitle(@Param("comnCd") String comnCd);

}

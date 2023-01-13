package com.mycompany.webapp.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;


import com.mycompany.webapp.dto.SubjectVO;

public interface IHomeRepository {
	
	List<SubjectVO> selectSubjectList(String catSubject);
	List<SubjectVO> selectCourseList(String catCourse);

	String getComnCdTitle(@Param("comnCd") String comnCd);
	
	List<SubjectVO> searchSubject(SubjectVO subjectVo);
	List<SubjectVO> searchOpenSubject(SubjectVO subjectVo);

}

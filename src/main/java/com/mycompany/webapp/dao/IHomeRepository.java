package com.mycompany.webapp.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.CourseVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.SubjectVO;

public interface IHomeRepository {
	
	List<OpenVO> selectSubjectList(String catSubjectCd);
	List<OpenVO> selectCourseList(String catCourseCd);

	String getComnCdTitle(@Param("comnCd") String comnCd);
	List<CommonCodeVO> getComnCdList (String comnCdType);
	
	List<SubjectVO> searchSubject(SubjectVO subjectVo);
	List<CourseVO> searchCourse(CourseVO courseVo);
	List<OpenVO> searchOpenSubject(OpenVO openVo);
	List<OpenVO> searchOpenCourse(OpenVO openVo);

}

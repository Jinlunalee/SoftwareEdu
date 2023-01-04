package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;

@Mapper
public interface IEnrollRepository {
	List<EnrollVO> getEnrollList();
	String getProgress(String studentId);
	void clickCancel(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	void clickDelete(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
}

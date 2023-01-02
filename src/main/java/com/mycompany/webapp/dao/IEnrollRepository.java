package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;

@Mapper
public interface IEnrollRepository {
	List<EnrollVO> getEnrollList();
	EnrollVO getEnrollDetails();
	StudentVO getName(String studentId);
	SubjectVO getSubjectName(String subjectId);
	EnrollVO getOpenDetails();
	int getProgress(String studentId);
}

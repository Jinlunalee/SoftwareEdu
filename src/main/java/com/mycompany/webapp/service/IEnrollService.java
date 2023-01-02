package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;

public interface IEnrollService {
	List<EnrollVO> getEnrollList();
	EnrollVO getEnrollDetails();
	StudentVO getName(String studentId);
	SubjectVO getSubjectName(String subjectId);
	EnrollVO getOpenDetails();
	int getProgress(String studentId);
}

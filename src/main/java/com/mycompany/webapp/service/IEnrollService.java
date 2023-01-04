package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;

public interface IEnrollService {
	List<EnrollVO> getEnrollList();
	String getProgress(String studentId);
	void clickCancel(String studentId, String subjectId, String subjectSeq);
	void clickDelete(String studentId, String subjectId, String subjectSeq);
}

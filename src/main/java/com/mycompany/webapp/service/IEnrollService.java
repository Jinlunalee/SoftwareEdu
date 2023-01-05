package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.StudentVO;

public interface IEnrollService {
	List<EnrollVO> getEnrollList();
	String getRatio(String studentId, String subjectId, String subjectSeq);
	void clickCancel(EnrollVO enroll, String studentId, String subjectId, String subjectSeq);
	void clickDelete(String studentId, String subjectId, String subjectSeq);
	void addHours(EnrollVO enroll, String studentId, String subjectId, String subjectSeq);
	List<CommonCodeVO> getCancelList();
	List<StudentVO> getStudentList(StudentVO studentVO);
}

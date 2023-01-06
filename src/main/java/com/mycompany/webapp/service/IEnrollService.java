package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.StudentVO;

public interface IEnrollService {
	List<EnrollVO> getEnrollList();
	String getRatio(String studentId, String subjectId, String subjectSeq);
	void clickCancel(EnrollVO enroll, String studentId, String subjectId, String subjectSeq);
	void clickDelete(String studentId, String subjectId, String subjectSeq);
	void clickDeleteEnrollByOpen(String subjectId, int subjectSeq);
	void addHours(EnrollVO enroll, String studentId, String subjectId, String subjectSeq);
//	int getHours(String enrollId);
	List<CommonCodeVO> getCancelList();
	List<StudentVO> getStudentList(StudentVO studentVO);
	void approval(String studentId, String subjectId, String subjectSeq);
	List<OpenVO> getOpenList(OpenVO openVO);
	void addEnroll(String studentId, String subjcetId, int subjectSeq);
}

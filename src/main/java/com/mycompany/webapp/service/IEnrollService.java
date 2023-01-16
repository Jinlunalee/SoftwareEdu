package com.mycompany.webapp.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;

public interface IEnrollService {
	List<EnrollVO> getEnrollList();
	void clickCancel(EnrollVO enroll, String studentId, String subjectId, int subjectSeq);
	void clickDelete(String studentId, String subjectId, int subjectSeq);
	int getRatioUsingEnrollId(String enrollId);
	void clickDeleteEnrollByOpen(String subjectId, int subjectSeq);
	void addHours(int addHours, String enrollId);
	List<CommonCodeVO> getCancelList();
	List<StudentVO> getStudentList(StudentVO studentVO);
	void approval(String studentId, String subjectId, int subjectSeq);
	List<OpenVO> getOpenList(OpenVO openVO);
	void addEnroll(String studentId, String subjcetId, int subjectSeq);
	void addCourse(String studentId, String courseId);
	int recruitTotalPeople(String subjectId, int subjectSeq, String state);
	EnrollVO getEnrollDetails(String enrollId); // 수강 상세 정보 가져오기
}

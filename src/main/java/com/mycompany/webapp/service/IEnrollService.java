package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.StudentVO;

public interface IEnrollService {
	void clickCancel(EnrollVO enroll, String studentId, String subjectId, int subjectSeq); // 취소 버튼
	void clickDelete(String studentId, String subjectId, int subjectSeq); // 논리 삭제
	int getRatioUsingEnrollId(String enrollId); // 진도율
	void clickDeleteEnrollByOpen(String subjectId, int subjectSeq);
	void addHours(int addHours, String enrollId); // 수강 시간 입력
	List<CommonCodeVO> getCancelList(); // 취소 사유 리스트
	List<StudentVO> getStudentList(StudentVO studentVO); // 수강생 리스트
	void approval(String studentId, String subjectId, int subjectSeq); // 승인 버튼
	List<OpenVO> getOpenList(OpenVO openVO); // 
	void addEnroll(String studentId, String subjcetId, int subjectSeq); // 수강 강좌 추가
	void addCourse(String studentId, String courseId, String courseOpenYear); // 수강 과정 추가
	int recruitTotalPeople(String subjectId, int subjectSeq, String state); // 모집인원
	EnrollVO getEnrollDetails(String enrollId); // 수강 상세 화면
}

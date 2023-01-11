package com.mycompany.webapp.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;

public interface ISubjectService {
	List<SubjectVO> selectCourseList();
	List<SubjectVO> selectSubjectList();
	
	SubjectVO selectSubjectDetails(String subjectId, int subjectSeq);
	
	int updateSubject(SubjectVO subject); // 과정/강좌 수정
	int updateFileData(SubjectVO subject, UploadfileVO file); // 과정/강좌 수정 첨부파일
	UploadfileVO getFile(String fileId);
	
	int insertSubject(SubjectVO subject); // 과정/강좌 개설
	int insertFileData(SubjectVO subject, UploadfileVO file); // 과정/강좌 개설 첨부파일
	
	List<SubjectVO> selectAllCourse();//과정명 가져오기
	List<SubjectVO> selectAllSubject(); //강좌명 가져오기
	
	Map<String, Object> infoSubjectCourse(String courseId, String subjectId); // 강좌에 대한 정보
//	List<SubjectVO> infoSubjectCourse(String courseId, String subjectId); // 강좌에 대한 정보
//	SubjectVO infoSubjectCourse(String courseId, String subjectId); // 강좌에 대한 정보
	
	void clickDeleteOpen(String subjectId, int subjectSeq);
	void clickDeleteUploadFile(String fileId);
	
	int closeSubject(String subjectId, int subjectSeq); //폐깡처리
	
	List<SubjectVO> selectSubjectByCourseId(String courseId);
}

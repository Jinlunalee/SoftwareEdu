package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;

public interface ISubjectService {
	List<SubjectVO> selectCourseList();
	List<SubjectVO> selectSubjectList();
	
	SubjectVO selectSubjectDetails(String subjectId, int subjectSeq);
	int recruitTotalPeople(String subjectId, int subjectSeq, String state);
	
	int insertSubject(SubjectVO subject); // 과정/강좌 개설
	int insertFileData(SubjectVO subject, UploadfileVO file); // 과정/강좌 개설 첨부파일
	
	List<SubjectVO> selectAllCourse();//과정명 가져오기
	List<SubjectVO> selectAllSubject(); //강좌명 가져오기
}

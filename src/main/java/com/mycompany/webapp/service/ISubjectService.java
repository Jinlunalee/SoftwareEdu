package com.mycompany.webapp.service;

import java.util.List;
import java.util.Map;

import com.mycompany.webapp.dto.CourseVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;

public interface ISubjectService {
	List<OpenVO> selectCourseList();
	List<OpenVO> selectSubjectList();
	
	OpenVO selectSubjectDetails(String subjectId, int subjectSeq);
	
	int updateSubject(OpenVO openVo); // 과정/강좌 수정
	int updateFileData(OpenVO openVo, UploadfileVO file); // 과정/강좌 수정 첨부파일
	UploadfileVO getFile(String fileId);
	
	int insertSubject(OpenVO openVo); // 과정/강좌 개설
	int insertFileData(OpenVO openVo, UploadfileVO file); // 과정/강좌 개설 첨부파일
	
	List<CourseVO> selectAllCourse();//과정명 가져오기
	List<SubjectVO> selectAllSubject(); //강좌명 가져오기
	
	Map<String, Object> infoSubjectCourse(String courseId, String subjectId); // 강좌에 대한 정보
//	List<SubjectVO> infoSubjectCourse(String courseId, String subjectId); // 강좌에 대한 정보
//	SubjectVO infoSubjectCourse(String courseId, String subjectId); // 강좌에 대한 정보
	
	void clickDeleteOpen(String subjectId, int subjectSeq); // 논리 삭제
	void clickDeleteUploadFile(String fileId); //논리삭제 (첨부파일)
	
	int closeSubject(String subjectId, int subjectSeq); //폐깡처리
	
	List<OpenVO> selectSubjectByCourseId(String courseId);  // 한과정안에 동일한 강좌 못들어가도록하기위해 과정안의 강좌를 가져옴.
	List<OpenVO> selectOpenSubjectByCourseIdAndYear(String courseId, String year);  // 올해 같은 과정으로 개설된 강좌 리스트 가져오기
	List<OpenVO> selectOpenCourseBySubjectIdAndYear(String subjectId, String year);  // 올해 해당강좌에 개설된 과정 리스트 가져오기
	List<OpenVO> selectOpenSubjectByStudentId(String studentId);  // 수강생이 들었거나 듣고있는 강좌 리스트 가져오기
	int checkHoliday(String startDay, String endDay);
}

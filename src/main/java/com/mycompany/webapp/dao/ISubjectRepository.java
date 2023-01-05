package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;

@Mapper
public interface ISubjectRepository {
	List<SubjectVO> selectCourseList(); // 개설 과정 목록 조회
	List<SubjectVO> selectSubjectList(); // 개설 강좌 목록 조회
	
	SubjectVO selectSubjectDetails(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq); // 강좌 상세보기
	int recruitTotalPeople(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq, @Param("state") String state);//모집된 인원보기
	
	int updateSubject(SubjectVO subject); // 과정/강좌 수정
	int updateFileData(UploadfileVO file); // 과정/강좌 수정 첨부파일
	
	int insertSubject(SubjectVO subject); // 과정/강좌 개설
	int insertFileData(UploadfileVO file); // 과정/강좌 개설 첨부파일
	
	List<SubjectVO> selectAllCourse();//과정명 가져오기
	List<SubjectVO> selectAllSubject(); //강좌명 가져오기
	
	int checkCourse(String courseId); // 강좌개설시, 같은 과정이 존재하는지 확인
	
	SubjectVO infoSubject(String subjectId); // 강좌에 대한 정보
	
}

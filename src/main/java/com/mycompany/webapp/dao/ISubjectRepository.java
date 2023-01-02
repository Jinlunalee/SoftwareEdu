package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;

@Mapper
public interface ISubjectRepository {
	List<SubjectVO> selectCourseList(); // 개설 과정 목록 조회
	List<SubjectVO> selectSubjectList(); // 개설 강좌 목록 조회
	
	int insertSubject(SubjectVO subject); // 과정/강좌 개설
	int insertFileData(UploadfileVO file); // 과정/강좌 개설 첨부파일
	
	SubjectVO selectSubjectDetails(String subjectId); // 과정/강좌 상세보기
	
	
}

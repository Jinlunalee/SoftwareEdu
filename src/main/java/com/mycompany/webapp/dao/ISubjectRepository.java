package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.CourseVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;

@Mapper
public interface ISubjectRepository {	
	OpenVO selectSubjectDetails(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq); // 강좌 상세보기
	
	int updateSubject(OpenVO openVo); // 과정/강좌 수정
	int updateFileData(UploadfileVO file); // 과정/강좌 수정 첨부파일
	UploadfileVO getFile(String fileId); // 파일 첨부파일 가져오기 
	String selectMaxFileId();//파일아이디 최대값
	
	int insertSubject(OpenVO openVo); // 과정/강좌 개설
	int insertFileData(UploadfileVO file); // 과정/강좌 개설 첨부파일
	
	List<CourseVO> selectAllCourse();//과정명 가져오기
	List<SubjectVO> selectAllSubject(); //강좌명 가져오기
	
	SubjectVO infoSubject(String subjectId); // 강좌에 대한 기본 정보 출력
	OpenVO infoOpenCourse(@Param("courseId") String courseId, @Param("year") String year); // 같은 개설 과정에 대한 정보
	int checkOpenCourse(@Param("courseId") String courseId, @Param("year") String year); // 강좌개설시, 같은 과정이 존재하는지 open테이블에서 확인(최초개설인지 개설되어있는 과정인지 확인)
	
	int updateRecruitSameCourse(OpenVO openVo); //같은 과정 신청일자 변경
	void clickDeleteOpen(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq); //논리 삭제
	void clickDeleteUploadFile(String fileId); //논리 삭제
	
	int closeSubject(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);//폐강버튼 눌렀을 때 
	
	List<OpenVO> selectSubjectByCourseId(String courseId); // 한과정안에 동일한 강좌 못들어가도록하기위해 과정안의 강좌를 가져옴.
	List<OpenVO> selectOpenSubjectByCourseIdAndYear(@Param("courseId") String courseId, @Param("year") String year); // 올해 같은 과정으로 개설된 강좌 리스트 가져오기
	List<OpenVO> selectOpenCourseBySubjectIdAndYear(@Param("subjectId") String subjectId, @Param("year") String year); // 올해 해당강좌에 개설된 과정 리스트 가져오기
	List<OpenVO> selectOpenSubjectByStudentId(String studentId); // 수강생이 들었거나 듣고있는 강좌 리스트 가져오기
	int checkHoliday(@Param("startDay") String startDay, @Param("endDay") String endDay); // 휴일 체크
}

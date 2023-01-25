package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;

@Mapper
public interface IEnrollRepository {
	List<EnrollVO> getEnrollList();
	void clickCancel(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	void clickDelete(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	int getRatioUsingEnrollId(@Param("enrollId") String enrollId);
	void clickDeleteEnrollByOpen(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	void addHours(@Param("addHours") int addHours, @Param("enrollId") String enrollId);
	List<CommonCodeVO> getCancelList();
	void updateCancelRsCd(@Param("cancelRsCd") String cancelRsCd, @Param("cancelRsEtc") String cancelRsEtc, @Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	List<StudentVO> getStudentList(StudentVO studentVO);
	void approval(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	List<OpenVO> getOpenList(OpenVO openVO);
	void addEnroll(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq, @Param("maxEnrollId") int maxEnrollId);
//	void addCourse(Map<String, Object> addCourse, String studnetId, String maxEnroll2);
	int getMaxEnrollId();
	int getSubjectCountByCourse(@Param("courseId") String courseId, @Param("courseOpenYear") String courseOpenYear);
	List<OpenVO> getSubjectInfoByCourse(@Param("courseId") String courseId, @Param("courseOpenYear") String courseOpenYear);
	int updateEnrollCancel(); // 강좌가 폐강시 해당 강좌 듣는 수강생도 수강취소 처리
	int recruitTotalPeople(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq, @Param("state") String state);//모집된 인원보기
	EnrollVO getEnrollDetails(String enrollId); // 수강 상세 정보 가져오기
}

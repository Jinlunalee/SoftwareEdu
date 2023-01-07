package com.mycompany.webapp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.StudentVO;

@Mapper
public interface IEnrollRepository {
	List<EnrollVO> getEnrollList();
	String getRatio(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	void clickCancel(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	void clickDelete(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	void clickDeleteEnrollByOpen(@Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq);
	void addHours(@Param("addHours") int addHours, @Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	//int getHours(String enrollId);
	List<CommonCodeVO> getCancelList();
	void updateCancelRsCd(@Param("cancelRsC") String cancelRsCd, @Param("cancelRsEtc") String cancelRsEtc, @Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	List<StudentVO> getStudentList(StudentVO studentVO);
	void approval(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	List<OpenVO> getOpenList(OpenVO openVO);
	void addEnroll(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") int subjectSeq, @Param("maxEnrollId") int maxEnrollId);
	void addCourse(Map<String, Object> addCourse, String studnetId, String maxEnroll2);
	int getMaxEnrollId();
}

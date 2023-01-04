package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.StudentVO;

@Mapper
public interface IEnrollRepository {
	List<EnrollVO> getEnrollList();
	String getRatio(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	void clickCancel(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	void clickDelete(@Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	void addHours(@Param("addHours") int addHours, @Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	List<CommonCodeVO> getCancelList();
	void updateCancelRsCd(@Param("cancelRsC") String cancelRsCd, @Param("cancelRsEtc") String cancelRsEtc, @Param("studentId") String studentId, @Param("subjectId") String subjectId, @Param("subjectSeq") String subjectSeq);
	List<StudentVO> getStudentList(StudentVO studentVO);
}

package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IEnrollRepository;
import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.service.IEnrollService;

@Service
public class EnrollService implements IEnrollService{

	@Autowired
	IEnrollRepository enrollRepository;
	
	@Override
	public List<EnrollVO> getEnrollList() {
		return enrollRepository.getEnrollList();
	}
	
	public String getRatio(String studentId, String subjectId, String subjectSeq) {
		return enrollRepository.getRatio(studentId, subjectId, subjectSeq);
	}
	
	public void clickCancel(EnrollVO enroll, String studentId, String subjectId, String subjectSeq) {
		String cancelRsCd = enroll.getCancelRsCd();
		String cancelRsEtc = enroll.getCancelRsEtc();
		enrollRepository.updateCancelRsCd(cancelRsCd, cancelRsEtc, studentId, subjectId, subjectSeq);
		enrollRepository.clickCancel(studentId, subjectId, subjectSeq);
	}
	
	public void clickDelete(String studentId, String subjectId, String subjectSeq) {
		enrollRepository.clickDelete(studentId, subjectId, subjectSeq);
	}
	

	@Override
	public void clickDeleteOnOpen(String subjectId, int subjectSeq) {
		enrollRepository.clickDeleteOnOpen(subjectId, subjectSeq);
	}
	
	public void addHours(EnrollVO enroll, String studentId, String subjectId, String subjectSeq) {
		int addHours = enroll.getAddHours();
		enrollRepository.addHours(addHours, studentId, subjectId, subjectSeq);
	}
	
	public List<CommonCodeVO> getCancelList() {
		return enrollRepository.getCancelList();
	}
	
	@Override
	public List<StudentVO> getStudentList(StudentVO studentVO) {
		return enrollRepository.getStudentList(studentVO);
	}
	
	public void approval(String studentId, String subjectId, String subjectSeq) {
		enrollRepository.approval(studentId, subjectId, subjectSeq);
	}
	
	@Override
	public List<OpenVO> getOpenList(OpenVO openVO) {
		return enrollRepository.getOpenList(openVO);
	}

	
}

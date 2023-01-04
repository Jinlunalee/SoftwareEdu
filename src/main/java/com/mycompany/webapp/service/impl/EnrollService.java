package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IEnrollRepository;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IEnrollService;

@Service
public class EnrollService implements IEnrollService{

	@Autowired
	IEnrollRepository enrollRepository;
	
	@Override
	public List<EnrollVO> getEnrollList() {
		return enrollRepository.getEnrollList();
	}
	
	public String getProgress(String studentId) {
		return enrollRepository.getProgress(studentId);
	}
	
	public void clickCancel(String studentId, String subjectId, String subjectSeq) {
		enrollRepository.clickCancel(studentId, subjectId, subjectSeq);
	}
	
	public void clickDelete(String studentId, String subjectId, String subjectSeq) {
		enrollRepository.clickDelete(studentId, subjectId, subjectSeq);
	}

}

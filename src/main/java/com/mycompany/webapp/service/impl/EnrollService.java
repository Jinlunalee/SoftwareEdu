package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IEnrollRepository;
import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.Pager;
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
	
	@Override
	public void clickCancel(EnrollVO enroll, String studentId, String subjectId, int subjectSeq) {
		String cancelRsCd = enroll.getCancelRsCd();
		String cancelRsEtc = enroll.getCancelRsEtc();
		enrollRepository.updateCancelRsCd(cancelRsCd, cancelRsEtc, studentId, subjectId, subjectSeq);
		enrollRepository.clickCancel(studentId, subjectId, subjectSeq);
	}
	
	@Override
	public void clickDelete(String studentId, String subjectId, int subjectSeq) {
		enrollRepository.clickDelete(studentId, subjectId, subjectSeq);
	}
	

	@Override
	public void clickDeleteEnrollByOpen(String subjectId, int subjectSeq) {
		enrollRepository.clickDeleteEnrollByOpen(subjectId, subjectSeq);
	}
	
	@Override
	public void addHours(EnrollVO enroll, String studentId, String subjectId, int subjectSeq) {
		int addHours = enroll.getAddHours();
		enrollRepository.addHours(addHours, studentId, subjectId, subjectSeq);
	}
	
	@Override
	public List<CommonCodeVO> getCancelList() {
		return enrollRepository.getCancelList();
	}
	
	@Override
	public List<StudentVO> getStudentList(StudentVO studentVO) {
		return enrollRepository.getStudentList(studentVO);
	}
	
	@Override
	public void approval(String studentId, String subjectId, int subjectSeq) {
		enrollRepository.approval(studentId, subjectId, subjectSeq);
	}
	
	@Override
	public List<OpenVO> getOpenList(OpenVO openVO) {
		return enrollRepository.getOpenList(openVO);
	}
	
	@Override
	public void addEnroll(String studentId, String subjectId, int subjectSeq) {
		int maxEnrollId = enrollRepository.getMaxEnrollId() + 1;
		enrollRepository.addEnroll(studentId, subjectId, subjectSeq, maxEnrollId);
	}

	@Override
	public void addCourse(String studentId, String courseId) {
		// course에 담긴 subject 갯수 가져오기
		int subjectCount = enrollRepository.getSubjectCountByCourse(courseId);
		
		// open테이블에서 정보 가져오기
		List<OpenVO> openVo = enrollRepository.getSubjectInfoByCourse(courseId);
		
		// 갯수만큼 enrollId +1 해주고, addEnroll 해주기
		for(int i=0; i<subjectCount; i++) {
			int maxEnrollId = enrollRepository.getMaxEnrollId() + 1;
			enrollRepository.addEnroll(studentId, openVo.get(i).getSubjectId(), openVo.get(i).getSubjectSeq(), maxEnrollId);
		}
	}

	@Override
	public int recruitTotalPeople(String subjectId, int subjectSeq, String state) {
		return enrollRepository.recruitTotalPeople(subjectId, subjectSeq, state);
	}
	
}

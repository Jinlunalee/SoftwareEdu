package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IEnrollRepository;
import com.mycompany.webapp.dao.IHomeRepository;
import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.OpenVO;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.service.IEnrollService;

@Service
public class EnrollService implements IEnrollService{

	@Autowired
	IEnrollRepository enrollRepository;
	
	@Autowired
	IHomeRepository homeRepository;
	
	@Override
	public void clickCancel(EnrollVO enroll, String studentId, String subjectId, int subjectSeq) {
		String cancelRsCd = enroll.getCancelRsCd();
		String cancelRsEtc = enroll.getCancelRsEtc();
		if(cancelRsEtc != null) {
			enrollRepository.updateCancelRsCdEtc(cancelRsCd, cancelRsEtc, studentId, subjectId, subjectSeq);
			enrollRepository.clickCancel(studentId, subjectId, subjectSeq);
		}else {
			enrollRepository.updateCancelRsCd(cancelRsCd, studentId, subjectId, subjectSeq);
			enrollRepository.clickCancel(studentId, subjectId, subjectSeq);
		}
		
	}

	@Override
	public int getRatioUsingEnrollId(String enrollId) {
		return enrollRepository.getRatioUsingEnrollId(enrollId);
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
	public void addHours(int addHours, String enrollId) {
		enrollRepository.addHours(addHours, enrollId);
	}
	
	@Override
	public List<CommonCodeVO> getCancelList() {
		return enrollRepository.getCancelList();
	}
	
	@Override
	public List<StudentVO> getStudentList(StudentVO studentVO) {
		
		List<StudentVO> getStudentList = enrollRepository.getStudentList(studentVO);
		
		for(StudentVO studentVo : getStudentList) {
			studentVo.setAddDoTitle(homeRepository.getComnCdTitle(studentVo.getAddDoCd()));
			studentVo.setGenderTitle(homeRepository.getComnCdTitle(studentVo.getGenderCd()));
			studentVo.setPositionTitle(homeRepository.getComnCdTitle(studentVo.getPositionCd()));
		}
		
		return getStudentList;
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
	public void addCourse(String studentId, String courseId, String courseOpenYear) {
		// course??? ?????? subject ?????? ????????????
		int subjectCount = enrollRepository.getSubjectCountByCourse(courseId, courseOpenYear);
		
		// open??????????????? ?????? ????????????
		List<OpenVO> openVo = enrollRepository.getSubjectInfoByCourse(courseId, courseOpenYear);
		
		// ???????????? enrollId +1 ?????????, addEnroll ?????????
		for(int i=0; i<subjectCount; i++) {
			int maxEnrollId = enrollRepository.getMaxEnrollId() + 1;
			enrollRepository.addEnroll(studentId, openVo.get(i).getSubjectId(), openVo.get(i).getSubjectSeq(), maxEnrollId);
		}
	}

	@Override
	public int recruitTotalPeople(String subjectId, int subjectSeq, String state) {
		return enrollRepository.recruitTotalPeople(subjectId, subjectSeq, state);
	}

	@Override
	public EnrollVO getEnrollDetails(String enrollId) {
		EnrollVO enrollVo = enrollRepository.getEnrollDetails(enrollId);
		enrollVo.setRatio(enrollRepository.getRatioUsingEnrollId(enrollId));
		enrollVo.setPositionCdTitle(homeRepository.getComnCdTitle(enrollVo.getPositionCd())); // ????????? ??????
		enrollVo.setGenderCdTitle(homeRepository.getComnCdTitle(enrollVo.getGenderCd())); // ????????? ??????
		enrollVo.setAddDoCdTitle(homeRepository.getComnCdTitle(enrollVo.getAddDoCd())); // ????????? ??????
		enrollVo.setStateCdTitle(homeRepository.getComnCdTitle(enrollVo.getStateCd())); // ?????? ??????
		enrollVo.setCatSubjectCdTitle(homeRepository.getComnCdTitle(enrollVo.getCatSubjectCd())); // ?????? ??????
		enrollVo.setLevelCdTitle(homeRepository.getComnCdTitle(enrollVo.getLevelCd())); // ?????? ?????????
		enrollVo.setOpenStateCdTitle(homeRepository.getComnCdTitle(enrollVo.getOpenStateCd()));
		if(enrollVo.getCancelRsCd() != null) {
		enrollVo.setCancelRsTitle(homeRepository.getComnCdTitle(enrollVo.getCancelRsCd()));
		}
		return enrollVo;
	}
	
}

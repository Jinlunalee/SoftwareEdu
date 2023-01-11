package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IHomeRepository;
import com.mycompany.webapp.dao.IPagerRepository;
import com.mycompany.webapp.dto.EnrollVO;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IPagerService;

@Service
public class PagerService implements IPagerService {

	@Autowired
	IPagerRepository pagerRepository;
	
	@Autowired
	IHomeRepository homeRepository;
	
	@Override
	public int getCountStudentRow() {
		return pagerRepository.getCountStudentRow();
	}
	
	@Override
	public List<StudentVO> selectStudentListByPage(Pager pager) {
		return pagerRepository.selectStudentListByPage(pager);
	}

	@Override
	public int getCountOpenCourseRow() {
		return pagerRepository.getCountOpenCourseRow();
	}

	@Override
	public List<SubjectVO> selectOpenCourseListByPage(Pager pager) {
		List<SubjectVO> boardList = pagerRepository.selectOpenCourseListByPage(pager);
		// catCourse 공통코드로 catCourseTitle 가져와서 set하기
		for(SubjectVO subjectVo : boardList) {
			subjectVo.setCatCourseTitle(homeRepository.getComnCdTitle(subjectVo.getCatCourse()));
		}
		return boardList;
	}

	@Override
	public int getCountOpenSubjectRow() {
		return pagerRepository.getCountOpenSubjectRow();
	}

	@Override
	public List<SubjectVO> selectOpenSubjectListByPage(Pager pager) {
		List<SubjectVO> boardList = pagerRepository.selectOpenSubjectListByPage(pager);
		// catSubject 공통코드로 catSubjectTitle 가져와서 set하기
		for(SubjectVO subjectVo : boardList) {
			subjectVo.setCatSubjectTitle(homeRepository.getComnCdTitle(subjectVo.getCatSubject()));
		}
		return boardList;
	}

	@Override
	public int getCountEnrollRow() {
		return pagerRepository.getCountEnrollRow();
	}

	@Override
	public List<EnrollVO> selectEnrollListByPage(Pager pager) {
		List<EnrollVO> boardList = pagerRepository.selectEnrollListByPage(pager);
		// stateCd, openStateCd 공통코드로 stateCdTitle, openStateCdTitle 가져와서 set하기
		for(EnrollVO enrollVo : boardList) {
			enrollVo.setStateCdTitle(homeRepository.getComnCdTitle(enrollVo.getStateCd()));
			enrollVo.setOpenStateCdTitle(homeRepository.getComnCdTitle(enrollVo.getOpenStateCd()));
		}
		return boardList;
	}

	@Override
	public int getCountSearchRow(EnrollVO enroll) {
		// TODO Auto-generated method stub
		return pagerRepository.getCountSearchRow(enroll);
	}

	@Override
	public List<EnrollVO> selectSearchListByPage(EnrollVO enroll, Pager pager) {
		String applyStartDay = enroll.getApplyStartDay();
		String applyEndDay = enroll.getApplyEndDay();
		String student = enroll.getStudent();
		String course = enroll.getCourse();
		String state = enroll.getState();
		String keyword1 = enroll.getKeyword1();
		String keyword2 = enroll.getKeyword2();
		
		int endRowNo = pager.getEndRowNo();
		int startRowNo = pager.getStartRowNo();
		
		return pagerRepository.selectSearchListByPage(applyStartDay, applyEndDay, student, course, state, endRowNo, startRowNo, keyword1, keyword2);
	}
	
	



}

package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		return pagerRepository.selectOpenCourseListByPage(pager);
	}

	@Override
	public int getCountOpenSubjectRow() {
		return pagerRepository.getCountOpenSubjectRow();
	}

	@Override
	public List<SubjectVO> selectOpenSubjectListByPage(Pager pager) {
		return pagerRepository.selectOpenSubjectListByPage(pager);
	}

	@Override
	public int getCountEnrollRow() {
		return pagerRepository.getCountEnrollRow();
	}

	@Override
	public List<EnrollVO> selectEnrollListByPage(Pager pager) {
		return pagerRepository.selectEnrollListByPage(pager);
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

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



}

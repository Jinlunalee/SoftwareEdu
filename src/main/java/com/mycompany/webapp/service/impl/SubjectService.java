package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.ISubjectRepository;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.ISubjectService;

@Service
public class SubjectService implements ISubjectService{
	
	@Autowired
	ISubjectRepository subjectRepository;
	
	@Override
	public List<SubjectVO> selectCourseList() {
		return subjectRepository.selectCourseList();
	}

	@Override
	public List<SubjectVO> selectSubjectList() {
		return subjectRepository.selectSubjectList();
	}

	@Override
	public SubjectVO selectSubjectDetails(String subjectId) {
		return subjectRepository.selectSubjectDetails(subjectId);
	}

}

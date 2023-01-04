package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.webapp.dao.ISubjectRepository;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.dto.UploadfileVO;
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
	public SubjectVO selectSubjectDetails(String subjectId, int subjectSeq) {
		return subjectRepository.selectSubjectDetails(subjectId, subjectSeq);
	}

	@Override
	public int recruitTotalPeople(String subjectId, int subjectSeq, String state) {
		return subjectRepository.recruitTotalPeople(subjectId, subjectSeq, state);
	}

	@Override
	public int insertSubject(SubjectVO subject) {
		return subjectRepository.insertSubject(subject);
	}
	
	@Transactional
	@Override
	public int insertFileData(SubjectVO subject, UploadfileVO file) {
		subjectRepository.insertSubject(subject);
		if(file != null && file.getFileName() != null && file.getFileName().equals("")) {
			file.setSubjectId(subject.getSubjectId());
			subjectRepository.insertFileData(file);
		}
		return 0;
	}

	@Override
	public List<SubjectVO> selectAllCourse() {
		return subjectRepository.selectAllCourse();
	}

	@Override
	public List<SubjectVO> selectAllSubject() {
		return subjectRepository.selectAllSubject();
	}

}

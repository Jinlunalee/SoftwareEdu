package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IStudentRepository;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.service.IStudentService;

@Service
public class StudentService implements IStudentService{
	@Autowired
	IStudentRepository studentRepository;
	
	@Override
	public List<StudentVO> getStudentList() {
		return studentRepository.getStudentList();
	}

}

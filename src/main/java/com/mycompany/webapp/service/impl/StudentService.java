package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IStudentRepository;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IStudentService;

@Service
public class StudentService implements IStudentService{
	@Autowired
	IStudentRepository studentRepository;
	
	@Override
	public List<StudentVO> getStudentList() {
		return studentRepository.getStudentList();
	}

	@Override
	public List<StudentVO> getDataList () {
		return studentRepository.getDataList();
	}
	
	@Override
	public List<SubjectVO> getSbjDataList() {
		return studentRepository.getSbjDataList();
	}

	
	// 여기서부터 추가
	/*
	public List<StudentVO> getStudentList(Pager pager) {
		return IStudentRepository.selectByPage(pager);
	}
	
	public Board getBoard(int bno) {
		return boardDao.selectByBno(bno);
	}
	
	public int getTotalBoardNum() {
		return .count();
	}

*/
}

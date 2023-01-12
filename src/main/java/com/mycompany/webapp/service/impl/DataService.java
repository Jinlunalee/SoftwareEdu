package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IDataRepository;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IDataService;

@Service
public class DataService implements IDataService{
	@Autowired
	IDataRepository dataRepository;
	
	@Override
	public List<StudentVO> getDataList () {
		return dataRepository.getDataList();
	}
	
	@Override
	public List<SubjectVO> getSbjDataList() {
		return dataRepository.getSbjDataList();
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

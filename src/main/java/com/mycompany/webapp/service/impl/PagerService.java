package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IPagerRepository;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;
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



}

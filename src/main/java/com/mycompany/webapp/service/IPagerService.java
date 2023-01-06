package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.StudentVO;

public interface IPagerService {
	int getCountStudentRow();
	List<StudentVO> selectStudentListByPage(Pager pager);


}

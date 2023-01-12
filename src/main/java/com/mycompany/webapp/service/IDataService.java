package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;

public interface IDataService {
	List<StudentVO> getDataList();
	List<SubjectVO> getSbjDataList();
}

package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;

public interface IDataService {
	String getDataGson();
	List<StudentVO> getDataList();
	List<SubjectVO> getSbjDataList();
	String getSbjDataGson();
}

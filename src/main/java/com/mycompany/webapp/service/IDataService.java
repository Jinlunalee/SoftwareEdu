package com.mycompany.webapp.service;

import java.util.List;

import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;

public interface IDataService {
	String getDataGson(String startDay, String endDay);
	String getDataList(String startDay, String endDay);
	String getSbjDataList(String startDay, String endDay);
	String getSbjDataGson(String startDay, String endDay);
}

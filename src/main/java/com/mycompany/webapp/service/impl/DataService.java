package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.mycompany.webapp.dao.IDataRepository;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IDataService;

@Service
public class DataService implements IDataService{
	@Autowired
	IDataRepository dataRepository;
	
	Gson gson = new Gson();



	@Override
	public String getDataGson() {
		gson.toJson(dataRepository.getDataList());

		List<StudentVO> dataList = dataRepository.getDataList();
		
		String jsonStr = gson.toJson(dataList);		
		
		return jsonStr;
	}

			
	
	@Override
	public String getSbjDataGson() {
		gson.toJson(dataRepository.getSbjDataList());

		List<SubjectVO> sbjdataList = dataRepository.getSbjDataList();
		
		String jsonStr2 = gson.toJson(sbjdataList);		
		
		return jsonStr2;
	}
	
	
	
	
	
			
/*			일단 주석처리하고
	@Override
	public List<StudentVO> getDataList () {
		return dataRepository.getDataList();
	}
	*/
	
	@Override
	public List<StudentVO> getDataList() {
		return dataRepository.getDataList();
	}
	
	@Override
	public List<SubjectVO> getSbjDataList() {
		return dataRepository.getSbjDataList();
	}

//  여기에 6번
	
	
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

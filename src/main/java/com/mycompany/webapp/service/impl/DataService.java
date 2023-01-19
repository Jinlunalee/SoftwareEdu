package com.mycompany.webapp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.mycompany.webapp.dao.IDataRepository;
import com.mycompany.webapp.dto.StudentVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IDataService;

@Service
public class DataService implements IDataService{
	@Autowired
	IDataRepository dataRepository;

	// @Expose를 사용하기 위해, new Gson()이 아닌 new GsonBuilder()사용 : @Expose처리된 필드는 직렬화에서 배제시킬 수 있음.
	Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();


	//1번 json
	@Override
	public String getDataGson(String startDay, String endDay) {
		List<StudentVO> dataList = dataRepository.getDataList(startDay, endDay);

		String jsonStr = gson.toJson(dataList);		

		return jsonStr;
	}


	//2번 json
	@Override
	public String getSbjDataGson(String startDay, String endDay) {
		List<SubjectVO> sbjdataList = dataRepository.getSbjDataList(startDay, endDay);

		String jsonStr2 = gson.toJson(sbjdataList);		

		return jsonStr2;
	}


	/*			일단 주석처리하고
	@Override
	public List<StudentVO> getDataList () {
		return dataRepository.getDataList();
	}
	 */


	// 학생xml
	@Override
	public List<StudentVO> getDataList(String startDay, String endDay) {

		

		return dataRepository.getDataList(startDay, endDay);
	}

	// 강좌 xml
	@Override
	public List<SubjectVO> getSbjDataList(String startDay, String endDay) {
	
		System.out.println("dataservice : " + dataRepository.getSbjDataList(startDay, endDay));
		return dataRepository.getSbjDataList(startDay, endDay);
	}

}
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


	// 학생 정보 json
	@Override
	public String getDataGson(String startDay, String endDay) {
		List<StudentVO> dataList = dataRepository.getDataList(startDay, endDay);

		String jsonStr = gson.toJson(dataList);		

		return jsonStr;
	}


	// 강좌 정보 json
	@Override
	public String getSbjDataGson(String startDay, String endDay) {
		List<SubjectVO> sbjdataList = dataRepository.getSbjDataList(startDay, endDay);

		String jsonStr2 = gson.toJson(sbjdataList);		

		return jsonStr2;
	}


	/*			
	@Override
	public List<StudentVO> getDataList () {
		return dataRepository.getDataList();
	}
	 */


	// 학생 xml
	@Override
	public String getDataList(String startDay, String endDay) {
			List<StudentVO> dataList = dataRepository.getDataList(startDay, endDay);
		
		String result = "";  // for문 밖에서 결과값을 받을 result를 선언 
		for (StudentVO vo : dataList) {	
			String agentId = vo.getAgentId();
			String stdSbj = vo.getStdSbj();
			String name = vo.getName();
			String completeHours = vo.getCompleteHours();
			String sendDt = vo.getSendDt();
		
			// 밑의 문자열에 "\n" 넣어도 엔터처리 안 됨
			// +=로 문자열을 이어붙이기
        result += "<student>";
        result += "<agent_id>" + "KOSA01" + "</agent_id>";
        result += "<std_sbj>"+ stdSbj +"</std_sbj>";
        result += "<name>" + name + "</name>";
        result +=  "<complete_hours>" + completeHours + "</complete_hours>";
        result +=  "<send_dt>" + sendDt + "<send_dt>";
        result +=  "</student>"; 
//        넣어야 할 정보 : 수강생 아이디에 교육연도, 강좌아이디, 강좌시퀀스, 수강아이디, 연수생아이디 추가하기
//        교육비 지원여부는 어차피 지원되는 것만 조회되는 거니까 넣지 말기
		}
		return result;
	}

	// 강좌 xml
	@Override
	public String getSbjDataList (String startDay, String endDay) {
		List<SubjectVO> sbjDataList = dataRepository.getSbjDataList(startDay, endDay);
	
        String result= ""; 
        
        for (SubjectVO vo : sbjDataList) {
        	String sbjIdSeq = vo.getSbjIdSeq();
        	String subjectTitle = vo.getSubjectTitle();
        	int hours = vo.getHours();
        	String sDay = vo.getStartDay();
        	String eDay = vo.getEndDay();
        	int cost = vo.getCost();
        	String sendDt = vo.getSendDt();
        	int cntStd = vo.getCntStd();
        	
        	
           result += "<subject>";
           result += "<sbjId_seq>" + sbjIdSeq + "</sbjId_seq>";
           result += "<subject_title>" + subjectTitle
                 + "</subject_title>";
           result += "<hours>" + hours + "</hours>";
           result += "<start_day>" + sDay + "</start_day>";
           result += "<end_day>" + eDay + "</end_day>";
           result += "<cost>" + cost + "</cost>";
           result += "<send_dt>" + sendDt + "</send_dt>";
           result += "<cnt_std>" + cntStd + "명" + "</cnt_std>";
           result += "</subject>";  
        }

		return result;
	}

}
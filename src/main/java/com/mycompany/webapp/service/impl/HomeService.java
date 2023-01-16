package com.mycompany.webapp.service.impl;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.IHomeRepository;
import com.mycompany.webapp.dto.CommonCodeVO;
import com.mycompany.webapp.dto.SubjectVO;
import com.mycompany.webapp.service.IHomeService;
@Service
public class HomeService implements IHomeService {
	@Autowired
	IHomeRepository homeRepository;
	
	@Override
	public List<SubjectVO> selectSubjectList(String catSubject) {

		return homeRepository.selectSubjectList(catSubject); 
	}

	@Override
	public List<SubjectVO> selectCourseList(String catCourse) {
		return homeRepository.selectCourseList(catCourse); 
	}

	@Override
	public String getComnCdTitle(String comnCd) {
		return homeRepository.getComnCdTitle(comnCd);
	}

	@Override
	public List<CommonCodeVO> getComnCdList(String comnCdType) {
		return homeRepository.getComnCdList(comnCdType);
	}

	@Override
	public List<SubjectVO> searchOpenSubject(SubjectVO subjectVo) {
		List<SubjectVO> boardList = homeRepository.searchOpenSubject(subjectVo);
		// level, state, catSubject 공통코드로 가져와서 set 하기
		for(SubjectVO subjectVoReturn : boardList) {
			subjectVoReturn.setLevelTitle(homeRepository.getComnCdTitle(subjectVoReturn.getLevel()));
			subjectVoReturn.setComnCdTitle(homeRepository.getComnCdTitle(subjectVoReturn.getState()));
			subjectVoReturn.setCatSubjectTitle(homeRepository.getComnCdTitle(subjectVoReturn.getCatSubject()));
		}
		return boardList;
	}


//	@Override
//	public List<SubjectVO> searchSubject(List<Map<String, Object>> searchParam) {
//		SubjectVO subjectVo = new SubjectVO();
//		subjectVo.setSubjectId(searchParam.get("subjectId"));
//		subjectVo.setSubjectTitle(searchParam.get("subjectTitle"));
//		subjectVo.setCatSubject(searchParam.get("catSubject"));
//		subjectVo.setDays(searchParam.get("days"));
//		subjectVo.setHours(searchParam.get("hours"));
//		subjectVo.setLevel(searchParam.get("level"));
//		subjectVo.setLevelEtc(searchParam.get("levelEtc"));
//		subjectVo.setCost(searchParam.get("cost"));
//		subjectVo.setRegYear(searchParam.get("regYear"));
//		return homeRepository.searchSubject(subjectVo);
//	}

//	@Override
//	public List<String> getColumnName(String searchType, List<Map<String, Object>> searchParam) {
//		List<String> list = new ArrayList<>();
//		
//		return null;
//	}

}
